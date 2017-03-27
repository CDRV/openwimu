#include "buttons.h"
#include "utils.h"
#include "config.h"
#include "usb.h"
#include "power.h"
#include "usb_pwr.h"
#include "MS__usb_prop.h"

//#include "MPUCompass_driver.h"

// Push button for WIMU
PushButton_TypeDef PowerButton = // Power Button
{
  GPIOC,                      // GPIOx
  RCC_AHBPeriph_GPIOC,        // GPIOx_PeriphClk
  GPIO_Pin_5,                 // GPIOx_Pin
  INACTIVE,                   // State
  0,                          // LastActivationNbrTicks
  0,                          // Number of press on that button
  BTN_NO_ACTION                   // Requested Action
};

PushButton_TypeDef ModeButton = // Mode Button
{
  GPIOC,                      // GPIOx
  RCC_AHBPeriph_GPIOC,        // GPIOx_PeriphClk
  GPIO_Pin_4,                 // GPIOx_Pin
  INACTIVE,                    // State
  0,                          // LastActivationNbrTicks
  0,                          // Number of press on that button
  BTN_NO_ACTION                   // Requested Action
};

//------------------------------------------------------------------------------
// PushButton_GetState
//------------------------------------------------------------------------------
// Description: Returns the selected Button state.
//
//------------------------------------------------------------------------------
// Parameters:
//  Button: specifies the Button to be checked
//
// Return value:
//    State = POLLING : the code is polling for push button activation
//    State = ACTIVE :  the push button is currently activated. A user that take action
//                      based on ACTIVE state MUST set State to POLLING when State
//                      reach ACTIVATION_PENDING.
//    State = ACTIVATION_PENDING : activation event is pending. In order to catch other
//                                  button event, user MUST put the State back to POLLING
// None
//------------------------------------------------------------------------------
PushButtonState_TypeDef PushButton_GetState(PushButton_TypeDef * Button)
{
  return Button->State;
}

void PushButton_SetState(PushButton_TypeDef * Button, PushButtonState_TypeDef state){
  Button->State = state;
  if (state==ACTIVE){
    Button->LastActivationTimeStamp = timestamp;
    if (Button->NbrOfPress==1){
      Button->FirstActivationTimeStamp = timestamp;
    }
  }
}

void PushButton_SetAction(PushButton_TypeDef * Button, PushButtonAction_TypeDef action){
  Button->RequestedAction = action;
}

void PushButton_UpdateState(PushButton_TypeDef * Button){
  uint8_t debounce_tick;
  switch (Button->State){
    case INACTIVE:
      if (PushButton_GetPinState(Button)){
        // Start debouncing
        Button->State = DEBOUNCING;
      }
    break;
    case ACTIVE:
     if (!PushButton_GetPinState(Button)){
          // Button was released
          PushButton_Reset(Button);
        }
    break;
    case DEBOUNCING:
      if (!Power_IsInStopMode())
        debounce_tick = PUSH_BUTTON_DEBOUNCE_TICK;
      else
        debounce_tick = PUSH_BUTTON_DEBOUNCE_TICK_LOWPOW;

      if (Button->ActivationNbrOfTicks>=debounce_tick){
        if (PushButton_GetPinState(Button)){
            Button->NbrOfPress++;
            PushButton_SetState(Button, ACTIVE);
            Buzzer_Start(20);
        }else{
            PushButton_Reset(Button);
        }
      }
     
    break;
    default:
    break;
  }

  // Reset everything if last activation > 2 seconds
  if (Button->LastActivationTimeStamp >= timestamp+2){
    PushButton_ResetAll(Button);
  }

 
}

void PushButton_ModeButtonUpdateAction(){
  if (ModeButton.State == DEBOUNCING) return;

  // Mark
  if (ModeButton.NbrOfPress==1 && !USB_IsConnected()){
    ModeButton.RequestedAction = BTN_MARK;
    ModeButton.NbrOfPress=0;
  }

  // Change USB Mode
  if (ModeButton.NbrOfPress==1 && USB_IsConnected()){
    ModeButton.RequestedAction = BTN_USB_MODE;
    ModeButton.NbrOfPress=0;

    /*if (Power_GetState()!=POWER_STATE_USB_ON){
        ModeButton.RequestedAction = BTN_NO_ACTION; // Clear requested action since we manage it here
        // Change power state
        Power_SetState(POWER_STATE_USB_ON);

        // Power USB On
        PowerOn();        
      }*/
  }
}

