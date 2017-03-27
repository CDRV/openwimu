//******************************************************************************
//  WIMUuSD - Power module
//
//  Description: This is the module that records internal and external data such
//				 as VBatt, Temperature and current probe (if present). Unlike 
//				 other module, if the current probe isn't there, data is still
//				 recorded since it uses a mix of internal and external sensors.
//
//  Author: Simon Brière, ing., M. Sc. A.
//  Initial Version: August 28th, 2009
//
//  Modifications: 
//  October 8th, 2009 - Added Stop function
//  October 13th, 2009 - Added Power Management function, charger detection pin
//  August 13th, 2010 - Added USB Charge detection (according that USB GPIO3 is 
//						correctly configured)
//  November 4th, 2010 - Improved USB Charge dectection by using the RESET pin
//						 instead of the GPIO3 pin
//  March 28th, 2011 - Added Activity Detection Power Management
//******************************************************************************
#include <stdio.h>

#include "power.h"
#include "datalogger.h"
#include "usb.h"
#include "usb_pwr.h"
#include "battery.h"
#include "buttons.h"
#include "main.h" // For shutdown

//#include "adc.h"
//#include "usb.h" // for USB charger detection
//#include "fsr.h" // For not seated power management
//#include "activity.h"

/*
//unsigned short power_data[POWER_BUF_NUM][3][MAX_ADC_FE];
unsigned short power_data[POWER_BUF_NUM][3*MAX_ADC_FE];
unsigned long power_time[POWER_BUF_NUM];
unsigned char power_wr_buf_ptr;
unsigned char power_rd_buf_ptr;
unsigned char power_ptr;


bool power_new_value;
bool power_charging;

unsigned char pow_acc_rd_index;
*/

bool power_ready;

PowerStates power_state;
PowerStates last_power_state;

bool power_is_charging;
bool power_is_stopped;
bool power_charge_completed;

// Power Management
//uint16_t Battery_ADCValue;
//uint16_t Temp_ADCValue;

uint16_t VRefIntCal;
float    Temp_Slope;
float    Temp_Offset;
//uint16_t TSense_Cal1;
//uint16_t TSense_Cal2;

//unsigned short power_noact_count; // Number of seconds no activity occured

//------------------------------------------------------------------------------
// INIT_POWER
//------------------------------------------------------------------------------
// Initialization function for the power module. Nothing has to be done, since
// all init is done in the adc module.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if initialization was successfully completed
// 0xYY, if initialization wasn't successfucompleted where YY=error code
//------------------------------------------------------------------------------
Error_TypeDef Power_Init(void){ 	
  // Initialize variables
  power_ready = false;
  power_is_charging = false;
  power_charge_completed = false;
  last_power_state = POWER_STATE_OFF;
  power_state = POWER_STATE_ON;
  power_is_stopped=false;

  // Get VrefIntCal value
  uint16_t* val = (uint16_t *) 0x1FF800F8;
  VRefIntCal = *(val);

  // Get TSense1 & TSense2 values
  uint16_t TSense_Cal1;
  uint16_t TSense_Cal2;

  val = (uint16_t *) 0x1FF800FA;
  TSense_Cal1 = *val;

  val = (uint16_t *) 0x1FF800FE;
  TSense_Cal2 = *val;

  Temp_Slope = ((float)TSense_Cal2 - (float)TSense_Cal1) / (110.f-30); // Actual temperature curve for that module

  Temp_Offset = TSense_Cal1 - (Temp_Slope * 30);

  return 0x00; //No error
}

//------------------------------------------------------------------------------
// START_POWER
//------------------------------------------------------------------------------
// Startup function for the power module
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if startup was successfully completed
// 0xYY, if startup wasn't successfully completed and where YY=error code
//------------------------------------------------------------------------------
Error_TypeDef Power_Start(void){
//  Power_StateUpdate(false);

  // Check if we are charging or not...
  //ChargeStat_Update();
  return ERROR_NONE;
}
/*
void Power_StateCheck(){
  uint16_t batt_lvl=65535;

  //if (Power_GetState() == POWER_STATE_USB_ON)
  //  return; // If connected to USB but running, don't check anything.

  // Check in which state we should start in
  if (USB_IsConnected()){
   
        Power_SetState(POWER_STATE_USB);
   
  }else{
  // Check if low-batt
    BatteryMonitoring_RdADC(&batt_lvl);
    if (batt_lvl <= LOWBAT_ADC_THRESHOLD){
      Power_SetState(POWER_STATE_LOWBAT);
    }else{
      Power_SetState(POWER_STATE_ON);  
    }      
  }
}*/

