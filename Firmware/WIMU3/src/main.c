//******************************************************************************
//  WIMUGPS - Main Module
//
//  Description: This is the main module, which includes the main functions
//
//  Author: Simon Briere, ing., M. Sc. A.
//  STM32 adaptation: Nicolas Viscogliosi
//  Initial Version: April 24th, 2013
//
//  Modifications:
//******************************************************************************

/* Includes ------------------------------------------------------------------*/
#include <stdio.h>

#include "main.h"
#include "battery.h"

/* Private macro -------------------------------------------------------------*/

/* Public variables ----------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/

// Timing
unsigned long timestamp;
unsigned char time_sync = 0;

// Settings & Config
WIMU_SETTINGS wimu_settings;
WIMU_CONFIG wimu_config;

// Data management
bool initialized = FALSE;
bool first_time_init = true;
int16_t dataToWrite[MAX_FS*3];  //Memory buffer to write 3-axis data
int8_t dataGPSToWrite[200];
float dataQuaternionToWrite[MAX_FS*4];
float Quaternion_1s[4][MAX_FS];
uint8_t Qua_SampleNumber = 0;

volatile int16_t AccelX_1s[2][MAX_FS];
volatile int16_t AccelY_1s[2][MAX_FS];
volatile int16_t AccelZ_1s[2][MAX_FS];
volatile int16_t GyroX_1s[2][MAX_FS];
volatile int16_t GyroY_1s[2][MAX_FS];
volatile int16_t GyroZ_1s[2][MAX_FS];

volatile int16_t MagnetoX_1s[2][MAX_FS];
volatile int16_t MagnetoY_1s[2][MAX_FS];
volatile int16_t MagnetoZ_1s[2][MAX_FS];




/* Extern variables ----------------------------------------------------------*/
// Real-Time Clock
extern RTC_TimeTypeDef RTC_TimeStruct;
extern RTC_DateTypeDef RTC_DateStruct;

// Using 64 bits SysTick counter to ensure that the counter will never overflow
extern volatile uint64_t SysTick_Counter;
extern volatile uint32_t SysTick_DelayDownCounter;


/* Private function prototypes -----------------------------------------------*/
void Main_ManageNewPowerState();
/* Private functions ---------------------------------------------------------*/

//------------------------------------------------------------------------------
// MAIN
//------------------------------------------------------------------------------
// System Main
//------------------------------------------------------------------------------
int main(void){
    char buf[32];

  /////////////////////////////////////
  // Base system initialization
  /////////////////////////////////////
  DOS_settings.exp_num = 0;
  //Set RTC initial time (01-01-xx00)
  RTC_SetInitial();
  timestamp=0;			// Global timestamp set to 0

  // Initial datalogger informations
  /*dos_filenum = -1;
  next_files();
  dos_runtime=0;*/

  //////////////////////////////////////////////
  // Starts everything that needs to be started
  //////////////////////////////////////////////
  Main_Start(); 

  //////////////////////////////////////////////
  // Write module start in log
  //////////////////////////////////////////////
   if (first_time_init==true){
    first_time_init=false;
    // Log start message, if required
     if (isModuleOnline(MODULE_DATALOGGER)){
      sprintf(buf, "WIMuGPS %d.%d.%d started\r\n", VERSION_MAJOR, VERSION_MINOR, VERSION_REV);
      datalog_save_data((unsigned char*)&buf[0],strlen(buf), TRUE, MODULE_CPU,0);
     }
   }

  initialized=true;

/* -----------Main loop----------- */
 while (1){   

  //  softWDTInit();
 	
       ////////////////////////
       // Power Management
       ///////////////////////
       if (Power_StateUpdate(false)){
         // Power state was changed - do the required action
         Main_ManageNewPowerState();
       }

       ////////////////////////
       // Reset Watchdog
       ///////////////////////
       //TODO        

        ////////////////////////
        // Process USB commands
        ///////////////////////
        if (isModuleOnline(MODULE_USB))
                main_usb();
      
        //Global manipulations
        ///////////////////////////////
      
        ///////////////////////////
        // Datalogger module
        ///////////////////////////
        if (isModuleOnline(MODULE_DATALOGGER)){
                main_datalogger();
        }

        // Power module
        ///////////////////////////
        if (isModuleOnline(MODULE_POWER)){
                main_power();				
        }

        ///////////////////////////
        // Accelerometer/Gyroscope module
        ///////////////////////////
        if (isModuleOnline(MODULE_ACC) || isModuleOnline(MODULE_GYRO)){
                main_mpu();
        }

        ///////////////////////////
        // Gyroscope module
        ///////////////////////////
        /*if (isModuleOnline(MODULE_GYRO)){
                main_gyro();
        }*/

        ///////////////////////////
        // Magnetometer module
        ///////////////////////////
        if (isModuleOnline(MODULE_MAGNETO)){
                main_magneto();
        }

      
      
        ///////////////////////////
        // Bluetooth module
        ///////////////////////////
        if (isModuleOnline(MODULE_BLE)){
                main_ble();
        }
                    
        ////////////////////////
        // Process GPS data
        ///////////////////////
        if (isModuleOnline(MODULE_GPS) || getModuleState(MODULE_GPS)==STATE_SPECIAL){
                main_gps();
        }
      
        ////////////////////////
        // Resets Management
        ///////////////////////
        manage_resets();
      
        ////////////////////////
        // Buttons Management
        ///////////////////////
        main_buttons();

        //////////////////////
        // IMU
        /////////////////////
        main_imu();

      #ifdef POWER_MANAGE
        /*if (i_mod_status[MODULE_DATALOGGER]==MODULE_ONLINE)
          if(SPI_I2S_GetFlagStatus(SD_SPI, SPI_I2S_FLAG_BSY) == RESET); // Wait for data write complete on card before sleeping
             PWR_EnterSleepMode(PWR_Regulator_ON, PWR_SLEEPEntry_WFI);*/
      #endif
    
    } // Main While
  


  /* -----------Main loop end----------- */
  return 0;
}

