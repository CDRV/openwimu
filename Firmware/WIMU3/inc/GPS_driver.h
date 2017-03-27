

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef GPS_DRIVER_H_
#define GPS_DRIVER_H_

/* Includes ------------------------------------------------------------------*/
#include "utils.h"
#include "stm32l1xx.h"
#include "stm32l1xx_usart.h"
#include "stm32l1xx_dma.h"
#include <stdio.h>

/* Exported types ------------------------------------------------------------*/
extern uint8_t GPS_Rx_DMA[255];
extern DMA_InitTypeDef DMA_InitStructure;

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/

/* Exported functions ------------------------------------------------------- */
void GPS_Config(void);
void GPS_1PPS_IRQConfig(FunctionalState NewState);
void GPS_SetupPower(void);
void GPS_EnablePower(void);
void GPS_DisablePower(void);
uint8_t GPS_Wakeup(void);
uint8_t GPS_Hibernate(void);
uint8_t GPS_PowerAndWakeup(void);
void GPS_ConfigRxIRQ(FunctionalState NewState);
void GPS_ConfigTxIRQ(FunctionalState NewState);
void GPS_SetBaudrate(uint32_t baudrate);

#endif /*GPS_DRIVER_H_*/
