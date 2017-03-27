/**************************************************************************************************
  Filename:       wimu.c

  Description:    This file contains the WIMU application 
                  (based on Simple BLE Peripheral sample application).

**************************************************************************************************/

/*********************************************************************
 * INCLUDES
 */
#include <stdio.h>

#include "bcomdef.h"
#include "OSAL.h"
#include "OSAL_PwrMgr.h"

#include "OnBoard.h"
#include "hal_adc.h"
#include "hal_led.h"
#include "hal_key.h"
#include "hal_lcd.h"
#include "hal_uart.h"
#include "hal_defs.h"

#include "gatt.h"

#include "hci.h"

#include "gapgattserver.h"
#include "gattservapp.h"
#include "devinfoservice.h"
#include "battservice.h"
#include "actimetryservice.h"
#include "gpsservice.h"
#include "timeservice.h"

#if defined ( PLUS_BROADCASTER )
  #include "peripheralBroadcaster.h"
#else
  #include "peripheral.h"
#endif

#include "gapbondmgr.h"

#include "wimu.h"

#include "wimu_util.h"
#include "st_util.h"

#if defined FEATURE_OAD
  #include "oad.h"
  #include "oad_target.h"
#endif

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

// ====== Debugging settings ======
/*
  For debugging purposes, code optomization was disabled.
  It can be re-enabled in Options/ C/C++ compiler / Optimizations
*/

// If uncommented, data provided in packets is random
//#define WIMU_RANDOM_DATA

// For debuggin purposes
//#define WIMU_DEBUG


// ====== WIMU UART settings ======
   
#define WIMU_UART_PORT HAL_UART_PORT_1

//#define WIMU_UART_BAUDRATE HAL_UART_BR_2400
//#define WIMU_UART_BAUDRATE HAL_UART_BR_4800
//#define WIMU_UART_BAUDRATE HAL_UART_BR_9600
//#define WIMU_UART_BAUDRATE HAL_UART_BR_14400
//#define WIMU_UART_BAUDRATE HAL_UART_BR_19200
//#define WIMU_UART_BAUDRATE HAL_UART_BR_28800
//#define WIMU_UART_BAUDRATE HAL_UART_BR_38400
//#define WIMU_UART_BAUDRATE HAL_UART_BR_57600
//#define WIMU_UART_BAUDRATE HAL_UART_BR_76800
//#define WIMU_UART_BAUDRATE HAL_UART_BR_115200
#define WIMU_UART_BAUDRATE HAL_UART_BR_230400

#define WIMU_UART_PARITY HAL_UART_NO_PARITY
#define WIMU_UART_STOPBITS HAL_UART_ONE_STOP_BIT
#define WIMU_UART_FLOWCONTROL HAL_UART_FLOW_OFF

// ====== WIMU Message Protocole ======
#define WIMU_SYNC_BYTE    0x00

#define WIMU_MSGTYPE_IMU      1
#define WIMU_MSGTYPE_GPS      2
#define WIMU_MSGTYPE_BATTERY  3
#define WIMU_MSGTYPE_DEVINFO  4
#define WIMU_MSGTYPE_CONTROL  5
#define WIMU_MSGTYPE_DATETIME 6
#define WIMU_MSGTYPE_CONFIG   7

#define WIMU_MSGTYPE_NUM      7

//#define WIMU_ACTIMETRY_DATALEN        40     // Expected data length for IMU Data, including header and CRC
//#define WIMU_BATTERY_DATALEN          5      // Expected data length for BATTERY Data, including header and CRC
//#define WIMU_GPS_NAVIGATION_DATALEN   103    // Expected data length for GPS Data, including header and CRC
//#define WIMU_DEVINFO_DATALEN          36     // Expected data length for Dev Info, including header and CRC

// ====== Application configuration ======   

// How often to perform periodic event
#define SBP_PERIODIC_EVT_PERIOD                   5
   
// ====== BLE stack configuration ======   
  
// What is the advertising interval when device is discoverable (units of 625us, 160=100ms)
#define DEFAULT_ADVERTISING_INTERVAL          160

