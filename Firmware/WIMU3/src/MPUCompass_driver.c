//******************************************************************************
//  WIMUuSD - MPU and Compass driver module
//
//  Description:
//
//  Limitations:  This module has been designed to configure, to read and to write
//                the MPU and Compass registers.
//
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 2, 2012
//
//  Modifications: 
//
//
//******************************************************************************


/* Includes ------------------------------------------------------------------*/
#include "MPUCompass_driver.h"
#include "power.h" // For shared power button interrupt on EXTI_5_9 line
#include "utils.h"
#include "stm32l152_eval.h"
#include "buttons.h"
#include <string.h> // For memcpy


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
uint8_t MPUCompass_PowerState = 0;

uint8_t MPUCompass_MPUConfigState = 0;
uint8_t MPUCompass_MPUWakeState = 0;
uint8_t MPUCompass_MPUAcqState = 0;

uint8_t MPU_DMA[16];

volatile MPUCompass_I2CState_Typedef MPUCompass_I2CState = MPUCOMPASS_I2C_IDLE;
volatile MPUCompass_I2CWrState_Typedef MPUCompass_I2CWrState = MPUCOMPASS_I2CWR_START;
volatile MPUCompass_I2CRdState_Typedef MPUCompass_I2CRdState = MPUCOMPASS_I2CRD_START;

volatile I2C_ReadStruct_Typedef I2C_ReadStructure;
volatile I2C_WriteStruct_Typedef I2C_WriteStructure;

uint8_t MPUCompass_CompassAcqState = 0;
volatile uint8_t MPUCompass_CompassStartAcq = 0;

uint8_t MPU_SampleNumber = 0;
uint8_t MPU_BufWrPtr = 0;
volatile uint8_t MPU_BufRdPtr = 0;
volatile uint8_t Compass_BufRdPtr = 0;

extern uint8_t MPUCompass_SamplingFrequency;

//volatile bool MPU_BufferReady[2] = {false,false};

volatile bool MPU_NewValue = false;
volatile bool Mag_NewValue = false;

extern volatile int16_t AccelX_1s[2][MAX_FS];
extern volatile int16_t AccelY_1s[2][MAX_FS];
extern volatile int16_t AccelZ_1s[2][MAX_FS];
extern volatile int16_t GyroX_1s[2][MAX_FS];
extern volatile int16_t GyroY_1s[2][MAX_FS];
extern volatile int16_t GyroZ_1s[2][MAX_FS];

uint8_t Compass_SampleNumber = 0;
uint8_t Compass_BufWrPtr = 0;
extern volatile uint8_t Compass_BufRdPtr;

//volatile bool Compass_BufferReady[2] = {false, false};

extern volatile int16_t MagnetoX_1s[2][MAX_FS];
extern volatile int16_t MagnetoY_1s[2][MAX_FS];
extern volatile int16_t MagnetoZ_1s[2][MAX_FS];

extern volatile uint8_t MPUCompass_CompassStartAcq;

extern volatile uint32_t SysTick_DelayDownCounter;

uint8_t MPU_SamplingFrequency = 50;
uint8_t MPUCompass_SamplingFrequency = 50;

TIM_TimeBaseInitTypeDef TIM_TimebaseCompassInit =
{
  0,                    // TIM_Prescaler (period tick = 1/32768 s)
  TIM_CounterMode_Up,   // TIM_CounterMode
  655,//MPUCOMPASS_50Hz,      // TIM_Period (default freq : 49,95)
  TIM_CKD_DIV1         // TIM_ClockDivision
};

// Configuring the timer output compare unit to trigger Compass read
// Setting the compare value to 1.59ms before period end
// (The CPU have 1,59ms to perform the Compass register read)
TIM_OCInitTypeDef TIM_OCCompassInit =
{
  TIM_OCMode_Timing,        // TIM_OCMode
  TIM_OutputState_Disable,  // TIM_OutputState
  655-52,//MPUCOMPASS_50Hz - 52,     // TIM_Pulse
  TIM_OCPolarity_High       // TIM_OCPolarity
};



/* Extern variables ----------------------------------------------------------*/
extern volatile uint64_t SysTick_Counter;
extern volatile uint32_t SysTick_Timeout;
extern PushButton_TypeDef PushButton1;
extern uint8_t BuzzerStartFlag;

/* Private function prototypes -----------------------------------------------*/
uint8_t MPUCompass_WrRegister(uint8_t I2C_Address, uint8_t RegisterAddress, uint8_t RegisterValue);
uint8_t MPUCompass_RdRegister(uint8_t I2C_Address, uint8_t RegisterAddress, uint8_t * RegisterValue, uint8_t BurstLength);
void MPUCompass_WaitDataReady(void);

Error_TypeDef MPUCompass_MPUInit(void){
    uint8_t status=0;

    MPU_BufRdPtr = MPU_BufWrPtr = 0;

   if (MPUCompass_ConfigIO()!=1)
      return ERROR_INIT;

   if (MPUCompass_EnablePower()!=1)
      return ERROR_POWER;

   if (MPUCompass_MPUWakeup()!=1)
      return ERROR_COM;

   if (MPUCompass_MPUIDValidation()==0){
      return ERROR_ID;
    } 

   if (MPUCompass_MPUConfigReg(wimu_config.acc.range, wimu_config.gyro.range)!=1)
      return ERROR_COM;

    if (wimu_config.general.sampling_rate==50){
      status = MPUCompass_MPUSetFreq(MPUCOMPASS_50Hz);
    }

    if (wimu_config.general.sampling_rate==100){
      status = MPUCompass_MPUSetFreq(MPUCOMPASS_100Hz);
    }

    if (wimu_config.general.sampling_rate==200){
      status = MPUCompass_MPUSetFreq(MPUCOMPASS_200Hz);
    }

    if (status!=1)
      return ERROR_COM;

    return ERROR_NONE;
}

/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
 * Function Name  :  MPUCompass_Config.
 * Description    :  configure the MPU and Compass.
 * Input          :  None.
 * Return         :  Config result: 1=OK, 0=LSE clock fail to start.
 *******************************************************************************/
