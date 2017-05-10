#ifndef BLE_H_
#define BLE_H_

#include "imu.h"
#include "gps.h"
#include "power.h"
#include "utils.h"

#define BLE_RX_BUFFER	64	// Maximum number of char that can be received
#define BLE_TX_BUFFER	128	// Maximum number of char that can be sent in one packet

#define BLE_TX_BUF_NUM	5	// Number of TX buffers (number of messages in the queue)
#define BLE_RX_BUF_NUM	2	// Number of RX buffers (number of commands waiting)

#define BLE_IMU_DATA	  1
#define BLE_GPS_DATA	  2
#define BLE_POWER_DATA	  3
#define BLE_DEVINFO_DATA  4
#define BLE_CONTROL_DATA  5
#define BLE_DATETIME_DATA 6
#define BLE_CONFIG_DATA   7

#define BLE_CTRL_FLAG_REC 0x01  // Control flag used to start/stop recording

#define BLE_SYNC_BYTE     0x00  // Sync byte for data flow to BLE chip - used in the Consistent Overhead Byte Stuffing algorithm (COBS) to prevent data with sync value to appear

typedef struct {
  uint8_t data_type;
  //uint16_t length;
  uint8_t length;
  uint8_t* data;
  //uint32_t crc;
} BLEFrame_Struct;

/*typedef struct {
  uint16_t frame_num;
  int16_t acc[3];
  int16_t gyro[3];
  int16_t  mag[3];
} BLE_IMU;*/

typedef struct
{
  uint16_t        year;
  uint8_t         month;
  uint8_t         day;
  uint8_t         hours;
  uint8_t         minutes;
  uint8_t         seconds;
} DateTime_Struct;

typedef struct
{
  DateTime_Struct  date_time;
  uint8_t          day_of_week; // 0=Undefined, 1 = Monday, ...
} DayDateTime_Struct;

typedef struct
{
  DayDateTime_Struct  day_date_time;
  uint8_t             fractions256;
} ExactTime256_Struct;

typedef struct
{
  ExactTime256_Struct     exact_time;
  uint8_t                 adjust_reason; // See https://developer.bluetooth.org/gatt/characteristics/Pages/CharacteristicViewer.aspx?u=org.bluetooth.characteristic.current_time.xml
} CurrentTime_Struct;

typedef struct
{
  uint16_t          flags;
  uint16_t          instantSpeed;
  int32_t           latitude;
  int32_t           longitude;
  int8_t            elevation[3];
  uint16_t          heading;
} LocationAndSpeed_Struct;
  
typedef struct
{
  uint16_t          flags;
  uint8_t           beaconsInSolution;
  uint8_t           beaconsInView;
  uint16_t          timeFirstFix;
  uint32_t          ehpe;               // Estimated Horizontal Position Error
  uint32_t          evpe;               // Estimated Vertical Position Error
  uint8_t           hdop;               // Horizontal Dilution of Precision
  uint8_t           vdop;               // Vertical Dilution of Precision
  
} PositionQuality_Struct;


// OR MASKING ATTRIBUTES
#define GPS_POSITION_QUALITY_INVALID_MASK            0
#define GPS_POSITION_QUALITY_OK_MASK                 0x0080
#define GPS_POSITION_QUALITY_ESTIMATED_MASK          0x0100
#define GPS_POSITION_QUALITY_LASTKNOWN_MASK          0x0180
#define GPS_POSITION_QUALITY_CLEAR_MASK              0x0180 // To be "AND"ed

typedef struct
{
  DateTime_Struct           date_time;
  LocationAndSpeed_Struct   loc_speed;
  PositionQuality_Struct    quality;
} GPSFrame_struct;


typedef struct
{
  uint16_t	serialNumber;
  uint8_t	hardRevision;
  uint8_t	firmSoftRevision[LEN_VERSION_STRING-2]; //should always be 29 in length (without \r\n)
} DEVINFOFrame_Struct;

typedef struct {
  uint16_t  enabled_modules;
  uint16_t  sampling_rate;
  uint8_t   acc_range;
  uint8_t   gyro_range;
  uint8_t   mag_range;
} IMUConfig_Struct;

typedef struct {
  uint8_t   status;
  uint16_t  rec_id;
} RemControl_Struct;

extern volatile unsigned char ble_rx_queue;
extern bool ble_rx_ready; // Set to TRUE when RX data is ready to be processed

extern bool ble_update_time; // Set to true to send the time update to the BLE chip
extern RemControl_Struct ble_control;

// Data frame structures
extern POWERFrame_Struct        POWERFrame;
extern DEVINFOFrame_Struct      DEVINFOFrame;

/////////////////////////////////////////////////////////////////
unsigned char init_ble(void);
unsigned char start_ble(void);
void stop_ble();

void BLE_SetupPower(void);
void BLE_EnablePower(void);
void BLE_DisablePower(void);

unsigned char BLE_process_rx(void);

void BLE_sendIMUData(IMUFrame_Struct* imu_data/*int16_t *acc, int16_t *gyro, int16_t *mag*/);
void BLE_sendPOWERData(POWERFrame_Struct* power_data);
void BLE_sendGPSData(unsigned char* gps_data, unsigned short length, uint8_t frame_type);
void BLE_sendDevInfoData(DEVINFOFrame_Struct* devInfo_data);
void BLE_sendConfig(WIMU_CONFIG* config_data);
void BLE_sendCurrentDateTime();
void BLE_sendRemoteControlData(RemControl_Struct* remCon);

void BLE_sendFrame(BLEFrame_Struct* frame);

void BLE_ConfigRxIRQ(FunctionalState NewState);
void BLE_ConfigTxIRQ(FunctionalState NewState);

// Consistent Overhead Byte Stuffing algorithm (COBS) implementation (https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing)
void COBS_StuffData(const unsigned char *ptr, unsigned long length, unsigned char *dst);
void COBS_UnStuffData(const unsigned char *ptr, unsigned long length, unsigned char *dst);

#endif /*BLE_H_*/
