//******************************************************************************
//  WIMUuSD - ADC Module
//
//  Description:
//
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 20th, 2012
//
//  Modifications:
//
//******************************************************************************

/* Includes ------------------------------------------------------------------*/
#include "battery.h"
#include "power.h"
#include "stm32l1xx_dma.h"
#include <string.h> // For memset

/* Global variables ----------------------------------------------------------*/
//BatteryMonitoringState_TypeDef BatMonitoring_State = BATTERY_MONITORING;

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
ADC_InitTypeDef ADC_InitStruct =
{
  ADC_Resolution_12b,                 // ADC_Resolution
  ENABLE,                            // ADC_ScanConvMode
  ENABLE,                            // ADC_ContinuousConvMode
  ADC_ExternalTrigConvEdge_None,      // ADC_ExternalTrigConvEdge
  ADC_ExternalTrigConv_T9_TRGO,       // ADC_ExternalTrigConv
  ADC_DataAlign_Right,                // ADC_DataAlign
  2                                   // ADC_NbrOfConversion
};

ADC_CommonInitTypeDef ADC_CommonInitStruct =
{
  ADC_Prescaler_Div1  // ADC_Prescaler
};

//uint16_t BatteryADC_Buffer[10] = {0,0,0,0,0,0,0,0,0,0}; // Keep last 10 samples
//uint8_t Battery_Buffer_Ptr=0;

uint32_t  BatteryTemp_ADC[2]; // Battery and temperature buffer for DMA transfers

/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Exported functions --------------------------------------------------------*/
void BatteryMonitoring_Config(void)
{
  BatteryMonitoring_Stop();
  BatteryTemp_ADC[0] = 0;
  BatteryTemp_ADC[1] = 0;

  DMA_InitTypeDef DMA_InitStructure;

  /* -------- Starting HSI clock -------- */
  RCC_HSICmd(ENABLE);
  while(RCC_GetFlagStatus(RCC_FLAG_HSIRDY) == RESET);
  
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_ADC1, ENABLE);

  // Enable temperature reading
  ADC_TempSensorVrefintCmd(ENABLE);
  
  /* ---------- Configuring ADC ---------- */

  // DMA config

   /* Enable DMA1 clock */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_DMA1, ENABLE);

  /* De-initialise  DMA */
  DMA_DeInit(DMA1_Channel1);
  
  /* DMA1 channel1 configuration */
  DMA_StructInit(&DMA_InitStructure);
  DMA_InitStructure.DMA_PeripheralBaseAddr = (uint32_t)&(ADC1->DR);	     // Set DMA channel Peripheral base address to ADC Data register
  DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t)&BatteryTemp_ADC[0];      // Set DMA channel Memeory base addr to ADC buffer address
  DMA_InitStructure.DMA_DIR = DMA_DIR_PeripheralSRC;                         // Set DMA channel direction to peripheral to memory
  DMA_InitStructure.DMA_BufferSize = 2;                                      // Set DMA channel buffersize to peripheral to ADC_CONV_BUFF_SIZE
  DMA_InitStructure.DMA_PeripheralInc = DMA_PeripheralInc_Disable;	     // Disable DMA channel Peripheral address auto increment
  DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Enable;                    // Enable Memory increment
  DMA_InitStructure.DMA_PeripheralDataSize = DMA_PeripheralDataSize_Word;    // set Peripheral data size to 8bit 
  DMA_InitStructure.DMA_MemoryDataSize = DMA_MemoryDataSize_Word;	     // set Memeory data size to 8bit 
  DMA_InitStructure.DMA_Mode = DMA_Mode_Circular;                              // Set DMA in normal mode
  DMA_InitStructure.DMA_Priority = DMA_Priority_High;	                     // Set DMA channel priority to High
  DMA_InitStructure.DMA_M2M = DMA_M2M_Disable;                               // Disable memory to memory option 
  DMA_Init(DMA1_Channel1, &DMA_InitStructure);                               // Use Init structure to initialise channel1 (channel linked to ADC)

  DMA_Cmd(DMA1_Channel1, ENABLE); // Enable DMA transfer

// Configuring ADC prescaler, resolution and data alignment
  ADC_CommonInit(&ADC_CommonInitStruct);
  ADC_Init(ADC1, &ADC_InitStruct);
  
  // Setting ADC auto power down (This must be done only when ADON = 0 (ADC power down))
  ADC_PowerDownCmd(ADC1, ADC_PowerDown_Idle, ENABLE);

  // Configuring the sampling time (This must be done only when ADON = 0 (ADC power down))
  ADC_RegularChannelConfig(ADC1, ADC_Channel_1, 1, ADC_SampleTime_384Cycles);
  ADC_RegularChannelConfig(ADC1, ADC_Channel_TempSensor, 2, ADC_SampleTime_384Cycles); //Temperature sensor
  
  // Enabling EOC bit setting at end of conversion
  //ADC_EOCOnEachRegularChannelCmd(ADC1, ENABLE);
  
  // Clearing EOC flag
  ADC_ClearFlag(ADC1, ADC_FLAG_EOC);

  // Enable DMA transfer on ADC after each conversion
  ADC_DMACmd(ADC1, ENABLE);
  ADC_DMARequestAfterLastTransferCmd(ADC1, ENABLE);

  // Enabling ADC (Set ADON bit in CR2 register)
  ADC_Cmd(ADC1, ENABLE);

  // Starting ADC conversion
  ADC_SoftwareStartConv(ADC1);

}

