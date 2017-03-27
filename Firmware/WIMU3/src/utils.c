//******************************************************************************
//  WIMUuSD - Utils
//
//  Description: This source contains utility functions that are globally used
//				 in the project.
//
//  Author: Simon Brière, ing., M. Sc. A.
//  Initial Version: April 3rd, 2009
//
//  Modifications: 
//	2nd November 2010 - Rework of us_sleep function to be functional
//						with delay > 65.6 ms
//
//  
//******************************************************************************
#include <stdio.h>
//#include "msp430x54x.h"
#include "utils.h"
#include "string.h" //for strlen
#include "config.h"
#include "datalogger.h"
#include "main.h" // For shutdown

#include "RTC.h"
#include <time.h>

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

// LED
uint8_t UpdateLedStatus = 0;

BuzzerState_TypeDef Buzzer_State = BUZZER_OFF;

uint8_t USBDetect_CurrentState = 0;
uint8_t ChargeStat_CurrentState = 0;

volatile ModuleStates i_mod_status[MODULE_INTERNAL_NUM];

//bool LED_status[3] = {bool, bool, bool};

// Set TIM_Prescaler for the timer according to folowing equation:
//  TimerUnit = TIMcCLK_Period * TIM_Prescaler
//
// Refer to system_stm32lxx.c to determine TIMcCLK_Period:
//  TIMcCLK_Period = 1/(SYSCLK) * AHB_Prescaler * APB1_Prescaler / X
//  where X = 1 when APB1_Prescaler == 1 and X = 2 when APB1_Prescaler != 1.
//
// When SYSCLK = 32MHz, AHB_Prescaler = 1, APB1_Prescaler = 1:
//  TimerUnit = 31,25 ns * TIM_Prescaler
// To get a TimerUnit of 1 ms, we have to use TIM_Prescaler = 32000
// To get a TimerUnit of 1 us, we have to use TIM_Prescaler = 32
//
// Division ratio is between CLK_INT frequency and sampling clock used by the digital filters (ETR, TIx)
// Those signal are not use; assigned value is irrelevant
TIM_TimeBaseInitTypeDef TIM_LedPWMTimeBaseInitStruct =
{
  32000,                // TIM_Prescaler (period tick = 1 ms)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1000,                 // TIM_Period
  TIM_CKD_DIV1         // TIM_ClockDivision
};

TIM_TimeBaseInitTypeDef TIM_LedLowPowPWMTimeBaseInitStruct =
{
  3200,                   // TIM_Prescaler (period tick = 1 ms)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1000,                 // TIM_Period
  TIM_CKD_DIV1         // TIM_ClockDivision
};


TIM_TimeBaseInitTypeDef TIM_BuzzerPWMTimeBaseInitStruct =
{
  32,                   // TIM_Prescaler (period tick = 1 us)
  TIM_CounterMode_Up,   // TIM_CounterMode
  350,                  // TIM_Period
  TIM_CKD_DIV1          // TIM_ClockDivision
};

TIM_TimeBaseInitTypeDef TIM_BuzzerLowPowPWMTimeBaseInitStruct =
{
  1,                   // TIM_Prescaler (period tick = 1 us)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1,                  // TIM_Period
  TIM_CKD_DIV1          // TIM_ClockDivision
};

TIM_TimeBaseInitTypeDef TIM_BuzzerSequencerTimeBaseInitStruct =
{
  32000,                // TIM_Prescaler (period tick = 1 ms)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1000,                 // TIM_Period
  TIM_CKD_DIV1         // TIM_ClockDivision
};

TIM_TimeBaseInitTypeDef TIM_BuzzerLowPowSequencerTimeBaseInitStruct =
{
  32,                   // TIM_Prescaler (period tick = 1 ms)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1000,                 // TIM_Period
  TIM_CKD_DIV1         // TIM_ClockDivision
};


TIM_TimeBaseInitTypeDef TIM_usWait =
{
  32,                   // TIM_Prescaler (period tick = 1 us)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1000,                 // TIM_Period
  TIM_CKD_DIV1         // TIM_ClockDivision
};

TIM_TimeBaseInitTypeDef TIM_msWait =
{
  32000,                // TIM_Prescaler (period tick = 1 ms)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1000,                 // TIM_Period
  TIM_CKD_DIV1         // TIM_ClockDivision
};