//------------------------------------------------------------------------------
// MAIN_INIT
//------------------------------------------------------------------------------
// Initialization function for the system.
//------------------------------------------------------------------------------
bool Main_Init(void){
  unsigned char i;
  uint32_t crc;

  //////////////////////////////
  // Initialize Clocks
  //////////////////////////////
  // System clock init
  RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);
  RCC_HSEConfig(RCC_HSE_ON);
  RCC_PLLCmd(ENABLE);
  SysTick_Config(SystemCoreClock/1000);     

  //Timer and RTC config
  Wait_TimerConfig();
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_PWR, ENABLE);
  RTC_Config();

  //////////////////////////////
  // Initialize Interrupt system
  //////////////////////////////
  NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);

  //////////////////////////////
  // UI (LED, button) config
  //////////////////////////////
  LedAndBuzzer_Config(false);
  PushButton_Config();

  //////////////////////////////
  // Monitors config
  //////////////////////////////
  // Battery Monitoring
  BatteryMonitoring_Config();
  // Charge detection Config
  //ChargeStat_Config();

  // Enable Pushbuttons interrupts - Charge stats modify EXTI interrupts, so before that line, would not be useful...
 // PushButton_SetInterrupt(&ModeButton, ENABLE);
  //PushButton_SetInterrupt(&PowerButton, ENABLE);

  // USB Detection
  USBDetect_Config();

  //////////////////////////////
  // Debugger config
  //////////////////////////////
  DBGMCU_Config(DBGMCU_SLEEP | DBGMCU_STOP | DBGMCU_STANDBY, ENABLE);

  //////////////////////////////
  // Modules config
  //////////////////////////////
  // Disable all modules by default
  for (i=0; i<MODULE_INTERNAL_NUM; i++)
          setModuleState(i,STATE_DISABLED);

  // Power down all devices, since otherwise, regulators may be left floating
   Main_PowerdownAll();

  //////////////////////////////
  // Flash memory initialization
  //////////////////////////////
   flash_init();

  //////////////////////////////
  // System Settings
  //////////////////////////////
         
  // Read settings from Flash
  flash_read_settings(&wimu_settings);

  // Checksum & load default values if error
  crc = crc_calc((unsigned char*)&wimu_settings, (sizeof(WIMU_SETTINGS)-4));
  if (crc != wimu_settings.crc  || wimu_settings.crc==0){
    //CRC error, using default values
    flash_default_settings(&wimu_settings);
  }

  // Set software version
  wimu_settings.version[0] = VERSION_MAJOR;
  wimu_settings.version[1] = VERSION_MINOR;
  wimu_settings.version[2] = VERSION_REV;

  //////////////////////////////
  // System Configuration
  //////////////////////////////

  // Read config from flash
  flash_read_config(&wimu_config);

  // Checksum & load default values if error
  crc = crc_calc((unsigned char*)&wimu_config, (sizeof(WIMU_CONFIG)-4));
  if (crc != wimu_config.crc || wimu_config.crc==0){
    //CRC error, using default values
    flash_default_config(&wimu_config);
  }
  
  //////////////////////////////
  // Modules Activation
  //////////////////////////////
  // Internal
  for (i=0;i<MODULE_INTERNAL_NUM;i++){
    if ((wimu_config.enabled_modules & (1<<i)) > 0){
      setModuleState(i,STATE_OFFLINE);
    }
  }

  setModuleState(MODULE_CPU, STATE_ONLINE);     //CPU is always on by default
  setModuleState(MODULE_USB, STATE_OFFLINE);    // Always enable USB Module
  setModuleState(MODULE_POWER, STATE_OFFLINE);  // Always enable Power Module

   // Manually control each module for test
  /*setModuleState(MODULE_ACC, STATE_DISABLED);
  setModuleState(MODULE_GYRO, STATE_DISABLED);
  setModuleState(MODULE_MAGNETO, STATE_DISABLED);
  setModuleState(MODULE_DATALOGGER, STATE_DISABLED);
  setModuleState(MODULE_GPS, STATE_DISABLED);
  setModuleState(MODULE_BLE, STATE_DISABLED);

  wimu_config.ui.write_led = true;*/

 // Enable IMU module if at least Acc and Gyro modules are enabled
  if (getModuleState(MODULE_ACC)==STATE_OFFLINE && getModuleState(MODULE_GYRO)==STATE_OFFLINE){
    setModuleState(MODULE_IMU, STATE_OFFLINE);
  }else
    setModuleState(MODULE_IMU, STATE_DISABLED);

  //////////////////////////////
  // Variables initialization
  //////////////////////////////
  //Initialize IMU Frame
  for (i=0;i<3;i++){
    IMUFrame.acc_data[i]=0xFFFF;
    IMUFrame.gyro_data[i]=0xFFFF;
    IMUFrame.mag_data[i]=0xFFFF;
  }
  IMUFrame.frame_num=0;

  return TRUE; //All is well!
}

// Start every modules
void Main_Start(){
  Main_Init();

  led(LED_GREEN, TRUE, MEDIUM_PRIORITY);

  //if (first_time_init){
    //////////////////////////////
    // USB Module - Started only once for the whole run
    //////////////////////////////
    if (getModuleState(MODULE_USB)==STATE_OFFLINE){ 
       USB_GlobalInit();
       USB_Start();
       setModuleState(MODULE_USB, STATE_ONLINE);

       if (USB_IsConnected()){
        // USB cable connected at startup, delay a little to allow everything to set up correctly
        msWait(500);
       }
    }	
  //}

  ChargeStat_Config();
  PushButton_SetInterrupt(&ModeButton, ENABLE);

  update_timestampRTC();
  if (Main_StartModules()==false){
    //Error happened in the initialization sequence
     error(MODULE_CPU, ERROR_INIT);
    //return;
   }
       
   // Turn off LED to indicate boot is completed
  led(LED_GREEN, FALSE, NO_PRIORITY);
  Buzzer_PlayStartSong();
}

// Stop every module
void Main_Stop(bool enter_stop_mode){
    uint8_t i;
    __disable_irq();

  // Wait a little if USB connected, to try and detect if we are connected to a "talking" device
    /*if (Power_GetState()==POWER_STATE_USB){
      msWait(200);
      Power_StateUpdate();
    }*/

  //Shutdown every module, except USB and power
  for (i=0; i<MODULE_INTERNAL_NUM; i++){
    if (i != MODULE_USB && i != MODULE_POWER && i!=MODULE_CPU)
      Main_Shutdown(i);
   }
   if (enter_stop_mode)
      Main_Shutdown(MODULE_CPU);
   Main_PowerdownAll();
   Power_StateDisplay();
   Wait_TimerConfig();
   __enable_irq();

   // STOP
   if (enter_stop_mode){
    USB_Stop();
    USBDetect_Config();

    #ifdef POWER_MANAGE
      LedAndBuzzer_Config(true);
    #endif

    if (Power_GetState()==POWER_STATE_OFF)
      Buzzer_PlayStopSong();

     while (Power_IsStopRequired(Power_GetState())){
        #ifdef POWER_MANAGE
          CLEAR_BIT(SysTick->CTRL, SysTick_CTRL_TICKINT_Msk);  // Disable SysTick interrupts
                    
          if (!Power_IsCharging() && Power_GetState()!=POWER_STATE_LOWBAT){
            LedAndBuzzer_Config(true);
            Power_StateDisplay();
            Power_Stop();
          }else{ 
            LedAndBuzzer_Config(false);
            Power_StateDisplay();
            //PWR_EnterSleepMode(PWR_Regulator_LowPower, PWR_STOPEntry_WFI); // Low-Power Sleep mode to enable timers for LED display
            Power_Sleep();
          }
          SET_BIT(SysTick->CTRL, SysTick_CTRL_TICKINT_Msk);    // Enable SysTick interrupts
        #endif
       if (PowerButton.RequestedAction==BTN_ON_OFF){
            // Give a quick visual feedback that the command was understood
            led(LED_GREEN, TRUE, MEDIUM_PRIORITY);
          }
        if (Power_StateUpdate()){
          Main_ManageNewPowerState();
          Power_StateDisplay();
        }
        
     }
   }
}