uint8_t MPUCompass_ConfigIO(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  //I2C_InitTypeDef I2C_InitStruct;
  NVIC_InitTypeDef NVIC_InitStructure;
  DMA_InitTypeDef DMA_InitStructure;

  // Configure GPIO for power supply
  MPUCompass_SetupPower();
  MPUCompass_DisablePower();

  // Initializing I2C peripheral
 /* I2C_InitStruct.I2C_ClockSpeed =   400000;
  I2C_InitStruct.I2C_Mode =         I2C_Mode_I2C;
  I2C_InitStruct.I2C_DutyCycle =    I2C_DutyCycle_2;
  I2C_InitStruct.I2C_OwnAddress1 =  0x00;
  I2C_InitStruct.I2C_Ack =          I2C_Ack_Enable;
  I2C_InitStruct.I2C_AcknowledgedAddress = I2C_AcknowledgedAddress_7bit;
  I2C_Config(I2C_MPUCOMPASS_PERIPHERAL_ID, &I2C_InitStruct);
 
  msWait(100);*/
  
  /* ------ MPU_INT GPIO (PB5) config ------ */
  
  /* Enable GPIOx AHB Clocks */
  //RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);
	
	/* Configure pin */
  GPIO_InitStructure.GPIO_Pin =     GPIO_Pin_5;
  GPIO_InitStructure.GPIO_Mode =    GPIO_Mode_IN;
  GPIO_InitStructure.GPIO_Speed =   GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType =   GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd =    GPIO_PuPd_NOPULL;
  GPIO_Init(GPIOB, &GPIO_InitStructure);

  // Configure I2C pins as input
  GPIO_InitStructure.GPIO_Pin =     GPIO_Pin_6;
  
  /* ------ MCO (PA8) config ------ */
   
  /* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA, ENABLE);

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(GPIOA, &GPIO_InitStructure);

  GPIO_ResetBits(GPIOA, GPIO_Pin_8);

  // Enabling the Power Controller (PWR) APB1 interface clock
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_PWR, ENABLE);
  
  // Enabling access to RTC domain
  PWR_RTCAccessCmd(ENABLE);
  
  // Enabling and selecting LSE as RTC clock source
  RCC_LSEConfig(RCC_LSE_ON);
  
   // Wait for LSE clock to be ready
  __disable_irq();
  SysTick_Timeout = LSE_STARTUP_TIMEOUT;
  __enable_irq();

  while (RCC_GetFlagStatus(RCC_FLAG_LSERDY) == RESET && SysTick_Timeout != 0)
  if (SysTick_Timeout == 0)
  {
      //printf("ERROR: LSE clock fail to start\n");
     return 0;
  }

  // Select LSE for MCO pin (PA8)
  RCC_MCOConfig(RCC_MCOSource_LSE, RCC_MCODiv_1);
  
  // Enable the interrupt for I2C transaction 
  NVIC_InitStructure.NVIC_IRQChannel = I2C1_EV_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);

  // DMA RX transfer setup
  // Enable DMA clock
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_DMA1, ENABLE);

  // Configure DMA transfer
  DMA_InitStructure.DMA_PeripheralBaseAddr =  (uint32_t)&I2C1->DR;
  DMA_InitStructure.DMA_MemoryBaseAddr =      (uint32_t)&MPU_DMA;                           
  DMA_InitStructure.DMA_DIR =                 DMA_DIR_PeripheralSRC;          
  DMA_InitStructure.DMA_BufferSize =          16;
  DMA_InitStructure.DMA_PeripheralInc =       DMA_PeripheralInc_Disable;
  DMA_InitStructure.DMA_MemoryInc =           DMA_MemoryInc_Enable; 
  DMA_InitStructure.DMA_PeripheralDataSize =  DMA_PeripheralDataSize_Byte;
  DMA_InitStructure.DMA_MemoryDataSize =      DMA_MemoryDataSize_Byte;    
  DMA_InitStructure.DMA_Mode =                DMA_Mode_Normal;
  DMA_InitStructure.DMA_Priority =            DMA_Priority_High;
  DMA_InitStructure.DMA_M2M =                 DMA_M2M_Disable;
  DMA_Init(DMA1_Channel7, &DMA_InitStructure);

// Enable the interrupt for DMA transfer
  NVIC_InitStructure.NVIC_IRQChannel =                    DMA1_Channel7_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority =  1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority =         0;
  NVIC_InitStructure.NVIC_IRQChannelCmd =                 ENABLE;
  NVIC_Init(&NVIC_InitStructure);
  DMA_ClearITPendingBit(DMA1_IT_TC7);

  return 1;
}

void MPUCompass_EnableInterrupt(bool enable){
  NVIC_InitTypeDef NVIC_InitStructure;
  /* Enable and set the EXTI interrupt priority */
  NVIC_InitStructure.NVIC_IRQChannel = EXTI9_5_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;

  if (enable==true)
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  else
    NVIC_InitStructure.NVIC_IRQChannelCmd = DISABLE;

  NVIC_Init(&NVIC_InitStructure);
  
  EXTI_ClearITPendingBit(EXTI_Line5);

  
}

void MPUCompass_SetupPower(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
 /* ------ SENSOR_PWR_EN GPIO (PB8) config ------ */
  
  /* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, ENABLE);
	
  /* Configure pin */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOB, &GPIO_InitStructure);
  
  GPIO_ResetBits(GPIOB, GPIO_Pin_8);
  __disable_irq();
  msWait(100);
  __enable_irq();

}

uint8_t MPUCompass_EnablePower(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  I2C_InitTypeDef I2C_InitStruct;
  uint8_t RegisterValue;
  uint8_t I2C_GlobalAccessResult = 1;

  // Enable MPU and compass power
  GPIO_SetBits(GPIOB, GPIO_Pin_8);
  MPUCompass_PowerState = 1;
  
  msWait(100);

  // Initializing I2C peripheral
  I2C_InitStruct.I2C_ClockSpeed =   400000;
  I2C_InitStruct.I2C_Mode =         I2C_Mode_I2C;
  I2C_InitStruct.I2C_DutyCycle =    I2C_DutyCycle_2;
  I2C_InitStruct.I2C_OwnAddress1 =  0x00;
  I2C_InitStruct.I2C_Ack =          I2C_Ack_Enable;
  I2C_InitStruct.I2C_AcknowledgedAddress = I2C_AcknowledgedAddress_7bit;
  I2C_Config(I2C_MPUCOMPASS_PERIPHERAL_ID, &I2C_InitStruct);
 
  //msWait(100);

  // Output MCO clock
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL ;
  GPIO_Init(GPIOA, &GPIO_InitStructure);
   
  // Configuring the Auxiliary I2C serial interface of MPU in Pass-Through Mode
  
  // Setting I2C_BYPASS_EN bit in INT_PIN_CFG register
  I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__INT_PIN_CFG, &RegisterValue, 1);
  RegisterValue = MPU_REG__INT_PIN_CFG__I2C_BYPASS_EN__MASK;
  I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__INT_PIN_CFG, RegisterValue);

  if(I2C_GlobalAccessResult == 0)
  {
    //printf("ERROR: Setting MPU's I2C in Pass-Through mode FAILED (I2C timeout).\n");
    return 0;
  }
  
  MPUCompass_MPUConfigState = 0;
  MPUCompass_MPUWakeState = 0;
  MPUCompass_MPUAcqState = 0;
           
  return 1;
}

void MPUCompass_DisablePower(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;

  // Shutdown MCO clock
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL ;
  GPIO_Init(GPIOA, &GPIO_InitStructure);
//  GPIO_ResetBits(GPIOA, GPIO_Pin_8);

  // Disabling I2C
  I2C_DeInit(I2C_MPUCOMPASS_PERIPHERAL_ID);
  I2C_Cmd(I2C_MPUCOMPASS_PERIPHERAL_ID, DISABLE);

  // Configure I2C pins as input
  GPIO_InitStructure.GPIO_Pin =     GPIO_Pin_6;
  GPIO_Init(GPIOB, &GPIO_InitStructure);
  GPIO_InitStructure.GPIO_Pin =     GPIO_Pin_7;
  GPIO_Init(GPIOB, &GPIO_InitStructure);

  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA, DISABLE);




  EXTI_ClearITPendingBit(EXTI_Line5);
 
  // Disable MPU and compass power
  GPIO_ResetBits(GPIOB, GPIO_Pin_8);
  MPUCompass_PowerState = 0;
  
    