TIM_TimeBaseInitTypeDef TIM_msWaitLowPow =
{
  3200,                   // TIM_Prescaler (period tick = 1 ms)
  TIM_CounterMode_Up,   // TIM_CounterMode
  1000,                 // TIM_Period
  TIM_CKD_DIV1         // TIM_ClockDivision
};


LEDState_TypeDef LEDStates[3];

/* Extern variables ----------------------------------------------------------*/
extern RTC_TimeTypeDef RTC_TimeStruct;
extern RTC_DateTypeDef RTC_DateStruct;

/* Private function prototypes -----------------------------------------------*/


/* Public functions ---------------------------------------------------------*/


//------------------------------------------------------------------------------
// LED_Config
//------------------------------------------------------------------------------
// Description: Mapping IOs for LEDs. Initializing the timer to pulse the led. 
// 
//------------------------------------------------------------------------------
// Parameters: None
//
// Return value:
// None
//------------------------------------------------------------------------------
void LedAndBuzzer_Config(bool low_power)
{
  /*Led_Config();
  Buzzer_Config();*/
  uint8_t i;

  GPIO_InitTypeDef GPIO_InitStructure;
  TIM_OCInitTypeDef TIM_OCInitStruct;
  NVIC_InitTypeDef NVIC_InitStructure;
  
  // Enabling TIM3 peripheral clock
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE);
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM6, ENABLE);
  
  // Enabling GPIO clock
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);
  
  // Connecting LED0 (RED)(TIM3_CH4), LED1 (GREEN)(TIM3_CH3), LED2 (BLUE)(TIM3_CH2) and Buzzer pins (TIM3_CH1) to the desired peripherals' Alternate Function
  GPIO_PinAFConfig(GPIOC, GPIO_PinSource6, GPIO_AF_TIM3);
  GPIO_PinAFConfig(GPIOC, GPIO_PinSource7, GPIO_AF_TIM3);
  GPIO_PinAFConfig(GPIOC, GPIO_PinSource8, GPIO_AF_TIM3);
  GPIO_PinAFConfig(GPIOC, GPIO_PinSource9, GPIO_AF_TIM3);

  // Configuring TIM3 alternate function and selecting the type, pull-up/pull-down and output speed
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6;
  GPIO_Init(GPIOC, &GPIO_InitStructure);

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7;
  /*GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  GPIO_SetBits(GPIOC, GPIO_Pin_7);

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  GPIO_SetBits(GPIOC, GPIO_Pin_8);
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  GPIO_SetBits(GPIOC, GPIO_Pin_9);*/
  
  GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  
  // Configuring TIM3 timebase for Buzzer
  if (low_power){
    TIM_LedPWMTimeBaseInitStruct.TIM_Prescaler = TIM_LedLowPowPWMTimeBaseInitStruct.TIM_Prescaler;
  }else{
    TIM_LedPWMTimeBaseInitStruct.TIM_Prescaler = 32000;
  }
  TIM_TimeBaseInit(TIM3, &TIM_LedPWMTimeBaseInitStruct);
  //TIM_TimeBaseInit(TIM3, &TIM_BuzzerPWMTimeBaseInitStruct);
  TIM_TimeBaseInit(TIM6, &TIM_BuzzerSequencerTimeBaseInitStruct); // Buzzer sequencer
  TIM_SelectOnePulseMode(TIM6, TIM_OPMode_Single);

  // Enable the TIM6 global Interrupt (for buzzer sequencer)
  NVIC_InitStructure.NVIC_IRQChannel = TIM6_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 4;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
  
  
  // Configuring the timer output compare unit for LED0, LED1 and LED2
  // Setting pulse width (blink time) of 500 (ms)
  // Setting the output to active high
  TIM_OCStructInit(&TIM_OCInitStruct);

  // ...For LED
  TIM_OCInitStruct.TIM_OCMode = TIM_OCMode_Timing;
  TIM_OCInitStruct.TIM_OutputState = TIM_OutputState_Enable;
  TIM_OCInitStruct.TIM_Pulse = 500;
  TIM_OCInitStruct.TIM_OCPolarity = TIM_OCPolarity_Low;
  
  TIM_OC2Init(TIM3, &TIM_OCInitStruct);
  TIM_OC3Init(TIM3, &TIM_OCInitStruct);
  TIM_OC4Init(TIM3, &TIM_OCInitStruct);
  
  // ...for buzzer
  TIM_OCInitStruct.TIM_OCMode = TIM_OCMode_Timing;
  TIM_OCInitStruct.TIM_OutputState = TIM_OutputState_Enable;
  TIM_OCInitStruct.TIM_Pulse = 175;
  TIM_OCInitStruct.TIM_OCPolarity = TIM_OCPolarity_High;
  TIM_OC1Init(TIM3, &TIM_OCInitStruct);
  
  // Driving outputs inactive
  TIM_SelectOCxM(TIM3, TIM_Channel_1, TIM_ForcedAction_InActive);
  TIM_CCxCmd(TIM3, TIM_Channel_1, TIM_CCx_Enable);

  TIM_SelectOCxM(TIM3, TIM_Channel_2, TIM_ForcedAction_InActive);
  TIM_CCxCmd(TIM3, TIM_Channel_2, TIM_CCx_Enable);
  
  TIM_SelectOCxM(TIM3, TIM_Channel_3, TIM_ForcedAction_InActive);
  TIM_CCxCmd(TIM3, TIM_Channel_3, TIM_CCx_Enable);
  
  TIM_SelectOCxM(TIM3, TIM_Channel_4, TIM_ForcedAction_InActive);
  TIM_CCxCmd(TIM3, TIM_Channel_4, TIM_CCx_Enable);
  
  // Enabling the proload register. Mandatory for PWM mode
  TIM_OC1PreloadConfig(TIM3, TIM_OCPreload_Enable);
  TIM_OC2PreloadConfig(TIM3, TIM_OCPreload_Enable);
  TIM_OC3PreloadConfig(TIM3, TIM_OCPreload_Enable);
  TIM_OC4PreloadConfig(TIM3, TIM_OCPreload_Enable);
  
  // Enabling auto-reload preload
  TIM_ARRPreloadConfig(TIM3, ENABLE);
  TIM_SetAutoreload(TIM3, 1000);
  
  // Update of the shadow register with the preloaded value will be initiated
  // when setting UG bit in TIMx_EGR register
  TIM_UpdateDisableConfig(TIM3, DISABLE);
  
  // Initializing shadow register
  TIM3->EGR = 0x0001;

  Buzzer_Stop();
  // Initialize led state structure
  for (i=0;i<3;i++){
    LEDStates[i].on = false;
    LEDStates[i].blinking = false;
    LEDStates[i].on_time = 0;
    LEDStates[i].off_time = 0;
    LEDStates[i].priority = NO_PRIORITY;
  }
  
}

