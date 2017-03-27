#ifndef DATALOGGER_H_
#define DATALOGGER_H_

#include "config.h"
#include "ff.h"

//------------------------
// Constants Define
//------------------------
//#define DOS_SD_SPI			// Define to set that we use a direct SD card interface with SPI


#define DOS_SETTINGS_FILE	"SETTINGS" 	// Settings file on the uSD card
#define DOS_CONFIG_FILE		"CONFIG.WCF"	// Configuration file on the uSD card
#define DOS_FILEID_FILE		"FILE_ID" 	// File number on the uSD card
#define DOS_FILE_EXT		".DAT"          // File extension for records
#define DOS_REC_PREFIX          "REC"           // Prefix for manually started recordings folders

#define DOS_CPU_FILE		"LOG.DAT"       // Log file
#define DOS_ADC_FILE		"ADC"           // ADC data file on the uSD card
#define DOS_GPS_FILE		"GPS"           // GPS data file on the uSD card
#define DOS_ACC_FILE		"ACC"           // Accelerometer data file on the card
#define DOS_GYRO_FILE		"GYR"		// Gyroscope data file on the card
#define DOS_MAG_FILE		"MAG"		// Magnetometer data file on the card
#define DOS_POWER_FILE		"POW"		// Power data file on the card
#define DOS_IMU_FILE            "IMU"		// IMU data file on the card

#define DOS_SONARS_FILE		"SON"   	// Sonars data file on the uSD card
#define DOS_ENCODERS_FILE	"ENC"   	// Encoders data file on the uSD card
#define DOS_FSR_FILE		"FSR"   	// FSR data file on the uSD card
#define DOS_JOY_FILE		"JOY"		// Joystick Data file on the uSD card

// ACC, GYRO, POWER, JOY @ 45 Hz
//#define DOS_ADC_HANDLE		0			//General file handle
//#define DOS_ACC_HANDLE		2		   // Always uses file 2 as handle for ACC
#define DOS_GPS_HANDLE		1		   // Always uses file 1 as handle for GPS
//#define DOS_GYRO_HANDLE		3

/*#define DOS_CPU_HANDLE			0
#define DOS_ACC_HANDLE			1
#define DOS_GYRO_HANDLE			2
#define DOS_MAG_HANDLE			3
#define DOS_GPS_HANDLE			4
#define DOS_POWER_HANDLE		5
#define DOS_SONARS_HANDLE		6
#define DOS_ENCODERS_HANDLE		7
#define DOS_FSR_HANDLE			8
#define DOS_JOY_HANDLE			9
*/
#define DOS_OPENFILE_NUM		1	//Maximum number of opened file at once


//#define DOS_SONARS_HANDLE	2			// Always uses file 2 as handle for Sonars

//#define DOS_FILE_TIME		60			// Time (in minutes) after which a new
										// file has to be created
										
//#define DOS_RESET_INTERVAL	24			// Time (in hours) after which the SD card must
										// be resetted in order to prevent low write speed
										// bug and data loss. Also equals the max number of
										// files in a folder.

//#define DOS_NOTIMESTAMP					// Define to use timer timestamp increasing instead
										// of DOS-ON-CHIP RTC.						

//#define DOS_TIMEOUT_RESET			// Define to reset on too many timeouts										
//#define DOS_TIMEOUT			300		// Set the time threshold to consider that DosWrite operation
									// is taking too much time (then trigger a reset), in milliseconds
//#define DOS_STRIKEOUT		360		// Number of time > TIMEOUT to consider resetting the module / hour
#define DOS_MAX_ERRORS		30		// Maximum number of write error allowed in a folder

									
//#define DOS_LED						// Define to enable visual display of writing operations	
//------------------------
// Structure Define
//------------------------
typedef struct {
	unsigned int exp_num;
} settings;
//------------------------
// Functions Define
//------------------------

unsigned char init_datalogger(void);
unsigned char start_datalogger(void);
unsigned char reset_datalogger(void);
void stop_datalogger(void);
void init_settings(settings * set);
unsigned char datalog_save_data(unsigned char* data, unsigned short length, bool internal, unsigned int module, unsigned long time);

void datalog_check_nextfiles();
void next_files();
unsigned char datalog_change_folder();
FRESULT datalog_switch_recording_mode();

//------------------------
// Variables Define
//------------------------
extern int dos_filenum;
extern unsigned char dos_runtime; //Datalogger running time (in hours)
extern unsigned short dos_errors;
extern settings DOS_settings;

extern uint16_t dos_rec_count;

//extern unsigned int dos_adc_bytes;
//extern unsigned int dos_gps_bytes;
extern unsigned long dos_split_ts;
#ifdef RAW_ADC
	extern unsigned char dos_adc_filename[12];
#else
	extern unsigned char dos_acc_filename[12];
	extern unsigned char dos_gyro_filename[12];
	extern unsigned char dos_joy_filename[12];
#endif
extern unsigned char dos_quaternion_filename[12];
extern unsigned char dos_mag_filename[12];
extern unsigned char dos_gps_filename[12];
extern unsigned char dos_sonars_filename[12];
extern unsigned char dos_encoders_filename[12];
extern unsigned char dos_fsr_filename[12];
extern unsigned char dos_power_filename[12];

extern bool dos_isRecording;

#endif /*DATALOGGER_H_*/
