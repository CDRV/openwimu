#ifndef MAIN_H_
#define MAIN_H_

#include "ff.h"
#include "Storage.h"

#include "RTC.h"

#include "USART_driver.h"
#include "SPI_driver.h"
#include "I2C_driver.h"
#include "MPUCompass_driver.h"
#include "GPS_Driver.h"
#include "FIFO.h"

#include "utils.h"
#include "battery.h"
#include "flash.h"
#include "gps.h"
#include "datalogger.h"
#include "usb.h"
#include "ble.h"
#include "power.h"
#include "imu.h"
#include "buttons.h"

#include "config.h"
//#include "Merged__h_config.h" 
#include "platform_config.h"

//------------------------
// Constants Define
//------------------------
//#define DEBUG_CONSOLE 1

#define TIMESTAMPING_BUTTON_ACTIVATIONTICK 1000 // Number of SysTick required for timestamping validation (1 second = 1000 SysTick)

//------------------------
// Structure Define
//------------------------

//------------------------
// Functions Define
//------------------------
#ifdef DEBUG_CONSOLE
//void DebugConsole_Init(void);
//int __putchar (int ch);
#endif

void USB_ModeSelection(void);
uint8_t PushButton_TimestampDetection(void);
uint8_t PushButton_PowerDownDetection(void);

// Init
bool Main_Init(void);
bool Main_StartModules(void);
void Main_Start();
void Main_Shutdown(InternalModules_ID int_mod);
void Main_PowerdownAll();

// Mains
//void main_acc(void);
void main_ble(void);
void main_buttons(void);
void main_datalogger(void);
void main_gps(void);
//void main_gyro(void);
void main_imu(void);
void main_magneto(void);
void main_mpu(void);
void main_power(void);
void main_usb(void);

// Managers
void manage_resets();

//------------------------
// Variables Define
//------------------------

#endif /*MAIN_H_*/