/*
  This is set to true to renegotiate the connection interval
*/
// Whether to enable automatic parameter update request when a connection is formed
#define DEFAULT_ENABLE_UPDATE_REQUEST         FALSE

// Limited discoverable mode advertises for 30.72s, and then stops
// General discoverable mode advertises indefinitely

#define DEFAULT_DISCOVERABLE_MODE             GAP_ADTYPE_FLAGS_GENERAL


/*
  Adjust the connection interval so that there is less 
  than 4 notifications that have to be transferred on each connection
  event.
*/
// Minimum connection interval (units of 1.25ms, 80=100ms) if automatic parameter update request is enabled
#define DEFAULT_DESIRED_MIN_CONN_INTERVAL     4//12

// Maximum connection interval (units of 1.25ms, 800=1000ms) if automatic parameter update request is enabled
#define DEFAULT_DESIRED_MAX_CONN_INTERVAL     4//12

// Slave latency to use if automatic parameter update request is enabled
#define DEFAULT_DESIRED_SLAVE_LATENCY         0


// Supervision timeout value (units of 10ms, 1000=10s) if automatic parameter update request is enabled
#define DEFAULT_DESIRED_CONN_TIMEOUT          1600

// Company Identifier: Texas Instruments Inc. (13)
#define TI_COMPANY_ID                         0x000D

#define INVALID_CONNHANDLE                    0xFFFF

// Length of bd addr as a string
#define B_ADDR_STR_LEN                        15

#if defined ( PLUS_BROADCASTER )
  #define ADV_IN_CONN_WAIT                    500 // delay 500 ms
#endif

/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */

//uint16 packetCount=0;
//bool sensorsReadEnabler = true;
//static uint16 numCalls=0;
//static uint16 seqNums[200];

/*********************************************************************
 * EXTERNAL VARIABLES
 */

/*********************************************************************
 * EXTERNAL FUNCTIONS
 */

/*********************************************************************
 * LOCAL VARIABLES
 */

static uint8 WIMU_TaskID;   // Task ID for internal task/event processing

// GAP - SCAN RSP data (max size = 31 bytes)
static uint8 scanRspData[] =
{
  // complete name
  0x0B,   // length of this data
  GAP_ADTYPE_LOCAL_NAME_COMPLETE,
  'W',   
  'I',   
  'M',   
  'U',
  '3',
  '-',
  'x',
  'x',
  'x',
  'x',

  // connection interval range
 /* 0x05,   // length of this data
  GAP_ADTYPE_SLAVE_CONN_INTERVAL_RANGE,
  LO_UINT16( DEFAULT_DESIRED_MIN_CONN_INTERVAL ),  
  HI_UINT16( DEFAULT_DESIRED_MIN_CONN_INTERVAL ),
  LO_UINT16( DEFAULT_DESIRED_MAX_CONN_INTERVAL ),  
  HI_UINT16( DEFAULT_DESIRED_MAX_CONN_INTERVAL ),

  // Tx power level
  0x02,   // length of this data
  GAP_ADTYPE_POWER_LEVEL,
  0       // 0dBm*/
};

// GAP - Advertisement data (max size = 31 bytes, though this is
// best kept short to conserve power while advertisting)
static uint8 advertData[] =
{
  // Flags; this sets the device to use limited discoverable
  // mode (advertises for 30 seconds at a time) instead of general
  // discoverable mode (advertises indefinitely)
  0x02,   // length of this data
  GAP_ADTYPE_FLAGS,
  DEFAULT_DISCOVERABLE_MODE | GAP_ADTYPE_FLAGS_BREDR_NOT_SUPPORTED,

  // service UUID, to notify central devices what services are included
  // in this peripheral
  0x07,   // length of this data
#ifdef WIMU_LONG_UUIDS
  GAP_ADTYPE_128BIT_MORE,
#else
  GAP_ADTYPE_16BIT_MORE,
#endif
  // some of the UUID's, but not all
  WIMU_ACTIMETRY_UUID(ACTIMETRY_SERV_UUID),
  LO_UINT16(GPS_SERV_UUID),
  HI_UINT16(GPS_SERV_UUID),
  LO_UINT16(BATT_SERVICE_UUID),
  HI_UINT16(BATT_SERVICE_UUID),
  LO_UINT16(TIME_SERVICE_UUID),
  HI_UINT16(TIME_SERVICE_UUID)
};

