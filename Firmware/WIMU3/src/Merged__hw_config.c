/**
  ******************************************************************************
  * @file    hw_config.c
  * @author  MCD Application Team
  * @version V3.4.0
  * @date    29-June-2012
  * @brief   Hardware Configuration & Setup
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

#include "Merged__hw_config.h"
#include "Merged__stm32_it.h"
#include "MS__mass_mal.h"
#include "MS__usb_desc.h"
#include "usb_pwr.h"
#include "usb_lib.h"
#include "usb.h"

#include "power.h"

#include "VC__usb_prop.h"
#include "VC__usb_desc.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
ErrorStatus HSEStartUpStatus;


uint8_t  USB_Tx_State = 0;

/* Extern variables ----------------------------------------------------------*/

//extern ProgramMode usb_mode;
extern LINE_CODING linecoding;

extern unsigned char usb_tx_rd_ptr; // Actual TX read index
extern unsigned char usb_tx_index;	 // Actual TX buffer index (write)
extern unsigned char usb_tx_queue;  // Actual number of unsent elements in TX

extern unsigned short usb_tx_len[USB_TX_BUF_NUM];


/* Private function prototypes -----------------------------------------------*/
static void IntToUnicode (uint32_t value , uint8_t *pbuf , uint8_t len);

/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : Set_System
* Description    : Configures Main system clocks & power and Interrupt priority group
* Input          : None.
* Return         : None.
*******************************************************************************/
void Set_System(void)
{
  /*!< At this stage the microcontroller clock setting is already configured, 
       this is done through SystemInit() function which is called from startup
       file (startup_stm32f10x_xx.s) before to branch to application main.
       To reconfigure the default setting of SystemInit() function, refer to
       system_stm32f10x.c file
     */ 
#if defined(USB_USE_EXTERNAL_PULLUP)
  GPIO_InitTypeDef  GPIO_InitStructure;
#endif /* USB_USE_EXTERNAL_PULLUP */
  
  /* Enable the SYSCFG module clock */
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_SYSCFG, ENABLE);  
  
//#if defined(USB_USE_EXTERNAL_PULLUP)
//  /* Enable the USB disconnect GPIO clock */
//  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIO_DISCONNECT, ENABLE);
//
//  /* USB_DISCONNECT used as USB pull-up */
//  GPIO_InitStructure.GPIO_Pin = USB_DISCONNECT_PIN;
//  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
//  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
//  GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;
//  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
//  GPIO_Init(USB_DISCONNECT, &GPIO_InitStructure);  
//#endif /* USB_USE_EXTERNAL_PULLUP */  
  
	// MS specific section
	if(usb_mode == MASS_STORAGE /*&& getModuleState(MODULE_DATALOGGER)!=STATE_DISABLED*/)
	{
	/* MAL configuration */
		MAL_Config();
	}
	// End of MS specific section
	  
}

/*******************************************************************************
* Function Name  : Set_USBClock
* Description    : Configures USB Clock input (48MHz)
* Input          : None.
* Return         : None.
*******************************************************************************/
void Set_USBClock(void)
{
  /* Enable USB clock */
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_USB, ENABLE);
}

/*******************************************************************************
* Function Name  : Enter_LowPowerMode
* Description    : Power-off system clocks and power while entering suspend mode
* Input          : None.
* Return         : None.
*******************************************************************************/
void Enter_LowPowerMode(void)
{
  /* Set the device state to suspend */
  bDeviceState = SUSPENDED;
}

/*******************************************************************************
* Function Name  : Leave_LowPowerMode
* Description    : Restores system clocks and power while exiting suspend mode
* Input          : None.
* Return         : None.
*******************************************************************************/
void Leave_LowPowerMode(void)
{
  DEVICE_INFO *pInfo = &Device_Info;

  /* Set the device state to the correct state */
  if (pInfo->Current_Configuration != 0)
  {
    /* Device configured */
    bDeviceState = CONFIGURED;
   // Power_StateUpdate();
  }
  else
  {
    bDeviceState = ATTACHED;
  }

}

/*******************************************************************************
* Function Name  : USB_Interrupts_Config
* Description    : Configures the USB interrupts
* Input          : None.
* Return         : None.
*******************************************************************************/
void USB_Interrupts_Config(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;

 // NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);

  NVIC_InitStructure.NVIC_IRQChannel = USB_LP_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
  
// MS specific section  
//#if defined(STM32L1XX_HD)|| defined(STM32L1XX_MD_PLUS) 
//  NVIC_InitStructure.NVIC_IRQChannel = SDIO_IRQn;
//  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
//  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
//  NVIC_Init(&NVIC_InitStructure);
//  NVIC_InitStructure.NVIC_IRQChannel = SD_SDIO_DMA_IRQn;
//  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
//  NVIC_Init(&NVIC_InitStructure);
//#endif 
// End of MS specific section
 
}