void ChargeStat_Config(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  EXTI_InitTypeDef EXTI_InitStructure;
  NVIC_InitTypeDef NVIC_InitStructure;
  
  /* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_SYSCFG, ENABLE);
	
  /* Configure detection pin */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(GPIOC, &GPIO_InitStructure);

  /* Connect EXTI Line to INT Pin */
  SYSCFG_EXTILineConfig(EXTI_PortSourceGPIOC, EXTI_PinSource1);
  
  /* Configure EXTI line */
  EXTI_InitStructure.EXTI_Line = EXTI_Line1;
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising_Falling;
  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
  EXTI_Init(&EXTI_InitStructure);
  
  /* Enable and set the EXTI interrupt priority */
  NVIC_InitStructure.NVIC_IRQChannel = EXTI1_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);

  ChargeStat_Update();

}

uint8_t ChargeStat_GetState(){
  return GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_1);
}

void ChargeStat_Update(){
    if ( ChargeStat_GetState()== POWER_USB_CHARGE_LOGIC){
        //if (!power_charge_completed) // Don't put back into charging mode if already completed without unplugging USB
          power_is_charging = true;      
    }else{
      //Not charging
      power_is_charging = false;
      power_charge_completed = USB_IsConnected(); // Only set this flag if connected to USB
    }
    Power_StateDisplay(); // Refresh LED status
}
/*
void ExtPwr_Config(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  
  // Enable GPIOx AHB Clocks
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);
	
  // Configure push button pins
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_Init(GPIOB, &GPIO_InitStructure);
  
}

void ExtPwr_Enable(void)
{
  GPIO_SetBits(GPIOB, GPIO_Pin_9);
}

void ExtPwr_Disable(void)
{
  GPIO_ResetBits(GPIOB, GPIO_Pin_9);
}*/

void Power_StateDisplay(){
  switch (power_state){
    case POWER_STATE_USB:
    case POWER_STATE_USB_MASS:
    case POWER_STATE_USB_COM:
    //case POWER_STATE_USB_ON:
      led(LED_RED,FALSE, NO_PRIORITY);
      led(LED_GREEN,FALSE, NO_PRIORITY);
      if (Power_IsCharging()){
        //led(LED_RED,TRUE);
        led_start_blink(LED_BLUE,100,2900, HIGH_PRIORITY);
      }else{
        //led(LED_RED,FALSE);
        led_stop_blink(LED_BLUE);
      }
    break;
    case POWER_STATE_OFF:
      /*if (USB_GetState()==USB_STATE_CONNECTED)
        led(LED_BLUE, TRUE);
      else*/
      led(LED_BLUE, FALSE, NO_PRIORITY);
      if (Power_IsCharging())
        //led(LED_RED, TRUE);
        led_start_blink(LED_BLUE,100,2900, HIGH_PRIORITY);
      else{
        led_stop_blink(LED_BLUE);
      }
      led(LED_RED,FALSE, NO_PRIORITY);
      led(LED_GREEN,FALSE, NO_PRIORITY);
    break;
    case POWER_STATE_LOWBAT:
      led(LED_BLUE,FALSE, HIGH_PRIORITY);
      //led(LED_GREEN,TRUE);
      led(LED_GREEN,FALSE, HIGH_PRIORITY);
      led_stop_blink(LED_RED);
      led_start_blink(LED_RED,50,4950, HIGH_PRIORITY);
    break;
    case POWER_STATE_ON:
      /*led(LED_RED,TRUE);
      led(LED_GREEN,TRUE);*/
      led(LED_RED,FALSE, NO_PRIORITY);
      led(LED_GREEN,FALSE, NO_PRIORITY);
      led(LED_BLUE,FALSE, NO_PRIORITY);
    break;
    default:
      //led(LED_BLUE,FALSE);
      break;
  }
}

