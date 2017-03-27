//******************************************************************************
//  WIMUuSD - SPI driver module
//
//  Description:
//
//  Limitations:  This module has been designed for the SPI to be master. Code
//                MUST be adapt to supprt slave mode
//
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 10th, 2012
//
//  Modifications: 
//
//
//******************************************************************************


/* Includes ------------------------------------------------------------------*/
#include "SPI_driver.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

const SPIConfig_TypeDef SPIConfigTable[1] =
{
  {
    SPI1, RCC_APB2Periph_SPI1,
    RCC_AHBPeriph_GPIOA, GPIOA, GPIO_Pin_7, GPIO_PinSource7, GPIO_AF_SPI1,
    RCC_AHBPeriph_GPIOA, GPIOA, GPIO_Pin_6, GPIO_PinSource6, GPIO_AF_SPI1,
    RCC_AHBPeriph_GPIOA, GPIOA, GPIO_Pin_5, GPIO_PinSource5, GPIO_AF_SPI1
  }
};


/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
 * Function Name  :   SPI_Config.
 * Description    :   Configure the SPI to be MASTER and with default values.
 *
 *                    ***This function do NOT enable the SPI***
 *
 * Input          :   SPI_InitStruct: Refer to stm32l1xx_spi.h for for field description
 *                :   SPIx: specific SPI peripheral to use (SPI1, SPI2, ect.)
 * Return         :   None.
 *******************************************************************************/
void SPI_Config(SPI_TypeDef* SPIx, SPI_InitTypeDef* SPI_InitStruct)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  
  uint8_t SPIConfigTable_Index;
  
  for(SPIConfigTable_Index = 0; SPIConfigTable_Index < NBR_OF_SPI_USED; SPIConfigTable_Index++)
  {
    if(SPIConfigTable[SPIConfigTable_Index].SPIx == SPIx) break;
  }
  
  /* Enabling SPI clock */
  if (SPIConfigTable[SPIConfigTable_Index].SPIx == SPI1)
  {
    RCC_APB2PeriphClockCmd(SPIConfigTable[SPIConfigTable_Index].SPIx_PeriphClk, ENABLE);
  }
  else
  {
    RCC_APB1PeriphClockCmd(SPIConfigTable[SPIConfigTable_Index].SPIx_PeriphClk, ENABLE);
  }
  
  /* Enabling GPIO clock */
  RCC_AHBPeriphClockCmd(SPIConfigTable[SPIConfigTable_Index].SPIx_MOSIGPIOClk | SPIConfigTable[SPIConfigTable_Index].SPIx_MISOGPIOClk | SPIConfigTable[SPIConfigTable_Index].SPIx_SCKGPIOClk, ENABLE);
  
  // Connecting MOSI, MISO and SCK pins to the desired peripherals' Alternate Function
  GPIO_PinAFConfig(SPIConfigTable[SPIConfigTable_Index].SPIx_MOSIPort, SPIConfigTable[SPIConfigTable_Index].SPIx_MOSIPinSource, SPIConfigTable[SPIConfigTable_Index].SPIx_MOSIAlternFunc);
  GPIO_PinAFConfig(SPIConfigTable[SPIConfigTable_Index].SPIx_MISOPort, SPIConfigTable[SPIConfigTable_Index].SPIx_MISOPinSource, SPIConfigTable[SPIConfigTable_Index].SPIx_MISOAlternFunc);
  GPIO_PinAFConfig(SPIConfigTable[SPIConfigTable_Index].SPIx_SCKPort, SPIConfigTable[SPIConfigTable_Index].SPIx_SCKPinSource, SPIConfigTable[SPIConfigTable_Index].SPIx_SCKAlternFunc);
  
  /* Configure SPI MOSI as alternate function and selecting the IO type, pull-up/pull-down and output speed */
  GPIO_InitStructure.GPIO_Pin = SPIConfigTable[SPIConfigTable_Index].SPIx_MOSIPin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
  GPIO_Init(SPIConfigTable[SPIConfigTable_Index].SPIx_MOSIPort, &GPIO_InitStructure);

  /* Configure SPI SCK as alternate function and selecting the IO type, pull-up/pull-down and output speed */
  GPIO_InitStructure.GPIO_Pin = SPIConfigTable[SPIConfigTable_Index].SPIx_SCKPin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
  GPIO_Init(SPIConfigTable[SPIConfigTable_Index].SPIx_SCKPort, &GPIO_InitStructure);

  /* Configure SPI MISO as alternate function and selecting the type and pull-up/pull-down */
  GPIO_InitStructure.GPIO_Pin = SPIConfigTable[SPIConfigTable_Index].SPIx_MISOPin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
  GPIO_Init(SPIConfigTable[SPIConfigTable_Index].SPIx_MISOPort, &GPIO_InitStructure);
  
  /* Initializing the SPI (Polarity, Phase, First Data, Baud Rate Prescaler, Slave
   Management, Peripheral Mode and CRC Polynomial values) */
  SPI_Init(SPIConfigTable[SPIConfigTable_Index].SPIx, SPI_InitStruct);
  
	return;
}

