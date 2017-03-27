/**************************************************************************************************
  Filename:       battservice.c
  Revised:        $Date $
  Revision:       $Revision $

  Description:    This file contains the Battery service.

  Copyright 2012-2013 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
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

#include "battservice.h"
#include "wimu_util.h"
#include "st_util.h"

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

// ADC voltage level
#define BATT_ADC_LEVEL_3V           409
#define BATT_ADC_LEVEL_2V           273

#define BATT_LEVEL_VALUE_IDX        2 // Position of battery level in attribute array
#define BATT_LEVEL_VALUE_CCCD_IDX   3 // Position of battery level CCCD in attribute array

/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */
// Battery service
CONST uint8 battServUUID[ATT_BT_UUID_SIZE] =
{
  LO_UINT16(BATT_SERVICE_UUID), HI_UINT16(BATT_SERVICE_UUID)
};

// Battery level characteristic
CONST uint8 battLevelUUID[ATT_BT_UUID_SIZE] =
{
  LO_UINT16(BATT_LEVEL_UUID), HI_UINT16(BATT_LEVEL_UUID)
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

// Application callback
//static battServiceCB_t battServiceCB;

static batteryCBs_t *Battery_AppCBs = NULL;

// Measurement setup callback
//static battServiceSetupCB_t battServiceSetupCB = NULL;

// Measurement teardown callback
//static battServiceTeardownCB_t battServiceTeardownCB = NULL;

// Measurement calculation callback
//static battServiceCalcCB_t battServiceCalcCB = NULL;

//static uint16 battMinLevel = BATT_ADC_LEVEL_2V; // For VDD/3 measurements
//static uint16 battMaxLevel = BATT_ADC_LEVEL_3V; // For VDD/3 measurements*/

// Critical battery level setting

// ADC channel to be used for reading
//static uint8 battServiceAdcCh = HAL_ADC_CHANNEL_VDD;

/*********************************************************************
 * Profile Attributes - variables
 */

// Battery Service attribute
static CONST gattAttrType_t battService = { ATT_BT_UUID_SIZE, battServUUID };

// Battery level characteristic
static uint8 battLevelProps = GATT_PROP_READ | GATT_PROP_NOTIFY;
static uint8 battLevel = 0;
static gattCharCfg_t battLevelClientCharCfg[GATT_MAX_NUM_CONN];

/*********************************************************************
 * Profile Attributes - Table
 */

static gattAttribute_t battAttrTbl[] =
{
  // Battery Service
  {
    { ATT_BT_UUID_SIZE, primaryServiceUUID }, /* type */
    GATT_PERMIT_READ,                         /* permissions */
    0,                                        /* handle */
    (uint8 *)&battService                     /* pValue */
  },

    // Battery Level Declaration
    {
      { ATT_BT_UUID_SIZE, characterUUID },
      GATT_PERMIT_READ,
      0,
      &battLevelProps
    },

      // Battery Level Value
      {
        { ATT_BT_UUID_SIZE, battLevelUUID },
        GATT_PERMIT_READ,
        0,
        &battLevel
      },

      // Battery Level Client Characteristic Configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)battLevelClientCharCfg
      }
};


/*********************************************************************
 * LOCAL FUNCTIONS
 */
static uint8 battReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                             uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen );
static bStatus_t battWriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                  uint8 *pValue, uint8 len, uint16 offset );
//static void battNotifyCB( linkDBItem_t *pLinkItem );
//static uint8 battMeasure( void );
//static void battNotifyLevel( void );

/*********************************************************************
 * PROFILE CALLBACKS
 */
// Battery Service Callbacks
CONST gattServiceCBs_t battCBs =
{
  battReadAttrCB,  // Read callback function pointer
  battWriteAttrCB, // Write callback function pointer
  NULL             // Authorization callback function pointer
};

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      Batt_AddService
 *
 * @brief   Initializes the Battery Service by registering
 *          GATT attributes with the GATT server.
 *
 * @return  Success or Failure
 */