/*******************************************************************************
* Function Name  : USB_Cable_Config
* Description    : Software Connection/Disconnection of USB Cable.
* Input          : None.
* Return         : Status
*******************************************************************************/
void USB_Cable_Config (FunctionalState NewState)
{

  SYSCFG_USBPuCmd(NewState);


//#if defined(STM32L1XX_MD)
//  if (NewState != DISABLE)
//  {
//    STM32L15_USB_CONNECT;
//  }
//  else
//  {
//    STM32L15_USB_DISCONNECT;
//  }  
//  
//// MS specific section
//#else
//  if (NewState != DISABLE)
//  {
//    GPIO_ResetBits(USB_DISCONNECT, USB_DISCONNECT_PIN);
//    SYSCFG_USBPuCmd(ENABLE);
//
//  }
//  else
//  {
//    GPIO_SetBits(USB_DISCONNECT, USB_DISCONNECT_PIN);
//    SYSCFG_USBPuCmd(DISABLE);
//
//  }
//#endif
// End of MS specific section
}

/*******************************************************************************
 * Function Name  : Handle_USBAsynchXfer.
 * Description    : send data to USB.
 * Input          : None.
 * Return         : none.
 *******************************************************************************/
void Handle_USBAsynchXfer (void)
{

  uint16_t USB_Tx_Length;


  
  // If no buffer is under transmission
  if(USB_Tx_State != 1)
  {
    if (usb_tx_queue > 0)
    {

      //usb_tx_index = 0;
      
      if (usb_tx_len[usb_tx_rd_ptr] > VIRTUAL_COM_PORT_DATA_SIZE)
      {
        USB_Tx_Length = VIRTUAL_COM_PORT_DATA_SIZE;
        
        UserToPMABufferCopy(&usb_tx[usb_tx_rd_ptr][usb_tx_index], VC__ENDP1_TXADDR, USB_Tx_Length);
        SetEPTxCount(ENDP1, USB_Tx_Length);
        SetEPTxValid(ENDP1);

        usb_tx_index += VIRTUAL_COM_PORT_DATA_SIZE;
        USB_Tx_State = 1;
      }
      // Send entire buffer fit in one VC transaction
      else
      {
        USB_Tx_Length = usb_tx_len[usb_tx_rd_ptr]-usb_tx_index;
        if (USB_Tx_Length > VIRTUAL_COM_PORT_DATA_SIZE){
          //This can happen when com port opens / closes and usb_tx_index isn't correctly setted
          USB_Tx_Length = usb_tx_len[usb_tx_rd_ptr];
        }
        usb_tx_queue--;
        
        UserToPMABufferCopy(&usb_tx[usb_tx_rd_ptr][usb_tx_index], VC__ENDP1_TXADDR, USB_Tx_Length);
        SetEPTxCount(ENDP1, USB_Tx_Length);
        SetEPTxValid(ENDP1);

        usb_tx_rd_ptr++;
        if (usb_tx_rd_ptr >= USB_TX_BUF_NUM)
          usb_tx_rd_ptr = 0;
        
        usb_tx_index = 0;
        USB_Tx_State = 0;
      }
      // Check endpoint status - stop transmission is NAK (com port closed)
      /*if (GetEPTxStatus(ENDP1)==EP_TX_NAK){
        usb_stop_all_streams();
        SetEPTxStatus(ENDP1, EP_TX_VALID); // Get ready for further transmissions
      }*/
    }
     
  }

   
  
}


/*******************************************************************************
* Function Name  : Get_SerialNum.
* Description    : Create the serial number string descriptor.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void Get_SerialNum(void)
{
  uint32_t Device_Serial0, Device_Serial1, Device_Serial2;

  Device_Serial0 = *(uint32_t*)(0x1FF80050);
  Device_Serial1 = *(uint32_t*)(0x1FF80054);
  Device_Serial2 = *(uint32_t*)(0x1FF80064);

  Device_Serial0 += Device_Serial2;

  if (usb_mode == VIRTUAL_COM)
	{
		if (Device_Serial0 != 0)
		{
			IntToUnicode (Device_Serial0, &Virtual_Com_Port_StringSerial[2] , 8);
			IntToUnicode (Device_Serial1, &Virtual_Com_Port_StringSerial[18], 4);
		}
	}
	else
	{
		if (Device_Serial0 != 0)
		{
			IntToUnicode (Device_Serial0, &MASS_StringSerial[2] , 8);
			IntToUnicode (Device_Serial1, &MASS_StringSerial[18], 4);
		}
	}
}

/*******************************************************************************
* Function Name  : HexToChar.
* Description    : Convert Hex 32Bits value into char.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
static void IntToUnicode (uint32_t value , uint8_t *pbuf , uint8_t len)
{
  uint8_t idx = 0;
  
  for( idx = 0 ; idx < len ; idx ++)
  {
    if( ((value >> 28)) < 0xA )
    {
      pbuf[ 2* idx] = (value >> 28) + '0';
    }
    else
    {
      pbuf[2* idx] = (value >> 28) + 'A' - 10; 
    }
    
    value = value << 4;
    
    pbuf[ 2* idx + 1] = 0;
  }
}

// MS specific section

/*******************************************************************************
* Function Name  : MAL_Config
* Description    : MAL_layer configuration
* Input          : None.
* Return         : None.
*******************************************************************************/
void MAL_Config(void)
{
  MAL_Init(0);

}

// End of MS specific section

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
