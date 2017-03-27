/**************************************************************************************************
  Filename:       timeservice.h
  Revised:        $Date $
  Revision:       $Revision $

  Description:    This file contains the Current Time service definitions and
                  prototypes according to the BLE standard

**************************************************************************************************/

#ifndef TIMESERVICE_H
#define TIMESERVICE_H

#ifdef __cplusplus
extern "C"
{
#endif

/*********************************************************************
 * INCLUDES
 */

/*********************************************************************
 * CONSTANTS
 */


// Service UUIDs
#define TIME_SERVICE_UUID               0x1805  // Current Time Service
#define CURRENT_TIME_UUID               0x2A2B  // Current Time Characteristics

// Parameters
#define CURRENT_TIME_PARAM              0

/*********************************************************************
 * TYPEDEFS
 */

// Service callback function
//typedef void (*battServiceCB_t)(uint8 event);


/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

// Callback when a characteristic value has changed
typedef NULL_OK void (*timeChange_t)( uint8 paramID );

typedef struct
{
  timeChange_t        pfnTimeChange;  // Called when characteristic value changes
} timeCBs_t;

/*********************************************************************
 * API FUNCTIONS
 */

/*********************************************************************
 * @fn      Time_AddService
 *
 * @brief   Initializes the Current Time service by registering
 *          GATT attributes with the GATT server.
 *
 * @return  Success or Failure
 */
extern bStatus_t Time_AddService( void );

/*********************************************************************
 * @fn      Time_Register
 *
 * @brief   Register a callback function with the Current Time Service.
 *
 * @param   pfnServiceCB - Callback function.
 *
 * @return  None.
 */
extern bStatus_t Time_Register( timeCBs_t *appCallbacks );

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
extern bStatus_t Time_SetParameter( uint8 param, uint8 len, void *value );

/*********************************************************************
 * @fn      Time_GetParameter
 *
 * @brief   Get a Current Time parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to get.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
extern bStatus_t Time_GetParameter( uint8 param, void *value );

/*********************************************************************
 * @fn          Time_HandleConnStatusCB
 *
 * @brief       Current Time Service link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
void Time_HandleConnStatusCB( uint16 connHandle, uint8 changeType );

/*********************************************************************
*********************************************************************/

#ifdef __cplusplus
}
#endif

#endif /* TIMESERVICE_H */
