//******************************************************************************
//  WIMUuSD - Real-Time clock module
//
//  Description: 
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 10th, 2012
//
//  Modifications: 
//
//
//******************************************************************************


/* Includes ------------------------------------------------------------------*/
#include "RTC.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
RTC_TimeTypeDef RTC_TimeStruct;
RTC_DateTypeDef RTC_DateStruct;

/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/


/*******************************************************************************
 * Function Name  : RTC_Config
 * Description    : Low level config of the STM32 RTC
 * Input          : None.
 * Output         : Result (1: Success; 0: Error)
 * Return         : None.
 *******************************************************************************/
int RTC_Config(void)
{
  RTC_InitTypeDef RTC_InitStruct;
  
  // Enabling the Power Controller (PWR) APB1 interface clock
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_PWR, ENABLE);
  
  // Enabling access to RTC domain
  PWR_RTCAccessCmd(ENABLE);
  
  // Enabling and selecting LSE as RTC clock source
  RCC_LSEConfig(RCC_LSE_ON);
	while (RCC_GetFlagStatus(RCC_FLAG_LSERDY) == RESET);  // Wait for LSE clock to be ready
  RCC_RTCCLKConfig(RCC_RTCCLKSource_LSE);
  RCC_RTCCLKCmd(ENABLE);
  
  // Configuring the RTC Prescaler (Asynchronous and Synchronous) and RTC hour format
  RTC_StructInit(&RTC_InitStruct);
  RTC_Init(&RTC_InitStruct);
  
  
  
  return 1;
}

void RTC_SetInitial(void){
  // Initializing time and date until synchro w/ GPS or USB
  RTC_TimeStructInit(&RTC_TimeStruct);
  RTC_DateStructInit(&RTC_DateStruct);
  RTC_DateStruct.RTC_Month = 1;
  RTC_SetTime(RTC_Format_BIN, &RTC_TimeStruct);
  RTC_SetDate(RTC_Format_BIN, &RTC_DateStruct);
}