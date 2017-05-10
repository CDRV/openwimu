#ifndef POWER_H_
#define POWER_H_

#include "config.h"
#include "stm32l1xx.h"
#include "utils.h"
//#include "adc.h"

//------------------------
// Constants Define
//------------------------
//#define POWER_BUF_NUM			2					// Number of alimentation buffers
//#define POWER_TEMP_ADC			10					// Temperature sensor ADC channel
//#define POWER_VBATT_ADC			6					// VBatt ADC channel
//#define POWER_CURRENT_ADC		13					// Current Probe ADC channel

//Low Batt
//#define POWER_SLEEPIN_T		5					// Number of seconds required with a Vcc<3V required to
												// enter sleep mode
//#define POWER_LOWBAT_ADC_VAL	2752			// Threshold on the ADC reading to consider we have a low bat

//#define POWER_NOACT_ONTIME		240					// Number of seconds to enter sleep mode when there is no activity detected
//#define POWER_NOACT_OFFTIME	10					// Number of seconds with activity to exit sleep mode

//External Charger									
//#define POWER_CHARGEIN_T	1					// Number of seconds required to enter charge mode
//#define POWER_SLEEPOUT_T	2					// Number of seconds required to exit sleep mode
//#define POWER_CHARGE_LOGIC	0					// Signal level of the charge signal when charging, set to 0x02 when high
//#define POWER_CHARGE_ILOGIC	0x02				// Inverse logic

//USB Charger
//#define POWER_USB_CHARGEIN_T	10				// Number of seconds required to enter USB charge mode
#define POWER_USB_CHARGE_LOGIC	0   // Signal level of the charge signal when charging
#define POWER_USB_CHARGE_ILOGIC	1   // Inverse logic

//#ifdef POWER_OFF_USB
//	#define POWER_USB_CHECK()		(P8IN & BIT7) //(POWER_USB_CHARGE_ILOGIC)	//(P8IN & BIT7)
//#else
//	#define POWER_USB_CHECK()		0//(P8IN & BIT7) //(POWER_USB_CHARGE_ILOGIC)	//(P8IN & BIT7)
//#endif

#define POWER_GPS_TURNON		21600	// Time (in s.) after which the GPS needs to be turned on, when module is on charge.

typedef enum{
  POWER_STATE_ON,
  POWER_STATE_LOWBAT,
  POWER_STATE_USB,
  POWER_STATE_USB_MASS,
  POWER_STATE_USB_COM,
  POWER_STATE_OFF
}  PowerStates;
/*
#define POWER_STATE_ON                  0 // All systems go
#define POWER_STATE_LOWBAT		1 // Low battery mode
#define POWER_STATE_USB_ON		2 // On USB, all sensors ON
#define POWER_STATE_USB			3 // On USB, off.
#define POWER_STATE_OFF                 4 // Low-power mode (OFF)
#define POWER_STATE_ACTIVITY            5 // No power activity mode
*/

//------------------------
// Structure Define
//------------------------

typedef struct{
  uint8_t batteryValue;
}POWERFrame_Struct;

//------------------------
// Functions Define
//------------------------

Error_TypeDef Power_Init(void);
Error_TypeDef Power_Start(void);
//void          Power_StateCheck();
void          Power_Stop(void);
void          Power_Sleep(void);

bool          Power_IsBattLow();

bool          Power_IsInStopMode();

void          Power_StateDisplay(void);
//bool          Power_StateManage(void);  // Return true if we need to stop the module
bool          Power_StateUpdate();
bool          Power_IsStopRequired(PowerStates state);
bool          Power_IsStateUSBRelated(PowerStates state);
bool          Power_IsCharging();

//void          Power_SetState(PowerStates new_state);
PowerStates   Power_GetState();
PowerStates   Power_GetLastState();

uint8_t       Power_GetStateTime();
void          Power_ResetStateTime();
void          Power_SetStateTime(uint8_t new_time);
void          Power_UpdateStateTime();

void          ChargeStat_Config(void);
//uint8_t ChargeStat_StateChanged(uint8_t * NewState);
uint8_t       ChargeStat_GetState();
void          ChargeStat_Update();

void          Power_SetState(PowerStates new_state);

float         Battery_VFromADC(uint16_t batt);
float         Temp_FromADC(uint16_t temp);

//------------------------
// Variables Define
//------------------------
// Power Management
extern uint16_t Battery_ADCValue;
extern uint16_t Temp_ADCValue;
extern bool power_ready;
//extern unsigned long power_charge_t;


/*void ExtPwr_Config(void);
void ExtPwr_Enable(void);
void ExtPwr_Disable(void);*/



#endif /*POWER_H_*/