//  msWait(200);
}

uint8_t MPUCompass_MPUWakeup(void)
{
  uint8_t I2C_GlobalAccessResult = 1;
  uint8_t RegisterValue;

  // Waking up MPU by clearing SLEEP bit in PWR_MGMT_1 register
  I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__PWR_MGMT_1, &RegisterValue, 1);
  RegisterValue &= ~MPU_REG__PWR_MGMT_1__SLEEP__MASK;
  I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__PWR_MGMT_1, RegisterValue);
  
  if(I2C_GlobalAccessResult == 0)
  {
   // printf("ERROR: MPU wakeup FAILED (I2C timeout).\n");
    return 0;
  }
  
  MPUCompass_MPUWakeState = 1;
  
  return 1;

}

uint8_t MPUCompass_MPUSleep(void)
{
  uint8_t I2C_GlobalAccessResult = 1;
  uint8_t RegisterValue;

  // Put MPU in Sleep mode by setting SLEEP bit in PWR_MGMT_1 register
  I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__PWR_MGMT_1, &RegisterValue, 1);
  RegisterValue |= MPU_REG__PWR_MGMT_1__SLEEP__MASK;
  I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__PWR_MGMT_1, RegisterValue);

  if(I2C_GlobalAccessResult == 0)
  {
    printf("ERROR: MPU Sleep FAILED (I2C timeout).\n");
    return 0;
  }
  
  MPUCompass_MPUWakeState = 0;

  return 1;
}

uint8_t MPUCompass_MPUSetFreq(MPUCompassSamplingFreq_TypeDef SamplingFreq)
{
  uint8_t I2C_AccessResult;
  
  if(MPUCompass_PowerState == 1 && MPUCompass_MPUConfigState == 1 && MPUCompass_MPUAcqState == 0)
  {
    // Setting sampling frequency in SMPRT_DIV register
    I2C_AccessResult = MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__SMPLRT_DIV, SamplingFreq /*/ 4 - 1*/);
    
    if(I2C_AccessResult == 0)
    {
      //printf("ERROR: MPU frequency setting FAILED (I2C timeout).\n");
      return 0;
    }
    
    //msWait(50);
    return 1;
  }
  else
  {
    //printf("ERROR: MPU frequency setting failed\n");
    return 0;
  }
}


Error_TypeDef MPUCompass_MPUStart(void)
{
  EXTI_InitTypeDef EXTI_InitStructure;
  //NVIC_InitTypeDef NVIC_InitStructure;
  //uint8_t i;
  
  //MPU_BufferReady[0] = false;
  //MPU_BufferReady[1] = false;

  

  /*for (i=0;i<2;i++){
    Acc_BufferReady[i]=false;
    Gyro_BufferReady[i]=false;
  }*/

  /* Enable the INT Clock */
  //RCC_APB2PeriphClockCmd(RCC_APB2Periph_SYSCFG, ENABLE);
  
  /* Connect EXTI Line to INT Pin */
  SYSCFG_EXTILineConfig(EXTI_PortSourceGPIOB, EXTI_PinSource5);
  
  /* Configure EXTI line */
  EXTI_InitStructure.EXTI_Line = EXTI_Line5;
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising;
  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
  EXTI_Init(&EXTI_InitStructure);
  MPUCompass_EnableInterrupt(true);

  MPUCompass_MPUAcqState = 1;


  return ERROR_NONE;
  
}

void MPUCompass_MPUStop(void)
{
  EXTI_InitTypeDef EXTI_InitStructure;
  //NVIC_InitTypeDef NVIC_InitStructure;
  
  /* Configure EXTI line */
  EXTI_InitStructure.EXTI_Line = EXTI_Line5;
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising;
  EXTI_InitStructure.EXTI_LineCmd = DISABLE;
  EXTI_Init(&EXTI_InitStructure);
  
  /* Enable and set the EXTI interrupt priority */
  /*NVIC_InitStructure.NVIC_IRQChannel = EXTI9_5_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = DISABLE;
  NVIC_Init(&NVIC_InitStructure);*/
  //MPUCompass_EnableInterrupt(false);

  MPUCompass_MPUAcqState = 0;

}

uint8_t MPUCompass_MPUIDValidation(void)
{
  uint8_t RegisterValue;
  uint8_t I2C_AccessResult;
  
  if(MPUCompass_PowerState != 0)
  {

    I2C_AccessResult = MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__WHO_AM_I, &RegisterValue, 1);
    
    if(I2C_AccessResult == 0)
    {
      //printf("ERROR: I2C timeout during MPU ID read\n");
      return 0;
    }
    
    if(((RegisterValue >> 1) & 0x3F) != 0x34)
    {
      //printf("ERROR: Invalid MPU ID\n");
      return 0;
    }
    
    return 1;
  }
  else
  {
    //printf("ERROR: MPU ID validation falied (Power is down)\n");
    return 0;
  }
  
}

// acc_range = value to put in the register (0 to 3)
// gyro_range = value to put in the register (0 to 3)
uint8_t MPUCompass_MPUConfigReg(uint8_t acc_range, uint8_t gyro_range)
{
  uint8_t RegisterValue;
  uint8_t I2C_GlobalAccessResult = 1;
  
  if(MPUCompass_PowerState != 0)
  {
    // Setting initial sampling frequency to 50Hz SMPRT_DIV register
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__SMPLRT_DIV, MPUCOMPASS_50Hz/*/ 4 - 1*/); // Will be overwritten in SetFreq
    
    // Setting Gyro range
     RegisterValue = (gyro_range << MPU_REG__GYRO_CONFIG__FS_SEL__SHIFT) & MPU_REG__GYRO_CONFIG__FS_SEL__MASK;
    //RegisterValue = 0x10; // +/-1000 deg/sec
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__GYRO_CONFIG, RegisterValue);
    
    // Setting Acc range
    RegisterValue = (acc_range << MPU_REG__ACCEL_CONFIG__AFS_SEL__SHIFT) & MPU_REG__ACCEL_CONFIG__AFS_SEL__MASK;
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__ACCEL_CONFIG, RegisterValue);
    
    // Configure the interrupt status bits to be cleared on any read operation by
    // setting INT_RD_CLEAR bit in INT_PIN_CFG register
    // (I2C_BYPASS_EN bit must always be set)
    RegisterValue = MPU_REG__INT_PIN_CFG__INT_RD_CLEAR__MASK | MPU_REG__INT_PIN_CFG__I2C_BYPASS_EN__MASK;
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__INT_PIN_CFG, RegisterValue);
    
    // Enabling Data ready interrupt by setting DATA_RDY_INT bit in INT_ENABLE register
    RegisterValue = MPU_REG__INT_ENABLE__DATA_RDY_EN__MASK;
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__INT_ENABLE, RegisterValue);
    //I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__INT_ENABLE, &RegisterValue, 1);
    
    // Select external 32.768kHz clock as MPU clock source by writing to CLKSEL bits in PWR_MGMT_1 register
    // Disabling the temperature sensor by setting TEMP_DIS bit in PWR_MGMT_1 register
    I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__PWR_MGMT_1, &RegisterValue, 1);
    RegisterValue |= (4 << MPU_REG__PWR_MGMT_1__CLKSEL__SHIFT) | MPU_REG__PWR_MGMT_1__TEMP_DIS__MASK;
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__PWR_MGMT_1, RegisterValue);

    #ifdef MPU_FILTERGYRO
      RegisterValue = MPU_DLPF_5HZ; 
      I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_MPU_ADDR, MPU_REG__CONFIG, RegisterValue);
    #endif
    
    //msWait(50);
    
    if(I2C_GlobalAccessResult == 0)
    {
      //printf("ERROR: MPU config register FAILED because of timeout.\n");
      return 0;
    }

    MPUCompass_MPUConfigState = 1;

    return 1;
  }
  else
  {
    printf("ERROR: MPU config register FAILED (Power is down)\n");
    return 0;
  }
  
}

