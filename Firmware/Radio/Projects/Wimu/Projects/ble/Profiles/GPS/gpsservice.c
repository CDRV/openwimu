/**************************************************************************************************
  Filename:       gpsprofile.c
  Creation:       Date: 2015-07-23

  Description:    Gps profile (based on simpleGATT Profile)

**************************************************************************************************/

/*********************************************************************
 * INCLUDES
 */
#include "bcomdef.h"
#include "OSAL.h"
#include "linkdb.h"
#include "att.h"
#include "gatt.h"
#include "gatt_uuid.h"
#include "gattservapp.h"
#include "gapbondmgr.h"

#include "gpsservice.h"

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

#define SERVAPP_NUM_ATTR_SUPPORTED        11

/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */
// Simple GATT Profile Service UUID: 0xFFF0
CONST uint8 gpsServUUID[ATT_BT_UUID_SIZE] =
{ 
  LO_UINT16(GPS_SERV_UUID), HI_UINT16(GPS_SERV_UUID)
};

// GPS_FEATURES_UUID
CONST uint8 gpsFeaturesUUID[ATT_BT_UUID_SIZE] =
{ 
  LO_UINT16(GPS_FEATURES_UUID), HI_UINT16(GPS_FEATURES_UUID)
};

// GPS_LOCATION_AND_SPEED_UUID
CONST uint8 gpsLocationAndSpeedUUID[ATT_BT_UUID_SIZE] =
{ 
  LO_UINT16(GPS_LOCATION_AND_SPEED_UUID), HI_UINT16(GPS_LOCATION_AND_SPEED_UUID)
};

// GPS_DATE_TIME_UUID
CONST uint8 gpsDateTimeUUID[ATT_BT_UUID_SIZE] =
{ 
  LO_UINT16(GPS_DATE_TIME_UUID), HI_UINT16(GPS_DATE_TIME_UUID)
};

// GPS_POSITION_QUALITY_UUID
CONST uint8 gpsPositionQualityUUID[ATT_BT_UUID_SIZE] =
{ 
  LO_UINT16(GPS_POSITION_QUALITY_UUID), HI_UINT16(GPS_POSITION_QUALITY_UUID)
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

/*********************************************************************
 * Profile Attributes - variables
 */

// Gps Service attribute
static CONST gattAttrType_t gpsService = { ATT_BT_UUID_SIZE, gpsServUUID };

// gpsFeatures Properties
static uint8 gpsFeaturesProps = GATT_PROP_READ;

// gpsFeatures Value
static uint8 gpsFeatures[4] = {0x00, 0x00, 0x60, 0x5D};

// gpsLocationAndSpeed Properties
static uint8 gpsLocationAndSpeedProps = GATT_PROP_NOTIFY;

// gpsLocationAndSpeed Value
static uint8 gpsLocationAndSpeed[17] = {0x00, 0x00,             // flags
                                        0x00, 0x00,             // speed
                                        0x00, 0x00, 0x00, 0x00, // latitude
                                        0x00, 0x00, 0x00, 0x00, // longitude
                                        0x00, 0x00, 0x00,       // elevation
                                        0x00, 0x00};             // heading

static gattCharCfg_t gpsLocationAndSpeedClientCharCfg[GATT_MAX_NUM_CONN];

// gpsDateTime Properties
static uint8 gpsDateTimeProps = GATT_PROP_READ | GATT_PROP_NOTIFY;

// gpsDateTime Value
static uint8 gpsDateTime[7] = {         0x00, 0x00,             // year
                                        0x00,                   // month
                                        0x00,                   // day
                                        0x00,                   // hours
                                        0x00,                   // minutes
                                        0x00};                  // seconds

static gattCharCfg_t gpsDateTimeClientCharCfg[GATT_MAX_NUM_CONN];

// gpsPositionQuality Properties
static uint8 gpsPositionQualityProps = GATT_PROP_READ;// | GATT_PROP_NOTIFY;  notifications are excluded

// gpsPositionQuality Value
static uint8 gpsPositionQuality[16] = {0x00, 0x00,                  // flags
                                       0x00,                        // nb of Beacons in Solution
                                       0x00,                        // nb of Beacons in View
                                       0x00, 0x00,                  // Time to First Fix
                                       0x00, 0x00, 0x00, 0x00,      // EHPE
                                       0x00, 0x00, 0x00, 0x00,      // EVPE
                                       0x00,                        // HDOP
                                       0x00};                       // VDOP

//static gattCharCfg_t gpsPositionQualityClientCharCfg[GATT_MAX_NUM_CONN];

/*********************************************************************
 * Profile Attributes - Table
 */

static gattAttribute_t gpsAttrTbl[SERVAPP_NUM_ATTR_SUPPORTED] = 
{
  // Simple Profile Service
  { 
    { ATT_BT_UUID_SIZE, primaryServiceUUID }, /* type */
    GATT_PERMIT_READ,                         /* permissions */
    0,                                        /* handle */
    (uint8 *)&gpsService                      /* pValue */
  },

    // gpsFeatures Declaration
    { 
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ, 
      0,
      &gpsFeaturesProps 
    },

      // gpsFeatures Value
      { 
        { ATT_BT_UUID_SIZE, gpsFeaturesUUID },
        GATT_PERMIT_READ, 
        0, 
        gpsFeatures 
      },

    // gpsLocationAndSpeed Declaration
    { 
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ, 
      0,
      &gpsLocationAndSpeedProps 
    },

      // gpsLocationAndSpeed Value
      { 
        { ATT_BT_UUID_SIZE, gpsLocationAndSpeedUUID },
        GATT_PERMIT_READ, 
        0, 
        gpsLocationAndSpeed 
      },

      // gpsLocationAndSpeed Client Characteristic Configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)gpsLocationAndSpeedClientCharCfg
      },
      
    // gpsDateTime Declaration
    { 
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ, 
      0,
      &gpsDateTimeProps 
    },

      // gpsDateTime Value
      { 
        { ATT_BT_UUID_SIZE, gpsDateTimeUUID },
        GATT_PERMIT_READ, 
        0, 
        gpsDateTime 
      },

      // gpsDateTime Client Characteristic Configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)gpsDateTimeClientCharCfg
      },
      
    // gpsPositionQuality Declaration
    { 
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ, 
      0,
      &gpsPositionQualityProps
    },

      // gpsPositionQuality Value
      { 
        { ATT_BT_UUID_SIZE, gpsPositionQualityUUID },
        GATT_PERMIT_READ, 
        0, 
        gpsPositionQuality
      }/*,                              // Notifications are excluded

      // gpsPositionQuality Client Characteristic Configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)gpsPositionQualityClientCharCfg
      }*/
};


