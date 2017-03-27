/**************************************************************************************************
  Filename:       actimetryservice.c

  Description:    Actimetry Service (based on Sensor Profile)

**************************************************************************************************/

/*********************************************************************
 * INCLUDES
 */
#include "bcomdef.h"
#include "linkdb.h"
#include "gatt.h"
#include "gatt_uuid.h"
#include "gattservapp.h"

#include "actimetryservice.h"
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

// Actimetry Service UUID
CONST uint8 actimetryServUUID[WIMU_ACTIMETRY_UUID_SIZE] =
{
  WIMU_ACTIMETRY_UUID(ACTIMETRY_SERV_UUID),
};

// Actimetry Characteristic value Imu UUID
CONST uint8 actimetryImuUUID[WIMU_ACTIMETRY_UUID_SIZE] =
{
  WIMU_ACTIMETRY_UUID(ACTIMETRY_IMU_UUID),
};

// Actimetry Characteristic value Quaternion UUID
CONST uint8 actimetryQuaternionUUID[WIMU_ACTIMETRY_UUID_SIZE] =
{
  WIMU_ACTIMETRY_UUID(ACTIMETRY_QUATERNION_UUID),
};

// Actimetry Characteristic value Configuration UUID
CONST uint8 actimetryCfgUUID[WIMU_ACTIMETRY_UUID_SIZE] =
{
  WIMU_ACTIMETRY_UUID(ACTIMETRY_CONFIG_UUID),
};

// Actimetry Characteristic value Control UUID, used to start/stop recordings
CONST uint8 actimetryControlUUID[WIMU_ACTIMETRY_UUID_SIZE] =
{
  WIMU_ACTIMETRY_UUID(ACTIMETRY_CONTROL_UUID),
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

static actimetryCBs_t *Actimetry_AppCBs = NULL;

/*********************************************************************
 * Profile Attributes - variables
 */


// Actimetry  Profile Service attribute
static CONST gattAttrType_t actimetryService = { WIMU_ACTIMETRY_UUID_SIZE, actimetryServUUID };

// Accelerometer Characteristic Properties
static uint8 actimetryImuProps = GATT_PROP_READ | GATT_PROP_NOTIFY;

static uint8 actimetryImu[WIMU_ACTIMETRY_IMU_PACKET_SIZE] = {0};//{0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14};//{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

// Actimetry Characteristic Configuration
static gattCharCfg_t actimetryImuConfig[GATT_MAX_NUM_CONN];

// Actimetry Characteristic User Description
static uint8 actimetryImuUserDesp[19] = "Actimetry IMU Data\0";

// Accelerometer Characteristic Properties
static uint8 actimetryQuaternionProps = GATT_PROP_READ | GATT_PROP_NOTIFY;

static uint8 actimetryQuaternion[WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE] = { 0, 0, 0, 0,
                                                                            0, 0, 0, 0,
                                                                            0, 0, 0, 0,
                                                                            0, 0, 0, 0};

// Actimetry Characteristic Configuration
static gattCharCfg_t actimetryQuaternionConfig[GATT_MAX_NUM_CONN];

// Actimetry Characteristic User Description
static uint8 actimetryQuaternionUserDesp[26] = "Actimetry Quaternion Data\0";

// Actimetry Characteristic Configuration Properties
static uint8 actimetryCfgProps = GATT_PROP_READ | GATT_PROP_WRITE | GATT_PROP_NOTIFY;

// Actimetry Characteristic Configuration Value
static uint8 actimetryCfg[sizeof(IMU_Config_t)];

static gattCharCfg_t actimetryCfgConfig[GATT_MAX_NUM_CONN];

// Actimetry Characteristic Configuration User Description
static uint8 actimetryCfgUserDesp[17] = "Actimetry Config\0";


// Actimetry Characteristic Configuration Value
static uint8 actimetryControl[sizeof(RemControl_t)];

static gattCharCfg_t actimetryControlConfig[GATT_MAX_NUM_CONN];


// Actimetry Characteristic Configuration User Description
static uint8 actimetryControlUserDesp[18] = "Actimetry Control\0";

/*********************************************************************
 * Profile Attributes - Table
 */

static gattAttribute_t sensorActimetryAttrTbl[] =
{
  {
    { ATT_BT_UUID_SIZE, primaryServiceUUID }, /* type */
    GATT_PERMIT_READ,                         /* permissions */
    0,                                        /* handle */
    (uint8 *)&actimetryService                /* pValue */
  },

    // Characteristic Declaration
    {
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ,
      0,
      &actimetryImuProps
    },

      // Characteristic Value "Imu Data"
      {
        { WIMU_ACTIMETRY_UUID_SIZE, actimetryImuUUID },
        GATT_PERMIT_READ,
        0,
        actimetryImu
      },

      // Characteristic configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)actimetryImuConfig
      },

      // Characteristic User Description
      {
        { ATT_BT_UUID_SIZE, charUserDescUUID },
        GATT_PERMIT_READ,
        0,
        actimetryImuUserDesp
      },
      
    // Characteristic Declaration
    {
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ,
      0,
      &actimetryQuaternionProps
    },
      // Characteristic Value "Quaternion Data"
      {
        { WIMU_ACTIMETRY_UUID_SIZE, actimetryQuaternionUUID },
        GATT_PERMIT_READ,
        0,
        actimetryQuaternion
      },

      // Characteristic configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)actimetryQuaternionConfig
      },

      // Characteristic User Description
      {
        { ATT_BT_UUID_SIZE, charUserDescUUID },
        GATT_PERMIT_READ,
        0,
        actimetryQuaternionUserDesp
      },
    // Characteristic 2 Declaration
    {
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ,
      0,
      &actimetryCfgProps
    },

      // Characteristic Value "Configuration"
      {
        { WIMU_ACTIMETRY_UUID_SIZE, actimetryCfgUUID },
        GATT_PERMIT_READ/* | GATT_PERMIT_WRITE*/,
        0,
        actimetryCfg
      },
      // Characteristic configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ/* | GATT_PERMIT_WRITE*/,
        0,
        (uint8 *)actimetryCfgConfig
      },
      // Characteristic User Description
      {
        { ATT_BT_UUID_SIZE, charUserDescUUID },
        GATT_PERMIT_READ,
        0,
        actimetryCfgUserDesp
      },
      
      // Characteristic Value "Control"
      {
        { WIMU_ACTIMETRY_UUID_SIZE, actimetryControlUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        actimetryControl
      },
      // Characteristic configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)actimetryControlConfig
      },
      // Characteristic User Description
      {
        { ATT_BT_UUID_SIZE, charUserDescUUID },
        GATT_PERMIT_READ,
        0,
        actimetryControlUserDesp
      },
};


