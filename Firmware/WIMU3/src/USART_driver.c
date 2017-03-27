//******************************************************************************
//  WIMUuSD - USART driver module
//
//  Description: 
//
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 10th, 2012
//
//  Modifications: 
//
//
//******************************************************************************


/* Includes ------------------------------------------------------------------*/
#include "USART_driver.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/


const USARTConfig_TypeDef USARTConfigTable[NBR_OF_USART_USED] =
{
  {
    USART1, RCC_APB2Periph_USART1,
    RCC_AHBPeriph_GPIOA, GPIOA, GPIO_Pin_9, GPIO_PinSource9, GPIO_AF_USART1,
    RCC_AHBPeriph_GPIOA, GPIOA, GPIO_Pin_10, GPIO_PinSource10, GPIO_AF_USART1
  },
  
  {
    USART2, RCC_APB1Periph_USART2,
    RCC_AHBPeriph_GPIOA, GPIOA, GPIO_Pin_2, GPIO_PinSource2, GPIO_AF_USART2,
    RCC_AHBPeriph_GPIOA, GPIOA, GPIO_Pin_3, GPIO_PinSource3, GPIO_AF_USART2
  },
  
  {
    USART3, RCC_APB1Periph_USART3,
    RCC_AHBPeriph_GPIOC, GPIOC, GPIO_Pin_10, GPIO_PinSource10, GPIO_AF_USART3,
    RCC_AHBPeriph_GPIOC, GPIOC, GPIO_Pin_11, GPIO_PinSource11, GPIO_AF_USART3
  },
    
  {
    UART5, RCC_APB1Periph_UART5,
    RCC_AHBPeriph_GPIOC, GPIOC, GPIO_Pin_12, GPIO_PinSource12, GPIO_AF_UART5,
    RCC_AHBPeriph_GPIOD, GPIOD, GPIO_Pin_2, GPIO_PinSource2, GPIO_AF_UART5
  }
};


/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/


/*******************************************************************************
 * Function Name  :  USART_Config.
 * Description    :  configure the USART with default values.
 * Input          :  None.
 * Return         :  None.
 *******************************************************************************/
void USART_Config(USART_TypeDef* USARTx, USART_InitTypeDef* USART_InitStruct)
{  
  GPIO_InitTypeDef GPIO_InitStructure;
  
  uint8_t USARTConfigTable_Index;
  
  for(USARTConfigTable_Index = 0; USARTConfigTable_Index < NBR_OF_USART_USED; USARTConfigTable_Index++)
  {
    if(USARTConfigTable[USARTConfigTable_Index].USARTx == USARTx) break;
  }
    
  /* Enabling USART clock */
  if (USARTConfigTable[USARTConfigTable_Index].USARTx == USART1)
  {
    RCC_APB2PeriphClockCmd(USARTConfigTable[USARTConfigTable_Index].USARTx_PeriphClk, ENABLE);
  }
  else
  {
    RCC_APB1PeriphClockCmd(USARTConfigTable[USARTConfigTable_Index].USARTx_PeriphClk, ENABLE);
  }
  
  /* Enabling GPIO clock */
  RCC_AHBPeriphClockCmd(USARTConfigTable[USARTConfigTable_Index].USARTx_TXGPIOClk | USARTConfigTable[USARTConfigTable_Index].USARTx_RXGPIOClk, ENABLE);
  
  // Connecting TX and RX pins to the desired peripherals' Alternate Function
  GPIO_PinAFConfig(USARTConfigTable[USARTConfigTable_Index].USARTx_TXPort, USARTConfigTable[USARTConfigTable_Index].USARTx_TXPinSource, USARTConfigTable[USARTConfigTable_Index].USARTx_TXAlternFunc);
  GPIO_PinAFConfig(USARTConfigTable[USARTConfigTable_Index].USARTx_RXPort, USARTConfigTable[USARTConfigTable_Index].USARTx_RXPinSource, USARTConfigTable[USARTConfigTable_Index].USARTx_RXAlternFunc);
  
  /* Configure USART Tx as alternate function and selecting the type, pull-up/pull-down and output speed */
  GPIO_InitStructure.GPIO_Pin = USARTConfigTable[USARTConfigTable_Index].USARTx_TXPin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(USARTConfigTable[USARTConfigTable_Index].USARTx_TXPort, &GPIO_InitStructure);
  
  /* Configure USART Rx as alternate function and selecting the type and pull-up/pull-down */
  GPIO_InitStructure.GPIO_Pin = USARTConfigTable[USARTConfigTable_Index].USARTx_RXPin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
  GPIO_Init(USARTConfigTable[USARTConfigTable_Index].USARTx_RXPort, &GPIO_InitStructure);
  
  /* Initializing the USART (Baud Rate, Word Length , Stop Bit, Parity, Hardware
   flow control and Mode) */
  USART_Init(USARTConfigTable[USARTConfigTable_Index].USARTx, USART_InitStruct);
  
  /* Enabling the USART */
  USART_Cmd(USARTConfigTable[USARTConfigTable_Index].USARTx, ENABLE);
	return;
}