/*********************************************************************
 * LOCAL FUNCTIONS
 */
static uint8 gps_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr, 
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen );
static bStatus_t gps_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                 uint8 *pValue, uint8 len, uint16 offset );

static void gps_HandleConnStatusCB( uint16 connHandle, uint8 changeType );


/*********************************************************************
 * PROFILE CALLBACKS
 */
// Gps Profile Service Callbacks
CONST gattServiceCBs_t gpsCBs =
{
  gps_ReadAttrCB,  // Read callback function pointer
  gps_WriteAttrCB, // Write callback function pointer
  NULL                       // Authorization callback function pointer
};

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      Gps_AddService
 *
 * @brief   Initializes the Gps Profile service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  Success or Failure
 */
bStatus_t Gps_AddService( uint32 services )
{
  uint8 status = SUCCESS;

  // Initialize Client Characteristic Configuration attributes
  GATTServApp_InitCharCfg( INVALID_CONNHANDLE, gpsLocationAndSpeedClientCharCfg );
  
  // Notifications are excluded
  //GATTServApp_InitCharCfg( INVALID_CONNHANDLE, gpsPositionQualityClientCharCfg );
  GATTServApp_InitCharCfg( INVALID_CONNHANDLE, gpsDateTimeClientCharCfg );
  
  // Register with Link DB to receive link status change callback
  VOID linkDB_Register( gps_HandleConnStatusCB );  
  
  if ( services & GPS_SERVICE )
  {
    // Register GATT attribute list and CBs with GATT Server App
    status = GATTServApp_RegisterService( gpsAttrTbl, 
                                          GATT_NUM_ATTRS( gpsAttrTbl ),
                                          &gpsCBs );
  }

  return ( status );
}

/*********************************************************************
 * @fn      Gps_SetParameter
 *
 * @brief   Set a Gps Profile parameter.
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
bStatus_t Gps_SetParameter( uint8 param, uint8 len, void *value )
{
  bStatus_t ret = SUCCESS;
  switch ( param )
  {
    case GPS_FEATURES:
      if ( len == sizeof(gpsFeatures) ) 
      {
        VOID osal_memcpy( gpsFeatures, value, sizeof(gpsFeatures) );
      }
      else
      {
        ret = bleInvalidRange;
      }
      break;

    case GPS_LOCATION_AND_SPEED:
      if ( len == WIMU_GPS_LOCATION_AND_SPEED_PACKET_SIZE ) 
      {
        VOID osal_memcpy( gpsLocationAndSpeed, value, WIMU_GPS_LOCATION_AND_SPEED_PACKET_SIZE );
        
        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( gpsLocationAndSpeedClientCharCfg, gpsLocationAndSpeed, FALSE,
                                   gpsAttrTbl, GATT_NUM_ATTRS( gpsAttrTbl ),
                                   INVALID_TASK_ID );
      }
      else
      {
        ret = bleInvalidRange;
      }
    break;
    
    case GPS_DATE_TIME:
      if ( len == WIMU_GPS_DATE_TIME_PACKET_SIZE ) 
      {
        VOID osal_memcpy( gpsDateTime, value, WIMU_GPS_DATE_TIME_PACKET_SIZE );
        
        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( gpsDateTimeClientCharCfg, gpsDateTime, FALSE,
                                   gpsAttrTbl, GATT_NUM_ATTRS( gpsAttrTbl ),
                                   INVALID_TASK_ID );
      }
      else
      {
        ret = bleInvalidRange;
      }
    break;
      
    case GPS_POSITION_QUALITY:
      if ( len == WIMU_GPS_POSITION_QUALITY_PACKET_SIZE ) 
      {
        VOID osal_memcpy( gpsPositionQuality, value, WIMU_GPS_POSITION_QUALITY_PACKET_SIZE );
        
        // See if Notification has been enabled
        // Notifications are excluded (https://developer.bluetooth.org)
/*        GATTServApp_ProcessCharCfg( gpsPositionQualityClientCharCfg, gpsPositionQuality, FALSE,
                                   gpsAttrTbl, GATT_NUM_ATTRS( gpsAttrTbl ),
                                   INVALID_TASK_ID );*/
      }
      else
      {
        ret = bleInvalidRange;
      }
      break;
  }
  
  return ( ret );
}

