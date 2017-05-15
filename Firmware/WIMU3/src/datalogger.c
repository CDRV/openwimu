//******************************************************************************
//  WIMUuGPS - DataLogger
//
//  Description: This is the internal datalogger call functions. The functions
//               follow the conventional peripheral structures, with added 
// 				 features to support peripheral specific functions. Currently,
//				 the system supports a direct microSD card interface using SPI.
//
//  Author: Simon Brière, ing., M. Sc. A.
//  Initial Version: November 29th, 2010
//
//  Modifications: 
//  March 30th, 2011 - Prevented new folder being created if WIMU did not reboot
//******************************************************************************
#include "datalogger.h"
#include "utils.h"

#include "storage.h"
#include "usb.h" // For mass storage

//#include "fsr.h" // Used to enabled / disable seated detection
#include "gps.h"

#include "ble.h" // For BLE recording control

#include <time.h> //For timestamping functions
#include <stdio.h> //For sprintf
#include <string.h>

settings DOS_settings;

unsigned char dos_acc_filename[12];
unsigned char dos_gyro_filename[12];
unsigned char dos_joy_filename[12];
unsigned char dos_mag_filename[12];
unsigned char dos_gps_filename[12];
unsigned char dos_quaternion_filename[12];
//unsigned char dos_sonars_filename[12];
//unsigned char dos_encoders_filename[12];
//unsigned char dos_fsr_filename[12];
unsigned char   dos_power_filename[12];

int             dos_filenum;
unsigned long   dos_split_ts;
unsigned short  dos_errors;

unsigned char   dos_runtime=0;

uint16_t dos_rec_count=0;      // Number of manual recorded folders present on the card
bool dos_isRecording = false; // Flag to indicate if we are indeed recording in a specific folder or not

FATFS fatfs;
FIL dos_files[DOS_OPENFILE_NUM]; // Open files pointers


// Private prototypes
FRESULT datalog_update_manual_recordings_count(); 
FRESULT datalog_save_config();
FRESULT datalog_save_settings();

//------------------------------------------------------------------------------
// INIT_DATALOGGER
//------------------------------------------------------------------------------
// Initialization function for the DataLogger module. Currently, USCI_A1 in SPI
// mode is used to interface the chip.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if initialization was successfully completed
// 0xYY, if initialization wasn't successfully completed where YY=error code
//------------------------------------------------------------------------------
unsigned char init_datalogger(void){
	
	//Nothing to do here - all done in sd.c - sd_initialize() function.
	dos_errors = 0;
	//dos_runtime = 0; //Already initialized in declaration, no need to touch it anymore
	
	return 0x00; //No error
}

//------------------------------------------------------------------------------
// START_DATALOGGER
//------------------------------------------------------------------------------
// Startup function for the DataLogger module. Creates Data Folder for the
// experiment.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if startup was successfully completed
// 0xYY, if startup wasn't successfully completed and where YY=error code
//------------------------------------------------------------------------------
unsigned char start_datalogger(void){
	FRESULT status;
	
	dos_errors = 0;

        if (fatfs.id!=0)
          return 0;

	//f_mount(0, &fatfs);		/* Register volume work area (never fails) */
        f_mount(&fatfs, "", 1);
/*	if ((status = f_chdrive(0))!= FR_OK)
		return 1;//status;*/
	
        // Count numbers of manually started recordings
        if (!datalog_update_manual_recordings_count()==FR_OK)
          return 2;
        status = datalog_change_folder();
        if (status!=0)
          return status;		

	return 0x00;
}

//------------------------------------------------------------------------------
// RESET_DATALOGGER
//------------------------------------------------------------------------------
// Executes an hardware reset of the DataLogger module. Not used anymore in current
// configuration.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (void):
// None
//------------------------------------------------------------------------------
unsigned char reset_datalogger(void){
  unsigned char status=0;
  stop_datalogger();
  msWait(100);
  status = start_datalogger();
  if (status>0)
    setModuleState(MODULE_DATALOGGER, STATE_ONLINE);
  return status;
}