bStatus_t Batt_AddService( void )
{
  uint8 status = SUCCESS;

  // Initialize Client Characteristic Configuration attributes
  GATTServApp_InitCharCfg( INVALID_CONNHANDLE, battLevelClientCharCfg );

  // Register GATT attribute list and CBs with GATT Server App
  status = GATTServApp_RegisterService( battAttrTbl,
                                        GATT_NUM_ATTRS( battAttrTbl ),
                                        &battCBs );

  return ( status );
}

/*********************************************************************
 * @fn      Batt_Register
 *
 * @brief   Register a callback function with the Battery Service.
 *
 * @param   pfnServiceCB - Callback function.
 *
 * @return  None.
 */
bStatus_t Batt_Register( batteryCBs_t *appCallbacks )
{
  if ( Battery_AppCBs == NULL )
  {
    if ( appCallbacks != NULL )
    {
      Battery_AppCBs = appCallbacks;
    }

    return ( SUCCESS );
  }

  return ( bleAlreadyInRequestedMode );
}
/*********************************************************************
 * @fn      Batt_SetParameter
 *
 * @brief   Set a Battery Service parameter.
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
bStatus_t Batt_SetParameter( uint8 param, uint8 len, void *value )
{
  bStatus_t ret = SUCCESS;

  switch ( param )
  {
    case BATT_PARAM_LEVEL:
      if ( len == WIMU_BATTERY_PACKET_SIZE )
      {
        battLevel = *((uint8*)value);
        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( battLevelClientCharCfg, &battLevel, FALSE,
                                   battAttrTbl, GATT_NUM_ATTRS( battAttrTbl ),
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
 * @fn      Batt_GetParameter
 *
 * @brief   Get a Battery Service parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to get.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Batt_GetParameter( uint8 param, void *value )
{
  bStatus_t ret = SUCCESS;
  switch ( param )
  {
    case BATT_PARAM_LEVEL:
      *((uint8*)value) = battLevel;
      break;

    default:
      ret = INVALIDPARAMETER;
      break;
  }

  return ( ret );
}

/*********************************************************************
 * @fn          battReadAttrCB
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

static uint8 battReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                             uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen )
{
  bStatus_t status = SUCCESS;

  // Make sure it's not a blob operation (no attributes in the profile are long)
  if ( offset > 0 )
  {
    return ( ATT_ERR_ATTR_NOT_LONG );
  }

  uint16 uuid = BUILD_UINT16( pAttr->type.uuid[0], pAttr->type.uuid[1] );

  // Measure battery level if reading level
  if ( uuid == BATT_LEVEL_UUID )
  {
    *pLen = WIMU_BATTERY_PACKET_SIZE;
    VOID osal_memcpy( pValue, pAttr->pValue, WIMU_BATTERY_PACKET_SIZE );
  }
  else
  {
    status = ATT_ERR_ATTR_NOT_FOUND;
  }

  return ( status );
}

/*********************************************************************
 * @fn      battWriteAttrCB
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
static bStatus_t battWriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
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
 * @fn          Batt_HandleConnStatusCB
 *
 * @brief       Battery Service link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
void Batt_HandleConnStatusCB( uint16 connHandle, uint8 changeType )
{/*
  // Make sure this is not loopback connection
  if ( connHandle != LOOPBACK_CONNHANDLE )
  {
    // Reset Client Char Config if connection has dropped
    if ( ( changeType == LINKDB_STATUS_UPDATE_REMOVED )      ||
         ( ( changeType == LINKDB_STATUS_UPDATE_STATEFLAGS ) &&
           ( !linkDB_Up( connHandle ) ) ) )
    {
      GATTServApp_InitCharCfg( connHandle, battLevelClientCharCfg );
    }
  }*/
}


/*********************************************************************
*********************************************************************/

