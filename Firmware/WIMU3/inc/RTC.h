

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef RTC_H_
#define RTC_H_

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx_rtc.h"
#include "stm32l1xx_rcc.h"


/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

int RTC_Config(void);
void RTC_SetInitial(void);
 	

#endif /*RTC_H_*/