/*uint8_t MPUCompass_ReadMPUData(int16_t * AccelXYZData, int16_t * GyroXYZData)
{
  uint8_t I2C_AccessResult = 1;
  uint8_t RegisterValue[14];
  
  I2C_AccessResult &= MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__ACCEL_XOUT_H, RegisterValue, 14);
  
  AccelXYZData[0] = ((int16_t)(RegisterValue[0]) << 8) | RegisterValue[1];
  AccelXYZData[1] = ((int16_t)(RegisterValue[2]) << 8) | RegisterValue[3];
  AccelXYZData[2] = ((int16_t)(RegisterValue[4]) << 8) | RegisterValue[5];

  GyroXYZData[0] = ((int16_t)(RegisterValue[8]) << 8) | RegisterValue[9];
  GyroXYZData[1] = ((int16_t)(RegisterValue[10]) << 8) | RegisterValue[11];
  GyroXYZData[2] = ((int16_t)(RegisterValue[12]) << 8) | RegisterValue[13];

  return I2C_AccessResult;
  
}*/

uint8_t MPUCompass_StartReadMPUData(){
  uint8_t I2C_AccessResult = 1;
  
  I2C_AccessResult &= MPUCompass_RdRegister(I2C_MPU_ADDR, MPU_REG__ACCEL_XOUT_H, NULL, 14);

  return I2C_AccessResult;
}

uint8_t MPUCompass_CompassIDValidation(void)
{
  uint8_t CompassID[3];
  uint8_t I2C_GlobalAccessResult = 1;
  //uint8_t ReturnValue = 1;
  
  if(MPUCompass_PowerState != 0)
  {
        
    I2C_GlobalAccessResult = MPUCompass_RdRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__ID_A, CompassID, 3);
            
    if(I2C_GlobalAccessResult == 0)
    {
      printf("ERROR: I2C timeout during Compass ID read\n");
      return 0;
    }
    
    if(CompassID[0] != 'H' || CompassID[1] != '4' || CompassID[2] != '3')
    {
      printf("ERROR: Invalid Compass ID\n");
      return 0;
    }
    
    return 1;
  }
  else
  {
    printf("ERROR: Compass ID validation failed (Power is down)\n");
    return 0;
  }
  
}

uint8_t MPUCompass_CompassConfigReg(uint8_t mag_range)
{
  uint8_t RegisterValue;
  uint8_t I2C_GlobalAccessResult = 1;
  
  if(MPUCompass_PowerState != 0)
  {
    
    // Initialize Config Register A
    /*RegisterValue = (0 << COMPASS_REG__CONG_A__MUST_CLR__SHIFT) & COMPASS_REG__CONG_A__MUST_CLR__MASK;
    RegisterValue |= (0 << COMPASS_REG__CONG_A__SAMPLE_FOR_AVG__SHIFT) & COMPASS_REG__CONG_A__SAMPLE_FOR_AVG__MASK;
    RegisterValue |= (0 << COMPASS_REG__CONG_A__OUTPUT_RATE__SHIFT) & COMPASS_REG__CONG_A__OUTPUT_RATE__MASK;
    RegisterValue |= (0 << COMPASS_REG__CONG_A__MEAS_CONF__SHIFT) & COMPASS_REG__CONG_A__MEAS_CONF__MASK;*/
    RegisterValue = (COMPASS_SAMPLE_AVG << 5) + (COMPASS_DATA_OUT << 2) + COMPASS_MEASURE;
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__CONF_A, RegisterValue);   

    // Initialize Config Register B
    /*RegisterValue = (0 << COMPASS_REG__CONG_B__GAIN__SHIFT) & COMPASS_REG__CONG_B__GAIN__MASK;
    RegisterValue |= (0 << COMPASS_REG__CONG_B__MUST_CLR__SHIFT) & COMPASS_REG__CONG_B__MUST_CLR__MASK;*/
    RegisterValue = (mag_range << 5);
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__CONF_B, RegisterValue);
    
    
    // Initialize Mode register
    //RegisterValue = (0x20 << COMPASS_REG__MODE__MUST_CLR__SHIFT) & COMPASS_REG__MODE__MUST_CLR__MASK;
    //RegisterValue |= (1 << COMPASS_REG__MODE__OPERATE_MODE__SHIFT) & COMPASS_REG__MODE__OPERATE_MODE__MASK;
    RegisterValue = COMPASS_MODE;
    I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__MODE, RegisterValue);
    /*
    I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_COMPASS_ADDR+1, COMPASS_REG__CONF_A, &RegisterValue, 1);
    I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_COMPASS_ADDR+1, COMPASS_REG__CONF_B, &RegisterValue, 1);
    I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_COMPASS_ADDR+1, COMPASS_REG__MODE, &RegisterValue, 1);*/
    
    
    if(I2C_GlobalAccessResult == 0)
    {
      printf("ERROR: Compass config register FAILED (I2C timeout).\n");
    }
    
    return I2C_GlobalAccessResult;
  }
  else
  {
    printf("ERROR: Compass config register FAILED (Power is down)\n");
    return 0;
  }
  
}


uint8_t MPUCompass_CompassSetFreq(MPUCompassSamplingFreq_TypeDef SamplingFreq)
{
  uint16_t timer_period = 655;

  if(MPUCompass_CompassAcqState == 0)
  {
    // Disabling the timer
    TIM_Cmd(TIM10, DISABLE);
    
    // Set timer period
    if (SamplingFreq==MPUCOMPASS_50Hz) timer_period = 655;//655; //50.0275 Hz
    if (SamplingFreq==MPUCOMPASS_100Hz || SamplingFreq==MPUCOMPASS_200Hz) timer_period = 327; //100.208 Hz
    //if (SamplingFreq==MPUCOMPASS_200Hz) timer_period = 163; // 201.031 Hz

    TIM_TimebaseCompassInit.TIM_Period = timer_period;
    TIM_TimeBaseInit(TIM10, &TIM_TimebaseCompassInit);
    
    // Set sample reading time
    TIM_OCCompassInit.TIM_Pulse = timer_period - 52;
    TIM_OC1Init(TIM10, &TIM_OCCompassInit);

    // Enabling the timer
    TIM_Cmd(TIM10, ENABLE);
  }

  return 1;

}