// GAP GATT Attributes
static uint8 attDeviceName[5] = "WIMU3";

uint8 rx_byte[WIMU_RX_MAX];
uint16 rx_index=0;
uint16 rx_len=0;

/*********************************************************************
 * LOCAL FUNCTIONS
 */
static void performPeriodicTask( void );
static void WIMU_UARTCallback (uint8 port, uint8 event);
static void WIMU_updateProfileSensors( void );
uint8 WIMU_getEndOfFrame_Position(void);
//void WIMU_SyncRX();
// Consistent Overhead Byte Stuffing algorithm (COBS) implementation (https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing)
void COBS_StuffData(const unsigned char *ptr, unsigned long length, unsigned char *dst);
void COBS_UnStuffData(const unsigned char *ptr, unsigned long length, unsigned char *dst);

/*********************************************************************
 * PROFILE CALLBACKS
 */

// GAP Role Callbacks
static gapRolesCBs_t WIMU_PeripheralCBs =
{
  NULL,                           // Profile State Change Callbacks
  NULL                            // When a valid RSSI is read from controller (not used by application)
};

// GAP Bond Manager Callbacks
static gapBondCBs_t WIMU_BondMgrCBs =
{
  NULL,                     // Passcode callback (not used by application)
  NULL                      // Pairing / Bonding state Callback (not used by application)
};


static void WIMU_openUART( void ){
    
    osal_memset(&rx_byte[0],0xFF, WIMU_RX_MAX);
  
    halUARTCfg_t uartConf;
    
    uartConf.configured =         TRUE;
    uartConf.baudRate =           WIMU_UART_BAUDRATE;
    uartConf.flowControl =        WIMU_UART_FLOWCONTROL;
    uartConf.flowControlThreshold=128; // Not used
    uartConf.idleTimeout =        6; // Not used
    uartConf.rx.maxBufSize =      256; // Not used
    uartConf.tx.maxBufSize =      50; // Not used
    uartConf.intEnable =          TRUE;
    uartConf.callBackFunc =       &WIMU_UARTCallback;
        
    HalUARTOpen(WIMU_UART_PORT, &uartConf);
    
};

void WIMU_requestDevInfo( void ){
  uint8 msg[2] = {WIMU_MSGTYPE_DEVINFO, 0};
  uint8 stuffed[4];
  
  COBS_StuffData(&msg[0], 3, &stuffed[0]);
  stuffed[3] = WIMU_SYNC_BYTE;
  
  HalUARTWrite(WIMU_UART_PORT, stuffed, 4);
}
/*
void WIMU_requestConfig( void ){
  uint8 msg[2] = {WIMU_MSGTYPE_CONFIG, 0};
  uint8 stuffed[4];
  
  COBS_StuffData(&msg[0], 3, &stuffed[0]);
  stuffed[3] = WIMU_SYNC_BYTE;
  
  HalUARTWrite(WIMU_UART_PORT, stuffed, 4);
}*/

void WIMU_setControlMode( uint8* config ){
  uint8 msg[2 + sizeof(RemControl_t)];
  msg[0] = WIMU_MSGTYPE_CONTROL;
  msg[1] = sizeof(RemControl_t);
  osal_memcpy(&msg[2], config, sizeof(RemControl_t));
  uint8 stuffed[2 + sizeof(RemControl_t) + 2];
  stuffed[2 + sizeof(RemControl_t) + 1] = WIMU_SYNC_BYTE;
  
  COBS_StuffData(&msg[0], 2 + sizeof(RemControl_t), &stuffed[0]);
    
  HalUARTWrite(WIMU_UART_PORT, stuffed, 2 + sizeof(RemControl_t) + 2);
}