// time_ms = time in ms the buzzer should be on

void Buzzer_Start(uint16_t time_ms)
{
//  NVIC_InitTypeDef NVIC_InitStructure;

  // Don't play the buzzer if in low-batt!
  if (Power_GetState()==POWER_STATE_LOWBAT || Power_GetLastState()==POWER_STATE_LOWBAT)
    return;
  
  // Changing state of the buffer
  Buzzer_State = BUZZER_ON;
  
  // Initializing the buzz cycle counter
  //Buzzer_NbrOfCycleCompleted = 0;

// Start Timer6 that will end the buzzer
  TIM_Cmd(TIM6, DISABLE);
  TIM_ClearITPendingBit(TIM6, TIM_IT_Update);
  if (!Power_IsInStopMode())
    TIM_PrescalerConfig(TIM6, TIM_BuzzerSequencerTimeBaseInitStruct.TIM_Prescaler, TIM_PSCReloadMode_Update);
  else
    TIM_PrescalerConfig(TIM6, TIM_BuzzerLowPowSequencerTimeBaseInitStruct.TIM_Prescaler, TIM_PSCReloadMode_Update);
  TIM_SetAutoreload(TIM6, time_ms);
  TIM_ITConfig(TIM6, TIM_IT_Update, ENABLE);
  TIM_Cmd(TIM6, ENABLE);

  // Placing buzzer output in PWM1 mode - Start buzzing
  TIM_Cmd(TIM3, DISABLE);
  if (!Power_IsInStopMode())
    TIM_TimeBaseInit(TIM3, &TIM_BuzzerPWMTimeBaseInitStruct);
  else
    TIM_TimeBaseInit(TIM3, &TIM_BuzzerLowPowPWMTimeBaseInitStruct);
  TIM_SelectOCxM(TIM3, TIM_Channel_1, TIM_OCMode_PWM1);
  TIM_CCxCmd(TIM3, TIM_Channel_1, TIM_CCx_Enable);
  TIM_Cmd(TIM3, ENABLE);
}