void BatteryMonitoring_Stop(){
  // Disabling ADC (Clear ADON bit in CR2 register)
  ADC_Cmd(ADC1, DISABLE);
  DMA_DeInit(DMA1_Channel1);
  ADC_DeInit(ADC1);

  // Disable temperature reading
  ADC_TempSensorVrefintCmd(DISABLE);

  // Clear and reset buffers
  BatteryTemp_ADC[0] = 0;
  BatteryTemp_ADC[1] = 0;

  //memset(&BatteryADC_Buffer,0,10);
  //Battery_Buffer_Ptr = 0;
  //Battery_ADCValue = 0;

}

uint16_t  BatteryMonitoring_GetBatteryADCValue(){
  return (uint16_t)BatteryTemp_ADC[0];
}

uint16_t  BatteryMonitoring_GetTempADCValue(){
  return (uint16_t)BatteryTemp_ADC[1];
}

/*
uint8_t BatteryMonitoring_RdADC(uint16_t * ADCValue)
{
  uint8_t i;
  // Validating that HSI clock is stable
  if(RCC_GetFlagStatus(RCC_FLAG_HSIRDY) == RESET)
  {
    return 0;
  }
  
  // Validating that the ADC is ready to start a conversion (ADSONS = 1 and RCNR = 0)
  if(ADC_GetFlagStatus(ADC1, ADC_FLAG_ADONS) == SET && ADC_GetFlagStatus(ADC1, ADC_FLAG_RCNR) == RESET)
  {
    // Set channel
    ADC_RegularChannelConfig(ADC1, ADC_Channel_1, 1, ADC_SampleTime_4Cycles);

   // Starting ADC conversion
    ADC_SoftwareStartConv(ADC1);
  
    // Wait for conversion completion
    while(ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == RESET);
  
    // Clearing EOC flag
    ADC_ClearFlag(ADC1, ADC_FLAG_EOC);
  
    BatteryADC_Buffer[Battery_Buffer_Ptr++] = (uint16_t)(ADC_GetConversionValue(ADC1));
    
    if (Battery_Buffer_Ptr>=10)
      Battery_Buffer_Ptr = 0;

    while (BatteryADC_Buffer[9]==0){  // Fill buffer with samples, if needed
      // Starting ADC conversion
      ADC_SoftwareStartConv(ADC1);
    
      // Wait for conversion completion
      while(ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == RESET);
    
      // Clearing EOC flag
      ADC_ClearFlag(ADC1, ADC_FLAG_EOC);
    
      BatteryADC_Buffer[Battery_Buffer_Ptr++] = (uint16_t)(ADC_GetConversionValue(ADC1));
      
      if (Battery_Buffer_Ptr>=10)
        Battery_Buffer_Ptr = 0;
    }
   
    // Return max over the period
    *ADCValue=BatteryADC_Buffer[0];
    for (i=1; i<10; i++){
      if (BatteryADC_Buffer[i]>*ADCValue)
        *ADCValue = BatteryADC_Buffer[i];
    }  
    
    return 1;
  }
  else
  {
    return 0;
  }
  
}

uint8_t TempMonitoring_RdADC(uint16_t* ADCValue){


    // Validating that HSI clock is stable
    if(RCC_GetFlagStatus(RCC_FLAG_HSIRDY) == RESET)
    {
      return 0;
    }
  
    // Validating that the ADC is ready to start a conversion (ADSONS = 1 and RCNR = 0)
    if(ADC_GetFlagStatus(ADC1, ADC_FLAG_ADONS) == SET && ADC_GetFlagStatus(ADC1, ADC_FLAG_RCNR) == RESET)
    {
      // Set channel
      ADC_RegularChannelConfig(ADC1, ADC_Channel_TempSensor, 1, ADC_SampleTime_384Cycles); //Temperature sensor

      // Starting ADC conversion
      ADC_SoftwareStartConv(ADC1);
    
      // Wait for conversion completion
      while(ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == RESET);
    
      // Clearing EOC flag
      ADC_ClearFlag(ADC1, ADC_FLAG_EOC);
    
      *ADCValue = (uint16_t)(ADC_GetConversionValue(ADC1));
    
      return 1;
    }
    else
    {
      return 0;
    }
}*/

/* Private functions ---------------------------------------------------------*/
