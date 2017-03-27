/**
  ******************************************************************************
  * @file    stm32_it.c
  * @author  MCD Application Team
  * @version V3.4.0
  * @date    29-June-2012
  * @brief   Main Interrupt Service Routines.
  *          This file provides template for all exceptions handler and peripherals
  *          interrupt service routine.
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
#include "usb_lib.h"
#include "usb_istr.h"
#include "usb_pwr.h"
#include "usb.h"
#include "USART_driver.h"
#include "utils.h"
#include "gps.h"
#include "MPUCompass_driver.h"
#include "power.h"
#include "buttons.h"
#include "ble.h"
#include "battery.h"
#include "power.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Extern variables ----------------------------------------------------------*/
// USART Buffers
// USART Buffers
extern FIFO_TypeDef Usart1_TxFIFOStruct;
extern FIFO_TypeDef Usart1_RxFIFOStruct;


//extern uint32_t Buzzer_NbrOfCycleCompleted;

extern PushButton_TypeDef PushButton1;
extern PushButton_TypeDef PushButton2;

extern uint8_t Calib_Counter;

volatile uint64_t SysTick_Counter = 0;
volatile uint32_t SysTick_Timeout;
//volatile uint32_t SysTick_DelayDownCounter;



extern BOOL test_mode;

/******************************************************************************/
/*            Cortex-M Processor Exceptions Handlers                         */
/******************************************************************************/

/*******************************************************************************
* Function Name  : NMI_Handler
* Description    : This function handles NMI exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void NMI_Handler(void)
{
}

/*******************************************************************************
* Function Name  : HardFault_Handler
* Description    : This function handles Hard Fault exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void HardFault_Handler(void)
{
  /* Go to infinite loop when Hard Fault exception occurs */
  while (1)
  {
    //Reboot the module
    NVIC_SystemReset();
  }
}

/*******************************************************************************
* Function Name  : MemManage_Handler
* Description    : This function handles Memory Manage exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void MemManage_Handler(void)
{
  /* Go to infinite loop when Memory Manage exception occurs */
  while (1)
  {
  //Reboot the module
    NVIC_SystemReset();
  }
}

/*******************************************************************************
* Function Name  : BusFault_Handler
* Description    : This function handles Bus Fault exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void BusFault_Handler(void)
{
  /* Go to infinite loop when Bus Fault exception occurs */
  while (1)
  {
  //Reboot the module
    NVIC_SystemReset();
  }
}

/*******************************************************************************
* Function Name  : UsageFault_Handler
* Description    : This function handles Usage Fault exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void UsageFault_Handler(void)
{
  /* Go to infinite loop when Usage Fault exception occurs */
  while (1)
  {
  //Reboot the module
    NVIC_SystemReset();
  }
}

/*******************************************************************************
* Function Name  : SVC_Handler
* Description    : This function handles SVCall exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void SVC_Handler(void)
{
}

/*******************************************************************************
* Function Name  : DebugMon_Handler
* Description    : This function handles Debug Monitor exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void DebugMon_Handler(void)
{
}

/*******************************************************************************
* Function Name  : PendSV_Handler
* Description    : This function handles PendSVC exception.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void PendSV_Handler(void)
{
}

/*******************************************************************************
* Function Name  : SysTick_Handler
* Description    : This function handles SysTick Handler.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void SysTick_Handler(void)
{

  static uint8_t Alive_Counter=0;
  
  /* --------- SysTick counter --------- */
  SysTick_Counter++;

  // Update timestamp
  if (SysTick_Counter>=1000){
    update_timestampRTC();

    SysTick_Counter=0;
    Alive_Counter++;

    // Check battery power
    if (isModuleOnline(MODULE_POWER)){
      power_ready = TRUE;
    }

    if (isModuleOnline(MODULE_BLE)){
      ble_update_time = true;
    }

    // Update calibration counter if needed
/*    if (Calib_Counter>0){
      Calib_Counter--;
      Buzzer_Start(10);

      if (isModuleOnline(MODULE_USB)){
        if (Calib_Counter>0)
          usb_send_char('.');
        else
          usb_send_string("OK\n\r",4);
      }
      //Buzzer_Stop();
    }*/
    // Update battery level
//   BatteryMonitoring_RdADC(&Battery_ADCValue);
  }

  // Push buttons management
  if (PushButton_GetState(&ModeButton)!=INACTIVE){
    ModeButton.ActivationNbrOfTicks++;
    PushButton_UpdateState(&ModeButton);
    PushButton_ModeButtonUpdateAction();
  }

  if (PushButton_GetState(&PowerButton)!=INACTIVE){
    PowerButton.ActivationNbrOfTicks++;
    PushButton_UpdateState(&PowerButton);
    PushButton_PowerButtonUpdateAction();
  }

 
  if(SysTick_Timeout > 0)
  {
    SysTick_Timeout--;
  }

  /*if (Power_GetState()!=POWER_STATE_ON && Power_GetState() != POWER_STATE_USB_ON)
    return;*/

  // Blink LED if needed
  if (wimu_config.ui.led_blink_time>0 && initialized==true){
    if (Alive_Counter >= wimu_config.ui.led_blink_time){
      if (!Power_IsStateUSBRelated(Power_GetState()))
        led(LED_GREEN,TRUE, LOW_PRIORITY);
      Alive_Counter=0;
    }
    if (SysTick_Counter==500 && Alive_Counter==0){
      if (!Power_IsStateUSBRelated(Power_GetState()))
        led(LED_GREEN,FALSE, LOW_PRIORITY);
    }
   
   
  }
  
  /*if(SysTick_DelayDownCounter > 0)
  {
    SysTick_DelayDownCounter--;
  }*/

  
 
  
}

/******************************************************************************/
/*            STM32 Peripherals Interrupt Handlers                        */
/******************************************************************************/


/*******************************************************************************
* Function Name  : USB_IRQHandler
* Description    : This function handles USB Low Priority interrupts
*                  requests.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void USB_LP_IRQHandler(void)
{
  USB_Istr();
}


/******************************************************************************/
/*                 STM32 Peripherals Interrupt Handlers                   */
/*  Add here the Interrupt Handler for the used peripheral(s) (PPP), for the  */
/*  available peripheral interrupt handler's name please refer to the startup */
/*  file (startup_stm32xxx.s).                                            */
/******************************************************************************/







/*******************************************************************************
 * Function Name  : TIM4_IRQHandler
 * Description    : This function handles UART5 interrupt request.
 * Input          : None
 * Output         : None
 * Return         : None
 *******************************************************************************/
void TIM4_IRQHandler(void)
{

  #ifdef EN_SOFT_WATCHDOG
  IWDG_Enable();
  #endif
  
  while (1);
}

// MODE BUTTON HANDLER
void EXTI4_IRQHandler(void){
  //Mode button was pushed
  if(EXTI_GetITStatus(EXTI_Line4) != RESET){

    PushButton_UpdateState(&ModeButton);

    /*
    if (USB_GetState()==USB_STATE_CONNECTED){
      // Change power state
      PowerSetState(POWER_STATE_USB_ON);

      // Power USB On
      PowerOn();
      //led(LED_GREEN,TRUE);
    }*/

   
    EXTI_ClearITPendingBit(EXTI_Line4);
  }
}





/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