void Buzzer_Stop(void)
{
  //NVIC_InitTypeDef NVIC_InitStructure;
 
  // Disabling the timer
  //TIM_Cmd(TIM3, DISABLE);
  
  // Disabling the TIM3 gloabal Interrupt
  /*NVIC_InitStructure.NVIC_IRQChannel = TIM3_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelCmd = DISABLE;
  NVIC_Init(&NVIC_InitStructure);*/

  // Forcing low on buzzer output
  TIM_Cmd(TIM3, DISABLE);
  TIM_TimeBaseInit(TIM3, &TIM_LedPWMTimeBaseInitStruct);
  TIM_SelectOCxM(TIM3, TIM_Channel_1, TIM_ForcedAction_InActive);
  TIM_CCxCmd(TIM3, TIM_Channel_1, TIM_CCx_Enable);
  TIM_Cmd(TIM3, ENABLE);

  TIM_ITConfig(TIM6, TIM_IT_Update, DISABLE);

  led_restore_state();
  // changing state of the buffer
  Buzzer_State = BUZZER_OFF;
  //Buzzer_NbrOfCycleCompleted = BUZZER_LENGTH_NBROFCYCLE;
}

void Buzzer_SetFrequency(uint16_t f){
  TIM_BuzzerPWMTimeBaseInitStruct.TIM_Period = 1 / (f * 1e-6);

  if (Buzzer_State==BUZZER_ON){
    // Change the tone
    TIM_Cmd(TIM3, DISABLE);
    TIM_TimeBaseInit(TIM3, &TIM_BuzzerPWMTimeBaseInitStruct);
    TIM_SelectOCxM(TIM3, TIM_Channel_1, TIM_OCMode_PWM1);
    TIM_CCxCmd(TIM3, TIM_Channel_1, TIM_CCx_Enable);
    TIM_Cmd(TIM3, ENABLE);
  }
}

void Buzzer_PlayStopSong(){
  Buzzer_SetFrequency(BUZZER_NOTE_C);
  Buzzer_Start(300);
  msWait(100);
  Buzzer_SetFrequency(BUZZER_NOTE_E);
  msWait(100);
  Buzzer_SetFrequency(BUZZER_NOTE_G);
  msWait(100);
  Buzzer_SetFrequency(BUZZER_DEFAULT_TONE);
  Buzzer_Stop();
}

void Buzzer_PlayStartSong(){
  Buzzer_SetFrequency(BUZZER_NOTE_G);
  Buzzer_Start(300);
  msWait(100);
  Buzzer_SetFrequency(BUZZER_NOTE_E);
  msWait(100);
  Buzzer_SetFrequency(BUZZER_NOTE_C);
  msWait(100);
  Buzzer_SetFrequency(BUZZER_DEFAULT_TONE);
  Buzzer_Stop();
}



void Wait_TimerConfig(void)
{

  // Enabling TIM9 peripheral clock
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_TIM9, ENABLE);
  
  // Configuring TIM9 timebase (use either TIM_msWait or TIM_usWait
  // because prescaler will be adjusted at the beginning of usWait and msWait functions)
  TIM_TimeBaseInit(TIM9, &TIM_msWait);
  
  // Enabling auto-reload preload
  TIM_ARRPreloadConfig(TIM9, ENABLE);
  
  // Disabling the timer
  TIM_Cmd(TIM9, DISABLE);
  
}

//------------------------------------------------------------------------------
// usWait
//------------------------------------------------------------------------------
// Do nothing for the specified time interval.
//------------------------------------------------------------------------------
// Parameters: 
// SleepTime, number of micro-seconds to sleep
//
// Return value:
// None
//------------------------------------------------------------------------------