void WIMU_setCurrentTime( uint8* current ){
  uint8 msg[2 + WIMU_GPS_CURRENT_TIME_PACKET_SIZE];
  msg[0] = WIMU_MSGTYPE_DATETIME;
  msg[1] = WIMU_GPS_CURRENT_TIME_PACKET_SIZE;
  osal_memcpy(&msg[2], current, WIMU_GPS_CURRENT_TIME_PACKET_SIZE);
  
  uint8 stuffed[2 + WIMU_GPS_CURRENT_TIME_PACKET_SIZE + 2];
  stuffed[2 + WIMU_GPS_CURRENT_TIME_PACKET_SIZE + 1] = WIMU_SYNC_BYTE;
  
  COBS_StuffData(&msg[0], 2 + WIMU_GPS_CURRENT_TIME_PACKET_SIZE, &stuffed[0]);
    
  HalUARTWrite(WIMU_UART_PORT, stuffed, 2 + WIMU_GPS_CURRENT_TIME_PACKET_SIZE + 2);
}

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      WIMU_Init
 *
 * @brief   Initialization function for the Simple BLE Peripheral App Task.
 *          This is called during initialization and should contain
 *          any application specific initialization (ie. hardware
 *          initialization/setup, table initialization, power up
 *          notificaiton ... ).
 *
 * @param   task_id - the ID assigned by OSAL.  This ID should be
 *                    used to send messages and set timers.
 *
 * @return  none
 */