/*********************************************************************
 * LOCAL FUNCTIONS
 */
static uint8 Actimetry_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen );
static bStatus_t Actimetry_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                 uint8 *pValue, uint8 len, uint16 offset );
static void Actimetry_HandleConnStatusCB( uint16 connHandle, uint8 changeType );

/*********************************************************************
 * PROFILE CALLBACKS
 */
// Simple Profile Service Callbacks
CONST gattServiceCBs_t actimetryCBs =
{
  Actimetry_ReadAttrCB,  // Read callback function pointer
  Actimetry_WriteAttrCB, // Write callback function pointer
  NULL              // Authorization callback function pointer
};

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      Actimetry_AddService
 *
 * @brief   Initializes the Sensor Profile service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  Success or Failure
 */
bStatus_t Actimetry_AddService( uint32 services )
{
  uint8 status = SUCCESS;

  // Register with Link DB to receive link status change callback
  VOID linkDB_Register( Actimetry_HandleConnStatusCB );

  if (services & ACTIMETRY_SERVICE )
  {

    // Register GATT attribute list and CBs with GATT Server App
    status = GATTServApp_RegisterService( sensorActimetryAttrTbl,
                                          GATT_NUM_ATTRS( sensorActimetryAttrTbl ),
                                          &actimetryCBs );
  }

  return ( status );
}


/*********************************************************************
 * @fn      Actimetry_RegisterAppCBs
 *
 * @brief   Registers the application callback function. Only call
 *          this function once.
 *
 * @param   callbacks - pointer to application callbacks.
 *
 * @return  SUCCESS or bleAlreadyInRequestedMode
 */