void usWait(uint16_t SleepTime)
{
  // Disabling the timer
  TIM_Cmd(TIM9, DISABLE);
  
  // Initializing TIM9 with us values
  TIM_TimeBaseInit(TIM9, &TIM_usWait);
  
  // Changing preload register value updating shadow register
  TIM_SetAutoreload(TIM9, SleepTime);
  TIM9->EGR = 0x0001;
  TIM_ClearFlag(TIM9, TIM_IT_Update);
  
  // Starting timer and wait until SleepTime ending
  TIM_Cmd(TIM9, ENABLE);
  while(TIM_GetFlagStatus(TIM9, TIM_IT_Update) == RESET);
  TIM_ClearFlag(TIM9, TIM_IT_Update);
  
  // Disabling the timer
  TIM_Cmd(TIM9, DISABLE);

}

//------------------------------------------------------------------------------
// msWait
//------------------------------------------------------------------------------
// Do nothing for the specified time interval.
//------------------------------------------------------------------------------
// Parameters:
// SleepTime, number of milli-seconds to sleep
//
// Return value:
// None
//------------------------------------------------------------------------------

void msWait(uint16_t SleepTime)
{
  
  // Disabling the timer
  TIM_Cmd(TIM9, DISABLE);

  // Initializing TIM9 with us values
  if (!Power_IsInStopMode())
    TIM_TimeBaseInit(TIM9, &TIM_msWait);
  else
    TIM_TimeBaseInit(TIM9, &TIM_msWaitLowPow);
  
  // Changing preload register value updating shadow register
  TIM_SetAutoreload(TIM9, SleepTime);
  TIM9->EGR = 0x0001;
  TIM_ClearFlag(TIM9, TIM_IT_Update);
  
  // Starting timer and wait until SleepTime ending
  TIM_Cmd(TIM9, ENABLE);
  while(TIM_GetFlagStatus(TIM9, TIM_IT_Update) == RESET);
  TIM_ClearFlag(TIM9, TIM_IT_Update);
  
  // Disabling the timer
  TIM_Cmd(TIM9, DISABLE);
  
}



//------------------------------------------------------------------------------

// LED

//------------------------------------------------------------------------------

// Turn on or off the specified LED

//------------------------------------------------------------------------------

// Parameters: 

// id, the LED to turn on or off

// state, LED_ON to turn on or LED_OFF to turn off

// priority, the priority associated with that LED activation. Lower priority than the current
//           one will be ignored.

// Return value:

// None

//------------------------------------------------------------------------------

void led(LED_Color led, bool state, Priority_TypeDef priority){
    if (LEDStates[led].priority > priority && priority != NO_PRIORITY)
      return; // Ignore request as the LED displayed has more priority

    if (LEDStates[led].blinking==true){
      led_stop_blink(led); // Stop blinking mode if that LED is currently blinking
      //return; 
    }
 
  // ----------Taking control of the shared timer TIM3----------
    // Disabling the timer
    TIM_Cmd(TIM3, DISABLE);

    // Initializing TIM3 with LED values
    //TIM_TimeBaseInit(TIM3, &TIM_LedPWMTimeBaseInitStruct);

    // Reseting counter
    //TIM_SetCounter(TIM3, 0);

    //Select the correct LED and apply the state
    switch (led){
        case LED_RED:
            if (state==false){
              TIM_SelectOCxM(TIM3, TIM_Channel_4, TIM_ForcedAction_InActive);
              TIM_CCxCmd(TIM3, TIM_Channel_4, TIM_CCx_Enable);
               //GPIO_SetBits(GPIOC, GPIO_Pin_9);
             }else{
              TIM_SelectOCxM(TIM3, TIM_Channel_4, TIM_ForcedAction_Active);
              TIM_CCxCmd(TIM3, TIM_Channel_4, TIM_CCx_Enable);
              //GPIO_ResetBits(GPIOC, GPIO_Pin_9);
            }
        break;

        case LED_GREEN:
             if (state==false){
              TIM_SelectOCxM(TIM3, TIM_Channel_3, TIM_ForcedAction_InActive);
              TIM_CCxCmd(TIM3, TIM_Channel_3, TIM_CCx_Enable);
              //GPIO_SetBits(GPIOC, GPIO_Pin_8);
             }else{
              TIM_SelectOCxM(TIM3, TIM_Channel_3, TIM_ForcedAction_Active);
              TIM_CCxCmd(TIM3, TIM_Channel_3, TIM_CCx_Enable);
              //GPIO_ResetBits(GPIOC, GPIO_Pin_8);
            }
        break;

        case LED_BLUE:
            if (state==false){
              TIM_SelectOCxM(TIM3, TIM_Channel_2, TIM_ForcedAction_InActive);
              TIM_CCxCmd(TIM3, TIM_Channel_2, TIM_CCx_Enable);
              //GPIO_SetBits(GPIOC, GPIO_Pin_7);
             }else{
              TIM_SelectOCxM(TIM3, TIM_Channel_2, TIM_ForcedAction_Active);
              TIM_CCxCmd(TIM3, TIM_Channel_2, TIM_CCx_Enable);
              //GPIO_ResetBits(GPIOC, GPIO_Pin_7);
            }
        break;
    };

    // Updating shadow registers
    //TIM3->EGR = 0x0001;

    // Enabling TIM3
    TIM_Cmd(TIM3, ENABLE);


    LEDStates[led].on = state;
    LEDStates[led].priority = priority;
    return;
}

