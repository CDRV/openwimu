/**
  ******************************************************************************
  * @file    stm32_it.h
  * @author  MCD Application Team
  * @version V3.4.0
  * @date    29-June-2012
  * @brief   This file contains the headers of the interrupt handlers.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2012 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */


/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __Merge__STM32_IT_H
#define __Merge__STM32_IT_H

/* Includes ------------------------------------------------------------------*/
#include "platform_config.h"
#include "USART_driver.h"
#include "MPUCompass_driver.h"


/* Exported types ------------------------------------------------------------*/
extern int compteurQuaternion;

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

void NMI_Handler(void);
void HardFault_Handler(void);
void MemManage_Handler(void);
void BusFault_Handler(void);
void UsageFault_Handler(void);
void SVC_Handler(void);
void DebugMon_Handler(void);
void PendSV_Handler(void);
void SysTick_Handler(void);

void USB_LP_IRQHandler(void);

void USART3_IRQHandler(void);
void TIM4_IRQHandler(void);
void TIM10_IRQHandler(void);
void EXTI3_IRQHandler(void);
void EXTI9_5_IRQHandler(void);
void I2C1_EV_IRQHandler(void);


#endif /* __Merge__STM32_IT_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

