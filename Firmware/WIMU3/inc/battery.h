
/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef BATTERY_H_
#define BATTERY_H_

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx_adc.h"
#include "stm32l1xx_rcc.h"

/* Exported types ------------------------------------------------------------*/
/*typedef enum
{
  BATTERY_MONITORING,
  BATTERY_NOT_MONITORING
} BatteryMonitoringState_TypeDef;*/

/* Exported constants --------------------------------------------------------*/

/* Exported macro ------------------------------------------------------------*/

// Setting low battery treshold :
//  ADC in = Battery_Volt/2 (resistive on board voltage divider)
//  Treshold_Volt/2 = 3,3/4096 LOWBAT_ADC_TRESHOLD
//   <--> LOWBAT_ADC_TRESHOLD = Treshold_Volt/2 * 4096/3,3
//  When Treshold_Volt = 3,5V, LOWBAT_ADC_TRESHOLD = 2172 (0x087C)

// Experimental measurement
// 2285 = 3.7 V
// 2220 = 3.6 V
// 2150 = 3.5 V
#define LOWBAT_ADC_THRESHOLD 2100
//#define LOWBAT_ADC_THRESHOLD 543

/* Exported functions ------------------------------------------------------- */
void BatteryMonitoring_Config(void);
void BatteryMonitoring_Stop();
uint16_t  BatteryMonitoring_GetBatteryADCValue();
uint16_t  BatteryMonitoring_GetTempADCValue();
//uint8_t BatteryMonitoring_RdADC(uint16_t * ADCValue);
//uint8_t TempMonitoring_RdADC(uint16_t * ADCValue);

#endif /*BATTERY_H_*/
