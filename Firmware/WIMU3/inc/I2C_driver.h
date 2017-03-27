

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef I2C_DRIVER_H_
#define I2C_DRIVER_H_

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx_i2c.h"
#include "stm32l1xx_rcc.h"
#include <stdio.h>



/* Exported types ------------------------------------------------------------*/
typedef struct
{
  I2C_TypeDef* I2Cx;            // I2C1 or I2C2
  uint32_t I2Cx_PeriphClk;      // RCC_APB1Periph_I2C1 or RCC_APB1Periph_I2C2
  
  uint32_t I2Cx_SCLGPIOClk;     // RCC_AHBPeriph_GPIOx
  GPIO_TypeDef* I2Cx_SCLPort;   // GPIOx, where x is A, B...
  uint16_t I2Cx_SCLPin;         // GPIO_Pin_x, where x can be 0, 1... 15
  uint8_t I2Cx_SCLPinSource;    // GPIO_PinSourcex, where x can be 0, 1... 15
  uint8_t I2Cx_SCLAlternFunc;   // GPIO_AF_I2C or GPIO_AF_I2C2
  
  uint32_t I2Cx_SDAGPIOClk;     // RCC_AHBPeriph_GPIOx
  GPIO_TypeDef* I2Cx_SDAPort;   // GPIOx, where x is A, B...
  uint16_t I2Cx_SDAPin;         // GPIO_Pin_x, where x can be 0, 1... 15
  uint8_t I2Cx_SDAPinSource;    // GPIO_PinSourcex, where x can be 0, 1... 15
  uint8_t I2Cx_SDAAlternFunc;   // GPIO_AF_I2C or GPIO_AF_I2C2

} I2CConfig_TypeDef;

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/

#define NBR_OF_I2C_USED 2

/* Exported functions ------------------------------------------------------- */

void I2C_Config(I2C_TypeDef* I2Cx, I2C_InitTypeDef* I2C_InitStruct);

#endif /*I2C_DRIVER_H_*/