//------------------------------------------------------------------------------
// MAIN_STARTUP
//------------------------------------------------------------------------------
// Initialize each internal peripheral. 
// Verify that each device is correctly responding
// Start (enable) each device 
//------------------------------------------------------------------------------
bool Main_StartModules(void){
    unsigned char status;
    uint16_t  battery;
    //unsigned short count;
    //unsigned char f = ((wimu_config.cpu_opt & CONFIG_CPU_ADCBIT1) >> 7)*2 + ((wimu_config.cpu_opt & CONFIG_CPU_ADCBIT0) >> (CONFIG_CPU_ADCBIT0-1));
    //unsigned short fe;
    //if (f==0) fe=50;
    //if (f==1) fe=100;
    //if (f==2) fe=200;

    // Set sampling rate for BLE module
    //DEVINFOFrame.samplingRate = wimu_config.general.sampling_rate;

    // Update battery level
    //BatteryMonitoring_RdADC(&Battery_ADCValue);

    // Wait for first battery level reading
    while ( (battery = BatteryMonitoring_GetBatteryADCValue() ) == 0);
        
    //////////////////////////////
    // Power Module
    //////////////////////////////   
    if (getModuleState(MODULE_POWER)==STATE_OFFLINE){
        if ((status=Power_Init())!=0){
            error(MODULE_POWER, status);
            return FALSE; //Problem occured
        }

        if ((status=Power_Start())!=0){
                error(MODULE_POWER, status);
                return FALSE;
        }
        setModuleState(MODULE_POWER, STATE_ONLINE);
        
        usb_mode = MASS_STORAGE; // Set USB mode in case it is already plugged in
        if (Power_StateUpdate()){
          Main_ManageNewPowerState();
          if (Power_IsStopRequired(Power_GetState()) || Power_GetState()==POWER_STATE_USB_MASS)
            return true; // Leave here
        }

        /*if (USB_GetState()==USB_STATE_CONNECTED && Power_GetState() != POWER_STATE_USB_ON)
          Power_SetState(POWER_STATE_USB);

        if (Power_GetState() != POWER_STATE_ON && Power_GetState() != POWER_STATE_USB_ON  && USB_GetState()!=USB_STATE_CONNECTED){
            return true; // Leave here
        } */
    }


    //////////////////////////////
    // LOGGER Module
    //////////////////////////////
    if (getModuleState(MODULE_DATALOGGER)==STATE_OFFLINE && Power_GetState()!=POWER_STATE_USB_MASS && Power_GetState()!=POWER_STATE_USB_COM){
      status=init_datalogger();
      msWait(100);
      if (status==0)
          status=start_datalogger();
      
      if (status!=0)
          error(MODULE_DATALOGGER, status);
      
      setModuleState(MODULE_DATALOGGER,STATE_ONLINE);
    }

    /*if (Power_GetState() != POWER_STATE_ON && Power_GetState() != POWER_STATE_USB_ON){
        return TRUE; // Leave here
    }*/

    /////////////////////////////////////
    // Accelerometer & Gyrometer Modules
    /////////////////////////////////////
    if (getModuleState(MODULE_ACC)==STATE_OFFLINE || getModuleState(MODULE_GYRO)==STATE_OFFLINE){

        status = MPUCompass_MPUInit();
        if (status==ERROR_NONE)
          status = MPUCompass_MPUStart();
        
        if (status!=ERROR_NONE)
          error(MODULE_ACC,status);

        if (getModuleState(MODULE_ACC)==STATE_OFFLINE){
          setModuleState(MODULE_ACC,STATE_ONLINE);
          IMUFrame_ReadyMask |= MODULE_ACC;
        }

        if (getModuleState(MODULE_GYRO)==STATE_OFFLINE){
          setModuleState(MODULE_GYRO, STATE_ONLINE);
          IMUFrame_ReadyMask |= MODULE_GYRO;
        }
        
    }

    //////////////////////////////
    // Magnetometer Module
    //////////////////////////////
    if (getModuleState(MODULE_MAGNETO)==STATE_OFFLINE){

        if (!isModuleOnline(MODULE_ACC) && !isModuleOnline(MODULE_GYRO)){ //i_mod_status[MODULE_ACC]!=MODULE_ONLINE && i_mod_status[MODULE_GYRO]!=MODULE_ONLINE){
          MPUCompass_ConfigIO();
          MPUCompass_EnablePower();
          MPUCompass_MPUWakeup();            
         // MPUCompass_MPUConfigReg();
        }

       if (MPUCompass_CompassIDValidation()==0)
            error(MODULE_MAGNETO, 1);
    
       MPUCompass_CompassConfigReg(wimu_config.magneto.range);
       MPUCompass_CompassInitTimer();
       //MPUCompass_CompassSetFreq(MPUCOMPASS_50Hz);
    

       if (wimu_config.general.sampling_rate==50)   MPUCompass_CompassSetFreq(MPUCOMPASS_50Hz);
       if (wimu_config.general.sampling_rate==100)  MPUCompass_CompassSetFreq(MPUCOMPASS_100Hz);
       if (wimu_config.general.sampling_rate==200)  MPUCompass_CompassSetFreq(MPUCOMPASS_200Hz);

       if (isModuleOnline(MODULE_ACC) || isModuleOnline(MODULE_GYRO))
        MPUCompass_CompassSync();

       //MPUCompass_MPUStart();
       MPUCompass_CompassStart();
   
       setModuleState(MODULE_MAGNETO, STATE_ONLINE);
        
       IMUFrame_ReadyMask |= MODULE_MAGNETO;
        
    }

    // Ensure interrupts are still set for PushButton which shares the same Int Vector as the MPU
    //PushButton_SetInterrupt(&PowerButton, ENABLE);

    //////////////////////////////
    // BLE Module
    //////////////////////////////
    if (getModuleState(MODULE_BLE)==STATE_OFFLINE){

        if ((status=init_ble())!=0){
                error(MODULE_BLE, status);
                return FALSE; //Problem occured
        }
        if ((status=start_ble())!=0){
                error(MODULE_BLE, status);
                return FALSE;
        }
        setModuleState(MODULE_BLE, STATE_ONLINE);
    }	

    //////////////////////////////
    // GPS Module
    //////////////////////////////
    if (getModuleState(MODULE_GPS)==STATE_OFFLINE || wimu_config.datetime.enable_gps_time){
        if ((status=GPS_Init())!=0){
                error(MODULE_GPS, status);
                return FALSE; //Problem occured
        }
        if ((status=GPS_Start())!=0){
                error(MODULE_GPS, status);
                return FALSE;
        }
        setModuleState(MODULE_GPS, STATE_ONLINE);

        // In case MPU is off, we must manually set the interrupt for the power button
        if (!isModuleOnline(MODULE_ACC) && !isModuleOnline(MODULE_MAGNETO))
          PushButton_SetInterrupt(&PowerButton, ENABLE);
    
        if (wimu_config.datetime.enable_gps_time && !isModuleOnline(MODULE_GPS))
            setModuleState(MODULE_GPS,STATE_SPECIAL);
    }	

    //////////////////////////////
    // IMU Module
    //////////////////////////////
    if (getModuleState(MODULE_IMU)==STATE_OFFLINE){
      IMUInit();
      madgwick_Struct = MadgwickInit(wimu_config.imu.beta, 
                                     wimu_config.general.sampling_rate, 
                                     getModuleState(MODULE_MAGNETO)==STATE_DISABLED || wimu_config.imu.disable_magneto, 
                                     wimu_config.imu.auto_calib_gyro);
      setModuleState(MODULE_IMU, STATE_ONLINE);
    }
  
  return true; //All is well!
}


//------------------------------------------------------------------------------
// MAIN_DATALOGGER
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the datalogger
// module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_datalogger(void){
   datalog_check_nextfiles(); // Check if we need to change file
}

//------------------------------------------------------------------------------
// MAIN_USB
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the USB
// module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_usb(void){
  uint8_t usb_bin_stream_old = usb_stream_bin;
    if (usb_rx_ready==TRUE){
      //led(LED1, TRUE);
    
      USB_ProcessRX();

      if (usb_bin_stream_old != usb_stream_bin){
        if (usb_stream_bin == USB_STREAM_FAST){
          // Must start all modules
          led(LED_GREEN, TRUE, NO_PRIORITY);
          Main_StartModules();
          led(LED_GREEN, FALSE, NO_PRIORITY);

          // Ensure we are still in the correct state!
          Power_SetState(POWER_STATE_USB_COM);
        }else{
          // Must stop all modules..
          Main_Stop(false);
          //...except battery monitor
          BatteryMonitoring_Config();
        }
      }
    
      
      //led(LED1, FALSE);
      if (usb_rx_queue<=0)
              usb_rx_ready=FALSE; 
    }
}

//------------------------------------------------------------------------------
// MAIN_BLE
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the BLE
// module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_ble(void){
    if (ble_rx_ready==TRUE){
          BLE_process_rx();
          
          if (ble_rx_queue<=0)
            ble_rx_ready=FALSE; 
    }
    
    // Check if we need to update the timestamp
    if (ble_update_time){
      BLE_sendCurrentDateTime();
      ble_update_time = false;
    }
}

