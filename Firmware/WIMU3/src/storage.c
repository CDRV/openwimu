/**
  ******************************************************************************
  * @file    storage.c
  * @author  MCD Application Team
  * @version V1.2.0
  * @date    24-January-2012
  * @brief   This file includes the Storage (FatFs) driver for the STM32L152-EVAL
  *          demo.
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * FOR MORE INFORMATION PLEASE READ CAREFULLY THE LICENSE AGREEMENT FILE
  * LOCATED IN THE ROOT DIRECTORY OF THIS FIRMWARE PACKAGE.
  *
  * <h2><center>&copy; COPYRIGHT 2012 STMicroelectronics</center></h2>
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
//#include "main.h"
#include "Storage.h"

/** @addtogroup STM32L152_EVAL_Demo
  * @{
  */

/** @defgroup STORAGE
  * @brief This file includes the Storage (FatFs) driver for the STM32L152-EVAL
  *        demo.
  * @{
  */

/** @defgroup STORAGE_Private_Types
  * @{
  */
/**
  * @}
  */

/** @defgroup STORAGE_Private_Defines
  * @{
  */
/**
  * @}
  */

/** @defgroup STORAGE_Private_Macros
  * @{
  */
/**
  * @}
  */

/** @defgroup STORAGE_Private_Variables
  * @{
  */
FATFS fs;
FILINFO fno;
DIR dir;
FIL F_LogFile;
UINT BytesWritten;
UINT BytesRead;
extern const uint8_t SlidesCheck[];
extern uint8_t Buffer1[];
/**
  * @}
  */


/** @defgroup STORAGE_Private_FunctionPrototypes
  * @{
  */
/**
  * @}
  */

/** @defgroup STORAGE_Private_Functions
  * @{
  */

/**
  * @brief  SDCARD Initialisation for FatFs
  * @param  None
  * @retval err : Error status (0=> success, 1=> fail)
  */
uint32_t Storage_Init(void)
{
  EXTI_InitTypeDef EXTI_InitStructure;

  SD_Init();

//  SYSCFG_EXTILineConfig(SD_DETECT_EXTI_PORT_SOURCE, SD_DETECT_EXTI_PIN_SOURCE);

  /*!< Configure the SD Card detect Pin as input with interrupt */
//  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
//  EXTI_InitStructure.EXTI_Line = SD_DETECT_EXTI_LINE;
//  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising;
//  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
//  EXTI_Init(&EXTI_InitStructure);

  /****************** FatFs Volume Acess ******************************/

  if (f_mount(0, &fs) == FR_INVALID_DRIVE)
  {
    return 1;
  }
  return 0;
}



/**
 * @brief  Create a file on SD
 * @param  FileName: the file name to create
 * @retval err : Error status (0=> success, 1=> fail)
 */
uint32_t Storage_CreateFile(FIL * F, const char* FileName, char * FileNameWithNumAndExtension)
{
	uint8_t FileName_Length = strlen(FileName);
	uint8_t FileName_HundredPos = FileName_Length;
	uint8_t FileName_TensPos = FileName_Length + 1;
	uint8_t FileName_UnitiesPos = FileName_Length + 2;
	char *s_FileName_NumberStart; 
	FRESULT res;		/* FatFs function common result code */
	
	// Create file "FileName000.txt" if no "FileNameXXX.txt" files exist.
	// Create "FileName(XXX+1).txt" if "FileNameXXX.txt" files exist
	strcpy(FileNameWithNumAndExtension, FileName);
	strcat(FileNameWithNumAndExtension,"000.txt");
	s_FileName_NumberStart = &FileNameWithNumAndExtension[FileName_Length];

	

	res = f_open (F, FileNameWithNumAndExtension, FA_CREATE_NEW);
	while(res == FR_EXIST || (res != FR_OK && res != FR_DISK_ERR && res != FR_NO_FILESYSTEM && res != FR_NOT_READY && res != FR_NOT_ENABLED && res != FR_INT_ERR && res != FR_DENIED))
	{
		if(strcmp(s_FileName_NumberStart,"999.txt") == 0)
		{
			printf("Error: Reach file %s",FileNameWithNumAndExtension);
		}
		else if (strcmp(s_FileName_NumberStart + 1,"99.txt") == 0)
		{
			FileNameWithNumAndExtension[FileName_HundredPos]++;
			FileNameWithNumAndExtension[FileName_TensPos] = '0';
			FileNameWithNumAndExtension[FileName_UnitiesPos] = '0';
		}
		else if (strcmp(s_FileName_NumberStart + 2,"9.txt") == 0)
		{
			FileNameWithNumAndExtension[FileName_TensPos]++;
			FileNameWithNumAndExtension[FileName_UnitiesPos] = '0';			
		}
		else
		{
			FileNameWithNumAndExtension[FileName_UnitiesPos]++;			
		}

		res = f_open (F, FileNameWithNumAndExtension, FA_CREATE_NEW);
	}
	
	
	return 0;
	
}


/**
  * @}
  */

/**
  * @}
  */

/**
  * @}
  */

/******************* (C) COPYRIGHT 2012 STMicroelectronics *****END OF FILE****/