uint8_t MPUCompass_CompassInitiateSingleMeasure(void)
{
  uint8_t RegisterValue;
  uint8_t I2C_AccessResult = 1;
  

  /*RegisterValue = (0 << COMPASS_REG__MODE__MUST_CLR__SHIFT) & COMPASS_REG__MODE__MUST_CLR__MASK;
  RegisterValue |= (1 << COMPASS_REG__MODE__OPERATE_MODE__SHIFT) & COMPASS_REG__MODE__OPERATE_MODE__MASK;*/
  RegisterValue = COMPASS_MODE_SINGLE;
  I2C_AccessResult &= MPUCompass_WrRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__MODE, RegisterValue);
   
  return I2C_AccessResult;
  
}

void MPUCompass_WaitDataReady(void){
 // uint8_t Status=0;
  //while ((Status&0x01)==0){*/
  //MPUCompass_RdRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__STATUS, &Status, 1);
  //MPUCompass_RdRegister(I2C_COMPASS_RD_ADDR, COMPASS_REG__STATUS, NULL, 1);
  MPUCompass_RdRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__STATUS, NULL, 1);
    //msWait(1);
  //}
}


/*uint8_t MPUCompass_ReadMegnetoData(int16_t * MagnetoXYZData)
{
  uint8_t I2C_GlobalAccessResult = 1;
  uint8_t RegisterValue[6]={0,0,0,0,0,0};
  uint8_t Status=0;
  //uint8_t test=0;

  MPUCompass_WaitDataReady();
  //RegisterValue[0] = (COMPASS_SAMPLE_AVG << 5) + (COMPASS_DATA_OUT << 2) + COMPASS_MEASURE;
  //I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_COMPASS_ADDR, COMPASS_REG__CONF_A, RegisterValue[0], false);   

  I2C_GlobalAccessResult = MPUCompass_RdRegister(I2C_COMPASS_ADDR, COMPASS_REG__DATA_X_MSB, RegisterValue,6);

  MagnetoXYZData[0] = ((int16_t)(RegisterValue[0]) << 8) | RegisterValue[1];
  MagnetoXYZData[1] = ((int16_t)(RegisterValue[4]) << 8) | RegisterValue[5];
  MagnetoXYZData[2] = ((int16_t)(RegisterValue[2]) << 8) | RegisterValue[3];
  
  //I2C_GlobalAccessResult &= MPUCompass_RdRegister(I2C_COMPASS_ADDR+1, COMPASS_REG__STATUS, &Status, 1);
  
  //I2C_GlobalAccessResult &= MPUCompass_WrRegister(I2C_COMPASS_ADDR, COMPASS_REG__DATA_X_MSB, 0, true);
  return I2C_GlobalAccessResult;
  
}*/

uint8_t MPUCompass_StartReadMagnetoData(){
  uint8_t I2C_GlobalAccessResult = 1;

  MPUCompass_WaitDataReady();
  //I2C_GlobalAccessResult = MPUCompass_RdRegister(I2C_COMPASS_ADDR, COMPASS_REG__DATA_X_MSB, NULL, 6);

  return I2C_GlobalAccessResult;

}

void MPUCompass_CompassInitTimer(void)
{

  // Enabling TIM10 peripheral clock
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_TIM10, ENABLE);

  // Disabling the timer
  TIM_Cmd(TIM10, DISABLE);

  // Configuring TIM10 timebase
  TIM_TimeBaseInit(TIM10, &TIM_TimebaseCompassInit);
  
  TIM_ETRClockMode2Config(TIM10, TIM_ExtTRGPSC_OFF, TIM_ExtTRGPolarity_NonInverted, 0);
  
  // Enabling auto-reload preload
  TIM_ARRPreloadConfig(TIM10, ENABLE);
  
  // Configuring the timer output compare unit to trigger Compass read
  TIM_OC1Init(TIM10, &TIM_OCCompassInit);
  
  // Reseting counter
  TIM_SetCounter(TIM10, 0);
  
  // Updating shadow registers
  TIM10->EGR = 0x0001;
  
  // Enabling the timer
  TIM_Cmd(TIM10, ENABLE);

}

void MPUCompass_CompassStart(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;
 
  //Compass_BufferReady[0] = false;
  //Compass_BufferReady[1] = false;

  Compass_BufRdPtr = Compass_BufWrPtr = 0;

  MPUCompass_CompassStartAcq = 1;
  MPUCompass_CompassAcqState = 1;

  // Clearing timer update flag and enabling timer interrupt :
  // update inetrrupt and capture compare 1 interrupt
  TIM_ClearITPendingBit(TIM10, TIM_IT_Update/* | TIM_IT_CC1*/);
  TIM_ITConfig(TIM10, TIM_IT_Update /*| TIM_FLAG_CC1*/, ENABLE);

  // Enable the TIM10 global Interrupt
  NVIC_InitStructure.NVIC_IRQChannel = TIM10_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
  
}

void MPUCompass_CompassStop(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;
    
  // Disabling the TIM10 global Interrupt
  NVIC_InitStructure.NVIC_IRQChannel = TIM10_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelCmd = DISABLE;
  NVIC_Init(&NVIC_InitStructure);
  
  MPUCompass_CompassAcqState = 0;
  
}

uint8_t MPUCompass_CompassSync(void)
{

  //if(MPUCompass_PowerState == 1 && MPUCompass_MPUConfigState == 1 && MPUCompass_MPUWakeState == 1 && MPUCompass_MPUAcqState == 0)
  {
    // Wait for the rising edge of the MPU data ready signal
    __disable_irq();
    SysTick_Timeout = 10;
    __enable_irq();
    
    while(GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_5) != 0  && SysTick_Timeout != 0);
    while(GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_5) != 1  && SysTick_Timeout != 0);
    
    // Disabling the timer
    TIM_Cmd(TIM10, DISABLE);

    // Reseting counter
    TIM_SetCounter(TIM10, 0);
    
    // Updating shadow registers
    TIM10->EGR = 0x0001;

    // Enabling the timer
    TIM_Cmd(TIM10, ENABLE);
    
    if(SysTick_Timeout == 0)
    {
      printf("ERROR: Compass fail to sync on MPU data ready\n");
      return 0;
    }
    
    return 1;
  }
  
  return 0;

}