//------------------------------------------------------------------------------
// MAIN_POWER
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the power
// module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_power(void){
  //int i;
  char buf[32];

  float voltage_battery;
  float actual_temp;
  uint8_t pourcentage_battery;
  uint16_t adcValue;

  if (power_ready==TRUE){
    power_ready = FALSE;
    // Read battery level
    //BatteryMonitoring_RdADC(&Battery_ADCValue);
    adcValue = BatteryMonitoring_GetBatteryADCValue();

    //TDDO: Better algorithm for battery %
    voltage_battery = Battery_VFromADC(adcValue);
    //voltage_battery = (3.3/1024.0) * (float)(Battery_ADCValue) / 2.0;	// in volts
    pourcentage_battery = (uint8_t)((voltage_battery-3.3) / (3.7f-3.3f) * 100); //(uint8_t)((voltage_battery * 100.0)/3.7);		// in %
    if (pourcentage_battery > 100)
	  pourcentage_battery = 100;

    // Read actual temperature
    //TempMonitoring_RdADC(&Temp_ADCValue);
    adcValue = BatteryMonitoring_GetTempADCValue();
    
    actual_temp = Temp_FromADC(adcValue);
    // Check for low-batt
    /*if(Battery_ADCValue <= LOWBAT_ADC_THRESHOLD)
    {
      Power_SetState(POWER_STATE_LOWBAT);
      return;
    }*/

    dataToWrite[0] = (uint16_t)(actual_temp * 100); // Temperature
    dataToWrite[1] = (uint16_t)(voltage_battery * 100); // Battery voltage
    dataToWrite[2] = ((uint8_t)Power_GetState() & 0x7F) + (Power_IsCharging() ? 0x80 : 0x00); // Current power state & charge status

    //Save to Datalogger
    if (isModuleOnline(MODULE_DATALOGGER)){
            datalog_save_data((unsigned char*)&dataToWrite[0],6, TRUE, MODULE_POWER,0);
    }
        
    if (isModuleOnline(MODULE_USB)){
            if (usb_stream_power==USB_STREAM_SLOW){                     
                    sprintf(buf, "%ld, %f %f, %d\n\r", timestamp, voltage_battery, actual_temp, dataToWrite[2]);
                    USB_SendString(buf,strlen(buf));
            }
            if (usb_stream_bin==USB_STREAM_FAST){
                  USB_SendBinary((unsigned char*)&dataToWrite[0],6,MODULE_POWER);	
            }
            /*if (usb_stream_time==USB_STREAM_SLOW){                     
                    sprintf(buf, "%ld\n\r", timestamp);
                    USB_SendString(buf,strlen(buf));
            }*/


    }
	
    if (isModuleOnline(MODULE_BLE)){
            //Send power data to BLE chip
            POWERFrame.batteryValue = pourcentage_battery;
            BLE_sendPOWERData(&POWERFrame);
    }
  }
}

//------------------------------------------------------------------------------
// MAIN_ACC
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the accelerometer
// module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
/*void main_acc(void){
      //static uint8_t Acc_ReadBufferPtr = 0;
      static uint16_t idleCount=0xFFFF;
      //static uint16_t count = 0;
      //char buf[32];
      //int16_t AccelXYZData[3];
      //int16_t GyroXYZData[3];
  
      //unsigned int WrittenByteCount;
      //MPUCompass_ReadMPUData(AccelXYZData, GyroXYZData);
      idleCount--;

      if (idleCount==0){
        // No data for a while!
        error(MODULE_ACC, 32);
      }
      if (AccNewValue==TRUE){
        idleCount=0xFFFF;
        if (MPU_SampleNumber>0){
          memcpy(&dataToWrite[0], (void*) &AccelX_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
          memcpy(&dataToWrite[1], (void*) &AccelY_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
          memcpy(&dataToWrite[2], (void*) &AccelZ_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
         }else{
          memcpy(&dataToWrite[0], (void*) &AccelX_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[1], (void*) &AccelY_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[2], (void*) &AccelZ_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
         }
        

        // Prepare IMU Frame
        //dataToWrite[0] = dataToWrite[1] = dataToWrite[2] = count+=100;
        memcpy(&IMUFrame.acc_data, (void*) &dataToWrite[0], 6);

        IMUFrame_Status |= MODULE_ACC;

        AccNewValue=FALSE;
        
      }
       if(Acc_BufferReady[MPU_BufRdPtr] == TRUE)
      {
        memcpy(&dataToWrite, &AccelX_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
        memcpy(&dataToWrite[MPU_SamplingFrequency], &AccelY_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
        memcpy(&dataToWrite[MPU_SamplingFrequency*2], &AccelZ_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);

        //Save to Datalogger
        if (isModuleOnline(MODULE_DATALOGGER)){
                datalog_save_data((unsigned char*)&dataToWrite[0],3*MPU_SamplingFrequency*2, TRUE, MODULE_ACC,0);
        }


        Acc_BufferReady[MPU_BufRdPtr] = FALSE;

        // Check if gyro data was needed and already read before doing this...
        if (((IMUFrame_ReadyMask & MODULE_GYRO) > 0 && (IMUFrame_Status & MODULE_GYRO) >0) || (IMUFrame_ReadyMask & MODULE_GYRO) == 0){
          MPU_BufRdPtr++;
          if(MPU_BufRdPtr > 1)
            MPU_BufRdPtr = 0;

          debug_printf("A%d",MPU_BufRdPtr);
        }
      }
}

//------------------------------------------------------------------------------
// MAIN_GYRO
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the gyroscope
// module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_gyro(void){
    //static uint8_t Gyro_ReadBufferPtr = 0;
    //static uint16_t count = 0;
    //char buf[32];

    //unsigned int WrittenByteCount;
  
  if (GyroNewValue==TRUE){
      if (MPU_SampleNumber>0){
        memcpy(&dataToWrite[0], (void*) &GyroX_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
        memcpy(&dataToWrite[1], (void*) &GyroY_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
        memcpy(&dataToWrite[2], (void*) &GyroZ_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
       }else{
        memcpy(&dataToWrite[0], (void*) &GyroX_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
        memcpy(&dataToWrite[1], (void*) &GyroY_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
        memcpy(&dataToWrite[2], (void*) &GyroZ_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
       }
      

      //dataToWrite[0] = dataToWrite[1] = dataToWrite[2] = count+=100;
      memcpy(&IMUFrame.gyro_data, (void*) &dataToWrite[0], 6);
      IMUFrame_Status |= MODULE_GYRO;
      
      GyroNewValue=FALSE;
      
    }

  if(Gyro_BufferReady[MPU_BufRdPtr] == TRUE)
  {
    memcpy(&dataToWrite, &GyroX_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
    memcpy(&dataToWrite[MPU_SamplingFrequency], &GyroY_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
    memcpy(&dataToWrite[MPU_SamplingFrequency*2], &GyroZ_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);

    //Save to Datalogger
    if (isModuleOnline(MODULE_DATALOGGER)){
            datalog_save_data((unsigned char*)&dataToWrite[0],3*MPU_SamplingFrequency*2, TRUE, MODULE_GYRO,0);
    }
    
  

    Gyro_BufferReady[MPU_BufRdPtr] = FALSE;
    // Check if acc data was needed and already read before doing this...
    if (((IMUFrame_ReadyMask & MODULE_ACC) > 0 && (IMUFrame_Status & MODULE_ACC) >0) || (IMUFrame_ReadyMask & MODULE_ACC) == 0){
      MPU_BufRdPtr++;
      if(MPU_BufRdPtr > 1)
        MPU_BufRdPtr = 0;

      debug_printf("G%d",MPU_BufRdPtr);
    }

  }*
}*/

