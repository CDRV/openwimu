/**************************************************************************************************
  Filename:       timeservice.c
  Revised:        $Date $
  Revision:       $Revision $

  Description:    This file contains the Current Time service.

**************************************************************************************************/

/*********************************************************************
 * INCLUDES
 */
#include "bcomdef.h"
#include "OSAL.h"
#include "hal_adc.h"
#include "linkdb.h"
#include "att.h"
#include "gatt.h"
#include "gatt_uuid.h"
#include "gattservapp.h"
#include "hid_uuid.h"
#include "hiddev.h"

#include "timeservice.h"
#include "wimu_util.h"
#include "st_util.h"

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */
// Current Time service
CONST uint8 timeServUUID[ATT_BT_UUID_SIZE] =
{
  LO_UINT16(TIME_SERVICE_UUID), HI_UINT16(TIME_SERVICE_UUID)
};

// Current Time characteristic
CONST uint8 currentTimeUUID[ATT_BT_UUID_SIZE] =
{
  LO_UINT16(CURRENT_TIME_UUID), HI_UINT16(CURRENT_TIME_UUID)
};

/*********************************************************************
 * EXTERNAL VARIABLES
 */

/*********************************************************************
 * EXTERNAL FUNCTIONS
 */

/*********************************************************************
 * LOCAL VARIABLES
 */

static timeCBs_t *Time_AppCBs = NULL;

/*********************************************************************
 * Profile Attributes - variables
 */

// Time Service attribute
static CONST gattAttrType_t timeService = { ATT_BT_UUID_SIZE, timeServUUID };

// Current Time characteristic
static uint8 currentTimeProps = GATT_PROP_READ | GATT_PROP_NOTIFY | GATT_PROP_WRITE;
static uint8 currentTime[WIMU_GPS_CURRENT_TIME_PACKET_SIZE];
static gattCharCfg_t currentTimeClientCharCfg[GATT_MAX_NUM_CONN];

/*********************************************************************
 * Profile Attributes - Table
 */

static gattAttribute_t timeAttrTbl[] =
{
  // Current Time Service
  {
    { ATT_BT_UUID_SIZE, primaryServiceUUID }, /* type */
    GATT_PERMIT_READ,                         /* permissions */
    0,                                        /* handle */
    (uint8 *)&timeService                     /* pValue */
  },

    // Current Time Declaration
    {
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ,
      0,
      &currentTimeProps
    },

      // Current Time Value
      {
        { ATT_BT_UUID_SIZE, currentTimeUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8*)&currentTime
      },

      // Current Time Client Characteristic Configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)currentTimeClientCharCfg
      }
};


/*********************************************************************
 * LOCAL FUNCTIONS
 */
static uint8 timeReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                             uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen );
static bStatus_t timeWriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                  uint8 *pValue, uint8 len, uint16 offset );
//static void battNotifyCB( linkDBItem_t *pLinkItem );
//static uint8 battMeasure( void );
//static void battNotifyLevel( void );

/*********************************************************************
 * PROFILE CALLBACKS
 */
// Current Time Service Callbacks
CONST gattServiceCBs_t timeCBs =
{
  timeReadAttrCB,  // Read callback function pointer
  timeWriteAttrCB, // Write callback function pointer
  NULL             // Authorization callback function pointer
};

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      Time_AddService
 *
 * @brief   Initializes the Current Time Service by registering
 *          GATT attributes with the GATT server.
 *
 * @return  Success or Failure
 */
bStatus_t Time_AddService( void )
{
  uint8 status = SUCCESS;

  // Initialize Client Characteristic Configuration attributes
  GATTServApp_InitCharCfg( INVALID_CONNHANDLE, currentTimeClientCharCfg );

  // Register GATT attribute list and CBs with GATT Server App
  status = GATTServApp_RegisterService( timeAttrTbl,
                                        GATT_NUM_ATTRS( timeAttrTbl ),
                                        &timeCBs );

  return ( status );
}

/*********************************************************************
 * @fn      Time_Register
 *
 * @brief   Register a callback function with the Current Time Service.
 *
 * @param   pfnServiceCB - Callback function.
 *
 * @return  None.
 */
bStatus_t Time_Register( timeCBs_t *appCallbacks )
{
  if ( Time_AppCBs == NULL )
  {
    if ( appCallbacks != NULL )
    {
      Time_AppCBs = appCallbacks;
    }

    return ( SUCCESS );
  }

  return ( bleAlreadyInRequestedMode );
}
/*********************************************************************
 * @fn      Time_SetParameter
 *
 * @brief   Set a Current Time Service parameter.
 *
 * @param   param - Profile parameter ID
 * @param   len - length of data to right
 * @param   value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Time_SetParameter( uint8 param, uint8 len, void *value )
{
  bStatus_t ret = SUCCESS;

  switch ( param )
  {
    case CURRENT_TIME_PARAM:
      if ( len == WIMU_GPS_CURRENT_TIME_PACKET_SIZE )
      {
        osal_memcpy( currentTime, value, WIMU_GPS_CURRENT_TIME_PACKET_SIZE );
        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( currentTimeClientCharCfg, currentTime, FALSE,
                                   timeAttrTbl, GATT_NUM_ATTRS( timeAttrTbl ),
                                   INVALID_TASK_ID );
      }
      else
      {
        ret = bleInvalidRange;
      }
      break;
      
    default:
      ret = INVALIDPARAMETER;
      break;
  }

  return ( ret );
}

/*********************************************************************
 * @fn      Time_GetParameter
 *
 * @brief   Get a Current Time Service parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to get.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Time_GetParameter( uint8 param, void *value )
{
  bStatus_t ret = SUCCESS;
  switch ( param )
  {
    case CURRENT_TIME_PARAM:
      
      osal_memcpy( value, currentTime, WIMU_GPS_CURRENT_TIME_PACKET_SIZE );
      //*((uint8*)value) = currentTime;
      break;

    default:
      ret = INVALIDPARAMETER;
      break;
  }

  return ( ret );
}

/*********************************************************************
 * @fn          timeReadAttrCB
 *
 * @brief       Read an attribute.
 *
 * @param       connHandle - connection message was received on
 * @param       pAttr - pointer to attribute
 * @param       pValue - pointer to data to be read
 * @param       pLen - length of data to be read
 * @param       offset - offset of the first octet to be read
 * @param       maxLen - maximum length of data to be read
 *
 * @return      Success or Failure
 */