void PushButton_PowerButtonUpdateAction(){
  if (PowerButton.State == DEBOUNCING) return;
  // On-Off
  if (PowerButton.NbrOfPress==3){
    PowerButton.RequestedAction = BTN_ON_OFF;
    PowerButton.NbrOfPress=0;
  }



}
/*
uint16_t PushButton_GetActivationNbrTicks(PushButton_TypeDef * Button)
{
  return Button->ActivationNbrOfTicks;
}*/

void PushButton_Reset(PushButton_TypeDef * Button)
{
  PushButton_SetState(Button, INACTIVE);
  Button->ActivationNbrOfTicks = 0;
  //Button->NbrOfPress = 0;
}

void PushButton_ResetAll(PushButton_TypeDef * Button)
{
  PushButton_Reset(Button);
  Button->NbrOfPress = 0;
  Button->RequestedAction = BTN_NO_ACTION;
  Button->LastActivationTimeStamp = 0;
  Button->FirstActivationTimeStamp = 0;
}

void PushButton_Config(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
      
  /* Enable GPIOx AHB Clocks */
  RCC_AHBPeriphClockCmd(ModeButton.GPIOx_PeriphClk | PowerButton.GPIOx_PeriphClk, ENABLE);
	
   /* Configure push button pins */
  GPIO_InitStructure.GPIO_Pin = PowerButton.GPIOx_Pin;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(PowerButton.GPIOx, &GPIO_InitStructure);
  
  GPIO_InitStructure.GPIO_Pin = ModeButton.GPIOx_Pin;
  GPIO_Init(ModeButton.GPIOx, &GPIO_InitStructure);

  // Enable DMA clock - for a strange reason, this needs to be enabled.....!!
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_DMA1, ENABLE);
	
}

void PushButton_SetInterrupt(PushButton_TypeDef* Button, bool enabled){
  EXTI_InitTypeDef EXTI_InitStructure;
  NVIC_InitTypeDef NVIC_InitStructure;

  switch (Button->GPIOx_Pin){
    case GPIO_Pin_4: //Push Button 2
      if (enabled==true) SYSCFG_EXTILineConfig(EXTI_PortSourceGPIOC, EXTI_PinSource4);
      EXTI_InitStructure.EXTI_Line = EXTI_Line4;
      NVIC_InitStructure.NVIC_IRQChannel = EXTI4_IRQn;
      break;
    case GPIO_Pin_5: //Push Button 1
      if (enabled==true) SYSCFG_EXTILineConfig(EXTI_PortSourceGPIOC, EXTI_PinSource5);
      EXTI_InitStructure.EXTI_Line = EXTI_Line5;
      NVIC_InitStructure.NVIC_IRQChannel = EXTI9_5_IRQn;
      break;
    default:
      return; // Unsupported config
  }
    
  if (enabled==true){
    EXTI_InitStructure.EXTI_LineCmd = ENABLE;
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  }else{
    EXTI_InitStructure.EXTI_LineCmd = DISABLE;
    NVIC_InitStructure.NVIC_IRQChannelCmd = DISABLE;
  }

  // Configure EXTI line for button interrupts
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising_Falling; //EXTI_Trigger_Falling;
  EXTI_Init(&EXTI_InitStructure);
  
  // Enable and set the EXTI interrupt priority
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_Init(&NVIC_InitStructure);

  // Clear all pending interrupt
  EXTI_ClearITPendingBit(EXTI_InitStructure.EXTI_Line);

}

bool PushButton_GetPinState(PushButton_TypeDef *Button){
  uint8_t value;
  value = GPIO_ReadInputDataBit(Button->GPIOx, Button->GPIOx_Pin);
  if (value == PUSHBUTTON_INACTIVE_STATE)
    return false;
  else
    return true;
}