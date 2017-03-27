#ifndef WIMU_UTIL_H
#define WIMU_UTIL_H

#ifdef __cplusplus
extern "C"
{
#endif

// WIMU sensor data packet size
#define WIMU_ACTIMETRY_IMU_PACKET_SIZE sizeof(WIMU_actimetry_imu_packet_t)
  
#define WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE sizeof(WIMU_actimetry_quaternion_packet_t)
  
#define WIMU_BATTERY_PACKET_SIZE sizeof(WIMU_battery_packet_t)
  
#define WIMU_DEVINFO_PACKET_SIZE sizeof(WIMU_DevInfoFrame_t)
  
#define WIMU_GPS_LOCATION_AND_SPEED_PACKET_SIZE sizeof(locationAndSpeed_t)
  
#define WIMU_GPS_DATE_TIME_PACKET_SIZE sizeof(date_time_t)
  
#define WIMU_GPS_POSITION_QUALITY_PACKET_SIZE sizeof(positionQuality_t)
  
#define WIMU_GPS_CURRENT_TIME_PACKET_SIZE sizeof(currentTime_t)
   
//#define RAND_SINGED_SHORT osal_rand()-32768
  
//#define RAND_UNSINGED_SHORT osal_rand()

// Unsigned sensor values
typedef struct {
  uint16 x;
  uint16 y;
  uint16 z;
} WIMU_uSensors_t;

// Signed sensor values
typedef struct {
  int16 x;
  int16 y;
  int16 z;
} WIMU_sensors_t;

// WIMU actimetry imu data packet 
typedef struct {
  uint16 seq;
  WIMU_sensors_t acc;
  WIMU_sensors_t gyr;
  WIMU_sensors_t mag;
} WIMU_actimetry_imu_packet_t;

// WIMU actimetry quaternion data packet 
typedef struct {
  float q0;
  float q1;
  float q2;
  float q3;
} WIMU_actimetry_quaternion_packet_t;

// WIMU battery sensor data packet 
typedef struct {
  uint8 batteryValue;
} WIMU_battery_packet_t;

// WIMU device information
typedef struct
{
  uint16  serialNumber;
  uint8	  hardRevision;
  uint8	  firmSoftRevision[29]; //should always be 29 in length (without \r\n)
} WIMU_DevInfoFrame_t;

// WIMU gps sensor data packet
typedef struct
{
  uint16          year;
  uint8           month;
  uint8           day;
  uint8           hours;
  uint8           minutes;
  uint8           seconds;
  
} date_time_t;

typedef struct
{
  uint16          flags;
  uint16          instantSpeed;
  int32           latitude;
  int32           longitude;
  int8            elevation[3];
  uint16          heading;
} locationAndSpeed_t;
  
typedef struct
{
  uint16          flags;
  uint8           beaconsInSolution;
  uint8           beaconsInView;
  uint16          timeFirstFix;
  uint32          ehpe;               // Estimated Horizontal Position Error
  uint32          evpe;               // Estimated Vertical Position Error
  uint8           hdop;               // Horizontal Dilution of Precision
  uint8           vdop;               // Vertical Dilution of Precision
  
} positionQuality_t;

typedef struct
{
  date_time_t         date_time;
  locationAndSpeed_t  loc_speed;
  positionQuality_t   quality;
} WIMU_GPSFrame_t;

// WIMU Current time structure
typedef struct
{
  date_time_t   date_time;
  uint8         day_of_week; // 0=Undefined, 1 = Monday, ...
} dayDateTime_t;

typedef struct
{
  dayDateTime_t day_date_time;
  uint8         fractions256;
} exactTime256_t;

typedef struct
{
  exactTime256_t  exact_time;
  uint8           adjust_reason; // See https://developer.bluetooth.org/gatt/characteristics/Pages/CharacteristicViewer.aspx?u=org.bluetooth.characteristic.current_time.xml
} currentTime_t;

// IMU Config Structure
// NOTE: Not using full WIMU Config, since it would be larger than 22 bytes (limit of attributes size)
typedef struct {
  uint16  enabled_modules;
  uint8   sampling_rate;
  uint8   acc_range;
  uint8   gyro_range;
  uint8   mag_range;
} IMU_Config_t;

typedef struct {
  uint8   status;
  uint16  rec_id;
} RemControl_t;


// Event flags
#define WIMU_CONTROL_EVT 0x0008 // Sends control msg to the WIMU
#define WIMU_TIME_EVT    0x0010 // Update time on WIMU

//static void WIMU_packetInitRand(uint16 seq, WIMU_packet_t* packet);
//static void WIMU_packetInitZero(uint16 seq, WIMU_packet_t* packet);

/**
  * Initialise a packet  with random data
  */
/*
static void WIMU_packetInitRand(uint16 seq, WIMU_actimetry_packet_t* packet){

  packet->seq = seq;
  
  packet->acc.x = RAND_UNSINGED_SHORT;
  packet->acc.y = RAND_UNSINGED_SHORT;
  packet->acc.z = RAND_UNSINGED_SHORT;

  packet->gyr.x = RAND_UNSINGED_SHORT;
  packet->gyr.y = RAND_UNSINGED_SHORT;
  packet->gyr.z = RAND_UNSINGED_SHORT;

  packet->mag.x = RAND_SINGED_SHORT;
  packet->mag.y = RAND_SINGED_SHORT;
  packet->mag.z = RAND_SINGED_SHORT;
  
}
*/
#ifdef __cplusplus
}
#endif

#endif