//------------------------------------------------------------------------------
// STOP_DATALOGGER
//------------------------------------------------------------------------------
// Stop the Datalogger
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (void):
// None
//------------------------------------------------------------------------------
void stop_datalogger(void){

        //TEST
        //f_close(&dos_files[1]);
  
	//unsigned char tmp;
	f_mount(0, NULL, 1); // Unmount file system
	
	//tmp = UCA1RXBUF;
	
	//Clear structure buffer
	memset(&fatfs,0,sizeof(FATFS));

        SPI_I2S_DeInit(SD_SPI);

        //--TODO: Disable clock system & remove power to card (NV)
	
	//while (!(UCA1IFG&UCTXIFG));  
	//while (!(UCA1IFG&UCRXIFG));  
	//P5OUT |= BIT5;							  // Set P5.5 as high (Chip Select disabled)
	
	//Disable clk system
	/*sleep(100);
	
	UCA1CTL1 |= UCSWRST;
	UCA1CTLW0=1; 
	
	
	P5SEL &= ~(BIT6+BIT7); 	// Disable SIMO/MOSI
	P5DIR &= ~(BIT5); 		// Set P5.5 as input
	P3SEL &= ~(BIT6);
	sleep(100);
	
	//Shutdown the power supply of the datalogger
	P8OUT &= ~(BIT1); 		// Set P8.1 as low, cut power to SD card
	P8DIR &= ~(BIT1);	
	
	UCA1IFG = 0;
	//UCA1TXBUF = 0;*/
	if (getModuleState(MODULE_DATALOGGER) == STATE_ONLINE)
          setModuleState(MODULE_DATALOGGER, STATE_OFFLINE);

        if (getModuleState(MODULE_DATALOGGER) == STATE_SPECIAL)
          setModuleState(MODULE_DATALOGGER, STATE_DISABLED);
	
}
//------------------------------------------------------------------------------
// INIT_SETTINGS
//------------------------------------------------------------------------------
// Initialize the settings structure with default values.
//------------------------------------------------------------------------------
// Parameters: 
// set, pointer to a settings structure
//
// Return value (void):
// None
//------------------------------------------------------------------------------
void init_settings(settings * set){
	
	set->exp_num=1; // Start in folder "1"
	
	return;
}


//------------------------------------------------------------------------------
// NEXT_FILES
//------------------------------------------------------------------------------
// Update the file names when a break (timed - default: 1h) is detected, in order
// to have time separated files. Also closes and opens the next files.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (void):
// None
//------------------------------------------------------------------------------
void next_files(/*long timestamp*/){
	unsigned int t_diff=0;
        unsigned char f_diff=1;

        // Check difference between last split_ts and current timestamp to determine what file number is next
        if (dos_split_ts>0){
          t_diff = timestamp - dos_split_ts;
          f_diff = t_diff / (/*wimu_config.logger.file_time **/ 3600) + 1;
        }

	dos_filenum+=f_diff;

	sprintf((char*)dos_acc_filename, "%s_%d%s",DOS_ACC_FILE, dos_filenum, DOS_FILE_EXT);
	sprintf((char*)dos_gyro_filename, "%s_%d%s",DOS_GYRO_FILE, dos_filenum, DOS_FILE_EXT);
	sprintf((char*)dos_joy_filename, "%s_%d%s",DOS_JOY_FILE, dos_filenum, DOS_FILE_EXT);
	sprintf((char*)dos_quaternion_filename, "%s_%d%s",DOS_IMU_FILE, dos_filenum, DOS_FILE_EXT);
	sprintf((char*)dos_mag_filename, "%s_%d%s",DOS_MAG_FILE, dos_filenum, DOS_FILE_EXT);
	sprintf((char*)dos_gps_filename, "%s_%d%s",DOS_GPS_FILE, dos_filenum, DOS_FILE_EXT);
//	sprintf((char*)dos_sonars_filename, "%s_%d%s",DOS_SONARS_FILE, dos_filenum, DOS_FILE_EXT);
//	sprintf((char*)dos_encoders_filename, "%s_%d%s",DOS_ENCODERS_FILE, dos_filenum, DOS_FILE_EXT);
//	sprintf((char*)dos_fsr_filename, "%s_%d%s",DOS_FSR_FILE, dos_filenum, DOS_FILE_EXT);
	sprintf((char*)dos_power_filename, "%s_%d%s",DOS_POWER_FILE, dos_filenum, DOS_FILE_EXT);  

        if (timestamp>0)
          dos_split_ts = timestamp + /*wimu_config.logger.file_time **/ 3600;

	dos_runtime+=f_diff;
	
	if (dos_runtime >= wimu_config.logger.max_files_in_folder && dos_filenum>0){
		dos_runtime = 0;
		setModuleState(MODULE_DATALOGGER, STATE_RESET); 
	}
	
	return;
	
}


