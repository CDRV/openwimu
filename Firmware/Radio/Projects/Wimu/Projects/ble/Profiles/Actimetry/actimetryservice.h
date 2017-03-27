/**************************************************************************************************
  Filename:       actimetryservice.h

  Description:    Actimetry service definitions and prototypes. Based on
                  Gyroscope service from Sensors profile.
                  
                  The service consists of one characteristic which stores
                  the 20-byte value defined by specification. It allows 
                  to send this data via notifications or read it directly.

**************************************************************************************************/

#ifndef ACTIMETRYSERVICE_H
#define ACTIMETRYSERVICE_H

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

// If uncommented 128 bit UUIDs are used
//#define WIMU_LONG_UUIDS
/* 
  128 bit Version 1 UUIDs generated on http://www.uuidgenerator.net/
  Macro as in Components\ble\include\bcomdef.h 
*/
#ifdef WIMU_LONG_UUIDS
#  define WIMU_ACTIMETRY_UUID(uuid) 0x5e, 0xc0, 0xae, 0x91, 0x3c, 0xf2, 0x5b, 0x9f, 0xe2, 0x11, 0x93, 0xe3, LO_UINT16(uuid), HI_UINT16(uuid), 0xb3, 0x91
#  define WIMU_ACTIMETRY_UUID_SIZE ATT_UUID_SIZE
#else
#  define WIMU_ACTIMETRY_UUID(uuid) LO_UINT16(uuid), HI_UINT16(uuid)
#  define WIMU_ACTIMETRY_UUID_SIZE ATT_BT_UUID_SIZE
#endif

// Service UUIDs
#define ACTIMETRY_SERV_UUID             0x70ee  //91b370ee-e393-11e2-9f5b-f23c91aec05e
#define ACTIMETRY_IMU_UUID              0x7486  //91b37486-e393-11e2-9f5b-f23c91aec05e
#define ACTIMETRY_QUATERNION_UUID       0X759d  //91b3759d-e393-11e2-9f5b-f23c91aec05e
#define ACTIMETRY_CONFIG_UUID           0x76ac  //91b376ac-e393-11e2-9f5b-f23c91aec05e
#define ACTIMETRY_CONTROL_UUID          0x76ad  //91b376ad-e393-11e2-9f5b-f23c91aec05e
  
// Profile Parameters
#define ACTIMETRY_IMU                   12     // RN uint8 - Profile Attribute value
#define ACTIMETRY_QUATERNION            13     // RN uint8 - Profile Attribute value
#define ACTIMETRY_CONFIG                14     // RW uint8 - Profile Attribute value
#define ACTIMETRY_CONTROL               15     // RW uint8 - Profile Attribute value

// Actimetry control flags
#define ACT_CTRL_FLAG_REC      0x0001
  
// Sensor Profile Services bit fields
#define ACTIMETRY_SERVICE               0x00000020

// Length of sensor data in bytes
#define ACTIMETRY_IMU_LEN              20

/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

// Callback when a characteristic value has changed
typedef NULL_OK void (*actimetryChange_t)( uint8 paramID );

typedef struct
{
  actimetryChange_t        pfnActimetryChange;  // Called when characteristic value changes
} actimetryCBs_t;


/*********************************************************************
 * API FUNCTIONS
 */


/*
 * Actimetry_AddService- Initializes the Sensor GATT Profile service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 */
extern bStatus_t Actimetry_AddService( uint32 services );

/*
 * Actimetry_RegisterAppCBs - Registers the application callback function.
 *                    Only call this function once.
 *
 *    appCallbacks - pointer to application callbacks.
 */
extern bStatus_t Actimetry_RegisterAppCBs( actimetryCBs_t *appCallbacks );

/*
 * Actimetry_SetParameter - Set a Sensor GATT Profile parameter.
 *
 *    param - Profile parameter ID
 *    len   - length of data to write
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 */
extern bStatus_t Actimetry_SetParameter( uint8 param, uint8 len, void *value );

/*
 * Actimetry_GetParameter - Get a Sensor GATT Profile parameter.
 *
 *    param - Profile parameter ID
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 */
extern bStatus_t Actimetry_GetParameter( uint8 param, void *value );


/*********************************************************************
*********************************************************************/

#ifdef __cplusplus
}
#endif

#endif /* ACTIMETRYSERVICE_H */
