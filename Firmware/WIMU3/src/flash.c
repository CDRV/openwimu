//******************************************************************************
//  WIMUuSD - Flash Memory Module
//
//  Description: This is the interface to the EEPROM memory embedded in the STM32L151.
//				 It provides an access to the data stored in the EEPROM memory.
//
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 23th, 2012
//
//  Modifications:
//  
//******************************************************************************

#include "flash.h"


void flash_init(void)
{
  // Enabling the CRC peripheral clock
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_CRC, ENABLE);
}


//------------------------------------------------------------------------------
// flash_write_settings
//------------------------------------------------------------------------------
// This function writes the WIMU_SETTINGS structure in DATA_EEPROM section of Flash.
//------------------------------------------------------------------------------
// Parameters: 
// settings, a pointer to the WIMU_SETTINGS structure to be written.
//
// Return value (uint8_t):
// 0, if initialization was successfully completed
// 1, if initialization wasn't successfully completed where YY=error code
//------------------------------------------------------------------------------
uint8_t flash_write_settings(WIMU_SETTINGS* settings)
{
	FLASH_Status FlashOperationResult;
    
  uint8_t LoopIndex;
  uint8_t Settings_NbrByte = sizeof(WIMU_SETTINGS);
  uint8_t Settings_NbrCompleteWord = Settings_NbrByte >> 2;
  uint8_t Settings_NbrResidualByte = Settings_NbrByte & 0x3;

  // Unlocking Data EEPROM
  DATA_EEPROM_Unlock();
  
  /* --------- EEPROM erase --------- */
  
  for(LoopIndex = 0; LoopIndex < Settings_NbrCompleteWord; LoopIndex++)
  {
    FlashOperationResult = DATA_EEPROM_EraseWord(DATA_EEPROM_SETTING_BASE + LoopIndex * 4);
    
    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  if(Settings_NbrResidualByte != 0)
  {
    FlashOperationResult = DATA_EEPROM_EraseWord(DATA_EEPROM_SETTING_BASE + Settings_NbrCompleteWord * 4);
    
    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  /* --------- EEPROM write --------- */
  
  for(LoopIndex = 0; LoopIndex < Settings_NbrCompleteWord; LoopIndex++)
  {
    FlashOperationResult = DATA_EEPROM_FastProgramWord(DATA_EEPROM_SETTING_BASE + LoopIndex * 4, *((uint32_t*)settings + LoopIndex));

    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  for(LoopIndex = 0; LoopIndex < Settings_NbrResidualByte; LoopIndex++)
  {
    FlashOperationResult = DATA_EEPROM_FastProgramByte(DATA_EEPROM_SETTING_BASE + Settings_NbrCompleteWord * 4 + LoopIndex, *((uint8_t*)settings + Settings_NbrCompleteWord * 4 + LoopIndex));
    
    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  
  // Locking Data EEPROM
  DATA_EEPROM_Lock();
	
	return 1;
}

//------------------------------------------------------------------------------
// flash_write_config
//------------------------------------------------------------------------------
// This function writes the WIMU_CONFIG structure in DATA_EEPROM section of Flash.
//------------------------------------------------------------------------------
// Parameters: 
// config, a pointer to the WIMU_CONFIG structure to be written.
//
// Return value (uint8_t):
// 0, if initialization was successfully completed
// 1, if initialization wasn't successfully completed where YY=error code
//------------------------------------------------------------------------------
uint8_t flash_write_config(WIMU_CONFIG* config)
{
	FLASH_Status FlashOperationResult;
  
  uint8_t LoopIndex;
  uint8_t Config_NbrByte = sizeof(WIMU_CONFIG);
  uint8_t Config_NbrCompleteWord = Config_NbrByte >> 2;
  uint8_t Config_NbrResidualByte = Config_NbrByte & 0x3;
  
  // Unlocking Data EEPROM
  DATA_EEPROM_Unlock();
  
  /* --------- EEPROM erase --------- */
  
  for(LoopIndex = 0; LoopIndex < Config_NbrCompleteWord; LoopIndex++)
  {
    FlashOperationResult = DATA_EEPROM_EraseWord(DATA_EEPROM_CONFIG_BASE + LoopIndex * 4);
    
    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  if(Config_NbrResidualByte != 0)
  {
    FlashOperationResult = DATA_EEPROM_EraseWord(DATA_EEPROM_CONFIG_BASE + Config_NbrCompleteWord * 4);
    
    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  /* --------- EEPROM write --------- */
  
  for(LoopIndex = 0; LoopIndex < Config_NbrCompleteWord; LoopIndex++)
  {
    FlashOperationResult = DATA_EEPROM_FastProgramWord(DATA_EEPROM_CONFIG_BASE + LoopIndex * 4, *((uint32_t*)config + LoopIndex));
    
    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  for(LoopIndex = 0; LoopIndex < Config_NbrResidualByte; LoopIndex++)
  {
    FlashOperationResult = DATA_EEPROM_FastProgramByte(DATA_EEPROM_CONFIG_BASE + Config_NbrCompleteWord * 4 + LoopIndex, *((uint8_t*)config + Config_NbrCompleteWord * 4 + LoopIndex));
    
    if(FlashOperationResult != FLASH_COMPLETE)
    {
      return 0;
    }
  }
  
  
  // Locking Data EEPROM
  DATA_EEPROM_Lock();
	
	return 1;
}

//------------------------------------------------------------------------------
// crc_calc
//------------------------------------------------------------------------------
// This function uses the CRC module to calculate checksum value for the data
// specified in parameter.
//------------------------------------------------------------------------------
// Parameters: 
// data, a pointer to the data that needs to be calculated
// NbrOfCompleteWord, number of complete word in the data array
// NbrOfResidualByte, number of byte at the end of the array taht not fill completely
//                    the last word
//
// Return value (uint32_t):
// CRC32 value
//------------------------------------------------------------------------------
uint32_t crc_calc(uint8_t* data, uint16_t NbrOfByte)
{
  uint16_t LoopIndex;
  uint32_t DataWord;
  uint16_t NbrOfCompleteWord = NbrOfByte >> 2; // /4
  uint16_t NumberOfResidualByte = NbrOfByte - (NbrOfCompleteWord << 2);
	
  // Initialize CRC module
  CRC_ResetDR();
  
  // Feeding Words to the CRC module
  for(LoopIndex = 0; LoopIndex < NbrOfCompleteWord; LoopIndex++)
  {
    DataWord = ((uint32_t)(data[LoopIndex*4 + 3]) << 24)  | ((uint32_t)(data[LoopIndex*4 + 2]) << 16);
    DataWord |= ((uint32_t)(data[LoopIndex*4 + 1]) << 8)  | ((uint32_t)(data[LoopIndex*4 ]));
    //DataWord = data[LoopIndex];
    //CRC_CalcBlockCRC(data, NbrOfCompleteWord);
    //CRC_CalcBlockCRC(&DataWord, 1);
    CRC_CalcCRC(DataWord);
  }
  
  // Feeding residual bytes to CRC module in a left align word
  // (First byte left align in word, second byte insert after first byte...)
  DataWord = 0;
  for(LoopIndex = 0; LoopIndex < NumberOfResidualByte; LoopIndex++)
  {
    DataWord |= (*(data + (NbrOfCompleteWord << 2) + LoopIndex)) << (8 * (3 - LoopIndex));
    CRC_CalcCRC(DataWord);
  }
  
  return CRC_GetCRC();
	
}

//------------------------------------------------------------------------------
// FLASH_DEFAULT_SETTINGS
//------------------------------------------------------------------------------
// This function fills a WIMU_SETTINGS structure with the default values.
//------------------------------------------------------------------------------
// Parameters: 
// settings, a pointer to the WIMU_SETTINGS structure to be written.
//
// Return value :
// None
//------------------------------------------------------------------------------
void flash_default_settings(WIMU_SETTINGS* settings)
{
        uint8_t i;
	memset(settings,0,sizeof(WIMU_SETTINGS)-4);
	
	settings->id = 0x0000;
	settings->hw_id = 3;
	settings->crc = 0;

        // Set gains to 1 by default
        for (i=0; i<3; i++){
          settings->acc_gain[i]=1;
          settings->gyro_gain[i]=1;
          settings->mag_gain[i]=1;
        }


	return;
}

//------------------------------------------------------------------------------
// FLASH_DEFAULT_CONFIG
//------------------------------------------------------------------------------
// This function fills a WIMU_CONFIG structure with the default values.
//------------------------------------------------------------------------------
// Parameters: 
// config, a pointer to the WIMU_CONFIG structure to be written.
//
// Return value :
// None
//------------------------------------------------------------------------------
void flash_default_config(WIMU_CONFIG* config)
{
	memset(config,0,sizeof(WIMU_CONFIG)-4);
	
	/*config->int_mod = 0x00C0; 	// No sensors used
	config->ext_mod = 0; 		// No external module
	config->cpu_opt = (30 << 2);    // No watchdog, no ADC@100 Hz, 30s blink
	config->log_opt = 0;		// No writing LED
	config->gps_opt = 0x04;		// Tracking smoothing on
	config->power_opt = 0x02A5;	// Power off on USB = false, sleepout = 2, usbcharge_t=10, lowbat_t=5 
	config->log_filetime = 60;	// Create a new file each 60 minutes
	config->log_reset_t  = 24;	// Resets datalogger and change folder each 24 hours
	config->gps_dead_t = 5;		// If no reply from GPS in 5 seconds, tries to reset it
	config->gps_degrad_t = 60;	// GPS maximum number of seconds in degraded mode
	config->gps_deadrec_t = 60;	// GPS maximum number of seconds in dead reckoning mode
	config->enc_opt = 17;		// Encoder 17 cm radius wheel
	config->mag_opt = 1;		// Magneto range = 1Ga
	config->acc_opt = 3;		// Acc. range = 4g
	config->man_opt = 180;		// 3 minutes motion detection window*/

        // Set non-zero values
        config->ui.led_blink_time = 30;
        config->general.sampling_rate = 50;
        config->datetime.time_offset = -5;
        //config->logger.file_time = 60;
        config->logger.split_by_day = true;
        config->logger.max_files_in_folder = 24;
        config->gps.interval = 1;
        config->gps.enable_scan_when_charged = true;
        config->acc.range = 3;
        config->gyro.range = 0;
        config->magneto.range = 1;
        config->imu.beta = 0.5;
        
          
	config->crc = crc_calc((unsigned char*)config, sizeof(WIMU_CONFIG) - 4);
	return;
}

void flash_read_settings(WIMU_SETTINGS* settings)
{
  *settings = *(WIMU_SETTINGS*)(DATA_EEPROM_SETTING_BASE);
}

void flash_read_config(WIMU_CONFIG* config)
{
	*config = *(WIMU_CONFIG*)(DATA_EEPROM_CONFIG_BASE);
}

