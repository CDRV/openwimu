/**************************************************************************************************
  Filename:       wimu.h

  Description:    This file contains the WIMU application 
                  (based on Simple BLE Peripheral sample application)
                  definitions and prototypes.

**************************************************************************************************/

#ifndef WIMU_H
#define WIMU_H

#ifdef __cplusplus
extern "C"
{
#endif

/*********************************************************************
 * INCLUDES
 */


/*********************************************************************
 * DATA TYPES
 */
  
/*********************************************************************
 * CONSTANTS
 */
  
// Simple BLE Peripheral Task Events
#define SBP_START_DEVICE_EVT                              0x0001
#define SBP_PERIODIC_EVT                                  0x0002
#define SBP_ADV_IN_CONNECTION_EVT                         0x0004
  
#define WIMU_RX_MAX 256

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * FUNCTIONS
 */

/*
 * Task Initialization for the BLE Application
 */
extern void WIMU_Init( uint8 task_id );

/*
 * Task Event Processor for the BLE Application
 */
extern uint16 WIMU_ProcessEvent( uint8 task_id, uint16 events );

/*********************************************************************
*********************************************************************/

#ifdef __cplusplus
}
#endif

#endif /* WIMU_H */