/*******************************************************************************
 * Function Name  :  MPUCompass_WrRegister.
 * Description    :  Write to MPU or Compass according to the I2C_Address.
 *
 *                    ***CAUTION***: If Compass is to be access, the MPU MUST be
 *                    configured in Pass-Through Mode before compass register
 *                    access and put back to I2C Master Mode after compass
 *                    register access.
 *
 * Input          :   I2C_Address : I2C address of the chip to write to
 *                    RegisterAddress : Register address to write to
 *                    RegisterValue : register value to write in pointed register
 * Return         :  Access result (1=OK, 0=timeout).
 *******************************************************************************/
uint8_t MPUCompass_WrRegister(uint8_t I2C_Address, uint8_t RegisterAddress, uint8_t RegisterValue)
{
  uint16_t timeout = 0xFFFF;

  // Verify that the I2C bus is idle
  while(MPUCompass_I2CState != MPUCOMPASS_I2C_IDLE && (timeout--)>0);
  if (timeout==0)
    return 0;

  /*if(MPUCompass_I2CState != MPUCOMPASS_I2C_IDLE)
  {
    return 0;
  }*/
  
  // Prepare writing structure
  I2C_WriteStructure.I2CAddress = I2C_Address;
  I2C_WriteStructure.RegisterAddress = RegisterAddress;
  I2C_WriteStructure.RegisterValue = RegisterValue;

  // Start I2C write
  MPUCompass_I2CState = MPUCOMPASS_I2C_WRITING;
  MPUCompass_I2CWrState = MPUCOMPASS_I2CWR_START;
  
  // Enabling I2C interrupt
  I2C_ITConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_IT_BUF | I2C_IT_EVT, ENABLE);

  // Generating START condition
  I2C_GenerateSTART(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);

  timeout = 0xFFFF;

  while(MPUCompass_I2CState != MPUCOMPASS_I2C_IDLE  && (timeout--)>0)
  {
//    printf("Sw\n");

    //SB POWER MANAGEMENT OFF
    #ifdef POWER_MANAGE
    if (isModuleOnline(MODULE_DATALOGGER)){
     if(SPI_I2S_GetFlagStatus(SD_SPI, SPI_I2S_FLAG_BSY) == RESET) // Wait for data write complete on card before sleeping
        PWR_EnterSleepMode(PWR_Regulator_ON, PWR_SLEEPEntry_WFI);
    }else{
        PWR_EnterSleepMode(PWR_Regulator_ON, PWR_SLEEPEntry_WFI);
    }
    #endif
  }

  if (timeout==0)
    return 0;
  
//  printf("SwF\n");
  
  return 1;
  
}

/*******************************************************************************
 * Function Name  :  MPUCompass_RdRegister.
 * Description    :  Write to MPU or Compass according to the I2C_Address.
 *
 *                    ***CAUTION***: If Compass is to be access, the MPU MUST be
 *                    configured in Pass-Through Mode before compass register
 *                    access and put back to I2C Master Mode after compass
 *                    register access.
 *
 * Input          :   I2C_Address : I2C address of the chip to write to
 *                    RegisterAddress : Register address to read from
 *                    RegisterValue : Pointer to readed register value. If NULL, the function will block
 *                                    until data is fully received.
 * Return         :  Access result (1=OK, 0=timeout).
 *******************************************************************************/
uint8_t   MPUCompass_RdRegister(uint8_t I2C_Address, uint8_t RegisterAddress, uint8_t * RegisterValue, uint8_t BurstLength)
{
  uint16_t timeout=0xFFFF;

  // Verify that the I2C bus is idle
  while(MPUCompass_I2CState != MPUCOMPASS_I2C_IDLE && (timeout--)>0);
  if (timeout==0)
    return 0;
 /* if(MPUCompass_I2CState != MPUCOMPASS_I2C_IDLE)
  {
    return 0;
  }*/
  
  // Prepare reading structure
  I2C_ReadStructure.I2CAddress = I2C_Address;
  I2C_ReadStructure.RegisterAddress = RegisterAddress;
  I2C_ReadStructure.RegisterValue = RegisterValue;
  I2C_ReadStructure.BurstLength = BurstLength;
  
  // Start I2C read
  MPUCompass_I2CState = MPUCOMPASS_I2C_READING;
  MPUCompass_I2CRdState = MPUCOMPASS_I2CRD_START;

  // Use DMA 
  DMA_SetCurrDataCounter(DMA1_Channel7,BurstLength);

  //DMA
  DMA_ITConfig(DMA1_Channel7, DMA_IT_TC, true);
  I2C_DMACmd(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);

  // Enable DMA Channel
  DMA_Cmd(DMA1_Channel7, ENABLE);

  // Set LAST bit (to generate NACK automatically)
  if (BurstLength>1) I2C_DMALastTransferCmd(I2C_MPUCOMPASS_PERIPHERAL_ID,true);

  // Enabling I2C interrupt
  I2C_ITConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_IT_BUF | I2C_IT_EVT, ENABLE);

  // Generating START condition
  I2C_GenerateSTART(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);

  // If RegisterValue isn't NULL, we block until we get some results
  if (RegisterValue!=NULL){ 
    timeout=0xFFFF;
    while(MPUCompass_I2CState != MPUCOMPASS_I2C_IDLE && (timeout--)>0)
    {
      //debug_printf(".");
      //SB POWER MANAGEMENT OFF
      #ifdef POWER_MANAGE
      if (isModuleOnline(MODULE_DATALOGGER)){
         if(SPI_I2S_GetFlagStatus(SD_SPI, SPI_I2S_FLAG_BSY) == RESET) // Wait for data write complete on card before sleeping
            PWR_EnterSleepMode(PWR_Regulator_ON, PWR_SLEEPEntry_WFI);
      }else{
          PWR_EnterSleepMode(PWR_Regulator_ON, PWR_SLEEPEntry_WFI);
      }
      #endif
      //debug_printf("\n");
     // printf("W\n");
    }

    if (timeout==0){
      return 0;
    }
  
    memcpy(RegisterValue, &MPU_DMA, BurstLength);
  }
  return 1;
  
}

