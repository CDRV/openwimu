

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef WATCHDOG_H_
#define WATCHDOG_H_

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx_tim.h"


/* Exported types ------------------------------------------------------------*/

/* Exported constants --------------------------------------------------------*/

/* Exported macro ------------------------------------------------------------*/

// Set SOFTWDG_PRESCALER and SOFTWDG_PERIOD to get desired watchdog delay
// according to folowing equation:
//  WatchdogDelay = TIMcCLK_Period * SOFTWDG_PRESCALER * SOFTWDG_PERIOD
//
// Refer to system_stm32lxx.c to determine TIMcCLK_Period:
//  TIMcCLK_Period = 1/(SYSCLK) * AHB_Prescaler * APB1_Prescaler / X
//  where X = 1 when APB1_Prescaler == 1 and X = 2 when APB1_Prescaler != 1.
//
// When SYSCLK = 32MHz, AHB_Prescaler = 1, APB1_Prescaler = 1:
//  WatchdogDelay = 31,25 ns * SOFTWDG_PRESCALER * SOFTWDG_PERIOD
#define SOFTWDG_PRESCALER   32000 // *** 16 bits register (must be < 65 535)
#define SOFTWDG_PERIOD      10000 // *** 16 bits register (must be < 65 535)

/* Exported functions ------------------------------------------------------- */
void softWDTInit( void );
void SOFT_WDT_RELOAD(void);


#endif /*WATCHDOG_H_*/
