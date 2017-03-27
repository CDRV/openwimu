//******************************************************************************
//  GPS driver module
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
#include "GPS_driver.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
uint8_t GPS_PowerState = 0;

#if GPS_MODE==GPS_SIRF
uint8_t GPS_Rx_DMA[255];
DMA_InitTypeDef DMA_InitStructure;
#endif

/* Extern variables ----------------------------------------------------------*/
extern volatile uint64_t SysTick_Counter;
extern volatile uint32_t SysTick_Timeout;

/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/
uint8_t GPS_ReadWakeup(void);

/*******************************************************************************
 * Function Name  :  GPS_Config.
 * Description    :  Configure the GPS pins.
 * Input          :  None.
 * Return         :  None.
 *******************************************************************************/
void GPS_Config(void)
{  
  GPIO_InitTypeDef GPIO_InitStructure;

  GPS_SetupPower(); // Setup pin for power

  /************ GPS_ON_OFF (PB0) config ***********/

  /* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);
	
  /* Configure pin */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOB, &GPIO_InitStructure);

  GPIO_ResetBits(GPIOB, GPIO_Pin_0);
	
  /************ GPS_WAKEUP (PC2) config ***********/

  /* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);
	
  /* Configure pin */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOC, &GPIO_InitStructure);

  
  /************ GPS_1PPS (PC3) config ***********/

  /* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);
	
	/* Configure pin */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_3;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOC, &GPIO_InitStructure);

  
  /************ GPS USART (USART3-RX:PC11; USART3-TX:PC10) config ***********/
  
  /* Enabling GPIO clock */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);
  
  // Connecting TX and RX pins to the desired peripherals' Alternate Function
  GPIO_PinAFConfig(GPIOC, GPIO_PinSource10, GPIO_AF_USART3);
  GPIO_PinAFConfig(GPIOC, GPIO_PinSource11, GPIO_AF_USART3);
  
  /* Configure USART Tx in output whenever the GPS is hibernating (to prevent IO powering) */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  
  GPIO_ResetBits(GPIOC, GPIO_Pin_10);
  
  /* Configure USART Rx in alternate function */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
  GPIO_Init(GPIOC, &GPIO_InitStructure);

  // DMA RX transfer setup
  // Enable DMA clock
#if GPS_MODE==GPS_SIRF
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_DMA1, ENABLE);

  // Configure DMA transfer
  DMA_InitStructure.DMA_PeripheralBaseAddr = (uint32_t)&USART3->DR;
  DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t)&GPS_Rx_DMA;                           
  DMA_InitStructure.DMA_DIR = DMA_DIR_PeripheralSRC;          
  DMA_InitStructure.DMA_BufferSize = 1;
  DMA_InitStructure.DMA_PeripheralInc = DMA_PeripheralInc_Disable;
  DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Enable; 
  DMA_InitStructure.DMA_PeripheralDataSize = DMA_PeripheralDataSize_Byte;
  DMA_InitStructure.DMA_MemoryDataSize = DMA_MemoryDataSize_Byte;    
  DMA_InitStructure.DMA_Mode = DMA_Mode_Circular;
  DMA_InitStructure.DMA_Priority = DMA_Priority_High;
  DMA_InitStructure.DMA_M2M = DMA_M2M_Disable;
  DMA_Init(DMA1_Channel3, &DMA_InitStructure);
#endif
  // Set GPS Baudrate (default = 4800)
  GPS_SetBaudrate(4800);
  
  GPS_PowerState = 0;
  
  // Insert delay to allow GPS power to reach 0V before repowering
  msWait(50);


}

void GPS_SetBaudrate(uint32_t baudrate){
/* Initializing the USART (Baud Rate, Word Length , Stop Bit, Parity, Hardware
   flow control and Mode) */
  // Enabling USART clock
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART3, ENABLE);

  USART_InitTypeDef USART_InitStruct;

  USART_InitStruct.USART_BaudRate = baudrate;
  USART_InitStruct.USART_WordLength = USART_WordLength_8b;
  USART_InitStruct.USART_StopBits = USART_StopBits_1;
  USART_InitStruct.USART_Parity = USART_Parity_No;
  USART_InitStruct.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
  USART_InitStruct.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
  USART_Init(USART3, &USART_InitStruct);

}

void GPS_1PPS_IRQConfig(FunctionalState NewState)
{
  EXTI_InitTypeDef EXTI_InitStructure;
  NVIC_InitTypeDef NVIC_InitStructure;
  
  
  /* Enable the INT Clock */
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_SYSCFG, ENABLE);
  
  /* Connect EXTI Line to INT Pin */
  SYSCFG_EXTILineConfig(EXTI_PortSourceGPIOC, EXTI_PinSource3);
  
  /* Configure EXTI line */
  EXTI_InitStructure.EXTI_Line = EXTI_Line3;
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising;
  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
  EXTI_Init(&EXTI_InitStructure);
  
  /* Enable and set the EXTI interrupt priority */
  NVIC_InitStructure.NVIC_IRQChannel = EXTI3_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 4;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = NewState;
  NVIC_Init(&NVIC_InitStructure);

}

void GPS_SetupPower(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
    
  /************ GPS_PWR_EN (PB12) config ***********/

	/* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);
	
	/* Configure pin */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_12;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOB, &GPIO_InitStructure);
  
  GPIO_ResetBits(GPIOB, GPIO_Pin_12);
}

