#ifndef UTILS_H_
#define UTILS_H_

#include "config.h"
#include "stm32l1xx_gpio.h"
#include "stm32l1xx_rcc.h"
#include "stm32l1xx_tim.h"
#include "stm32l1xx_rtc.h"

//------------------------
// Constants Define
//------------------------
#define ERROR_RESET_TIME	30	// Number of seconds to reset the device if in error state, -1 = no reset.
#define ERROR_DATALOG_BLINK	 1	// Number of seconds to blink to LED on Datalogger error

#define ABS(a)	   (((a) < 0) ? -(a) : (a))

typedef enum
{
 LED_RED,
 LED_GREEN,
 LED_BLUE
} LED_Color;

typedef enum
{
  NO_PRIORITY,
  LOW_PRIORITY,
  MEDIUM_PRIORITY,
  HIGH_PRIORITY
} Priority_TypeDef;

typedef struct
{
  bool on;
  bool blinking;
  uint16_t on_time;
  uint16_t off_time;
  Priority_TypeDef priority;
} LEDState_TypeDef;


typedef enum{
  ERROR_NONE=0,
  ERROR_INIT,
  ERROR_COM,
  ERROR_ID,
  ERROR_POWER,
  ERROR_BUFFER,
  ERROR_UNMANAGED,
  ERROR_FORMAT,
  ERROR_CRC
}Error_TypeDef;

//typedef enum { INACTIVE, DEBOUNCING } PushButton_DebouncingState_TypeDef;


// LED
extern uint8_t UpdateLedStatus;

// Buzzer
typedef enum {BUZZER_ON, BUZZER_OFF} BuzzerState_TypeDef;
extern BuzzerState_TypeDef Buzzer_State;

#define BUZZER_NOTE_A         2273  // 440 Hz
#define BUZZER_NOTE_B         2024  // 494 Hz
#define BUZZER_NOTE_C         1912  // 523 Hz
#define BUZZER_NOTE_D         1704  // 587 Hz
#define BUZZER_NOTE_E         1517  // 659 Hz
#define BUZZER_NOTE_F         1431  // 699 Hz
#define BUZZER_NOTE_G         1276  // 784 Hz
#define BUZZER_DEFAULT_TONE   2857

//------------------------
// Functions Define
//------------------------

void LedAndBuzzer_Config(bool low_power);
void ChangeLEDState(void);
void Led_Config(void);

void Buzzer_Config(void);
void Buzzer_Start(uint16_t time_ms);
void Buzzer_Stop(void);
void Buzzer_SetFrequency(uint16_t f);
void Buzzer_PlayStartSong();
void Buzzer_PlayStopSong();

void Wait_TimerConfig(void);
void usWait(uint16_t SleepTime);
void msWait(uint16_t SleepTime);

void led(LED_Color led, bool state, Priority_TypeDef priority);
void led_toggle(LED_Color led, Priority_TypeDef priority);
bool led_get_state(LED_Color led);
void led_start_blink(LED_Color led, uint16_t on_time, uint16_t off_time, Priority_TypeDef priority);
void led_stop_blink(LED_Color led);
void led_restore_state();



//void led_alive_start();
//void led_alive_stop();

//
void error(unsigned char module, unsigned char code);
//
//void itoa(int n, char s[]);
//void reverse(char s[]);
//
//unsigned long time_count (bool start);
//float f_time_count (bool start);
//
//unsigned long get_count(void);
//
void update_RTCtime(uint16_t year, uint8_t month, uint8_t day, uint8_t hour, uint8_t min, uint8_t sec, bool apply_tz);
void update_timestampRTC();
void update_RTCtimeFromTimestamp(uint64_t ts);


ModuleStates getModuleState(InternalModules_ID module);
void setModuleState(InternalModules_ID module, ModuleStates state);
bool isModuleOnline(InternalModules_ID module);

uint32_t NumberOfSetBits(uint32_t i);

#endif /*UTILS_H_*/
