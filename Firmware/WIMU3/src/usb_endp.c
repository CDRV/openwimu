/**
  ******************************************************************************
  * @file    usb_endp.c
  * @author  MCD Application Team
  * @version V3.4.0
  * @date    29-June-2012
  * @brief   Endpoint routines
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
#include "usb_lib.h"
#include "usb_istr.h"
#include <stdio.h>
#include "MS__usb_bot.h"
#include "VC__usb_desc.h"
#include "usb_mem.h"
#include "Merged__hw_config.h"
#include "usb_pwr.h"
#include "usb.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/


/* Interval between sending IN packets in frame number (1 frame = 1ms) */
#define VCOMPORT_IN_FRAME_INTERVAL             5


/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

extern uint8_t  USB_Tx_State;
extern unsigned char usb_tx_rd_ptr; // Actual TX read index
extern unsigned char usb_rx_wr_ptr; // Actual RX write index
extern unsigned char usb_rx_index;  // Actual RX buffer index (write)
extern unsigned char usb_tx_index;	 // Actual TX buffer index (write)
extern unsigned char usb_rx_queue;	 // Actual number of unread elements in RX
extern unsigned char usb_tx_queue;  // Actual number of unsent elements in TX

extern unsigned short usb_tx_len[USB_TX_BUF_NUM];


//extern enum {VIRTUAL_COM, MASS_STORAGE} ProgramMode;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/*******************************************************************************
* Function Name  : EP1_IN_Callback
* Description    : EP1 IN Callback Routine
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void EP1_IN_Callback(void)
{
  uint16_t USB_Tx_Length;
  if(usb_mode == MASS_STORAGE)
	{
		Mass_Storage_In();
	}
	else
	{
            // Continue the buffer transmission
            if (USB_Tx_State == 1)
            {
              if (usb_tx_len[usb_tx_rd_ptr] - usb_tx_index > VIRTUAL_COM_PORT_DATA_SIZE)
              {
                USB_Tx_Length = VIRTUAL_COM_PORT_DATA_SIZE;
    
                UserToPMABufferCopy(&usb_tx[usb_tx_rd_ptr][usb_tx_index], VC__ENDP1_TXADDR, USB_Tx_Length);
                SetEPTxCount(ENDP1, USB_Tx_Length);
                SetEPTxValid(ENDP1);
    
                usb_tx_index += VIRTUAL_COM_PORT_DATA_SIZE;
                USB_Tx_State = 1;
              }
              // The remaining buffer data fit in one VC transaction
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
  
            }
	}
}

/*******************************************************************************
* Function Name  : EP2_OUT_Callback.
* Description    : EP2 OUT Callback Routine.
* Input          : None.
* Output         : None.
* Return         : None.
*******************************************************************************/
void EP2_OUT_Callback(void)
{
  Mass_Storage_Out();
}

/*******************************************************************************
 * Function Name  : EP3_OUT_Callback
 * Description    :
 * Input          : None.
 * Output         : None.
 * Return         : None.
 *******************************************************************************/
void EP3_OUT_Callback(void)
{
  static uint16_t USB_Rx_Cnt, LoopIndex;
  static uint8_t USB_Rx_Buffer[VIRTUAL_COM_PORT_DATA_SIZE];
  bool stop = false;
  
  /* Get the received data buffer and update the counter */
  USB_Rx_Cnt = USB_SIL_Read(EP3_OUT, USB_Rx_Buffer);
  
  
  for(LoopIndex = 0; LoopIndex < USB_Rx_Cnt; LoopIndex++)
  {
    usb_rx[usb_rx_wr_ptr][usb_rx_index++] = USB_Rx_Buffer[LoopIndex];
    
    // Look for command end character
    if (USB_Rx_Buffer[LoopIndex] == '\r' || USB_Rx_Buffer[LoopIndex] == '\n')
    {
      //For "set" commands, ignore end of line character if length not good
      if (usb_rx[usb_rx_wr_ptr][0]=='s' &&usb_rx[usb_rx_wr_ptr][1]=='e' && usb_rx[usb_rx_wr_ptr][2]=='t')
      {
        //We have a set command
        if (usb_rx[usb_rx_wr_ptr][3]=='s')
        {
          //Settings
          if (usb_rx_index>=sizeof(WIMU_SETTINGS)+6) //6 = len(setset)
          {
            //we must stop...
            //usb_rx_index=USB_RX_BUFFER+1;
            stop = true;
          }
        }
        if (usb_rx[usb_rx_wr_ptr][3]=='c')
        {
          //Config
          if (usb_rx_index>=sizeof(WIMU_CONFIG)+7) //7 = len(setconf)
          {
            //we must stop...
            //usb_rx_index=USB_RX_BUFFER+1;
            stop = true;
          }
        }
        
      }
      else
      {
        //we must stop...
       // usb_rx_index=USB_RX_BUFFER+1;
       stop = true;
      }
    }
    
    if (usb_rx_index>USB_RX_BUFFER || stop)
    {
      //usb_rx_len[usb_rx_wr_ptr]=usb_rx_index;
            
      if (!usb_rx_ready){
        if (usb_streaming==0){ //Echo character only if not streaming
          //USB_SendString("\n\r",2); //TODO: disable if streaming binary not commands
          if (usb_rx_index<USB_RX_BUFFER){
            usb_rx[usb_rx_wr_ptr][usb_rx_index++] = '\r';
          }
          USB_SendString((char*)&usb_rx[usb_rx_wr_ptr][0], usb_rx_index);
        }
      }

      usb_rx_index=0;
      usb_rx_queue++;
      
      usb_rx_wr_ptr++;
      if (usb_rx_wr_ptr >= USB_RX_BUF_NUM) // All buffers were used
        usb_rx_wr_ptr = 0;

      
      usb_rx_ready=TRUE;
    }
    else
    {
     /*if (usb_streaming==0){ //Echo character only if not streaming
        if (usb_tx_queue<USB_TX_BUF_NUM)
          USB_SendChar(USB_Rx_Buffer[LoopIndex]);
        else{ // Buffers are full, append char to the last one
          usb_tx[USB_TX_BUF_NUM-1][usb_tx_len[USB_TX_BUF_NUM-1]+1]=USB_Rx_Buffer[LoopIndex];
	  usb_tx_len[USB_TX_BUF_NUM-1]=usb_tx_len[USB_TX_BUF_NUM-1]+1;
        }
     }*/
    }
    
  }
  
  /* Enable the receive of data on EP3 */
  SetEPRxValid(ENDP3);
}


/*******************************************************************************
 * Function Name  : SOF_Callback / INTR_SOFINTR_Callback
 * Description    :
 * Input          : None.
 * Output         : None.
 * Return         : None.
 *******************************************************************************/
void SOF_Callback(void)
{
  static uint32_t FrameCount = 0;
  
  if(bDeviceState == CONFIGURED)
  {
    if (FrameCount++ == VCOMPORT_IN_FRAME_INTERVAL)
    {
      /* Reset the frame counter */
      FrameCount = 0;
      
      /* Check the data to be sent through IN pipe */
      Handle_USBAsynchXfer();
    }
  }  
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