bStatus_t Actimetry_RegisterAppCBs( actimetryCBs_t *appCallbacks )
{
  if ( Actimetry_AppCBs == NULL )
  {
    if ( appCallbacks != NULL )
    {
      Actimetry_AppCBs = appCallbacks;
    }

    return ( SUCCESS );
  }

  return ( bleAlreadyInRequestedMode );
}

/*********************************************************************
 * @fn      Actimetry_SetParameter
 *
 * @brief   Set a Sensor Profile parameter.
 *
 * @param   param - Profile parameter ID
 * @param   len - length of data to write
 * @param   value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Actimetry_SetParameter( uint8 param, uint8 len, void *value )
{
  bStatus_t ret = SUCCESS;
  switch ( param )
  {
    case ACTIMETRY_IMU:
      if ( len == WIMU_ACTIMETRY_IMU_PACKET_SIZE )
      {
        VOID osal_memcpy( actimetryImu, value, WIMU_ACTIMETRY_IMU_PACKET_SIZE );

        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( actimetryImuConfig, actimetryImu, FALSE,
                                   sensorActimetryAttrTbl, GATT_NUM_ATTRS( sensorActimetryAttrTbl ),
                                   INVALID_TASK_ID );
      }
      else
      {
        ret = bleInvalidRange;
      }
      break;

    case ACTIMETRY_QUATERNION:
      if ( len == WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE )
      {
        VOID osal_memcpy( actimetryQuaternion, value, WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE );

        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( actimetryQuaternionConfig, actimetryQuaternion, FALSE,
                                   sensorActimetryAttrTbl, GATT_NUM_ATTRS( sensorActimetryAttrTbl ),
                                   INVALID_TASK_ID );
      }
      else
      {
        ret = bleInvalidRange;
      }
      break;
      
    case ACTIMETRY_CONFIG:
      if(len == sizeof ( IMU_Config_t ) )
      {
//        actimetryCfg = *((uint8*)value);
        osal_memcpy( actimetryCfg, value, len );
          
      }
      else
      {
        ret = bleInvalidRange;
      }
      break;

      case ACTIMETRY_CONTROL:
      if(len == sizeof ( RemControl_t ) )
      {
        //actimetryControl = *((uint8*)value);
        osal_memcpy( actimetryControl, value, len);
        
        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( actimetryControlConfig, actimetryControl, FALSE,
                                   sensorActimetryAttrTbl, GATT_NUM_ATTRS( sensorActimetryAttrTbl ),
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
 * @fn      Actimetry_GetParameter
 *
 * @brief   Get a Actimetry Profile parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to put.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Actimetry_GetParameter( uint8 param, void *value )
{
  bStatus_t ret = SUCCESS;

  switch ( param )
  {
    case ACTIMETRY_IMU:
        VOID osal_memcpy (value, actimetryImu, WIMU_ACTIMETRY_IMU_PACKET_SIZE );
        break;

    case ACTIMETRY_QUATERNION:
        VOID osal_memcpy (value, actimetryQuaternion, WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE );
        break;
        
    case ACTIMETRY_CONFIG:
        //*((uint8*)value) = actimetryCfg;
        VOID osal_memcpy (value, actimetryCfg, sizeof(IMU_Config_t) );      
        break;

    case ACTIMETRY_CONTROL:
        //*((uint8*)value) = actimetryControl;
        osal_memcpy (value, actimetryControl, sizeof(RemControl_t) );
    break;
    default:
      ret = INVALIDPARAMETER;
      break;
  }

  return ( ret );
}

/*********************************************************************
 * @fn          Actimetry_ReadAttrCB
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
static uint8 Actimetry_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen )
{
  uint16 uuid;
  bStatus_t status = SUCCESS;

  // If attribute permissions require authorization to read, return error
  if ( gattPermitAuthorRead( pAttr->permissions ) )
  {
    // Insufficient authorization
    return ( ATT_ERR_INSUFFICIENT_AUTHOR );
  }

  // Make sure it's not a blob operation (no attributes in the profile are long)
  if ( offset > 0 )
  {
    return ( ATT_ERR_ATTR_NOT_LONG );
  }

  if (utilExtractUuid16(pAttr,&uuid) == FAILURE) {
    // Invalid handle
    *pLen = 0;
    return ATT_ERR_INVALID_HANDLE;
  }

  switch ( uuid )
  {
    // No need for "GATT_SERVICE_UUID" or "GATT_CLIENT_CHAR_CFG_UUID" cases;
    // gattserverapp handles those reads
    case ACTIMETRY_IMU_UUID:
      *pLen = WIMU_ACTIMETRY_IMU_PACKET_SIZE;
      VOID osal_memcpy( pValue, pAttr->pValue, WIMU_ACTIMETRY_IMU_PACKET_SIZE );
      break;

    case ACTIMETRY_QUATERNION_UUID:
      *pLen = WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE;
      VOID osal_memcpy( pValue, pAttr->pValue, WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE );
      break;
      
    case ACTIMETRY_CONFIG_UUID:
      *pLen = sizeof(IMU_Config_t);
      osal_memcpy( pValue, pAttr->pValue, sizeof(IMU_Config_t) );
      break;
      
      case ACTIMETRY_CONTROL_UUID:
      //*pLen = 1;
      //pValue[0] = *pAttr->pValue;
      *pLen = sizeof(RemControl_t);
      osal_memcpy( pValue, pAttr->pValue, sizeof(RemControl_t) );
      break;

    default:
      *pLen = 0;
      status = ATT_ERR_ATTR_NOT_FOUND;
      break;
  }

  return ( status );
}

/*********************************************************************
* @fn      Actimetry_WriteAttrCB
*
* @brief   Validate attribute data prior to a write operation
*
* @param   connHandle - connection message was received on
* @param   pAttr - pointer to attribute
* @param   pValue - pointer to data to be written
* @param   len - length of data
* @param   offset - offset of the first octet to be written
* @param   complete - whether this is the last packet
* @param   oper - whether to validate and/or write attribute value
*
* @return  Success or Failure
*/
static bStatus_t Actimetry_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
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
    case ACTIMETRY_IMU_UUID:
      //Should not get here
      break;

    case ACTIMETRY_QUATERNION_UUID:
      //Should not get here
      break;
      
    case ACTIMETRY_CONFIG_UUID:
      // Not done yet.
      
      //Validate the value
      // Make sure it's not a blob oper
      /*if ( offset == 0 )
      {
        if ( len != 1 )
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
        *pCurValue = pValue[0];

        if( pAttr->pValue == &actimetryCfg )
        {
          notifyApp = ACTIMETRY_CONF;
        }
      }*/
      break;
      
      case ACTIMETRY_CONTROL_UUID:
      //Validate the value
      // Make sure it's not a blob oper
      if ( offset == 0 )
      {
        if ( len != sizeof(RemControl_t) )
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
        
        *pCurValue = pValue[0];
        
        osal_set_event(/*WIMU_TaskID*/10, WIMU_CONTROL_EVT);

        if( pAttr->pValue == (uint8*)(&actimetryControl) )
        {
          notifyApp = ACTIMETRY_CONTROL;
        }
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
  if ( (notifyApp != 0xFF ) && Actimetry_AppCBs && Actimetry_AppCBs->pfnActimetryChange )
  {
    Actimetry_AppCBs->pfnActimetryChange( notifyApp );
  }

  return ( status );
}

/*********************************************************************
 * @fn          Actimetry_HandleConnStatusCB
 *
 * @brief       Sensor Profile link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
static void Actimetry_HandleConnStatusCB( uint16 connHandle, uint8 changeType )
{
  // Make sure this is not loopback connection
  if ( connHandle != LOOPBACK_CONNHANDLE )
  {
    // Reset Client Char Config if connection has dropped
    if ( ( changeType == LINKDB_STATUS_UPDATE_REMOVED )      ||
         ( ( changeType == LINKDB_STATUS_UPDATE_STATEFLAGS ) &&
           ( !linkDB_Up( connHandle ) ) ) )
    {
      GATTServApp_InitCharCfg( connHandle, actimetryImuConfig );
      GATTServApp_InitCharCfg( connHandle, actimetryQuaternionConfig );
      GATTServApp_InitCharCfg( connHandle, actimetryCfgConfig );
      GATTServApp_InitCharCfg( connHandle, actimetryControlConfig );
    }
  }
}


/*********************************************************************
*********************************************************************/
