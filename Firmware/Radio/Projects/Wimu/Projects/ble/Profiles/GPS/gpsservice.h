/**************************************************************************************************
  Filename:       gpsprofile.h
  Creation:       Date: 2015-07-23

  Description:    Gps profile (based on simpleGATT Profile)

**************************************************************************************************/

#ifndef GPSPROFILE_H
#define GPSPROFILE_H

#ifdef __cplusplus
extern "C"
{
#endif

/*********************************************************************
 * INCLUDES
 */

#include "wimu_util.h"
  
/*********************************************************************
 * CONSTANTS
 */

// Profile Parameters
#define GPS_FEATURES                           0  // R uint32 - Profile gpsFeatures       value 
#define GPS_LOCATION_AND_SPEED                 1  // R struct - Profile locationAndSpeed  value
#define GPS_POSITION_QUALITY                   2  // R struct - Profile positionQuality   value
#define GPS_DATE_TIME                          3  // R struct - Profile dateTime          value
  
// Simple Profile Service UUID
#define GPS_SERV_UUID                       0x1819  // Gps service UUID
  
#define GPS_FEATURES_UUID                   0x2A6A  // Gps Features
#define GPS_LOCATION_AND_SPEED_UUID         0x2A67  // Gps Location and Speed Data
#define GPS_DATE_TIME_UUID                  0x2A08  // Gps Date Time
#define GPS_POSITION_QUALITY_UUID           0x2A69  // Gps position quality Data

// Simple Keys Profile Services bit fields
#define GPS_SERVICE               0x00000001

/*********************************************************************
 * TYPEDEFS
 */


/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

/*********************************************************************
 * API FUNCTIONS 
 */

/*
 * Gps_AddService- Initializes the Gps Profile service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 */
extern bStatus_t Gps_AddService( uint32 services );

/*
 * Gps_SetParameter - Set a Gps Profile parameter.
 *
 *    param - Profile parameter ID
 *    len - length of data to right
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate 
 *          data type (example: data type of uint16 will be cast to 
 *          uint16 pointer).
 */
extern bStatus_t Gps_SetParameter( uint8 param, uint8 len, void *value );
  
/*
 * Gps_GetParameter - Get a Gps Profile parameter.
 *
 *    param - Profile parameter ID
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate 
 *          data type (example: data type of uint16 will be cast to 
 *          uint16 pointer).
 */
extern bStatus_t Gps_GetParameter( uint8 param, void *value );

/*********************************************************************
*********************************************************************/

#ifdef __cplusplus
}
#endif

#endif /* GPSPROFILE_H */
