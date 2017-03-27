//******************************************************************************
//  WIMUuSD - I2C driver module
//
//  Description:
//
//  Limitations:  This module has been designed for the I2C to be master. Code
//                MUST be adapt to supprt slave mode
//
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 30th, 2012
//
//  Modifications: 
//
//
//******************************************************************************


/* Includes ------------------------------------------------------------------*/
#include "I2C_driver.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

const I2CConfig_TypeDef I2CConfigTable[2] =
{
  {
    I2C1, RCC_APB1Periph_I2C1,
    RCC_AHBPeriph_GPIOB, GPIOB, GPIO_Pin_6, GPIO_PinSource6, GPIO_AF_I2C1,
    RCC_AHBPeriph_GPIOB, GPIOB, GPIO_Pin_7, GPIO_PinSource7, GPIO_AF_I2C1
  },
  
  {
    I2C2, RCC_APB1Periph_I2C2,
    RCC_AHBPeriph_GPIOB, GPIOB, GPIO_Pin_10, GPIO_PinSource10, GPIO_AF_I2C2,
    RCC_AHBPeriph_GPIOB, GPIOB, GPIO_Pin_11, GPIO_PinSource11, GPIO_AF_I2C2
  }
};


/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/


/*******************************************************************************
 * Function Name  :   I2C_Config.
 * Description    :   Configure the I2C peripheral.
 *
 * Input          :   I2C_InitStruct: Refer to stm32l1xx_i2c.h for for field description
 *                :   I2Cx: specific I2C peripheral to use (I2C1, I2C2)
 * Return         :   None.
 *******************************************************************************/
void I2C_Config(I2C_TypeDef* I2Cx, I2C_InitTypeDef* I2C_InitStruct)
{
 	GPIO_InitTypeDef  GPIO_InitStructure;
  
  uint8_t I2CConfigTable_Index;
  
  for(I2CConfigTable_Index = 0; I2CConfigTable_Index < NBR_OF_I2C_USED; I2CConfigTable_Index++)
  {
    if(I2CConfigTable[I2CConfigTable_Index].I2Cx == I2Cx) break;
  }
	
  // Enabling I2C peripheral clock
	RCC_APB1PeriphClockCmd(I2CConfigTable[I2CConfigTable_Index].I2Cx_PeriphClk, ENABLE);
	
	// Enabling GPIO clock
  RCC_AHBPeriphClockCmd(I2CConfigTable[I2CConfigTable_Index].I2Cx_SCLGPIOClk | I2CConfigTable[I2CConfigTable_Index].I2Cx_SDAGPIOClk, ENABLE);
  
  // Connecting SCL and SDA pins to the desired peripherals' Alternate Function
  GPIO_PinAFConfig(I2CConfigTable[I2CConfigTable_Index].I2Cx_SCLPort, I2CConfigTable[I2CConfigTable_Index].I2Cx_SCLPinSource, I2CConfigTable[I2CConfigTable_Index].I2Cx_SCLAlternFunc);
  GPIO_PinAFConfig(I2CConfigTable[I2CConfigTable_Index].I2Cx_SDAPort, I2CConfigTable[I2CConfigTable_Index].I2Cx_SDAPinSource, I2CConfigTable[I2CConfigTable_Index].I2Cx_SDAAlternFunc);
  
  /* Configure I2C SCL as alternate function and selecting the IO type, pull-up/pull-down and output speed */
  GPIO_InitStructure.GPIO_Pin = I2CConfigTable[I2CConfigTable_Index].I2Cx_SCLPin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(I2CConfigTable[I2CConfigTable_Index].I2Cx_SCLPort, &GPIO_InitStructure);
  
  /* Configure I2C SDA as alternate function and selecting the IO type, pull-up/pull-down and output speed */
  GPIO_InitStructure.GPIO_Pin = I2CConfigTable[I2CConfigTable_Index].I2Cx_SDAPin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(I2CConfigTable[I2CConfigTable_Index].I2Cx_SDAPort, &GPIO_InitStructure);
	
	// Initializing the I2C peripheral (Mode, duty cycle, Own address, Ack, Speed and Ack Address)
	I2C_Init(I2Cx, I2C_InitStruct);
	
  // Enabling I2C
	I2C_Cmd(I2Cx, ENABLE);
  
	return;
}