//------------------------------------------------------------------------------
// DATALOG_SAVE_DATA
//------------------------------------------------------------------------------
// Wrap-up function that saves data on the uSD card
//------------------------------------------------------------------------------
// Parameters: 
// data, pointer to the data in memory
// length, number of word to write
// internal, set to TRUE if module is internal (i.e. adc, gps, ...)
// module, ID of the module requesting the write (to correctly manage filenames)
// time, the timestamp attached to the data. Set to "0" to use actual time.
//
// Return value (Unsigned Char):
// 0x00, if writing was successfully completed
// 0xYY, if writing wasn't successfully completed and where YY=error code
//------------------------------------------------------------------------------
unsigned char datalog_save_data(unsigned char* data, unsigned short length, bool internal, unsigned int module, unsigned long time){
	unsigned char status=0;
	FRESULT err[5] = {FR_OK,FR_OK,FR_OK,FR_OK,FR_OK};
	char buf[32];
	unsigned int bytes_count;
        
        unsigned char* write_buffer;
        unsigned int buffer_len;

	//unsigned char handle;
	//unsigned long int fileSize;
	#ifdef DOS_TIMEOUT_RESET
		unsigned long time;
	#endif
	//unsigned char step=0;
	//unsigned long timestamp=0;
        
         if (usb_mode==MASS_STORAGE && USB_IsConnected()){
          return 0; // Don't write anything while in mass storage and connected
        }

      

        //LED blinking is config is set
	if (wimu_config.ui.write_led){
            if ((ble_control.status & BLE_CTRL_FLAG_REC) ==0)
              led(LED_RED,TRUE, MEDIUM_PRIORITY);
             else
              led(LED_BLUE,TRUE, MEDIUM_PRIORITY);
          //led(LED_RED,TRUE);
        }
		
	#ifndef DEBUG
		//WDTCTL = START_WATCHDOG;
	#endif
	
	#ifdef DOS_TIMEOUT_RESET
		time_count(TRUE);
	#endif

       
	
	if (internal==true){
		switch(module){
			case MODULE_CPU:
				err[0] = f_open(&dos_files[0], (TCHAR*) "LOG.DAT", FA_WRITE | FA_OPEN_APPEND);
			break;
			case MODULE_GPS:
				err[0] = f_open(&dos_files[0], (TCHAR*) &dos_gps_filename[0], FA_WRITE | FA_OPEN_APPEND);
			break;
			case MODULE_ACC:
				err[0] = f_open(&dos_files[0], (TCHAR*) &dos_acc_filename[0], FA_WRITE | FA_OPEN_APPEND);
                                //TEST
                                /*if (dos_files[1].flag == 0)
                                  f_open(&dos_files[1], (TCHAR*) &dos_acc_filename[0], FA_WRITE | FA_OPEN_APPEND);*/
			break;
			case MODULE_GYRO:
				err[0] = f_open(&dos_files[0], (TCHAR*) &dos_gyro_filename[0], FA_WRITE | FA_OPEN_APPEND);
			break;
			case MODULE_MAGNETO:
				err[0] = f_open(&dos_files[0], (TCHAR*) &dos_mag_filename[0], FA_WRITE | FA_OPEN_APPEND);
			break;
			case MODULE_POWER:
				err[0] = f_open(&dos_files[0], (TCHAR*) &dos_power_filename[0], FA_WRITE | FA_OPEN_APPEND);
			break;
                        case MODULE_IMU:
				err[0] = f_open(&dos_files[0], (TCHAR*) &dos_quaternion_filename[0], FA_WRITE | FA_OPEN_APPEND);
			break;
		}
		
	}else{
            //TODO: Save external sensors data...
		
	}
	
	// Move to end of file to append data
        //err[1] = f_lseek(&dos_files[0], f_size(&dos_files[0])); // Deprecated with new option "FA_OPEN_APPEND"
       // err[1] = FR_OK;
	
	//handle = datalog_get_modulefile(internal, module);
	//err[2] = FR_OK;
        
        // Allocate buffer
        if (module == MODULE_CPU){
          // Convert Timestamp to text
          if (time!=0)
            sprintf(buf, ",%ld,",time);
          else
            sprintf(buf, ",%ld,",timestamp);
          bytes_count = strlen(buf);
          //err[2] = f_write(&dos_files[0], buf, bytes_count, &bytes_count);
          buffer_len = bytes_count + length + 4 ; // 4 bytes = timestamp
          write_buffer = malloc(buffer_len);
          memcpy(&write_buffer[4], buf, bytes_count);
          memcpy(&write_buffer[4+bytes_count], data, length);
        }else{
          buffer_len = length + 4;
          write_buffer = malloc(buffer_len); // 4 bytes = timestamp
          memcpy(&write_buffer[4], data, length);
        }

	#ifdef GPS_MODE_2
		if (module != MODULE_GPS) //No timestamp on SIRF data		
	#endif
	//Timestamp
	if (time!=0)
		//err[2] = f_write(&dos_files[0], (unsigned char*) &time, 4, &bytes_count);
                memcpy(&write_buffer[0], (unsigned char*) &time, 4);
	else
		//err[2] = f_write(&dos_files[0], (unsigned char*) &timestamp, 4, &bytes_count);
                memcpy(&write_buffer[0], (unsigned char*) &timestamp, 4);
	
	//Data
	//err[3] = f_write(&dos_files[0], data, length, &bytes_count);
        //if (module!=MODULE_ACC)
          err[3] = f_write(&dos_files[0], write_buffer, buffer_len, &bytes_count);
        /*else
          err[3] = f_write(&dos_files[1], write_buffer, buffer_len, &bytes_count);*/
        free(write_buffer);
			
		
	// Close the file
        //if (module != MODULE_ACC)
          err[4] = f_close(&dos_files[0]);	
	
	#ifdef DOS_TIMEOUT_RESET
	time = time_count(FALSE);
	#endif
	
	//if (i_mod_status[MODULE_DATALOGGER]!=MODULE_RESET){ // Prevents infinite loop
		// DOSONCHIP error	
		status = err[0] + err[1] + err[2] + err[3] + err[4];  	
		if (status!=0){
			dos_errors++;	
			                    				
			if (dos_errors>=DOS_MAX_ERRORS){
				//Amount of write errors exceeded the maximum threshold
				setModuleState(MODULE_DATALOGGER, STATE_RESET);  // Provokes a reset of the card
                                //led(LED_RED,TRUE);
			}
                        
		}
	
        //LED indicator if flag is on
        if (wimu_config.ui.write_led){
          if ((ble_control.status & BLE_CTRL_FLAG_REC) ==0)
              led(LED_RED, FALSE, NO_PRIORITY);
             else
              led(LED_BLUE, FALSE, NO_PRIORITY);
	}

	return status;
}