//------------------------------------------------------------------------------
// LED
//------------------------------------------------------------------------------
// Switch the state of the specified LED. If the LED is on, it is turned off. If
// the LED is off, it is turned on.
//------------------------------------------------------------------------------
// Parameters: 
// id, the LED to turn on or off
//
// Return value:
// None
//------------------------------------------------------------------------------
void led_toggle(LED_Color l, Priority_TypeDef priority){

  if (LEDStates[l].priority > priority  && priority != NO_PRIORITY)
      return; // Ignore request as the LED displayed has more priority

  //Select the correct LED and apply the state
  /*switch (LEDStates[l].on){
          case true:
            LEDStates[l].on=false;
          break;
          case false:
            LEDStates[l].on=true;
          break;
  };*/
  LEDStates[l].on = !LEDStates[l].on;
  led(l,LEDStates[l].on, priority);

}

bool led_get_state(LED_Color l){
  return LEDStates[l].on;
}

void led_start_blink(LED_Color led, uint16_t on_time, uint16_t off_time, Priority_TypeDef priority){

    if (LEDStates[led].priority > priority  && priority != NO_PRIORITY)
      return; // Ignore request as the LED displayed has more priority

    // If LED is already blinking, return
    //if (LEDStates[led].blinking==true) return;

    // Disabling the timer
    TIM_Cmd(TIM3, DISABLE);

    // Initializing TIM3 with LED values
    //if (low_pow==bool){
      //TIM_TimeBaseInit(TIM3, &TIM_LedPWMTimeBaseInitStruct);
    /*}else{
      TIM_TimeBaseInit(TIM3, &TIM_LedLowPowPWMTimeBaseInitStruct);
    }*/

    // Reseting counter
    //TIM_SetCounter(TIM3, 0);

    TIM_SetAutoreload(TIM3, off_time+on_time); // WARNING: multiple LED blinking at different frequency will not correctly work.

    switch(led){
      case LED_RED:
        TIM_SetCompare4(TIM3, on_time);
    
        // Setting output compare mode
        TIM_SelectOCxM(TIM3, TIM_Channel_4, TIM_OCMode_PWM1);             // Red LED
        TIM_CCxCmd(TIM3, TIM_Channel_4, TIM_CCx_Enable);
      break;
      case LED_GREEN:
        //TIM_SetAutoreload(TIM3, off_time+on_time);
        TIM_SetCompare3(TIM3, on_time);
    
        // Setting output compare mode
        TIM_SelectOCxM(TIM3, TIM_Channel_3, TIM_OCMode_PWM1);             // Red LED
        TIM_CCxCmd(TIM3, TIM_Channel_3, TIM_CCx_Enable);
      break;
      case LED_BLUE:
        //TIM_SetAutoreload(TIM3, off_time+on_time);
        TIM_SetCompare2(TIM3, on_time);
    
        // Setting output compare mode
        TIM_SelectOCxM(TIM3, TIM_Channel_2, TIM_OCMode_PWM1);             // Red LED
        TIM_CCxCmd(TIM3, TIM_Channel_2, TIM_CCx_Enable);
      break;
    }
    // Updating shadow registers
    TIM3->EGR = 0x0001;

    // Enabling TIM3
    TIM_Cmd(TIM3, ENABLE);

    // Update state variables
    LEDStates[led].on_time = on_time;
    LEDStates[led].off_time = off_time;
    LEDStates[led].blinking = true;  
}

