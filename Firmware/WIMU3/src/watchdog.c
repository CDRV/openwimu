//******************************************************************************
//  WIMUuSD - Watchdog module
//
//  Description: 
//
//  Author: Jasmin
//  Initial Version: November 10th, 2012
//
//  Modifications: 
//
//
//******************************************************************************

/* Includes ------------------------------------------------------------------*/
#include "watchdog.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/


void softWDTInit(void)
{
  TIM_TimeBaseInitTypeDef TIM_TimeBaseStructure;
  NVIC_InitTypeDef NVIC_InitStructure;
  
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM4, ENABLE);
  
  /* --------------------------NVIC Configuration -------------------------------*/
  /* Enable the TIM4 global Interrupt */
  NVIC_InitStructure.NVIC_IRQChannel = TIM4_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  
  NVIC_Init(&NVIC_InitStructure);
  
  /* Time base configuration */
  TIM_TimeBaseStructure.TIM_Period = SOFTWDG_PERIOD;
  TIM_TimeBaseStructure.TIM_Prescaler = SOFTWDG_PRESCALER;
  // Division ratio between CLK_INT frequency and sampling clock used by the digital filters (ETR, TIx)
  // Those signal are not use for soft watchdog; assigned value is irrelevant
  TIM_TimeBaseStructure.TIM_ClockDivision = TIM_CKD_DIV1;
  TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
  
  TIM_TimeBaseInit(TIM4, &TIM_TimeBaseStructure);
  TIM_SetCounter(TIM4, 0);
  
  TIM_ClearITPendingBit(TIM4, TIM_IT_Update);
  /* TIM IT enable */
  TIM_ITConfig(TIM4, TIM_IT_Update, ENABLE);
  
  /* TIM4 enable counter */
  TIM_Cmd(TIM4, ENABLE);
}

void SOFT_WDT_RELOAD(void)
{
  TIM_Cmd(TIM4, DISABLE);
  TIM_SetCounter(TIM4, 0);
  TIM_Cmd(TIM4, ENABLE);
}
