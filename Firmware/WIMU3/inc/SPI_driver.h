

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef SPI_DRIVER_H_
#define SPI_DRIVER_H_

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx_spi.h"
#include "stm32l1xx_rcc.h"
#include <stdio.h>
#include "FIFO.h"



/* Exported types ------------------------------------------------------------*/
typedef struct
{
  SPI_TypeDef* SPIx;
  uint32_t SPIx_PeriphClk;
  
  uint32_t SPIx_MOSIGPIOClk;
  GPIO_TypeDef* SPIx_MOSIPort;
  uint16_t SPIx_MOSIPin;
  uint8_t SPIx_MOSIPinSource;
  uint8_t SPIx_MOSIAlternFunc;
  
  uint32_t SPIx_MISOGPIOClk;
  GPIO_TypeDef* SPIx_MISOPort;
  uint16_t SPIx_MISOPin;
  uint8_t SPIx_MISOPinSource;
  uint8_t SPIx_MISOAlternFunc;

  uint32_t SPIx_SCKGPIOClk;
  GPIO_TypeDef* SPIx_SCKPort;
  uint16_t SPIx_SCKPin;
  uint8_t SPIx_SCKPinSource;
  uint8_t SPIx_SCKAlternFunc;

} SPIConfig_TypeDef;

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/

#define NBR_OF_SPI_USED 1

/* Exported functions ------------------------------------------------------- */

void SPI_Config(SPI_TypeDef* SPIx, SPI_InitTypeDef* SPI_InitStruct);


#endif /*SPI_DRIVER_H_*/