void GPS_EnablePower(void)
{
  
  // Enable GPS power
  GPIO_SetBits(GPIOB, GPIO_Pin_12);
  
  msWait(50);
    
  GPS_PowerState = 1;
  
}

void GPS_DisablePower(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;

  GPIO_ResetBits(GPIOB, GPIO_Pin_12);

  // Disable the USART and change Tx GPIO type to output
  USART_Cmd(USART3, DISABLE);

  // Pull TX down in order not to IO power GPS
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
  
  GPIO_ResetBits(GPIOC, GPIO_Pin_10);
  
  GPS_PowerState = 0;

}

uint8_t GPS_Wakeup(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  
  // Do it only if power is ON
  if(GPS_PowerState == 1)
  {

    // Wake the GPS up if not awake
    if(GPS_ReadWakeup() == 0)
    {
      // Set ON_OFF
      GPIO_SetBits(GPIOB, GPIO_Pin_0);
      
      // Wait till wakeup activation
      __disable_irq();
      SysTick_Timeout = 250;
      __enable_irq();
      while (GPS_ReadWakeup() == 0 && SysTick_Timeout != 0);
      
      // Change TX GPIO type to Alternate function and enable the USART
      GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
      GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
      GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
      GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
      GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
      GPIO_Init(GPIOC, &GPIO_InitStructure);
      
      USART_Cmd(USART3, ENABLE);
      
      // Enable
#if GPS_MODE==GPS_SIRF
      DMA_Cmd(DMA1_Channel3, ENABLE);
      USART_DMACmd(USART3, USART_DMAReq_Rx, ENABLE);
#endif

      // Reset ON_OFF
      while (SysTick_Timeout > 0);
      GPIO_ResetBits(GPIOB, GPIO_Pin_0);


      msWait(10);
      if (GPS_ReadWakeup())
       setModuleState(MODULE_GPS,STATE_ONLINE);

      //TODO: Restore software trickle + power management in SIRF mode

      // Return 1 if the GPS is awake. If not, return 0 (wakeup fail)
      return GPS_ReadWakeup();

    }
    else
    {
      return 1;
    }

  }
  else
  {
    return 0;
  }
  
}

uint8_t GPS_Hibernate(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;

  // Do it only if power is ON
  if(GPS_PowerState == 1)
  {
    // Put GPS in hibernation if it is not already
    if(GPS_ReadWakeup() != 0)
    {
      //TODO: if in SIRF mode, restore normal operating mode (not trickle) before hibernation

      // Set ON_OFF
      GPIO_SetBits(GPIOB, GPIO_Pin_0);
      
      // Wait till wakeup falling
      __disable_irq();
      SysTick_Timeout = 150;
      __enable_irq();

      while (GPS_ReadWakeup() != 0 && SysTick_Timeout != 0);
      
      // Disable the USART and change Tx GPIO type to input
      USART_Cmd(USART3, DISABLE);
      DMA_Cmd(DMA1_Channel3, DISABLE);
      
      // Pull TX down in order not to IO power GPS
      GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
      GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
      GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
      GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
      GPIO_Init(GPIOC, &GPIO_InitStructure);
      
      GPIO_ResetBits(GPIOC, GPIO_Pin_10);

      // Reset ON_OFF
      while (SysTick_Timeout > 50);
      GPIO_ResetBits(GPIOB, GPIO_Pin_0);

    }
    
    msWait(10);
    
    if (!GPS_ReadWakeup())
      setModuleState(MODULE_GPS, STATE_SLEEPMODE);

    // Return 1 if the GPS is in hibernation. If not, return 0 (hibernation fail)
    return !GPS_ReadWakeup();
  }
  else
  {
    return 0;
  }
  
}

uint8_t GPS_ReadWakeup(void)
{
  return GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_2);
}

// This function is based on the module activation flowchart of the MN8010 design guidelines
// Return 1 when the module is up and running
uint8_t GPS_PowerAndWakeup(void)
{
  /*GPS_DisablePower();
  msWait(50);
  */
  GPS_EnablePower();
  
  msWait(400);
  
  return GPS_Wakeup();
  
}

void GPS_ConfigRxIRQ(FunctionalState NewState)
{
  NVIC_InitTypeDef NVIC_InitStructure;
   
  #if GPS_MODE==GPS_NMEA
  USART_ClearFlag(USART3, USART_FLAG_RXNE);
  USART_ITConfig(USART3, USART_IT_RXNE, NewState);
  NVIC_InitStructure.NVIC_IRQChannel = USART3_IRQn;
  #endif

  #if GPS_MODE==GPS_SIRF
  USART_ClearFlag(USART3, USART_FLAG_RXNE);
  DMA_ITConfig(DMA1_Channel3, DMA_IT_TC, NewState);
  NVIC_InitStructure.NVIC_IRQChannel = DMA1_Channel3_IRQn;
  #endif

  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = NewState;
  NVIC_Init(&NVIC_InitStructure);


}
void GPS_ConfigTxIRQ(FunctionalState NewState)
{
  NVIC_InitTypeDef NVIC_InitStructure;
  
  USART_ClearFlag(USART3, USART_FLAG_TC);
  USART_ITConfig(USART3, USART_IT_TC, NewState);
  
  NVIC_InitStructure.NVIC_IRQChannel = USART3_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 3;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = NewState;
  NVIC_Init(&NVIC_InitStructure);


}