void WIMU_Init( uint8 task_id )
{
  WIMU_TaskID = task_id;

  // Setup the GAP Peripheral Role Profile
  {
    
    // Start advertising upon initialization
    uint8 initial_advertising_enable = TRUE;
    
    // By setting this to zero, the device will go into the waiting state after
    // being discoverable for 30.72 seconds, and will not being advertising again
    // until the enabler is set back to TRUE
    uint16 gapRole_AdvertOffTime = 0;

    uint8 enable_update_request = DEFAULT_ENABLE_UPDATE_REQUEST;
    uint16 desired_min_interval = DEFAULT_DESIRED_MIN_CONN_INTERVAL;
    uint16 desired_max_interval = DEFAULT_DESIRED_MAX_CONN_INTERVAL;
    uint16 desired_slave_latency = DEFAULT_DESIRED_SLAVE_LATENCY;
    uint16 desired_conn_timeout = DEFAULT_DESIRED_CONN_TIMEOUT;

    // Set the GAP Role Parameters
    GAPRole_SetParameter( GAPROLE_ADVERT_ENABLED, sizeof( uint8 ), &initial_advertising_enable );
    GAPRole_SetParameter( GAPROLE_ADVERT_OFF_TIME, sizeof( uint16 ), &gapRole_AdvertOffTime );

    GAPRole_SetParameter( GAPROLE_SCAN_RSP_DATA, sizeof ( scanRspData ), scanRspData );
    GAPRole_SetParameter( GAPROLE_ADVERT_DATA, sizeof( advertData ), advertData );

    GAPRole_SetParameter( GAPROLE_PARAM_UPDATE_ENABLE, sizeof( uint8 ), &enable_update_request );
    GAPRole_SetParameter( GAPROLE_MIN_CONN_INTERVAL, sizeof( uint16 ), &desired_min_interval );
    GAPRole_SetParameter( GAPROLE_MAX_CONN_INTERVAL, sizeof( uint16 ), &desired_max_interval );
    GAPRole_SetParameter( GAPROLE_SLAVE_LATENCY, sizeof( uint16 ), &desired_slave_latency );
    GAPRole_SetParameter( GAPROLE_TIMEOUT_MULTIPLIER, sizeof( uint16 ), &desired_conn_timeout );
    
  }

  // Set the GAP Characteristics
  uint8 devNamePermission = GATT_PERMIT_READ|GATT_PERMIT_WRITE; 
  GGS_SetParameter( GGS_W_PERMIT_DEVICE_NAME_ATT, sizeof ( uint8 ), &devNamePermission );
  GGS_SetParameter( GGS_DEVICE_NAME_ATT, GAP_DEVICE_NAME_LEN, attDeviceName );

  // Set advertising interval
  {
    uint16 advInt = DEFAULT_ADVERTISING_INTERVAL;

    GAP_SetParamValue( TGAP_LIM_DISC_ADV_INT_MIN, advInt );
    GAP_SetParamValue( TGAP_LIM_DISC_ADV_INT_MAX, advInt );
    GAP_SetParamValue( TGAP_GEN_DISC_ADV_INT_MIN, advInt );
    GAP_SetParamValue( TGAP_GEN_DISC_ADV_INT_MAX, advInt );
  }

  // Setup the GAP Bond Manager
/*  {
    uint32 passkey = 0; // passkey "000000"
    uint8 pairMode = GAPBOND_PAIRING_MODE_WAIT_FOR_REQ;
    uint8 mitm = TRUE;
    uint8 ioCap = GAPBOND_IO_CAP_DISPLAY_ONLY;
    uint8 bonding = TRUE;
    GAPBondMgr_SetParameter( GAPBOND_DEFAULT_PASSCODE, sizeof ( uint32 ), &passkey );
    GAPBondMgr_SetParameter( GAPBOND_PAIRING_MODE, sizeof ( uint8 ), &pairMode );
    GAPBondMgr_SetParameter( GAPBOND_MITM_PROTECTION, sizeof ( uint8 ), &mitm );
    GAPBondMgr_SetParameter( GAPBOND_IO_CAPABILITIES, sizeof ( uint8 ), &ioCap );
    GAPBondMgr_SetParameter( GAPBOND_BONDING_ENABLED, sizeof ( uint8 ), &bonding );
  }*/

  // Initialize GATT attributes
  GGS_AddService( GATT_ALL_SERVICES );            // GAP
  GATTServApp_AddService( GATT_ALL_SERVICES );    // GATT attributes
  
  Actimetry_AddService( GATT_ALL_SERVICES );      // Actimetry Service
  DevInfo_AddService();                           // Device Information Service
  Batt_AddService();                              // Battery Service
  Gps_AddService(GATT_ALL_SERVICES);              // Gps service
  Time_AddService();                              // Current Time Service


#if defined FEATURE_OAD
  VOID OADTarget_AddService();                    // OAD Profile
#endif

  // Enable clock divide on halt
  // This reduces active current while radio is active and CC254x MCU
  // is halted
  //HCI_EXT_ClkDivOnHaltCmd( HCI_EXT_ENABLE_CLK_DIVIDE_ON_HALT );

#if defined ( DC_DC_P0_7 )

  // Enable stack to toggle bypass control on TPS62730 (DC/DC converter)
  HCI_EXT_MapPmIoPortCmd( HCI_EXT_PM_IO_PORT_P0, HCI_EXT_PM_IO_PORT_PIN7 );

#endif // defined ( DC_DC_P0_7 )

  // Initialize UART
  HalUARTInit();
  
  osal_memset(&rx_byte[rx_index],0xFF, WIMU_RX_MAX);
  
  // Open UART
  WIMU_openUART();
  
  // Setup a delayed profile startup
  osal_set_event( WIMU_TaskID, SBP_START_DEVICE_EVT );
  
  osal_set_event( WIMU_TaskID, GAPROLE_ADVERT_ENABLED);
  
  // Request dev info
//  WIMU_requestDevInfo();
}

/*********************************************************************
 * @fn      WIMU_ProcessEvent
 *
 * @brief   Simple BLE Peripheral Application Task event processor.  This function
 *          is called to process all events for the task.  Events
 *          include timers, messages and any other user defined events.
 *
 * @param   task_id  - The OSAL assigned task ID.
 * @param   events - events to process.  This is a bit map and can
 *                   contain more than one event.
 *
 * @return  events not processed
 */
