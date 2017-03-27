/**
  ******************************************************************************
  * @file    mass_mal.c
  * @author  MCD Application Team
  * @version V3.4.0
  * @date    29-June-2012
  * @brief   Medium Access Layer interface
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2012 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */


/* Includes ------------------------------------------------------------------*/
#include "platform_config.h"
#include "MS__mass_mal.h"
#include <stdio.h>
#include "config.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
uint32_t Mass_Memory_Size[2];
uint32_t Mass_Block_Size[2];
uint32_t Mass_Block_Count[2];
__IO uint32_t Status = 0;



#ifdef SDHC
extern uint8_t flag_SDHC;
#endif

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/*******************************************************************************
* Function Name  : MAL_Init
* Description    : Initializes the Media on the STM32
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
uint16_t MAL_Init(uint8_t lun)
{
  #ifdef SHOW_DEBUG_PRINTF
  printf("Entering MAL_Init()\n");
  #endif

  uint16_t status = MAL_OK;

  switch (lun)
  {
    case 0:
        Status = SD_Init();
      break;
    default:
      return MAL_FAIL;
  }
  return status;
}
/*******************************************************************************
* Function Name  : MAL_Write
* Description    : Write sectors
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
uint16_t MAL_Write(uint8_t lun, uint64_t Memory_Offset, uint32_t *Writebuff, uint16_t Transfer_Length)
{
  switch (lun)
  {
    case 0:
    Status = SD_WriteMultiBlocks((uint8_t*)Writebuff, Memory_Offset, Transfer_Length,1);
      break;
    default:
      return MAL_FAIL;
  }
  return MAL_OK;
}

/*******************************************************************************
* Function Name  : MAL_Read
* Description    : Read sectors
* Input          : None
* Output         : None
* Return         : Buffer pointer
*******************************************************************************/
uint16_t MAL_Read(uint8_t lun, uint64_t Memory_Offset, uint32_t *Readbuff, uint16_t Transfer_Length)
{
  switch (lun)
  {
    case 0:

      SD_ReadMultiBlocks((uint8_t*)Readbuff, Memory_Offset, Transfer_Length, 1);
      break;
    default:
      return MAL_FAIL;
  }
  return MAL_OK;
}

/*******************************************************************************
* Function Name  : MAL_GetStatus
* Description    : Get status
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
uint16_t MAL_GetStatus (uint8_t lun)
{
  #ifdef SHOW_DEBUG_PRINTF
  printf("Entering MAL_GetStatus()\n");
  #endif

  SD_CSD SD_csd;
  uint32_t DeviceSizeMul = 0;


  if (lun == 0)
  {
    SD_GetCSDRegister(&SD_csd);
#ifdef SDHC
    if(flag_SDHC ==1)
    {
      Mass_Block_Count[0] = ((uint32_t)(SD_csd.DeviceSize + 1))*1024 ;
      Mass_Block_Size[0] =  512;
      Mass_Memory_Size[0] = Mass_Block_Count[0]*Mass_Block_Size[0];
    }
    else
#endif //SDHC
    {
      uint32_t temp_block_mul = 0;
      DeviceSizeMul = SD_csd.DeviceSizeMul + 2;
      temp_block_mul = (1 << SD_csd.RdBlockLen)/ 512;
      Mass_Block_Count[0] = ((SD_csd.DeviceSize + 1) * (1 << (DeviceSizeMul))) * temp_block_mul;
      Mass_Block_Size[0] =  512;
      
      Mass_Memory_Size[0] = (Mass_Block_Count[0] * Mass_Block_Size[0]);
    }

//	STM_EVAL_LEDOn(LED2);
	return MAL_OK;

  }
//  STM_EVAL_LEDOn(LED2);
  return MAL_FAIL;
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