// Returns true if state was changed from last one
bool Power_StateUpdate(){
  PowerStates last_state = Power_GetState();
  // 1. Check if we need to stop the module
  if (PowerButton.RequestedAction==BTN_ON_OFF){
    // Wait for buzzer to end, if needed
//    while(Buzzer_State==BUZZER_ON);
    PushButton_ResetAll(&PowerButton);
    // Switch to OFF mode
    if (!Power_IsStopRequired(last_state) || last_state == POWER_STATE_LOWBAT){
      Power_SetState(POWER_STATE_OFF);
      return power_state != last_state;
    }

    // Switch to ON mode
    if (Power_GetState()==POWER_STATE_OFF){
      Power_SetState(POWER_STATE_ON);
      return power_state != last_state;
    }
  }

  // 1B. If "OFF", don't check anything else
  if (Power_GetState()==POWER_STATE_OFF)
    return false;

  // 2. Check if USB is connected
  if (USB_IsConnected()/* && !Power_IsStopRequired(last_state)*/){
    // Check if we are connected to a computer or not
     if ((bDeviceState==UNCONNECTED || bDeviceState==ATTACHED) && Power_GetState()!=POWER_STATE_USB_MASS && Power_GetState()!=POWER_STATE_USB_COM){
       // Wait a little more, just in case...
        //msWait(700);
        msWait(400);
        if (bDeviceState==UNCONNECTED || bDeviceState==ATTACHED){
          Power_SetState(POWER_STATE_USB); // Plugged in with a wall charger
          return power_state != last_state;
        }
      }
     //} else{
      // Depending on usb mode, set correct state
      if (usb_mode==VIRTUAL_COM)
        Power_SetState(POWER_STATE_USB_COM);
      if (usb_mode==MASS_STORAGE)
        Power_SetState(POWER_STATE_USB_MASS);
      return power_state != last_state;
     //}
  }

  // 3. Check for low-battery
  if (Power_IsBattLow()){
    Power_SetState(POWER_STATE_LOWBAT);
    return power_state != last_state;
  }

  // 4. OK, keep module running!
  Power_SetState(POWER_STATE_ON);
  return power_state != last_state;
}


bool Power_IsStopRequired(PowerStates state){
  return (state==POWER_STATE_OFF) ||
         (state==POWER_STATE_USB) ||
         (state==POWER_STATE_LOWBAT);
}


void Power_SetState(PowerStates new_state){
  if (new_state == power_state) return;
  last_power_state = power_state;
  power_state = new_state;

  Power_StateDisplay();

}

PowerStates Power_GetState(){
  return power_state;
}

PowerStates Power_GetLastState(){
  return last_power_state;
}

bool Power_IsBattLow(){
  //BatteryMonitoring_RdADC(&Battery_ADCValue); // Updated once per second or on demand, but not here!
    uint16_t Battery_ADCValue = BatteryMonitoring_GetBatteryADCValue();

    return (Battery_ADCValue <= LOWBAT_ADC_THRESHOLD) && Battery_ADCValue>0;
}

bool Power_IsStateUSBRelated(PowerStates state){
  bool rval =(state==POWER_STATE_USB) ||
         (state==POWER_STATE_USB_MASS) ||
         (state==POWER_STATE_USB_COM);
  return rval;
}

bool Power_IsInStopMode(){
    /*uint8_t scr = SCB->SCR;
    bool rval = (scr & SCB_SCR_SLEEPDEEP) > 0;
    return rval;*/
    return power_is_stopped;
}

void Power_Stop(){
  power_is_stopped=true;
  PWR_EnterSTOPMode(PWR_Regulator_LowPower, PWR_STOPEntry_WFI);
  power_is_stopped=false;
}

void Power_Sleep(){
  power_is_stopped=true;
  PWR_EnterSleepMode(PWR_Regulator_LowPower, PWR_STOPEntry_WFI);
  power_is_stopped=false;
}

bool Power_IsCharging(){
  return power_is_charging;
}

float Battery_VFromADC(uint16_t batt){
  float voltage = 0;

  voltage = batt * 2.f / 4096.f * 3.3f;


  //voltage_battery = (3.3/1024.0) * (float)(Battery_ADCValue) / 2.0;	// in volts

  return voltage;
}

float Temp_FromADC(uint16_t temp){
  float temperature;

  temperature = (float)temp * 1.06f; // Convert from 3.3 ADC ref to 3 ADC Ref value

  temperature = (temperature - Temp_Offset) / Temp_Slope;
   
  return temperature;
}


// Charging state changed
void EXTI1_IRQHandler(void)
{
  //char buf[32];
  if(EXTI_GetITStatus(EXTI_Line1) != RESET)
  {
    ChargeStat_Update();
    // Clear interrupt pending bit 
    EXTI_ClearITPendingBit(EXTI_Line1);
  }
  
}