/*******************************************************************************
 * Function Name  :  USART_ConfigRxIRQ.
 * Description    :  Enable or disable USART_IT_RXNE (Receive Data register not empty) interrupt.
 * Input          :   USARTx: Select the USART peripheral
 *                    NewState: new state of the interrupts (ENABLE or DISABLE)
 * Return         :  None.
 *******************************************************************************/
void USART_ConfigRxIRQ(USART_TypeDef* USARTx, FunctionalState NewState)
{
  NVIC_InitTypeDef NVIC_InitStructure;
  
  
  USART_ITConfig(USARTx, USART_IT_RXNE, NewState);
  
  NVIC_InitStructure.NVIC_IRQChannel = USART1_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = NewState;
  NVIC_Init(&NVIC_InitStructure);
  
}

/*******************************************************************************
 * Function Name  :  USARTx_SendDataIfPossible.
 * Description    :  Send data byte from FIFO w/ USARTx if FIFO is not empty and Tx data register is empty.
 * Input          :   USARTx: USART to send data with
 *                    FIFO: FIFO to read from
 * Return         :  None.
 *******************************************************************************/
void USARTx_SendDataIfPossible(USART_TypeDef* USARTx, FIFO_TypeDef* FIFO)
{
  uint8_t RdElement;
  
  // Verify that Tx data register is empty
  if ((USART_GetFlagStatus(USARTx, USART_FLAG_TXE) == SET))
  {
    // Send data if data available in FIFO
    if(FIFO_RdElementIfDataAvailable(FIFO, (void *)&RdElement) == 1)
    {
      USART_SendData(USARTx, RdElement);
    }    
  }
  
  return;
}

/*******************************************************************************
 * Function Name  :  USARTx_SendAllData.
 * Description    :  Send all the data bytes from FIFO w/ USARTx.
 * Input          :   USARTx: USART to send data with
 *                    FIFO: FIFO to read from
 * Return         :  None.
 *******************************************************************************/
void USARTx_SendAllData(USART_TypeDef* USARTx, FIFO_TypeDef* FIFO)
{
  uint8_t RdElement;
  
  // While there is data in the FIFO
  while(FIFO_RdElementIfDataAvailable(FIFO, (void *)&RdElement) == 1)
  {
    // Wait till Tx data register is empty
    while (USART_GetFlagStatus(USARTx, USART_FLAG_TXE) == RESET);
    
    USART_SendData(USARTx, RdElement);
  }
    
  return;
}



/*******************************************************************************
 * Function Name  :  USARTx_GetDataIfAvailable.
 * Description    :  Get data byte from USARTx if data is available and if FIFO is not full.
 * Input          :   USARTx: USART to get data with
 *                    FIFO: FIFO to read from
 * Return         :  Result: (1:Success; 0:Data loss).
 *******************************************************************************/
uint8_t USARTx_GetDataIfAvailable(USART_TypeDef* USARTx, FIFO_TypeDef* FIFO)
{
  uint8_t RdElement;
  
  // Verify that data is available in the rx register
  if (USART_GetFlagStatus(USARTx, USART_FLAG_RXNE) == SET)
  {
    RdElement = (uint8_t)USART_ReceiveData(USARTx);
    
    // Write data byte in the FIFO if there's enough free space
    //return FIFO_WrElementIfSpaceAvailable(FIFO, (void *)RdElement);
    return FIFO_WrElementIfSpaceAvailable(FIFO, (void *)&RdElement);
  }
  else
  {
    return 0 ;
  }
}

