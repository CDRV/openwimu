#ifndef CONFIG_H_
#define CONFIG_H_

#include <stdbool.h>
#include <stdint.h>

//--------------------------------
// Compilation options definitions
//--------------------------------
//#define TEST 		//Define to output clocks
//#define DEV_BOARD	//Define to use the Development Board from TI
//#define DEBUG_CONSOLE   //Define to use the debug console


//-------------------------
// Global definitions
//-------------------------
/*#ifndef TRUE
	#define TRUE	1
#endif
#ifndef FALSE
	#define FALSE	0
#endif
#ifndef BOOL
	#define BOOL unsigned char
#endif*/

//#define HARDWARE_VERSION	2 //Not used anymore - set in settings

#define VERSION_MAJOR	3	
#define VERSION_MINOR	3
#define VERSION_REV	4

#define VERSION_MAJOR_CHAR  '3'
#define VERSION_MINOR_CHAR  '3'
#define VERSION_REV_CHAR    '4'

#define VERSION_STRING  "** WIMuGPS - Version 3.3.4 **\n\r" //should always be 31 in length
#define	LEN_VERSION_STRING	31

#define CONSOLE_USART USART1
#define BLE_USART     USART2

#define SYNC_BYTE 0xEA          // Sync Byte for binary streaming
#define ESC_BYTE  0xED          // Escape Byte for binary streaming

#define POWER_MANAGE  1 //Set to use power management

//#define DEBUG	//Define to disable Watchdog timer

typedef struct {
	uint16_t id;			// Serial Number
	uint8_t hw_id; 			// Hardware revision ID
        uint8_t version[3];             // Version Numbers
	int16_t acc_gain[3];		// Accelerometers gain
	int16_t acc_offset[3];          // Accelerometers offset
	int16_t gyro_gain[3];           // Gyroscope gain
	int16_t gyro_offset[3];         // Gyroscope offset
	int16_t mag_gain[3];		// Magnetometers gain
	int16_t mag_offset[3];          // Magnetometers offset
        /*unsigned char unused1;	// Unused value in this WIMU version
	unsigned char unused2;		// Unused value in this WIMU version
	unsigned char unused3;		// Unused value in this WIMU version
	unsigned short unused4;         // Unused value in this WIMU version
	unsigned short unused5;         // Unused value in this WIMU version*/
	//unsigned char rtc_cal;	// RTC calibration register
	//unsigned short crc;		// Checksum of the structure
        int crc;
 } WIMU_SETTINGS;

typedef struct __attribute__((__packed__)) {
  int8_t    time_offset;
  bool      enable_gps_time;
  bool      enable_auto_offset; // Unused... for now!
} WIMUConfig_DateTimeOptions;

typedef struct __attribute__((__packed__)) {
  uint8_t   led_blink_time;
  bool      write_led;
  bool      enable_marking;
  bool      gps_fix_led;
  bool      ble_activity_led;
} WIMUConfig_UIOptions;

typedef struct __attribute__((__packed__)) {
  uint16_t   sampling_rate;
  bool      enable_watchdog;
} WIMUConfig_GlobalOptions;

typedef struct __attribute__((__packed__)) {
  uint8_t   max_files_in_folder;
  bool      split_by_day;
} WIMUConfig_LoggerOptions;

typedef struct __attribute__((__packed__)) {
  uint8_t interval;
  bool    force_cold;
  bool    enable_scan_when_charged;
} WIMUConfig_GPSOptions;

typedef struct __attribute__((__packed__)) {
  bool      power_manage;
  bool      enable_motion_detection;
  bool      adv_power_manage;
} WIMUConfig_PowerOptions;

typedef struct __attribute__((__packed__)) {
  bool      enable_control;
} WIMUConfig_BLEOptions;

typedef struct __attribute__((__packed__)) {
  uint8_t   range;
} WIMUConfig_AccOptions;

typedef struct __attribute__((__packed__))  {
  uint8_t   range;
} WIMUConfig_GyroOptions;

typedef struct __attribute__((__packed__)) {
  uint8_t   range;
} WIMUConfig_MagOptions;

typedef struct __attribute__((__packed__)) {
  float     beta;
  bool      disable_magneto;
  bool      auto_calib_gyro;
} WIMUConfig_IMUOptions;