uint16 WIMU_ProcessEvent( uint8 task_id, uint16 events )
{

  VOID task_id; // OSAL required parameter that isn't used in this function
///////////////////////////////////////////////////////
  if ( events & SYS_EVENT_MSG )
  {
    uint8 *pMsg;

    if ( (pMsg = osal_msg_receive( WIMU_TaskID )) != NULL )
    {
      //WIMU_ProcessOSALMsg( (osal_event_hdr_t *)pMsg );

      // Release the OSAL message
      VOID osal_msg_deallocate( pMsg );
    }

    // return unprocessed events
    return (events ^ SYS_EVENT_MSG);
  }
/////////////////////////////////////////
  if ( events & SBP_START_DEVICE_EVT )
  {
    // Start the Device
    VOID GAPRole_StartDevice( &WIMU_PeripheralCBs );

    // Start Bond Manager
    VOID GAPBondMgr_Register( &WIMU_BondMgrCBs );

//    // Open UART
   // WIMU_openUART();
        
    // Set timer for first periodic event
    osal_start_timerEx( WIMU_TaskID, SBP_PERIODIC_EVT, SBP_PERIODIC_EVT_PERIOD );

    return ( events ^ SBP_START_DEVICE_EVT );
  }
//////////////////////////////////////////////
  if ( events & SBP_PERIODIC_EVT )
  {
    // Restart timer
    if ( SBP_PERIODIC_EVT_PERIOD )
    {
      osal_start_timerEx( WIMU_TaskID, SBP_PERIODIC_EVT, SBP_PERIODIC_EVT_PERIOD );
    }

    // Perform periodic application task
    performPeriodicTask();

    return (events ^ SBP_PERIODIC_EVT);
  }
  
/////////////////////////////////////////////
  if ( events & GAPROLE_ADVERT_ENABLED )
  {

    // Request dev info
    WIMU_requestDevInfo();
        
    // Request module config
    //WIMU_requestConfig();
    
    return (events ^ GAPROLE_ADVERT_ENABLED);
  }
/////////////////////////////////////////////
  if ( events & WIMU_CONTROL_EVT){
    //uint8 config;
    uint8 config[sizeof(RemControl_t)];
    Actimetry_GetParameter(ACTIMETRY_CONTROL, &config);
    
    WIMU_setControlMode(config);
    
    return (events ^ WIMU_CONTROL_EVT);
  }
  
/////////////////////////////////////////////
  if ( events & WIMU_TIME_EVT){
    uint8 currentTime[WIMU_GPS_CURRENT_TIME_PACKET_SIZE];
    
    Time_GetParameter(CURRENT_TIME_PARAM, &currentTime);
    
    WIMU_setCurrentTime(currentTime);
    
    return (events ^ WIMU_TIME_EVT);
  }

  
  
#if defined ( PLUS_BROADCASTER )
  if ( events & SBP_ADV_IN_CONNECTION_EVT )
  {
    uint8 turnOnAdv = TRUE;
    // Turn on advertising while in a connection
    GAPRole_SetParameter( GAPROLE_ADVERT_ENABLED, sizeof( uint8 ), &turnOnAdv );

    return (events ^ SBP_ADV_IN_CONNECTION_EVT);
  }
#endif // PLUS_BROADCASTER

  // Discard unknown events
  return 0;
}


/*********************************************************************
 * @fn      performPeriodicTask
 *
 * @brief   Perform a periodic application task. This function gets
 *          called every five seconds as a result of the SBP_PERIODIC_EVT
 *          OSAL event. In this example, the value of the third
 *          characteristic in the SimpleGATTProfile service is retrieved
 *          from the profile, and then copied into the value of the
 *          the fourth characteristic.
 *
 * @param   none
 *
 * @return  none
 */
static void performPeriodicTask( void )
{

}

/*********************************************************************
 * @fn      WIMU_UARTCallback
 *
 * @brief   Called by the UART task when new data is received
 *
 * @param   none
 *
 * @return  none
 */
static void WIMU_UARTCallback(uint8 port, uint8 event)
{

  if (port==WIMU_UART_PORT) {
      WIMU_updateProfileSensors();
  }
  
}

/*********************************************************************
 * @fn      WIMU_updateProfileSensors
 *
 * @brief   Called by the application to read sensors data
 *          and put data in profiles
 *
 * @param   none
 *
 * @return  none
 */