void led_stop_blink(LED_Color l){
  // Update state variables
  LEDStates[l].on_time = 0;
  LEDStates[l].off_time = 0;
  LEDStates[l].blinking = false;

  led(l,false, NO_PRIORITY);
  TIM_Cmd(TIM3, DISABLE);
}

void led_restore_state(){
  uint8_t i;
  for (i=0; i<3; i++){
    if (LEDStates[i].blinking==true){
      led_start_blink(i,LEDStates[i].on_time, LEDStates[i].off_time, LEDStates[i].priority);
    }else{
      led(i,LEDStates[i].on, LEDStates[i].priority);
    }
  }
}

//------------------------------------------------------------------------------
// ERROR
//------------------------------------------------------------------------------
// Called when an error occurs. Turn a LED on to indicate the problem, and if the
// specific error isn't trapped, stops the CPU.
//------------------------------------------------------------------------------
// Parameters: 
// module, the module on which the error occured
// code, the error code
//
// Return value:
// None
//------------------------------------------------------------------------------
void error(unsigned char module, unsigned char code){
    led(LED_RED,true, HIGH_PRIORITY);
    led(LED_GREEN, false, HIGH_PRIORITY);
    uint8_t timeout=0;
    uint8_t i;
    char buf[64];

    // Shutdown everything except CPU & DataLogger & USB & Power
    for (i=0; i<MODULE_INTERNAL_NUM; i++){
        if (i != MODULE_USB && i != MODULE_POWER && i!=MODULE_CPU && i!=MODULE_DATALOGGER)
          Main_Shutdown(i);
    }

    // If datalogger is online, save error
    if (isModuleOnline(MODULE_DATALOGGER)){
          sprintf(buf, "ERROR: Module=%d, Code=%d\r\n", module, code);
          i = strlen(buf);
          datalog_save_data((unsigned char*)&buf[0], i, true, MODULE_CPU,0);/*!=0)*/
          msWait(200); 
    }
   
    // Set LED State according to error 
    led(LED_RED,true, HIGH_PRIORITY);
    //led(LED_GREEN,true);
    led(LED_BLUE,true, HIGH_PRIORITY);
    while(timeout<2){     
      //led_toggle(LED_RED, HIGH_PRIORITY);
      //led_toggle(LED_GREEN);
      for (i=0; i<module+1; i++){
        led_toggle(LED_BLUE, HIGH_PRIORITY);
        msWait(400);
        led_toggle(LED_BLUE, HIGH_PRIORITY);
        msWait(400);
      }

      led(LED_BLUE,false, HIGH_PRIORITY);
      msWait(2000);
      timeout++;
      
    }
    // Reset the WIMU
    NVIC_SystemReset();

}

