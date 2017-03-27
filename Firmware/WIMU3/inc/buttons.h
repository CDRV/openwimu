#ifndef BUTTONS_H_
#define BUTTONS_H_

#include "config.h"
#include "stm32l1xx_gpio.h"
#include "stm32l1xx_rcc.h"
#include "stm32l1xx_tim.h"

#define PUSHBUTTON_INACTIVE_STATE         1
#define PUSH_BUTTON_DEBOUNCE_TICK         100
#define PUSH_BUTTON_DEBOUNCE_TICK_LOWPOW  10

typedef enum
{
  INACTIVE,
  DEBOUNCING,
  ACTIVE
} PushButtonState_TypeDef;

typedef enum
{
  BTN_NO_ACTION,
  BTN_ON_OFF,
  BTN_MARK,
  BTN_USB_MODE,
  BTN_CALIB
} PushButtonAction_TypeDef;

typedef struct
{
  GPIO_TypeDef* GPIOx;
  uint32_t GPIOx_PeriphClk;
  uint16_t GPIOx_Pin;
  PushButtonState_TypeDef State;
  uint16_t ActivationNbrOfTicks;
  uint8_t NbrOfPress;
  PushButtonAction_TypeDef RequestedAction;
  uint64_t  FirstActivationTimeStamp;
  uint64_t  LastActivationTimeStamp;
} PushButton_TypeDef;

extern PushButton_TypeDef ModeButton;
extern PushButton_TypeDef PowerButton;


void PushButton_Config(void);

uint8_t PushButton_GetState(PushButton_TypeDef * Button);
void PushButton_UpdateState(PushButton_TypeDef * Button);

void PushButton_ModeButtonUpdateAction();
void PushButton_PowerButtonUpdateAction();

void PushButton_SetState(PushButton_TypeDef * Button, PushButtonState_TypeDef state);
void PushButton_SetAction(PushButton_TypeDef * Button, PushButtonAction_TypeDef action);

bool PushButton_GetPinState(PushButton_TypeDef *Button);
//void PushButton_SetPollingAndResetTicks(PushButton_TypeDef * Button);
void PushButton_Reset(PushButton_TypeDef * Button);
void PushButton_ResetAll(PushButton_TypeDef * Button);

uint16_t PushButton_GetActivationNbrTicks(PushButton_TypeDef * Button);
void PushButton_SetInterrupt(PushButton_TypeDef* Button, bool enabled);
#endif