static void WIMU_updateProfileSensors ( void )
{ 
  static uint16 numBytes=0;
  static uint8 msgCount=0;
//  uint8 i;
  uint8 end_pos=0;
  uint8 msgType;

  // Process new data on UART port
  numBytes = Hal_UART_RxBufLen(WIMU_UART_PORT);
  if (numBytes>WIMU_RX_MAX){
    numBytes = WIMU_RX_MAX;
  }
  if (rx_index+numBytes > WIMU_RX_MAX){
    // Error: overflow detected!
    rx_index=0;
  }

  HalUARTRead (WIMU_UART_PORT, &rx_byte[rx_index], numBytes); // Read data
  rx_index+=numBytes;
  
  // Check if we got the end of the message (SYNC byte)
  end_pos = WIMU_getEndOfFrame_Position();
  
  // Process message, if we got enough data
  /////////////////////////////////////////
  while ( end_pos > 0){
    // Unpack the data
    uint8 unstuffed[128];
    COBS_UnStuffData(&rx_byte[0], end_pos, &unstuffed[0]);
    msgType = unstuffed[0];
    rx_len = unstuffed[1];
    msgCount++;
    
    switch(msgType){
      /////////////////
      // DEVICE INFO
      /////////////////
    case WIMU_MSGTYPE_DEVINFO:{
          WIMU_DevInfoFrame_t devinfo;
          osal_memcpy(&devinfo,&unstuffed[2],sizeof(devinfo));
          //printf("DevInfo\n");
          
          DevInfo_SetParameter( DEVINFO_SERIAL_NUMBER, DEVINFO_SERIAL_NUMBER_LEN, &devinfo.serialNumber );
          DevInfo_SetParameter( DEVINFO_HARDWARE_REV, sizeof(uint8), &devinfo.hardRevision );
          DevInfo_SetParameter( DEVINFO_FIRMWARE_REV, DEVINFO_FIRMSOFT_REVISION_LEN, &devinfo.firmSoftRevision[0] );
          DevInfo_SetParameter( DEVINFO_SOFTWARE_REV, DEVINFO_FIRMSOFT_REVISION_LEN, &devinfo.firmSoftRevision[0] );          

          if(scanRspData[8] == 'x' && scanRspData[9] == 'x' && scanRspData[10] == 'x' && scanRspData[11] == 'x')
          {
            uint8 serialNumber[4] = {0};
            sprintf ((char *)serialNumber, "00%X", devinfo.serialNumber);
            scanRspData[8] = serialNumber[0];
            scanRspData[9] = serialNumber[1];
            scanRspData[10] = serialNumber[2];
            scanRspData[11] = serialNumber[3];
            GAP_UpdateAdvertisingData( WIMU_TaskID, FALSE, sizeof(scanRspData), scanRspData );
          }
          
          // Set sampling rate of the module
          //Actimetry_SetParameter( ACTIMETRY_CONFIG, 1, &devinfo.samplingRate);
    } 
        break;
        
        ///////////////
        // Battery
        ///////////////
    case WIMU_MSGTYPE_BATTERY:{	// Battery Data
      WIMU_battery_packet_t batteryData;
      
      // Process Data
      osal_memcpy(&batteryData,&unstuffed[2],sizeof(batteryData));           
                   
      // Update Battery values in the profile
      Batt_SetParameter( BATT_PARAM_LEVEL, WIMU_BATTERY_PACKET_SIZE, &batteryData );
          
          //GAP_UpdateAdvertisingData( WIMU_TaskID, FALSE, sizeof(scanRspData), scanRspData );
    }
        break;
        
        ///////////////
        // IMU
        ///////////////
    case WIMU_MSGTYPE_IMU:{ //IMU Data{
      WIMU_actimetry_imu_packet_t        imuData;
      WIMU_actimetry_quaternion_packet_t quaternionData;
      osal_memcpy(&imuData,&unstuffed[2],sizeof(imuData));
      osal_memcpy(&quaternionData,&unstuffed[2 + sizeof(imuData)],WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE);
                    
      // Update Actimetry values in the profile
      Actimetry_SetParameter( ACTIMETRY_IMU, WIMU_ACTIMETRY_IMU_PACKET_SIZE, &imuData );
      Actimetry_SetParameter( ACTIMETRY_QUATERNION, WIMU_ACTIMETRY_QUATERNION_PACKET_SIZE, &quaternionData );
    }
        break;
        
        ///////////////
        // GPS
        ///////////////        
    case WIMU_MSGTYPE_GPS:{
      WIMU_GPSFrame_t gpsData;
      osal_memcpy(&gpsData,&unstuffed[2],sizeof(gpsData));
      
      // Update values in profile
      Gps_SetParameter( GPS_LOCATION_AND_SPEED, WIMU_GPS_LOCATION_AND_SPEED_PACKET_SIZE, &gpsData.loc_speed );
      Gps_SetParameter( GPS_POSITION_QUALITY, WIMU_GPS_POSITION_QUALITY_PACKET_SIZE, &gpsData.quality );
      Gps_SetParameter( GPS_DATE_TIME, WIMU_GPS_DATE_TIME_PACKET_SIZE, &gpsData.date_time );
    }
    break;
    
    // Date and time    
    case WIMU_MSGTYPE_DATETIME:{
        currentTime_t currentTime;
        osal_memcpy(&currentTime,&unstuffed[2],sizeof(currentTime));
        Time_SetParameter(CURRENT_TIME_PARAM, WIMU_GPS_CURRENT_TIME_PACKET_SIZE, &currentTime );
    } break;
    
    // WIMU Config
    case WIMU_MSGTYPE_CONFIG:{
        //printf("Config\n");
        IMU_Config_t config;
        osal_memcpy(&config, &unstuffed[2], sizeof(IMU_Config_t));
        Actimetry_SetParameter( ACTIMETRY_CONFIG, sizeof(IMU_Config_t), &config);
    }break;
    
    // WIMU Control
    case WIMU_MSGTYPE_CONTROL:{
        RemControl_t control;
        osal_memcpy(&control, &unstuffed[2], sizeof(RemControl_t));
        Actimetry_SetParameter( ACTIMETRY_CONTROL, sizeof(RemControl_t), &control);
    }break;
    
    
    default:
      break;
    }
    
    // Remove bytes from data buffer
    //printf("#%d: %d, %d\n\r", msgCount, unstuffed[0], unstuffed[1]);
    osal_memcpy(&rx_byte[0],&rx_byte[end_pos+1],rx_index - end_pos);
    rx_index -= end_pos+1;
    osal_memset(&rx_byte[rx_index],0xFF, WIMU_RX_MAX - rx_index - 1);
    
    end_pos = WIMU_getEndOfFrame_Position();
  }
   
}