void EXTI9_5_IRQHandler(void)
{
  
  //static uint8_t MPUReadResult;

  if(EXTI_GetITStatus(EXTI_Line5) != RESET)
  {
    // Special case: if we are in lowpower (off) mode, manually debounce the button
    if (Power_IsInStopMode()/* || Power_GetState()==POWER_STATE_LOWBAT*/){


      // Manual debouncing
      msWait(PUSH_BUTTON_DEBOUNCE_TICK_LOWPOW);
      if (PushButton_GetPinState(&PowerButton)){
        EXTI_ClearITPendingBit(EXTI_Line5);
        return; // False reading
      }

      Buzzer_Start(100);
      
      led(LED_RED, true, HIGH_PRIORITY);
      msWait(50);
      led(LED_RED, false, HIGH_PRIORITY);

      update_timestampRTC();
      if (PowerButton.FirstActivationTimeStamp + 3 < timestamp){
        PowerButton.FirstActivationTimeStamp = timestamp;
        PowerButton.NbrOfPress = 0;
      }
      PowerButton.NbrOfPress++;
      //PushButton_UpdateState(&PowerButton);
      PowerButton.State = ACTIVE;
      PushButton_PowerButtonUpdateAction();
      EXTI_ClearITPendingBit(EXTI_Line5);
      return;
    }

    PushButton_UpdateState(&PowerButton);
/*
    if (PushButton_GetState(&PowerButton) == ACTIVE){
      PushButton_Reset(&PowerButton);
      __disable_irq();
      SysTick_DelayDownCounter = 5000;
      __enable_irq();
      //PowerDown_NbrOfPress++;
      PowerButton.NbrOfPress++;
      Buzzer_Start(20);
    }*/

    if (!isModuleOnline(MODULE_ACC) && !isModuleOnline(MODULE_GYRO)){
      EXTI_ClearITPendingBit(EXTI_Line5);
      return;
    }
    
    //MPUReadResult = 
    MPUCompass_StartReadMPUData();

    /*if(MPUReadResult == 0){
      AccelX_1s[MPU_BufWrPtr][MPU_SampleNumber] = 0xFFFF;
      AccelY_1s[MPU_BufWrPtr][MPU_SampleNumber] = 0xFFFF;
      AccelZ_1s[MPU_BufWrPtr][MPU_SampleNumber] = 0xFFFF;
      
      GyroX_1s[MPU_BufWrPtr][MPU_SampleNumber] = 0xFFFF;
      GyroY_1s[MPU_BufWrPtr][MPU_SampleNumber] = 0xFFFF;
      GyroZ_1s[MPU_BufWrPtr][MPU_SampleNumber] = 0xFFFF;
    } */
    
  /* Clear interrupt pending bit */
    EXTI_ClearITPendingBit(EXTI_Line5);
  }
  
}

void I2C1_EV_IRQHandler(void)
{
  //static uint8_t DataIndex=0;

  if(MPUCompass_I2CState == MPUCOMPASS_I2C_WRITING)
  {
    switch(MPUCompass_I2CWrState)
    {
      case MPUCOMPASS_I2CWR_START :
        /* ----- Event EV5 ------ */
        
        // Waiting for SB, MSL and BUSY flags (SB could interrupt the CPU)
       if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_MODE_SELECT) == SUCCESS)
        {
          // Send address for write
          I2C_Send7bitAddress(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_WriteStructure.I2CAddress, I2C_Direction_Transmitter);
          MPUCompass_I2CWrState = MPUCOMPASS_I2CWR_ICADDR_1;
        }
        break;
        
      case MPUCOMPASS_I2CWR_ICADDR_1 :
        /* ----- Event EV6 ------ */
        
        // Waiting for BUSY, MSL, ADDR, TXE and TRA flags (ADDR, and TXE could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == SUCCESS)
        {
          MPUCompass_I2CWrState = MPUCOMPASS_I2CWR_ICADDR_2;
        }
        break;
        
      case MPUCOMPASS_I2CWR_ICADDR_2 :
        /* ----- Event EV8_1 ------ */
        
        // Waiting for TRA, BUSY, MSL, TXE flags (TXE could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_BYTE_TRANSMITTING) == SUCCESS)
        {
          // Writting register address to the MPU
          I2C_SendData(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_WriteStructure.RegisterAddress);
          MPUCompass_I2CWrState = MPUCOMPASS_I2CWR_REGADDR;
        }
        break;
        
      case MPUCOMPASS_I2CWR_REGADDR :
        /* ----- Event EV8 ------ */
        
        // Waiting for TRA, BUSY, MSL, TXE flags (TXE could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_BYTE_TRANSMITTING) == SUCCESS)
        {
          // Writing register Value to the MPU      
            I2C_SendData(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_WriteStructure.RegisterValue);
            MPUCompass_I2CWrState = MPUCOMPASS_I2CWR_REGVAL;
        }
       break;
        
      case MPUCOMPASS_I2CWR_REGVAL :
       /* ----- Event EV8_2 ------ */
        
        // Waiting for TRA, BUSY, MSL, TXE and BTF flags (TXE and BTF could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_BYTE_TRANSMITTED) == SUCCESS)
        {
          // Generating STOP condition
          I2C_GenerateSTOP(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);

          // Disabling I2C interrupt
          I2C_ITConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_IT_BUF | I2C_IT_EVT, DISABLE);

          MPUCompass_I2CState = MPUCOMPASS_I2C_IDLE;
        }
        break;
        
      default:
        break;
    }
    
  }
  else if(MPUCompass_I2CState == MPUCOMPASS_I2C_READING)
  {
    switch(MPUCompass_I2CRdState)
    {
      case MPUCOMPASS_I2CRD_START :
       /* ----- Event EV5 ------ */
        
        // Waiting for SB, MSL and BUSY flags (SB could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_MODE_SELECT) == SUCCESS)
        {
          // Send I2C address for write
          I2C_Send7bitAddress(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_ReadStructure.I2CAddress, I2C_Direction_Transmitter);
          MPUCompass_I2CRdState = MPUCOMPASS_I2CRD_ICADDR_1;
        }
        break;

      case MPUCOMPASS_I2CRD_ICADDR_1 :
        /* ----- Event EV6 ------ */
        
        // Waiting for BUSY, MSL, ADDR, TXE and TRA flags (ADDR and TXE could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED) == SUCCESS)
        {
          MPUCompass_I2CRdState = MPUCOMPASS_I2CRD_ICADDR_2;
        }
        break;

      case MPUCOMPASS_I2CRD_ICADDR_2 :
        /* ----- Event EV8_1 ------ */
        
        // Waiting for TRA, BUSY, MSL, TXE flags (TXE could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_BYTE_TRANSMITTING) == SUCCESS)
        {
          // Writting register address to the MPU
          I2C_SendData(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_ReadStructure.RegisterAddress);
                    
          // Generating ReSTART condition
          I2C_GenerateSTART(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);

          MPUCompass_I2CRdState = MPUCOMPASS_I2CRD_REGADDR;
        }
        break;
        
      case MPUCOMPASS_I2CRD_REGADDR :
        /* ----- Event EV5 ------ */
        
        // Waiting for SB, MSL and BUSY flags (SB could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_MODE_SELECT) == SUCCESS)
        {
          
          // Disabling I2C interrupt
         // I2C_ITConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_IT_BUF | I2C_IT_EVT, DISABLE);

          // Send I2C address for read
          I2C_Send7bitAddress(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_ReadStructure.I2CAddress, I2C_Direction_Receiver);
          
          MPUCompass_I2CRdState = MPUCOMPASS_I2CRD_RESTART;

        }
        break;
        
      case MPUCOMPASS_I2CRD_RESTART :
        //----- Event EV6 ------ 
        
        // Waiting for BUSY, MSL and ADDR flags (ADDR could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) == SUCCESS)
        {
          //DataIndex = 0;
          if(I2C_ReadStructure.BurstLength > 1)
          {
            //MANAGED WITH DMA
            // Enabling receive ack to generate ACK after next received byte
            I2C_AcknowledgeConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);
            
          }
          else
          {
            // Disabling receive ack to generate NoACK after next received byte
            I2C_AcknowledgeConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, DISABLE);
            
            // Enabling STOP condition generation
            //I2C_GenerateSTOP(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);
          }
          MPUCompass_I2CRdState = MPUCOMPASS_I2CRD_DATA;
          
          I2C_ITConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_IT_BUF | I2C_IT_EVT, DISABLE);
        }
        break;
     
      /*case MPUCOMPASS_I2CRD_DATA :
        // ----- Event EV7_1 ------
        
        // Waiting for BUSY, MSL and RXNE flags (RXNE could interrupt the CPU)
        if(I2C_CheckEvent(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_EVENT_MASTER_BYTE_RECEIVED) == SUCCESS)
        {
          // Reading received data byte (MSB)
          I2C_ReadStructure.RegisterValue[DataIndex] = I2C_ReceiveData(I2C_MPUCOMPASS_PERIPHERAL_ID);
          
          DataIndex++;
          if(DataIndex == I2C_ReadStructure.BurstLength - 1)
          {
            // Disabling receive ack to generate NoACK after next received byte
            I2C_AcknowledgeConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, DISABLE);
            
            // Enabling STOP condition generation
            I2C_GenerateSTOP(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);
          }
          else if(DataIndex == I2C_ReadStructure.BurstLength)
          {
            // Disabling I2C interrupt
            I2C_ITConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, I2C_IT_BUF | I2C_IT_EVT, DISABLE);

            MPUCompass_I2CState = MPUCOMPASS_I2C_IDLE;
          }
        }
        break;*/

      default:
        break;
    }
  }
  else
  {
    //printf("X");
  }
  
}