static uint8 timeReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                             uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen )
{
  bStatus_t status = SUCCESS;

  // Make sure it's not a blob operation (no attributes in the profile are long)
  if ( offset > 0 )
  {
    return ( ATT_ERR_ATTR_NOT_LONG );
  }

  uint16 uuid = BUILD_UINT16( pAttr->type.uuid[0], pAttr->type.uuid[1] );

  if ( uuid == CURRENT_TIME_UUID )
  {
    *pLen = WIMU_GPS_CURRENT_TIME_PACKET_SIZE;
    VOID osal_memcpy( pValue, pAttr->pValue, WIMU_GPS_CURRENT_TIME_PACKET_SIZE );
  }
  else
  {
    status = ATT_ERR_ATTR_NOT_FOUND;
  }

  return ( status );
}

/*********************************************************************
 * @fn      timeWriteAttrCB
 *
 * @brief   Validate attribute data prior to a write operation
 *
 * @param   connHandle - connection message was received on
 * @param   pAttr - pointer to attribute
 * @param   pValue - pointer to data to be written
 * @param   len - length of data
 * @param   offset - offset of the first octet to be written
 *
 * @return  Success or Failure
 */
static bStatus_t timeWriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                  uint8 *pValue, uint8 len, uint16 offset )
{
  uint16 uuid;
  bStatus_t status = SUCCESS;
  uint8 notifyApp = 0xFF;

  // If attribute permissions require authorization to write, return error
  if ( gattPermitAuthorWrite( pAttr->permissions ) )
  {
    // Insufficient authorization
    return ( ATT_ERR_INSUFFICIENT_AUTHOR );
  }

  if (utilExtractUuid16(pAttr,&uuid) == FAILURE) {
    // Invalid handle
    return ATT_ERR_INVALID_HANDLE;
  }
  
  switch ( uuid )
  {
          
      case CURRENT_TIME_UUID:
      //Validate the value
      if ( offset == 0 )
      {
        if ( len != WIMU_GPS_CURRENT_TIME_PACKET_SIZE )
        {
          status = ATT_ERR_INVALID_VALUE_SIZE;
        }
      }
      else
      {
        status = ATT_ERR_ATTR_NOT_LONG;
      }

      //Write the value
      if ( status == SUCCESS )
      {
        uint8 *pCurValue = (uint8 *)pAttr->pValue;
        
        //*pCurValue = pValue[0];
        osal_memcpy( pCurValue, pValue, WIMU_GPS_CURRENT_TIME_PACKET_SIZE );
        
        osal_set_event(/*WIMU_TaskID*/10, WIMU_TIME_EVT);

        /*if( pAttr->pValue == &currentTime )
        {*/
          notifyApp = CURRENT_TIME_PARAM;
        //}
      }
      break;

    case GATT_CLIENT_CHAR_CFG_UUID:
      status = GATTServApp_ProcessCCCWriteReq( connHandle, pAttr, pValue, len,
                                              offset, GATT_CLIENT_CFG_NOTIFY );
      break;

    default:
      // Should never get here!
      status = ATT_ERR_ATTR_NOT_FOUND;
      break;
  }

  // If a charactersitic value changed then callback function to notify application of change
  if ( (notifyApp != 0xFF ) && Time_AppCBs && Time_AppCBs->pfnTimeChange )
  {
    Time_AppCBs->pfnTimeChange( notifyApp );
  }
/*
  uint16 uuid = BUILD_UINT16( pAttr->type.uuid[0], pAttr->type.uuid[1]);
  switch ( uuid )
  {
    case GATT_CLIENT_CHAR_CFG_UUID:
      status = GATTServApp_ProcessCCCWriteReq( connHandle, pAttr, pValue, len,
                                               offset, GATT_CLIENT_CFG_NOTIFY );
      break;

    default:
      status = ATT_ERR_ATTR_NOT_FOUND;
      break;
  }
  */
  return ( status );
}

/*********************************************************************
 * @fn          Time_HandleConnStatusCB
 *
 * @brief       Current Time link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
void Time_HandleConnStatusCB( uint16 connHandle, uint8 changeType )
{
  // Make sure this is not loopback connection
  if ( connHandle != LOOPBACK_CONNHANDLE )
  {
    // Reset Client Char Config if connection has dropped
    if ( ( changeType == LINKDB_STATUS_UPDATE_REMOVED )      ||
         ( ( changeType == LINKDB_STATUS_UPDATE_STATEFLAGS ) &&
           ( !linkDB_Up( connHandle ) ) ) )
    {
      GATTServApp_InitCharCfg( connHandle, currentTimeClientCharCfg );
    }
  }
}


/*********************************************************************
*********************************************************************/

