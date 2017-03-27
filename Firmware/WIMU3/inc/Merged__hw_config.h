/**
  ******************************************************************************
  * @file    hw_config.h
  * @author  MCD Application Team
  * @version V3.4.0
  * @date    29-June-2012
  * @brief   Hardware Configuration & Setup
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
#ifndef __Merged__HW_CONFIG_H
#define __Merged__HW_CONFIG_H

/* Includes ------------------------------------------------------------------*/

#include "platform_config.h"

// VC specific include
#include "usb_type.h"
// End of VC specific include
 
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported define -----------------------------------------------------------*/
#define BULK_MAX_PACKET_SIZE  0x00000040

// VC specific definitions
#define MASS_MEMORY_START     0x04002000
#define LED_ON                0xF0
#define LED_OFF               0xFF

#define USB_RX_DATA_SIZE			2048
#define USART_RX_DATA_SIZE   2048

// End of VC specific definition

/* Exported functions ------------------------------------------------------- */
void Set_System(void);
void Set_USBClock(void);
void Enter_LowPowerMode(void);
void Leave_LowPowerMode(void);
void USB_Interrupts_Config(void);
void USB_Cable_Config (FunctionalState NewState);
void Get_SerialNum(void);


int __putchar (int ch);

// MS specific section
//void Led_Config(void);
//void Led_RW_ON(void);
//void Led_RW_OFF(void);
//void USB_Configured_LED(void);
//void USB_NotConfigured_LED(void);
void MAL_Config(void);
// End of MS specific section

// VC specific section
void USB_To_USB_Send_Data(uint8_t* data_buffer, uint8_t Nb_bytes);
void Handle_USBAsynchXfer (void);
// End of VC specific section

/* External variables --------------------------------------------------------*/

#endif  /*__Merged__HW_CONFIG_H*/

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