/*********************************************************************
 * @fn      Gps_GetParameter
 *
 * @brief   Get a Gps Profile parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to put.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate 
 *          data type (example: data type of uint16 will be cast to 
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Gps_GetParameter( uint8 param, void *value )
{
  bStatus_t ret = SUCCESS;
  switch ( param )
  {
    case GPS_FEATURES:
      osal_memcpy (value, gpsFeatures, sizeof(gpsFeatures) );
      break;

    case GPS_LOCATION_AND_SPEED:
      osal_memcpy (value, gpsLocationAndSpeed, WIMU_GPS_LOCATION_AND_SPEED_PACKET_SIZE );
      break;      

    case GPS_DATE_TIME:
      osal_memcpy (value, gpsDateTime, WIMU_GPS_DATE_TIME_PACKET_SIZE );
      break;      

    case GPS_POSITION_QUALITY:
      osal_memcpy (value, gpsPositionQuality, WIMU_GPS_POSITION_QUALITY_PACKET_SIZE );
      break;  

    default:
      ret = INVALIDPARAMETER;
      break;
  }
  
  return ( ret );
}

/*********************************************************************
 * @fn          gps_ReadAttrCB
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
static uint8 gps_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr, 
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen )
{
  bStatus_t status = SUCCESS;

  // If attribute permissions require authorization to read, return error
  if ( gattPermitAuthorRead( pAttr->permissions ) )
  {
    // Insufficient authorization
    return ( ATT_ERR_INSUFFICIENT_AUTHOR );
  }
 
  if ( pAttr->type.len == ATT_BT_UUID_SIZE )
  {
    // 16-bit UUID
    uint16 uuid = BUILD_UINT16( pAttr->type.uuid[0], pAttr->type.uuid[1]);
    switch ( uuid )
    {
      case GPS_FEATURES_UUID:
        *pLen = 4;
        osal_memcpy( pValue, pAttr->pValue, 4 );
        break;
        
      case GPS_LOCATION_AND_SPEED_UUID:
        *pLen = WIMU_GPS_LOCATION_AND_SPEED_PACKET_SIZE;
        osal_memcpy( pValue, pAttr->pValue, WIMU_GPS_LOCATION_AND_SPEED_PACKET_SIZE );
        break;

      case GPS_DATE_TIME_UUID:
        *pLen = WIMU_GPS_DATE_TIME_PACKET_SIZE;
        osal_memcpy( pValue, pAttr->pValue, WIMU_GPS_DATE_TIME_PACKET_SIZE );
        break;
        
      case GPS_POSITION_QUALITY_UUID:
        *pLen = WIMU_GPS_POSITION_QUALITY_PACKET_SIZE;
        osal_memcpy( pValue, pAttr->pValue, WIMU_GPS_POSITION_QUALITY_PACKET_SIZE );
        break;
        
      default:
        // Should never get here!
        *pLen = 0;
        status = ATT_ERR_ATTR_NOT_FOUND;
        break;
    }
  }
  else
  {
    // 128-bit UUID
    *pLen = 0;
    status = ATT_ERR_INVALID_HANDLE;
  }

  return ( status );
}

/*********************************************************************
 * @fn      gps_WriteAttrCB
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
static bStatus_t gps_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                 uint8 *pValue, uint8 len, uint16 offset )
{
  bStatus_t status = SUCCESS;
  
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
  
  return ( status );
}

/*********************************************************************
 * @fn          gps_HandleConnStatusCB
 *
 * @brief       Gps Profile link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
static void gps_HandleConnStatusCB( uint16 connHandle, uint8 changeType )
{ 
  // Make sure this is not loopback connection
  if ( connHandle != LOOPBACK_CONNHANDLE )
  {
    // Reset Client Char Config if connection has dropped
    if ( ( changeType == LINKDB_STATUS_UPDATE_REMOVED )      ||
         ( ( changeType == LINKDB_STATUS_UPDATE_STATEFLAGS ) &&
           ( !linkDB_Up( connHandle ) ) ) )
    {
      GATTServApp_InitCharCfg( connHandle, gpsLocationAndSpeedClientCharCfg ); 
      //GATTServApp_InitCharCfg( connHandle, gpsPositionQualityClientCharCfg );
      GATTServApp_InitCharCfg( connHandle, gpsDateTimeClientCharCfg );
    }
  }
}


/*********************************************************************
*********************************************************************/