void TIM10_IRQHandler(void)
{
  //static int16_t MagnetoXYZData[3];
 // static uint8_t MagnetoReadResult;
  uint16_t timeout = 0xFFFF;

  if(TIM_GetITStatus(TIM10, TIM_IT_Update) == SET)
  {
    TIM_ClearFlag(TIM10, TIM_FLAG_Update);
    TIM_ClearITPendingBit(TIM10, TIM_IT_Update);
    
    while (I2C_GetFlagStatus(I2C_MPUCOMPASS_PERIPHERAL_ID,I2C_FLAG_BUSY)==SET && (--timeout)>0);

    if (timeout>0){
      //MPUCompass_StartReadMagnetoData();
      MPUCompass_CompassInitiateSingleMeasure();
      MPUCompass_WaitDataReady();
    
        }
    }
  

  if(TIM_GetITStatus(TIM10, TIM_IT_CC1) == SET)
  {
    TIM_ClearFlag(TIM10, TIM_FLAG_CC1);
    TIM_ClearITPendingBit(TIM10, TIM_IT_CC1);
  }
 
}

void DMA1_Channel7_IRQHandler(void){

  // Disabling receive ack to generate NoACK after next received byte
  //I2C_AcknowledgeConfig(I2C_MPUCOMPASS_PERIPHERAL_ID, DISABLE);
  
  // Enabling STOP condition generation
  I2C_GenerateSTOP(I2C_MPUCOMPASS_PERIPHERAL_ID, ENABLE);

  MPUCompass_I2CState = MPUCOMPASS_I2C_IDLE;
  //DMA
  DMA_ITConfig(DMA1_Channel7, DMA_IT_TC, false);

  // Disable DMA Channel
  DMA_Cmd(DMA1_Channel7, DISABLE);
  I2C_DMACmd(I2C_MPUCOMPASS_PERIPHERAL_ID, DISABLE);
  I2C_DMALastTransferCmd(I2C_MPUCOMPASS_PERIPHERAL_ID, false);

  // Check if we need to do something with the data

  // ACCELERO / GYRO
  if(I2C_ReadStructure.RegisterAddress==MPU_REG__ACCEL_XOUT_H){ //MPU Data

    AccelX_1s[MPU_BufWrPtr][MPU_SampleNumber] = ((int16_t)(MPU_DMA[0]) << 8) | MPU_DMA[1];
    AccelY_1s[MPU_BufWrPtr][MPU_SampleNumber] = ((int16_t)(MPU_DMA[2]) << 8) | MPU_DMA[3];
    AccelZ_1s[MPU_BufWrPtr][MPU_SampleNumber] = ((int16_t)(MPU_DMA[4]) << 8) | MPU_DMA[5];
    
    GyroX_1s[MPU_BufWrPtr][MPU_SampleNumber] = ((int16_t)(MPU_DMA[8]) << 8) | MPU_DMA[9];
    GyroY_1s[MPU_BufWrPtr][MPU_SampleNumber] = ((int16_t)(MPU_DMA[10]) << 8) | MPU_DMA[11];
    GyroZ_1s[MPU_BufWrPtr][MPU_SampleNumber] = ((int16_t)(MPU_DMA[12]) << 8) | MPU_DMA[13];
        
    MPU_SampleNumber++;

    MPU_NewValue = true;
    //GyroNewValue = true;

    //led_toggle(LED_RED);

    if(MPU_SampleNumber >= MPUCompass_SamplingFrequency)
    {
      MPU_SampleNumber = 0;
      //MPU_BufferReady[MPU_BufWrPtr] = true;
      //Gyro_BufferReady[MPU_BufWrPtr] = true;
     
      MPU_BufWrPtr++;
      if(MPU_BufWrPtr > 1)
        MPU_BufWrPtr = 0;

    }
  }

  // MAGNETO
  if (I2C_ReadStructure.RegisterAddress==COMPASS_REG__STATUS){
    //Data ready signal
    //if ((MPU_DMA[0]&0x03)==3 || MPU_DMA[0]==0x11 ){ // Status register: ready and locked
    if ((MPU_DMA[0]&0x01)==1){ // Status register: ready and locked
      DMA_ClearITPendingBit(DMA1_IT_TC7);
      MPUCompass_RdRegister(I2C_COMPASS_WR_ADDR, COMPASS_REG__DATA_X_MSB, NULL, 6);  //Data is ready, read!
      return;
      }
    else{
      MPUCompass_WaitDataReady();
    }
  }
  if (I2C_ReadStructure.RegisterAddress==COMPASS_REG__DATA_X_MSB){

      MagnetoX_1s[Compass_BufWrPtr][Compass_SampleNumber] = ((int16_t)(MPU_DMA[0]) << 8) | MPU_DMA[1];
      MagnetoZ_1s[Compass_BufWrPtr][Compass_SampleNumber] = ((int16_t)(MPU_DMA[2]) << 8) | MPU_DMA[3];
      MagnetoY_1s[Compass_BufWrPtr][Compass_SampleNumber] = ((int16_t)(MPU_DMA[4]) << 8) | MPU_DMA[5];
            
      Compass_SampleNumber++;
      Mag_NewValue = true;
      if(Compass_SampleNumber == MPUCompass_SamplingFrequency)
      {
        Compass_SampleNumber = 0;
        //Compass_BufferReady[Compass_BufWrPtr] = true;
        Compass_BufWrPtr++;
        if(Compass_BufWrPtr > 1)
          Compass_BufWrPtr = 0;
      }
   }
  
   DMA_ClearITPendingBit(DMA1_IT_TC7);

}
