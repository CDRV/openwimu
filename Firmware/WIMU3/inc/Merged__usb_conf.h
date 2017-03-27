/**
  ******************************************************************************
  * @file    usb_conf.h
  * @author  MCD Application Team
  * @version V3.4.0
  * @date    29-June-2012
  * @brief   Mass Storage Demo configuration header
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __Merged__USB_CONF_H
#define __Merged__USB_CONF_H

/*-------------------------------------------------------------*/
/* EP_NUM */
/* defines how many endpoints are used by the device */
/*-------------------------------------------------------------*/
// MS specific section ***
#define MS__EP_NUM                          (3)
// End of MS specific section ***

// VC specific section ***
#define VC__EP_NUM                          (4)
// En of CV specific section ***

/*-------------------------------------------------------------*/
/* --------------   Buffer Description Table  -----------------*/
/*-------------------------------------------------------------*/

// MS specific section ***
/* buffer table base address */

#define MS__BTABLE_ADDRESS      (0x00)

/* EP0  */
/* rx/tx buffer base address */
#define MS__ENDP0_RXADDR        (0x18)
#define MS__ENDP0_TXADDR        (0x58)

/* EP1  */
/* tx buffer base address */
#define MS__ENDP1_TXADDR        (0x98)

/* EP2  */
/* Rx buffer base address */
#define MS__ENDP2_RXADDR        (0xD8)
// End of MS specific section ***


// VC specific section ***
#define VC__BTABLE_ADDRESS      (0x00)

/* EP0  */
/* rx/tx buffer base address */
#define VC__ENDP0_RXADDR        (0x40)
#define VC__ENDP0_TXADDR        (0x80)

/* EP1  */
/* tx buffer base address */
#define VC__ENDP1_TXADDR        (0xC0)
#define VC__ENDP2_TXADDR        (0x100)
#define VC__ENDP3_RXADDR        (0x110)
// End of VC specific section ***


/* ISTR events */
/* _IMR_MSK */
/* mask defining which events has to be handled */
/* by the device application software */


#define MS__IMR_MSK (CNTR_CTRM  | CNTR_RESETM)
#define VC__IMR_MSK (CNTR_CTRM  | CNTR_SOFM  | CNTR_RESETM )
// Define the event section to be compiled : for VC and MS merged operation, ored the Masks
#define _IMR_MSK (CNTR_CTRM  | CNTR_SOFM  | CNTR_RESETM | CNTR_SUSPM )

// VC specific section ***
/*#define CTR_CALLBACK*/ 
/*#define DOVR_CALLBACK*/
/*#define ERR_CALLBACK*/
/*#define WKUP_CALLBACK*/
/*#define SUSP_CALLBACK*/
/*#define RESET_CALLBACK*/
#define SOF_CALLBACK
/*#define ESOF_CALLBACK*/
// End of VC specific section ***

/* CTR service routines */
/* associated to defined endpoints */
//#define  EP1_IN_Callback   NOP_Process
#define  EP2_IN_Callback   NOP_Process
#define  EP3_IN_Callback   NOP_Process
#define  EP4_IN_Callback   NOP_Process
#define  EP5_IN_Callback   NOP_Process
#define  EP6_IN_Callback   NOP_Process
#define  EP7_IN_Callback   NOP_Process


#define  EP1_OUT_Callback   NOP_Process
//#define  EP2_OUT_Callback   NOP_Process
//#define  EP3_OUT_Callback  NOP_Process
#define  EP4_OUT_Callback   NOP_Process
#define  EP5_OUT_Callback   NOP_Process
#define  EP6_OUT_Callback   NOP_Process
#define  EP7_OUT_Callback   NOP_Process


#endif /* __Merged__USB_CONF_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