typedef struct __attribute__((__packed__)) {
	uint16_t                    enabled_modules;   // Enabled modules
        WIMUConfig_DateTimeOptions  datetime;          // Date & Time options
        WIMUConfig_UIOptions        ui;                // User Interface options
        WIMUConfig_GlobalOptions    general;           // Global options
	WIMUConfig_LoggerOptions    logger;            // Datalogger options
        WIMUConfig_GPSOptions       gps;               // GPS options
        WIMUConfig_PowerOptions     power;             // Power options
	WIMUConfig_BLEOptions       ble;               // BLE options
	WIMUConfig_AccOptions       acc;               // Accelero options
        WIMUConfig_GyroOptions      gyro;              // Gyro options
	WIMUConfig_MagOptions       magneto;           // Magneto options
        WIMUConfig_IMUOptions       imu;               // IMU options
        int crc;
} WIMU_CONFIG;

#define MAX_FS  50

///////////
// CLOCK //
///////////
#define CLK_F_APROX 18000000 // Approximation of the CPU MCLK, 18 MHz
#define CLK_F       17989632	   // More accurate value of the CPU MCLK (N+1)*Freq, see "init()"

//#define US_CYCLE			18	// Number of clock cycle to have a micro-second

#define V_IN	3.3		// Input voltage

#define STOP_WATCHDOG	(WDTPW + WDTHOLD)
#define START_WATCHDOG	(WDTPW + WDTSSEL_2 + WDTIS_5 + WDTCNTCL)  // Set clock as VLOCLK (9.4 kHz typical) / 8192 = 1.15 Hz
#define RESET_WATCHDOG  ((WDTCTL & 0x00FF) | WDTPW | WDTCNTCL)

//------------------------
// Internal Peripherals
//------------------------

// Internal device definitions
typedef enum{
  MODULE_CPU=0,
  MODULE_BLE=1,
  MODULE_GPS=2,
  MODULE_GYRO=3,
  MODULE_MAGNETO=4,
  MODULE_ACC=5,
  MODULE_DATALOGGER=6,
  MODULE_USB=7,
  MODULE_POWER=8,
  MODULE_IMU=9,
  MODULE_INTERNAL_NUM //Total number of internal modules
} InternalModules_ID;

#define MODULE_ALL		0xFF

typedef enum{
  STATE_DISABLED,   // Set when a module is disabled
  STATE_ONLINE,     // Set when a module is online
  STATE_OFFLINE,    // Set when a module is enabled, but offline
  STATE_SLEEPMODE,  // Set when a module is in sleep mode
  STATE_TEMPOFF,    // Set when a module is temporarly off
  STATE_RESET,      // Set when a module needs to be resetted
  STATE_SPECIAL     // Set when a module is in a specific operating mode, depends on each module
} ModuleStates;

//extern volatile ModuleStates i_mod_status[MODULE_INTERNAL_NUM];

//------------------------
// External Peripherals
//------------------------
	
//extern unsigned int enabled_ext_devices;

// External enabled devices definitions (masks)
/*#define EXT_MODULE_SONARS		0//0x0001
#define EXT_MODULE_FSR			1//0x0002
#define EXT_MODULE_JOYSTICK		2//0x0004
#define EXT_MODULE_ENCODERS		3//0x0008
#define EXT_MODULE_CURRENT		4//0x0010
#define EXT_MODULE_CHARGER		5//0x0020
#define EXT_MODULE_WIENCODER            6//0x0040
#define EXT_MODULE_PULSEOX		7

#define EXT_MODULE_ALL		0xFF //EXT_MODULE_SONARS+EXT_MODULE_FSR+EXT_MODULE_JOYSTICK+EXT_MODULE_ENCODERS+EXT_MODULE_CURRENT+EXT_MODULE_CHARGER

#define EXT_MODULE_NUM			8

extern volatile unsigned char e_mod_status[EXT_MODULE_NUM];*/

#define TIME_SYNC_COUNT		30    // Number of seconds (GPS Samples) to consider the time from external source is stable
#define TIME_DRIFT_COUNT	3600  // Delay (in GPS samples) after which to update the timestamp (RTC clock) with the value in order to minimize drifts

//------------------------
// Variable references
//------------------------

//extern BOOL time_sync;				 //Set to TRUE when the time on the Datalogger is valid
									 //Time is set when a fix is done on the GPS
									 
extern unsigned char time_sync;		// Count the number of seconds needed to consider the GPS time to be stable 
extern unsigned long timestamp;


//extern unsigned char PowerDown_NbrOfPress;

extern bool initialized;

extern WIMU_SETTINGS wimu_settings;
extern WIMU_CONFIG wimu_config;

#endif /*CONFIG_H_*/
