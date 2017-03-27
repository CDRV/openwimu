

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef USART_DRIVER_H_
#define USART_DRIVER_H_

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx_usart.h"
#include "stm32l1xx_rcc.h"
#include <stdio.h>
#include "FIFO.h"



/* Exported types ------------------------------------------------------------*/
typedef struct
{
  USART_TypeDef* USARTx;
  uint32_t USARTx_PeriphClk;
  
  uint32_t USARTx_TXGPIOClk;
  GPIO_TypeDef* USARTx_TXPort;
  uint16_t USARTx_TXPin;
  uint8_t USARTx_TXPinSource;
  uint8_t USARTx_TXAlternFunc;
  
  uint32_t USARTx_RXGPIOClk;
  GPIO_TypeDef* USARTx_RXPort;
  uint16_t USARTx_RXPin;
  uint8_t USARTx_RXPinSource;
  uint8_t USARTx_RXAlternFunc;
  
} USARTConfig_TypeDef;

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/

#define NBR_OF_USART_USED 4

/* Exported functions ------------------------------------------------------- */

void USART_Config(USART_TypeDef* USARTx, USART_InitTypeDef* USART_InitStruct);
void USART_ConfigRxIRQ(USART_TypeDef* USARTx, FunctionalState NewState);
void USARTx_SendDataIfPossible(USART_TypeDef* USARTx, FIFO_TypeDef* FIFO);
void USARTx_SendAllData(USART_TypeDef* USARTx, FIFO_TypeDef* FIFO);
uint8_t USARTx_GetDataIfAvailable(USART_TypeDef* USARTx, FIFO_TypeDef* FIFO);

#endif /*USART_DRIVER_H_*/
