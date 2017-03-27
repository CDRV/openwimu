

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef FIFO_H_
#define FIFO_H_

/* Includes ------------------------------------------------------------------*/
#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <stdint.h>


/* Exported types ------------------------------------------------------------*/
typedef struct
{
  void * ArrayPtr;
  size_t ElementSize;
  uint16_t ArraySize;
  uint16_t RdPtr;
  uint16_t WrPtr;
  
} FIFO_TypeDef;

/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/


/* Exported functions ------------------------------------------------------- */

void FIFO_Init(FIFO_TypeDef* FIFO, void * ArrayPtr, size_t ElementSize, uint16_t ArraySize);
uint8_t FIFO_WrArrayInIfSpaceAvailable(FIFO_TypeDef* FIFO, void * Array, uint16_t Array_Length);
void FIFO_WrArrayIn(FIFO_TypeDef* FIFO, void * Array, uint16_t Array_Length);
uint8_t FIFO_WrElementIfSpaceAvailable(FIFO_TypeDef* FIFO, void * Element);
void FIFO_WrElementIn(FIFO_TypeDef* FIFO, void * Element);
uint8_t FIFO_RdElementIfDataAvailable(FIFO_TypeDef* FIFO, void * RdElement);
uint8_t FIFO_IsEmpty(FIFO_TypeDef* FIFO);
uint16_t FIFO_GetFreeSpace(FIFO_TypeDef* FIFO);

#endif /*FIFO_H_*/
