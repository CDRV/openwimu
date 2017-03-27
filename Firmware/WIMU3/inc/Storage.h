/**
  ******************************************************************************
  * @file    Storage.h
  *
  ******************************************************************************
  */


/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STORAGE_H
#define __STORAGE_H

/* Includes ------------------------------------------------------------------*/
#include "ff.h"
#include "stm32l152_eval.h"
//#include "stm32l152_eval_lcd.h"
//#include "stm32l152_eval_glass_lcd.h"
#include "stm32l152_eval_spi_sd.h"
//#include "stm32l152_eval_i2c_tsensor.h"
#include "ff.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
//#include "usb_lib.h"
//#include "usb_pwr.h"
#include <stdarg.h>

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
#define MAX_FILES 25

/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */

uint32_t Storage_Init(void);
uint32_t Storage_CreateFile(FIL * F, const char* FileName, char * FileNameWithNumAndExtension);



#endif /* __MS__MASS_MAL_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