//------------------------------------------------------------------------------
// DATALOG_CHECK_NEXTFILES
//------------------------------------------------------------------------------
// Check if needs to change file using the timestamp
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Long):
// Timestamp value, number of seconds since Jan 1st, 1970
// 0 if not valid
//------------------------------------------------------------------------------
void datalog_check_nextfiles(){
			
      if (timestamp>=dos_split_ts){ // New files needed?
              next_files();
      }

      return;// rval;
}

unsigned char datalog_change_folder(){
  char name[9]={0,0,0,0,0,0,0,0,0};
  FRESULT status;
  unsigned int bytes_count;
  //char buf[32]; //Char buffer

  //Switch to root directory
  name[0]='/';
  if ((status = f_chdir((const TCHAR*)&name[0]))!=FR_OK)
    return 1;//status;

  status = f_open(&dos_files[0], (const TCHAR*) DOS_FILEID_FILE, FA_READ); // Check for ID_FILE
 
  if (status==FR_NO_FILE){ //File was not found
    // Ensure file counter is set to 0
    dos_filenum=0;
    next_files();
    dos_runtime=0;
    DOS_settings.exp_num = 0;
  }

  if (DOS_settings.exp_num == 0){ // Not restarting the logger from sleep
      //Load settings from uSD card      
      if (status==FR_NO_FILE){ //File was not found
              // Initialize the settings structure		
              init_settings(&DOS_settings);                   
                      
      }else{ //File found
              if (status!=FR_OK){
                      return 2;//status;
              }else{
                      //Load the settings from the file
                      /*if (status = DOSread(0, (unsigned char*) &DOS_settings, sizeof(settings))!=0)
                              return status;*/
                      if ((status = f_read(&dos_files[0], (char*) &DOS_settings, sizeof(settings), &bytes_count))!=0)
                              return 3;//status;
                              
                                                
                      //Close the file	
                      //if (status=DOSclose(0)!=0) //Close the file
                      if ((status = f_close(&dos_files[0])) != FR_OK)
                              return 4;//status;
                              
                      // Delete old file
              }
      }
             
      // Create the file
      if ((status = f_open(&dos_files[0], (const TCHAR*) DOS_FILEID_FILE, FA_WRITE | FA_CREATE_ALWAYS))!= FR_OK)
              return 5;//status;
      
      // Increment Experiment number
      DOS_settings.exp_num++;
              
      // Save the settings
      if ((status = f_write(&dos_files[0], (const TCHAR*)&DOS_settings, sizeof(settings), &bytes_count)) != FR_OK)
              return 6;//status;
      // Decrement Experiment number (for the actual experiment) 
      DOS_settings.exp_num--;
      
      if ((status = f_close(&dos_files[0]))!=FR_OK)
              return 7;//status;
      
      // Create experiment log directory
      itoa(DOS_settings.exp_num, (char*) &name, 10);
      status = f_mkdir((const TCHAR*)&name);
      if (status!=FR_OK && status != FR_EXIST)
              return 8;//status;
    }else{
      if (status == FR_OK)
        f_close(&dos_files[0]); // Close ID_FILE

      //Restarting the logger from sleep
      itoa(DOS_settings.exp_num, (char*) &name,10);
    }
    //Switch to work directory
    if ((status = f_chdir((const TCHAR*)&name))!=FR_OK)
            return 9;//status;

    if ((status = datalog_save_settings()) != FR_OK)
      return 10;
    
    if ((status = datalog_save_config()) != FR_OK)
      return 11;

    return 0;
}