//------------------------------------------------------------------------------
// MAIN_MPU
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the accelero
// and/or gyroscope module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_mpu(void){
  static uint16_t idleCount=0xFFFF;
  
  // Error detection
  idleCount--;
  if (idleCount==0){
      // No data for a while!
      error(MODULE_ACC, 32);
  }

  if (MPU_NewValue==true){
      idleCount=0xFFFF;
      // Accelero
      if (isModuleOnline(MODULE_ACC)){
        if (MPU_SampleNumber>0){
          memcpy(&dataToWrite[0], (void*) &AccelX_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
          memcpy(&dataToWrite[1], (void*) &AccelY_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
          memcpy(&dataToWrite[2], (void*) &AccelZ_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
         }else{
          memcpy(&dataToWrite[0], (void*) &AccelX_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[1], (void*) &AccelY_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[2], (void*) &AccelZ_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
         }
    
        // Prepare IMU Frame
        memcpy(&IMUFrame.acc_data, (void*) &dataToWrite[0], 6);

        IMUFrame_Status |= MODULE_ACC;
      }

      // Gyro
      if (isModuleOnline(MODULE_GYRO)){
         if (MPU_SampleNumber>0){
          memcpy(&dataToWrite[0], (void*) &GyroX_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
          memcpy(&dataToWrite[1], (void*) &GyroY_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
          memcpy(&dataToWrite[2], (void*) &GyroZ_1s[MPU_BufRdPtr][MPU_SampleNumber-1], 2);
         }else{
          memcpy(&dataToWrite[0], (void*) &GyroX_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[1], (void*) &GyroY_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[2], (void*) &GyroZ_1s[MPU_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
         }

        // Prepare IMU Frame
        memcpy(&IMUFrame.gyro_data, (void*) &dataToWrite[0], 6);
        IMUFrame_Status |= MODULE_GYRO;    
      }
      MPU_NewValue=false;
    }

    // 1 Hz saving data
     if(/*MPU_BufferReady[MPU_BufRdPtr] == true*/MPU_BufRdPtr != MPU_BufWrPtr)
      {
        // Accelero
        if (isModuleOnline(MODULE_ACC)){
          memcpy(&dataToWrite, &AccelX_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
          memcpy(&dataToWrite[MPU_SamplingFrequency], &AccelY_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
          memcpy(&dataToWrite[MPU_SamplingFrequency*2], &AccelZ_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);

          //Save to Datalogger
          if (isModuleOnline(MODULE_DATALOGGER)){
                  datalog_save_data((unsigned char*)&dataToWrite[0],3*MPU_SamplingFrequency*2, TRUE, MODULE_ACC,0);
          }
        }
        
        // Gyro
        if (isModuleOnline(MODULE_GYRO)){
          memcpy(&dataToWrite, &GyroX_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
          memcpy(&dataToWrite[MPU_SamplingFrequency], &GyroY_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);
          memcpy(&dataToWrite[MPU_SamplingFrequency*2], &GyroZ_1s[MPU_BufRdPtr], MPU_SamplingFrequency*2);

          //Save to Datalogger
          if (isModuleOnline(MODULE_DATALOGGER)){
                  datalog_save_data((unsigned char*)&dataToWrite[0],3*MPU_SamplingFrequency*2, TRUE, MODULE_GYRO,0);
          }
        }


        //MPU_BufferReady[MPU_BufRdPtr] = false;

        MPU_BufRdPtr++;
        if(MPU_BufRdPtr > 1)
          MPU_BufRdPtr = 0;

        //debug_printf("A%d",MPU_BufRdPtr);
        
      }

}

//------------------------------------------------------------------------------
// MAIN_MAGNETO
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop if the magnetometer
// module is enabled.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_magneto(void){
  //static uint8_t Compass_ReadBufferPtr = 0;
  //static uint16_t count = 0;
  //unsigned int WrittenByteCount;
  uint8_t sample_number = Compass_SampleNumber;
  //char buf[32];

    if (Mag_NewValue==true){
        if (sample_number>0){
          memcpy(&dataToWrite[0], (void*) &MagnetoX_1s[Compass_BufRdPtr][sample_number-1], 2);
          memcpy(&dataToWrite[1], (void*) &MagnetoY_1s[Compass_BufRdPtr][sample_number-1], 2);
          memcpy(&dataToWrite[2], (void*) &MagnetoZ_1s[Compass_BufRdPtr][sample_number-1], 2);
       }else{
          memcpy(&dataToWrite[0], (void*) &MagnetoX_1s[Compass_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[1], (void*) &MagnetoY_1s[Compass_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
          memcpy(&dataToWrite[2], (void*) &MagnetoZ_1s[Compass_BufRdPtr][MPUCompass_SamplingFrequency-1], 2);
       }

     
    //dataToWrite[0] = dataToWrite[1] = dataToWrite[2] = count+=100;
     memcpy(&IMUFrame.mag_data, (void*) &dataToWrite[0], 6);

     IMUFrame_Status |= MODULE_MAGNETO;

     Mag_NewValue=false;   
     
    }
    if(/*Compass_BufferReady[Compass_BufRdPtr] == true*/Compass_BufRdPtr != Compass_BufWrPtr)
    {
      memcpy(&dataToWrite, &MagnetoX_1s[Compass_BufRdPtr], MPUCompass_SamplingFrequency*2);
      memcpy(&dataToWrite[MPUCompass_SamplingFrequency], &MagnetoY_1s[Compass_BufRdPtr], MPUCompass_SamplingFrequency*2);
      memcpy(&dataToWrite[MPUCompass_SamplingFrequency*2], &MagnetoZ_1s[Compass_BufRdPtr], MPUCompass_SamplingFrequency*2);

      //Save to Datalogger
      if (isModuleOnline(MODULE_DATALOGGER)){
          datalog_save_data((unsigned char*)&dataToWrite[0],3*MPUCompass_SamplingFrequency*2, TRUE, MODULE_MAGNETO,0/*mag_time[mag_rd_buf_ptr]*/);
      }

     /* if (isModuleOnline(MODULE_USB)){
              if (usb_stream_mag==USB_STREAM_SLOW){
                      sprintf(buf, "%ld, %d %d %d\n\r", timestamp,MagnetoX_1s[Compass_ReadBufferPtr][MPU_SampleNumber], MagnetoY_1s[Compass_ReadBufferPtr][MPU_SampleNumber], MagnetoZ_1s[Compass_ReadBufferPtr][MPU_SampleNumber]);
                      USB_SendString(buf,strlen(buf));
            }
      }*/
      
      //Compass_BufferReady[Compass_BufRdPtr] = false;
      Compass_BufRdPtr++;

      if(Compass_BufRdPtr > 1)
        Compass_BufRdPtr = 0;

     // debug_printf("M%d",Compass_BufRdPtr);


    }
}

//------------------------------------------------------------------------------
// MAIN_BUTTONS
//------------------------------------------------------------------------------
// This function is called on each iteration of the main loop. It process the
// required actions on the buttons
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void main_buttons(void){
    //char buf[32];
    //uint8_t i;

  switch(ModeButton.RequestedAction){
    case BTN_MARK:
       if (isModuleOnline(MODULE_DATALOGGER)/* && Calib_Counter==0*/){
          if (wimu_config.ui.enable_marking){ // Data marking enabled?
            if (dos_isRecording)
              datalog_save_data((unsigned char*)"Mark OFF\r\n", 10, TRUE, MODULE_CPU,0);
            else
              datalog_save_data((unsigned char*)"Mark ON\r\n", 9, TRUE, MODULE_CPU,0);
          
            //DOS_settings.exp_num = 0;
            //datalog_change_folder();

            datalog_switch_recording_mode();
            
            if (dos_isRecording)
              datalog_save_data((unsigned char*)"Mark ON\r\n", 9, TRUE, MODULE_CPU,0);
            else
              datalog_save_data((unsigned char*)"Mark OFF\r\n", 10, TRUE, MODULE_CPU,0);
            
            Buzzer_Start(100);          
          }
        }
        ModeButton.RequestedAction = BTN_NO_ACTION;
    break;
    case BTN_USB_MODE:
      // First step is directly managed into the button action since it must occur even if device is in sleep mode
      /*if (usb_mode==MASS_STORAGE && Power_GetState()==POWER_STATE_USB_ON){
        USB_ModeSelection();
        init_usb();
      }*/
      if (Power_GetState()==POWER_STATE_USB_MASS){
        USB_SetMode(VIRTUAL_COM);
        BatteryMonitoring_Config();
        Power_SetState(POWER_STATE_USB_COM);
      }else{
        if (Power_GetState()==POWER_STATE_USB_COM){
          USB_SetMode(MASS_STORAGE);
          Power_SetState(POWER_STATE_USB_MASS);
        }
      }


      ModeButton.RequestedAction = BTN_NO_ACTION;
    break;
    case BTN_CALIB:
      //IMUStartCalibProcess();
      ModeButton.RequestedAction = BTN_NO_ACTION;
    break;
    default:
      ModeButton.RequestedAction = BTN_NO_ACTION;
    break;
    }

    switch(PowerButton.RequestedAction){
    case BTN_ON_OFF:
      /*//Light all LED
      led(LED_RED,TRUE, HIGH_PRIORITY);
      led(LED_GREEN,TRUE, HIGH_PRIORITY);
      led(LED_BLUE,TRUE, HIGH_PRIORITY);

      Buzzer_Start(200);
      
      sprintf(buf, "WIMUGPS Off\r\n");
      if (isModuleOnline(MODULE_DATALOGGER)){
        datalog_save_data((unsigned char*)&buf[0],13, TRUE, MODULE_CPU,0);
        msWait(200);
      }*/

      if (Power_StateUpdate()){
        Main_ManageNewPowerState();
      }

      //Shutdown every module, except USB and power
      /*for (i=0; i<MODULE_INTERNAL_NUM; i++){
        if (i != MODULE_USB && i != MODULE_POWER && i!=MODULE_CPU)
          Main_Shutdown(i);
      }
      Main_Shutdown(MODULE_CPU);
         
     //Set wake-up interrupt
      Power_SetState(POWER_STATE_OFF);
      PushButton_SetInterrupt(&PowerButton, TRUE);
      //PushButton_SetInterrupt(&ModeButton, FALSE);  // Disable mode button

      // STOP
      PowerButton.NbrOfPress = 0;

       while (PowerButton.NbrOfPress <3 && Power_GetState() == POWER_STATE_OFF ){
          PowerButton.LastActivationTimeStamp = timestamp;

          #ifdef POWER_MANAGE
            PWR_EnterSTOPMode(PWR_Regulator_LowPower, PWR_STOPEntry_WFI);
          #else
            i = PowerButton.NbrOfPress;
            while (Power_GetState()==POWER_STATE_OFF && PowerButton.NbrOfPress==i);
          #endif
          
          update_timestampRTC();
          if (PowerButton.LastActivationTimeStamp + 2 < timestamp){ // 2 seconds delay expired, reset counter
            PowerButton.NbrOfPress = 0;
          }

          //PushButton_SetPollingAndResetTicks(&PushButton1);
          Power_StateDisplay();
        
          if (USB_IsConnected()){
            // Set clock to correctly display blinking LEDs
            RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);
            RCC_HSEConfig(RCC_HSE_ON);
            RCC_PLLCmd(ENABLE);

            // Disable push button interrupt
            PushButton_SetInterrupt(&PowerButton, FALSE);

            while (USB_GetState()==USB_STATE_CONNECTED){
              PWR_EnterSleepMode(PWR_Regulator_LowPower, PWR_STOPEntry_WFI);
            }
            // Reenable push button interrupt
            PushButton_SetInterrupt(&PowerButton, TRUE);
          }
        }*/

        //PowerDown_NbrOfPress = 0;
//        SysTick_DelayDownCounter=0;
        

        // This line is reached when the WIMU has been started again
        //Power_SetState(POWER_STATE_ON);
     
        // Restart modules
        /*Main_Init();
        led(LED_GREEN,TRUE, MEDIUM_PRIORITY);
        Main_Startup();
  //      startup_ext();
      
        sprintf(buf, "WIMUGPS On\r\n");
        if (isModuleOnline(MODULE_DATALOGGER))
                datalog_save_data((unsigned char*)&buf[0],12, TRUE, MODULE_CPU,0);

        led(LED_GREEN,FALSE, NO_PRIORITY);*/

        PushButton_ResetAll(&PowerButton);
        PowerButton.LastActivationTimeStamp = timestamp;
    break;
    default:
        PowerButton.RequestedAction = BTN_NO_ACTION;
    break;
  }

}

void main_gps(void){
  if (gps_rx_ready==TRUE){
      //Send data to BLE chip
      if (isModuleOnline(MODULE_BLE)){
        BLE_sendGPSData(gps_rx[gps_rx_rd_ptr], gps_rx_len[gps_rx_rd_ptr], gps_rx[gps_rx_rd_ptr][4]);
      }

      //Save the received GPS data                
      if (isModuleOnline(MODULE_DATALOGGER)){
          //Don't save useless frames
          if (gps_rx[gps_rx_rd_ptr][4]!= SIRF_DEV_DATA && gps_rx[gps_rx_rd_ptr][4]!= SIRF_OK_TO_SEND && gps_rx[gps_rx_rd_ptr][4]!= SIRF_CMD_ACK){                                        
            datalog_save_data(&gps_rx[gps_rx_rd_ptr][0],gps_rx_len[gps_rx_rd_ptr], TRUE, MODULE_GPS, 0);        
          }
       }
                    
      if (isModuleOnline(MODULE_USB)){
          if (usb_stream_gps == USB_STREAM_FAST){
                  USB_SendString((char*)&gps_rx[gps_rx_rd_ptr][0],gps_rx_len[gps_rx_rd_ptr]);			
          }
          if (usb_stream_bin==USB_STREAM_FAST){
                  USB_SendBinary((unsigned char*)&gps_rx[gps_rx_rd_ptr][0],gps_rx_len[gps_rx_rd_ptr],MODULE_GPS);	
          }
      }

        //update_timestampRTC(FALSE);
        
        GPS_ProcessRX();
        
        if (gps_rx_queue <= 0){
                gps_rx_ready = FALSE;
        }
    } // GPS RX READY              
}


void main_imu(void){
  //uint8_t i;
  // Check if IMU data is ready to send
  if (IMUFrame_Status == IMUFrame_ReadyMask && IMUFrame_ReadyMask>0){
     
    // Check if we are calibrating
    /*if (Calib_Counter>0){
      // We are, so keep min and max values
      for (i=0; i<3; i++){
        if isModuleOnline(MODULE_ACC)){
          if (IMUFrame.acc_data[i] < IMUCalib.acc_min[i])
            IMUCalib.acc_min[i] = IMUFrame.acc_data[i];
          if (IMUFrame.acc_data[i] > IMUCalib.acc_max[i])
            IMUCalib.acc_max[i] = IMUFrame.acc_data[i];
        }

        if (isModuleOnline(MODULE_GYRO)){
          if (IMUFrame.gyro_data[i] < IMUCalib.gyro_min[i])
            IMUCalib.gyro_min[i] = IMUFrame.gyro_data[i];
          if (IMUFrame.gyro_data[i] > IMUCalib.gyro_max[i])
            IMUCalib.gyro_max[i] = IMUFrame.gyro_data[i];
        }

        if (isModuleOnline(MODULE_MAGNETO)){
          if (IMUFrame.mag_data[i] < IMUCalib.mag_min[i])
            IMUCalib.mag_min[i] = IMUFrame.mag_data[i];
          if (IMUFrame.mag_data[i] > IMUCalib.mag_max[i] && IMUFrame.mag_data[i]!=0)
            IMUCalib.mag_max[i] = IMUFrame.mag_data[i];
        }

      }
    }else{
      if(IMUCalib.in_progress==TRUE ){
        IMUCalib.in_progress=FALSE;
        //if (i_mod_status[MODULE_MAGNETO]==MODULE_ONLINE){
        //  if (IMUFrame.mag_data[0]!=0)
        //    IMUProcessRawCalibration(&IMUCalib, &IMUFrame);
        //}
      }
    }*/
    
    // Calibrate data
    IMUFrame_Struct imu;
    memcpy(&imu, &IMUFrame, sizeof(IMUFrame_Struct));
    calibrateIMUFrame (&madgwick_Struct, &imu);
    MadgwickProcess   (&madgwick_Struct);

    // Copy Quaternion from Madwick_Struct to IMU_Frame_Struct (which will be sent)
    imu.quaternion[0] = madgwick_Struct.quaternion[0];
    imu.quaternion[1] = madgwick_Struct.quaternion[1];
    imu.quaternion[2] = madgwick_Struct.quaternion[2];
    imu.quaternion[3]=  madgwick_Struct.quaternion[3];

    // Send data
    //USB
    if (isModuleOnline(MODULE_USB)){
      if (usb_stream_bin==USB_STREAM_FAST){
        USB_SendBinary((unsigned char*)&imu,sizeof(IMUFrame_Struct),MODULE_IMU);
      }
    }

    //BLE
    //Send data to BLE chip
    if (isModuleOnline(MODULE_BLE)){
      if (usb_stream_bin==USB_STREAM_OFF){ // Don't use BLE if streaming data on USB
        BLE_sendIMUData(&imu);
      }
    }

   //Datalogger
     if (isModuleOnline(MODULE_DATALOGGER)){
        Qua_SampleNumber++;
        
        memcpy(&Quaternion_1s[0][Qua_SampleNumber-1],&imu.quaternion[0],4);
        memcpy(&Quaternion_1s[1][Qua_SampleNumber-1],&imu.quaternion[1],4);  
        memcpy(&Quaternion_1s[2][Qua_SampleNumber-1],&imu.quaternion[2],4); 
        memcpy(&Quaternion_1s[3][Qua_SampleNumber-1],&imu.quaternion[3],4);
  
        if(Qua_SampleNumber == MPU_SamplingFrequency){
           Qua_SampleNumber = 0;
           memcpy(&dataQuaternionToWrite, &Quaternion_1s[0], MPU_SamplingFrequency*4);
           memcpy(&dataQuaternionToWrite[MPU_SamplingFrequency], &Quaternion_1s[1], MPU_SamplingFrequency*4);
           memcpy(&dataQuaternionToWrite[MPU_SamplingFrequency*2], &Quaternion_1s[2], MPU_SamplingFrequency*4);
           memcpy(&dataQuaternionToWrite[MPU_SamplingFrequency*3], &Quaternion_1s[3], MPU_SamplingFrequency*4);
           datalog_save_data((unsigned char*)&dataQuaternionToWrite,MPU_SamplingFrequency*4*4, TRUE, MODULE_IMU,0/*mag_time[mag_rd_buf_ptr]*/);
      }    
    }

    IMUFrame_Status=0;
    IMUFrame.frame_num++;

  }// endif (IMUFrame_Status == IMUFrame_ReadyMask && IMUFrame_ReadyMask>0

}

void Main_Shutdown(InternalModules_ID int_mod){

	//*** USB MODULE *** 
	if (int_mod==MODULE_USB || int_mod==MODULE_ALL){
          if (getModuleState(MODULE_USB)!=STATE_DISABLED){
            USB_Stop();
            setModuleState(MODULE_USB, STATE_OFFLINE);
          }	
	}
	
	//*** DATALOGGER (DOS-ON-CHIP) ***
	if (int_mod==MODULE_DATALOGGER || int_mod==MODULE_ALL){
          if (getModuleState(MODULE_DATALOGGER)!=STATE_DISABLED){
            stop_datalogger();
            //setModuleState(MODULE_DATALOGGER, STATE_OFFLINE);
          }
	}
	
	//*** POWER MODULE ***
	/*if (int_mod==MODULE_POWER || int_mod==MODULE_ALL){
		if (i_mod_status[MODULE_POWER]!=MODULE_DISABLED){
			stop_power();
			i_mod_status[MODULE_POWER]=MODULE_OFFLINE;
		}
	}*/
	
	//*** GPS MODULE ***
	if (int_mod==MODULE_GPS || int_mod==MODULE_ALL){
          if (getModuleState(MODULE_GPS)!=STATE_DISABLED){
            GPS_Stop();
            setModuleState(MODULE_GPS, STATE_OFFLINE);
          }
	}	
	
	//*** ACCELEROMETERS MODULE ***
	if (int_mod==MODULE_ACC || int_mod==MODULE_ALL){
          if (getModuleState(MODULE_ACC)!=STATE_DISABLED/*(enabled_i_devices & MODULE_ACC) && ((int_mask & MODULE_ACC))*/){
                  MPUCompass_MPUStop();
                  MPUCompass_DisablePower();
                  setModuleState(MODULE_ACC, STATE_OFFLINE);
          }
	}
	
	//*** GYROSCOPE MODULE ***
	if (int_mod==MODULE_GYRO || int_mod==MODULE_ALL){
          if (getModuleState(MODULE_GYRO)!=STATE_DISABLED && getModuleState(MODULE_ACC)!=STATE_DISABLED && getModuleState(MODULE_ACC)!=STATE_OFFLINE){
                  MPUCompass_MPUStop();
                  MPUCompass_DisablePower();
                
          }
          if (getModuleState(MODULE_GYRO)!=STATE_DISABLED) 
            setModuleState(MODULE_GYRO, STATE_OFFLINE);
                  
	}
	
	//*** MAGNETO MODULE ***
	if (int_mod==MODULE_MAGNETO || int_mod==MODULE_ALL){
          if (getModuleState(MODULE_MAGNETO)!=STATE_DISABLED){
                  MPUCompass_CompassStop();
                  MPUCompass_DisablePower();
                  setModuleState(MODULE_MAGNETO, STATE_OFFLINE);
          }
	}
	
	//*** BLE MODULE ***
	if (int_mod==MODULE_BLE || int_mod==MODULE_ALL){
          if (getModuleState(MODULE_BLE)!=STATE_DISABLED){
                  stop_ble();
                  setModuleState(MODULE_BLE, STATE_OFFLINE);
          }
	}

        if (int_mod==MODULE_CPU || int_mod==MODULE_ALL){
          __disable_irq();
           BatteryMonitoring_Stop();
    
          GPIO_InitTypeDef GPIO_InitStructure;
          // Configure all GPIO as analog to reduce current consumption on non used IOs
          // Enable GPIOs clock
          RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA | RCC_AHBPeriph_GPIOB | RCC_AHBPeriph_GPIOC |
          RCC_AHBPeriph_GPIOD | RCC_AHBPeriph_GPIOE | RCC_AHBPeriph_GPIOH |
          RCC_AHBPeriph_GPIOF | RCC_AHBPeriph_GPIOG, ENABLE);

          GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AN;
          GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
          GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
          GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;
          GPIO_InitStructure.GPIO_Pin = GPIO_Pin_All /*- GPIO_Pin_1 - GPIO_Pin_6*/ - GPIO_Pin_7 - GPIO_Pin_8 - GPIO_Pin_9 - GPIO_Pin_13; // Dont touch USB and charge detection
          //GPIO_Init(GPIOC, &GPIO_InitStructure);

          GPIO_InitStructure.GPIO_Pin = GPIO_Pin_All;
          //GPIO_Init(GPIOC, &GPIO_InitStructure);
          GPIO_Init(GPIOD, &GPIO_InitStructure);
          GPIO_Init(GPIOE, &GPIO_InitStructure);
          GPIO_Init(GPIOH, &GPIO_InitStructure);
          GPIO_Init(GPIOG, &GPIO_InitStructure);
          GPIO_Init(GPIOF, &GPIO_InitStructure);

          
          //GPIO_Init(GPIOA, &GPIO_InitStructure);
          //GPIO_Init(GPIOB, &GPIO_InitStructure);

          // Disable GPIOs clock
          RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA | RCC_AHBPeriph_GPIOB |/* RCC_AHBPeriph_GPIOC |*/
          RCC_AHBPeriph_GPIOD | RCC_AHBPeriph_GPIOE | RCC_AHBPeriph_GPIOH |
          RCC_AHBPeriph_GPIOF | RCC_AHBPeriph_GPIOG, DISABLE);
    
          // Disable PVD
          PWR_PVDCmd(DISABLE);
          RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART3, DISABLE);
          //RCC_APB1PeriphClockCmd(RCC_APB1Periph_USB, DISABLE);
          RCC_APB1PeriphClockCmd(RCC_APB1Periph_PWR, DISABLE);
          //RCC_APB2PeriphClockCmd(RCC_APB2Periph_SYSCFG, DISABLE);  

          // Enable Ultra low power mode
          PWR_UltraLowPowerCmd(ENABLE);
          LedAndBuzzer_Config(false);
          PushButton_Config();
          ChargeStat_Config();
          
          // Enable Pushbuttons interrupts - Charge stats modify EXTI interrupts, so before that line, would not be useful...
          PushButton_SetInterrupt(&ModeButton, ENABLE);
          PushButton_SetInterrupt(&PowerButton, ENABLE);
          
          __enable_irq();

          // Keep USB interrupts alive
          //USBDetect_Config();
        }
}

void Main_PowerdownAll(){
      // Cuts power to all sensors, doesn't change any state in the config
      // GPS
      GPS_SetupPower();
      GPS_DisablePower();

      // Sensors
      MPUCompass_SetupPower();
      MPUCompass_DisablePower();

      // BLE
      BLE_SetupPower();
      BLE_DisablePower();
}

void Main_ManageNewPowerState(){
  uint8_t status;
  PowerStates last_state = Power_GetLastState();
  
  /////////////////////////////
  // New state action
  /////////////////////////////
  switch(Power_GetState()){
    /////////////////////////
    case POWER_STATE_ON:
      if (Power_IsStopRequired(last_state) || last_state == POWER_STATE_USB_MASS || last_state == POWER_STATE_USB_COM){
        Main_Shutdown(MODULE_ALL);
        // Restart every module
        Main_Start();
        //last_power_state = last_state; // Restore real last state, since reset will have cleared it to default
      }
      if (isModuleOnline(MODULE_DATALOGGER)){
        datalog_save_data((unsigned char*)"WIMUGPS ON\n\r",12, TRUE, MODULE_CPU,0);
        msWait(200);
      }
    break;

    /////////////////////////
    case POWER_STATE_OFF:
      //Light all LED
      led(LED_RED,TRUE, HIGH_PRIORITY);
      led(LED_GREEN,TRUE, HIGH_PRIORITY);
      led(LED_BLUE,TRUE, HIGH_PRIORITY);

      //Buzzer_Start(200);

      msWait(200);
      
      //Close all LED
      led(LED_RED,false, HIGH_PRIORITY);
      led(LED_GREEN,false, HIGH_PRIORITY);
      led(LED_BLUE,false, HIGH_PRIORITY);
      
      if (isModuleOnline(MODULE_DATALOGGER)){
        datalog_save_data((unsigned char*)"WIMUGPS OFF\r\n",13, TRUE, MODULE_CPU,0);
        msWait(200);
      }
      // Shutdown every module and stops
      Main_Stop(true);

       //Light all LED
      /*led(LED_RED,TRUE, HIGH_PRIORITY);
      led(LED_GREEN,TRUE, HIGH_PRIORITY);
      led(LED_BLUE,TRUE, HIGH_PRIORITY);*/

      //Buzzer_Start(100);

      /*msWait(300);
      
      //Close all LED
      led(LED_RED,false, HIGH_PRIORITY);
      led(LED_GREEN,false, HIGH_PRIORITY);
      led(LED_BLUE,false, HIGH_PRIORITY);*/

    break;

    ///////////////////////////
    case POWER_STATE_LOWBAT:
      if (isModuleOnline(MODULE_DATALOGGER)){
        datalog_save_data((unsigned char*)"Low-Battery\r\n",13, TRUE, MODULE_CPU,0);
        msWait(200);
      }
      
      // Shutdown every module and stops
      Main_Stop(true);

      // Ensure battery monitor is on before managing next state!
      BatteryMonitoring_Config();
    break;
    ////////////////////////////
    case POWER_STATE_USB:
      if (isModuleOnline(MODULE_DATALOGGER)){
        datalog_save_data((unsigned char*)"USB Connected\r\n",15, TRUE, MODULE_CPU,0);
        msWait(200);
      }

      // Shutdown every module and stops
      Main_Stop(true);
    break;
     ////////////////////////////
    case POWER_STATE_USB_MASS:
      if (isModuleOnline(MODULE_DATALOGGER)){
        datalog_save_data((unsigned char*)"USB Mass Storage\r\n",18, TRUE, MODULE_CPU,0);
        msWait(200);
      }

      if (!Power_IsStopRequired(last_state)){
        // Shutdown every module since they were not already off
        for (status=0; status<MODULE_INTERNAL_NUM; status++){
          if (status != MODULE_USB && status != MODULE_POWER && status!=MODULE_CPU && status!=MODULE_DATALOGGER)
            Main_Shutdown(status);
        }
      }

      // Start datalogger module
      if (!isModuleOnline(MODULE_DATALOGGER) && getModuleState(MODULE_DATALOGGER)!=STATE_SPECIAL){
        /*status = init_datalogger();
        msWait(100);*/
        //if (status==0)
        /*  status=start_datalogger();
      
        if (status!=0)
            error(MODULE_DATALOGGER, status);
        setModuleState(MODULE_DATALOGGER, STATE_SPECIAL);*/
     }

     USB_SetMode(MASS_STORAGE);

    break;
     ////////////////////////////
    case POWER_STATE_USB_COM:
    if (isModuleOnline(MODULE_DATALOGGER)){
        datalog_save_data((unsigned char*)"USB Virtual COM\r\n",17, TRUE, MODULE_CPU,0);
        msWait(200);
      }
      /*if (Power_IsStopRequired(last_state)){
        // Starts every module since they were off
          Main_Start();
       }*/

       // Start battery and temp monitoring
       BatteryMonitoring_Config();

       USB_SetMode(VIRTUAL_COM);

    break;
  }
  
   //////////////////////////
   // State Change logging
   //////////////////////////
  if (Power_IsStateUSBRelated(last_state) && !Power_IsStateUSBRelated(Power_GetState())){
    if (isModuleOnline(MODULE_DATALOGGER)){
      datalog_save_data((unsigned char*)"USB Disconnected\r\n",18, TRUE, MODULE_CPU,0);
      msWait(200);
    }
  }

  
}

void manage_resets(void){
	unsigned char status=1;
	unsigned char count=0;
	bool dos_toomany_errors=FALSE;
	
	//Datalogger
	if (getModuleState(MODULE_DATALOGGER)==STATE_RESET){
		//led(LED2,TRUE);
		
		if (dos_errors>= DOS_MAX_ERRORS)
			dos_toomany_errors = TRUE;
		
		while (status!=0 && count < 3){
			//Do a reset of the datalogger module
			//shutdown(MODULE_DATALOGGER,0);
			//sleep(1000);
			
			if (dos_toomany_errors == FALSE){
				DOS_settings.exp_num=0; //Force a folder change
			}
			
			status=reset_datalogger();
			/*if (status==0)
				status=start_datalogger();*/
			count++;
		}
		
		if (status!=0){
			error(MODULE_DATALOGGER, status);
			return;
		}
		
		setModuleState(MODULE_DATALOGGER, STATE_ONLINE);
		if (dos_toomany_errors == TRUE){
			datalog_save_data((unsigned char*)"Datalogger: Too many errors Reset\r\n",35, TRUE, MODULE_CPU,0);
			msWait(200);	
		}else{
			datalog_save_data((unsigned char*)"Datalogger: Folder Change\r\n",27, TRUE, MODULE_CPU,0);
			msWait(200);
		}
		
	}
}

#ifdef USE_FULL_ASSERT
/*******************************************************************************
* Function Name  : assert_failed
* Description    : Reports the name of the source file and the source line number
*                  where the assert_param error has occurred.
* Input          : - file: pointer to the source file name
*                  - line: assert_param error line source number
* Output         : None
* Return         : None
*******************************************************************************/
void assert_failed(uint8_t* file, uint32_t line)
{
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {}
}
#endif


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