uint8 WIMU_getEndOfFrame_Position(void){
  uint8 end_pos=0;
  uint16 i;
  for (i=0; i<rx_index; i++){
    if (rx_byte[i] == WIMU_SYNC_BYTE){
      end_pos=i;
      break;
    }
  }
  
  return end_pos;
}


/*
 * StuffData byte stuffs "length" bytes of
 * data at the location pointed to by "ptr",
 * writing the output to the location pointed
 * to by "dst".
 */
#define COBS_FinishBlock(X) (*code_ptr = (X), code_ptr = dst++, code = 0x01)

void COBS_StuffData(const unsigned char *ptr,
unsigned long length, unsigned char *dst)
{
  const unsigned char *end = ptr + length;
  unsigned char *code_ptr = dst++;
  unsigned char code = 0x01;

  while (ptr < end)
  {
    if (*ptr == 0)
      COBS_FinishBlock(code);
    else
    {
      *dst++ = *ptr;
      if (++code == 0xFF)
        COBS_FinishBlock(code);
    }
    ptr++;
  }

  COBS_FinishBlock(code);
}

/*
 * Defensive UnStuffData, which prevents poorly
 * conditioned data at *ptr from over-running
 * the available buffer at *dst.
 */

void COBS_UnStuffData(const unsigned char *ptr,
unsigned long length, unsigned char *dst)
{
  const unsigned char *end = ptr + length;
  while (ptr < end)
  {
    int i, code = *ptr++;
    for (i=1; ptr<end && i<code; i++)
      *dst++ = *ptr++;
    if (code < 0xFF)
      *dst++ = 0;
  }
}
/*********************************************************************
*********************************************************************/