// Used to isolate data in another folder - manual recordings
FRESULT datalog_switch_recording_mode(){
  FRESULT status;
  static char old_path[32];
  char rec_path[12];

  if (dos_isRecording){
    // Currently recording - restoring old path for future data
    if ((status = f_chdir((const TCHAR*)&old_path))!=FR_OK)
      return status;    
    
  }else{
    // Backup current path
    if ((status = f_getcwd(old_path,32))!=FR_OK)
      return status;

    // Build recording folder string
    sprintf((char*)rec_path, "/%s_%d", DOS_REC_PREFIX, ++dos_rec_count);

    // Create folder - no error check, in case the folder already exists
    f_mkdir((const TCHAR*)&rec_path);

    // Change to recording folder
    if ((status = f_chdir((const TCHAR*)&rec_path))!=FR_OK)
      return status; 

  }

  dos_isRecording = !dos_isRecording;

  return FR_OK;

}

FRESULT datalog_save_config(){
  FRESULT status;
  unsigned int bytes_count;

  if ((status = f_open(&dos_files[0], (const TCHAR*) DOS_CONFIG_FILE, FA_WRITE | FA_CREATE_ALWAYS))!= FR_OK)
    return status;

   //Save config
   if ((status = f_write(&dos_files[0], (const TCHAR*)&wimu_config, sizeof(WIMU_CONFIG), &bytes_count)) != FR_OK)
    return status;
            
   //Close config file
   if ((status = f_close(&dos_files[0]))!=FR_OK)
    return status;

    return FR_OK;
}

FRESULT datalog_save_settings(){
  FRESULT status;
  unsigned int bytes_count;

   //Save current settings
    if ((status = f_open(&dos_files[0], (const TCHAR*) DOS_SETTINGS_FILE, FA_WRITE | FA_CREATE_ALWAYS))!= FR_OK)
            return status;

    //Save settings
    if ((status = f_write(&dos_files[0], (const TCHAR*)&wimu_settings, sizeof(WIMU_SETTINGS), &bytes_count)) != FR_OK)
            return status;
          
    //Close settings file
    if ((status = f_close(&dos_files[0]))!=FR_OK)
            return status;

    return FR_OK;
}

// Counts the number of manually recorded data folders
FRESULT datalog_update_manual_recordings_count(){
  char name[10]={0,0,0,0,0,0,0,0,0,0};
  char current_path[32];
  char search_pattern[8];
  FRESULT status;
  DIR dj;         /* Directory search object */
  FILINFO fno;    /* File information */

  dos_rec_count = 0;

  // Save current folder
  if ((status = f_getcwd(current_path,32))!=FR_OK)
    return status;

  // Switch to root directory
  name[0]='/';
  if ((status = f_chdir((const TCHAR*)&name[0]))!=FR_OK)
    return status;

  // Browse each folder
  sprintf((char*)search_pattern, "%s_*", DOS_REC_PREFIX);

  status = f_findfirst(&dj, &fno, "", search_pattern);
  while (status == FR_OK && fno.fname[0]) {         /* Repeat while an item is found */
    dos_rec_count++;
    status = f_findnext(&dj, &fno);               /* Search for next item */
  }

  // Restore current folder
  if ((status = f_chdir((const TCHAR*)&current_path[0]))!=FR_OK)
    return status;

  return FR_OK;
}