//------------------------------------------------------------------------------
// UPDATE_RTCTime
//------------------------------------------------------------------------------
// Update the RTC time with specified values
//------------------------------------------------------------------------------
// Parameters: 
// year(0-3000), the year (ex. 2012)
// month(1-12), month of the year
// day(1-31), day of the month
// hour(1-24), hour 
// min(0-59), minute
// sec(0-59), second
//
// Return value (None):
// None, but RTC is updated
//------------------------------------------------------------------------------
void update_RTCtime(uint16_t year, uint8_t month, uint8_t day, uint8_t hour, uint8_t min, uint8_t sec, bool apply_tz){
  short tzone;
  struct tm timing;

  timing.tm_sec = sec;
  timing.tm_min = min;
  timing.tm_hour = hour;
  timing.tm_mday = day;
  timing.tm_mon = month-1;
  timing.tm_year = year-1900;

  timestamp = mktime(&timing);

  if (apply_tz==true){
    // Apply timezone offset
    tzone = wimu_config.datetime.time_offset;
    /*if ((wimu_config.log_opt & CONFIG_LOG_TZSIGN)>0) //Check sign
            tzone = -tzone;*/

    // Modify timestamp
    timestamp += tzone * 3600;
  }
  
  // Reconvert to time struct
  localtime_r((time_t*)&timestamp, &timing);

  /*RTC_DateStruct.RTC_Year = year-2000;
  RTC_DateStruct.RTC_Month = month;
  RTC_DateStruct.RTC_Date = day;
  
  RTC_TimeStruct.RTC_Hours = hour;
  RTC_TimeStruct.RTC_Minutes = min;
  RTC_TimeStruct.RTC_Seconds = sec;*/

  RTC_DateStruct.RTC_Year = timing.tm_year-100;
  RTC_DateStruct.RTC_Month = timing.tm_mon;
  RTC_DateStruct.RTC_Date = timing.tm_mday;
  
  RTC_TimeStruct.RTC_Hours = timing.tm_hour;
  RTC_TimeStruct.RTC_Minutes = timing.tm_min;
  RTC_TimeStruct.RTC_Seconds = timing.tm_sec;
  
  RTC_SetDate(RTC_Format_BIN, &RTC_DateStruct);
  RTC_SetTime(RTC_Format_BIN, &RTC_TimeStruct);
  
 // update_timestampRTC(true);
  
  //Update actual datalogger runtime value in order to split file correctly in days
  if(wimu_config.logger.split_by_day){
          //FIX ME
          //Only works if 24h are recorded in a folder
        /*RTC_GetDate(RTC_Format_BIN, &RTC_DateStruct);
        RTC_GetTime(RTC_Format_BIN, &RTC_TimeStruct);
       
        dos_runtime = RTC_TimeStruct.RTC_Hours;// + tzone;
        dos_split_ts = timestamp + wimu_config.log_filetime * 60 - RTC_TimeStruct.RTC_Minutes * 60 - RTC_TimeStruct.RTC_Seconds;*/

        dos_runtime = timing.tm_hour;// + tzone;
        dos_split_ts = timestamp + /*wimu_config.logger.file_time **/ 60 - timing.tm_min * 60 - timing.tm_sec;

  }
                                          
  return;
}
//
//------------------------------------------------------------------------------
// UPDATE_TIMESTAMPRTC
//------------------------------------------------------------------------------
// Update the timestamp value with the current RTC values. Timestamp is reported
// UNIX standard, e.g. seconds since Jan. 1st. 1970.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (None):
// None, but global timestamp variable is updated.
//------------------------------------------------------------------------------
void update_timestampRTC(){
    struct tm timing;
    RTC_GetTime(RTC_Format_BIN, &RTC_TimeStruct);
    RTC_GetDate(RTC_Format_BIN, &RTC_DateStruct);
   
    timing.tm_sec = RTC_TimeStruct.RTC_Seconds;
    timing.tm_min = RTC_TimeStruct.RTC_Minutes;
    timing.tm_hour = RTC_TimeStruct.RTC_Hours;
    timing.tm_mday = RTC_DateStruct.RTC_Date;
    timing.tm_mon = RTC_DateStruct.RTC_Month;
    timing.tm_year = RTC_DateStruct.RTC_Year+100;//+70;// - 1970;
    timestamp = mktime(&timing);

    return;
}

void update_RTCtimeFromTimestamp(uint64_t ts){
  struct tm timing;

  localtime_r((time_t*)&ts, &timing);
  update_RTCtime(timing.tm_year+1900, timing.tm_mon+1, timing.tm_mday, timing.tm_hour, timing.tm_min, timing.tm_sec, true);

}

inline ModuleStates getModuleState(InternalModules_ID module){
  return i_mod_status[module];
}

inline void setModuleState(InternalModules_ID module, ModuleStates state){
  i_mod_status[module] = state;
}

inline bool isModuleOnline(InternalModules_ID module){
  return i_mod_status[module] == STATE_ONLINE;
}

uint32_t NumberOfSetBits(uint32_t i) 
{ 
     i = i - ((i >> 1) & 0x55555555); 
     i = (i & 0x33333333) + ((i >> 2) & 0x33333333); 
     return (((i + (i >> 4)) & 0x0F0F0F0F) * 0x01010101) >> 24; 
} 
 


void TIM6_IRQHandler(void)
{
  Buzzer_Stop();
  TIM_ClearITPendingBit(TIM6, TIM_IT_Update);
}