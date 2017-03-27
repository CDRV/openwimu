//******************************************************************************
//  WIMUuSD - FIFO module
//
//  Description: 
//
//  Author: N. Viscogliosi, B. ing., M. Sc. A.
//  Initial Version: November 10th, 2012
//
//  Modifications: 
//
//
//******************************************************************************


/* Includes ------------------------------------------------------------------*/
#include "FIFO.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/

/* Extern variables ----------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private functions ---------------------------------------------------------*/


/*******************************************************************************
 * Function Name  :  FIFO_Init.
 * Description    :  Initialize FIFO.
 * Input          :   ElementSize: size of an element of the array pointed to by ArrayPtr
 *                    FIFO: FIFO structure
 *                    ArrayPtr: Address of the Array associated with the FIFO
 *                    ArraySize: Number of element in the array
 * Return         :  None
 *******************************************************************************/
void FIFO_Init(FIFO_TypeDef* FIFO, void * ArrayPtr, size_t ElementSize, uint16_t ArraySize)
{
  FIFO->ArrayPtr = ArrayPtr;
  FIFO->ElementSize = ElementSize;
  FIFO->ArraySize = ArraySize;
  FIFO->RdPtr = 0;
  FIFO->WrPtr = 0;
  
  return;
}

/*******************************************************************************
 * Function Name  :   FIFO_WrArrayInIfSpaceAvailable.
 * Description    :   Write array in FIFO.
 *                    ***CAUTION: Array MUST be of the same type than FIFO elements type
 * Input          :   FIFO: Destination FIFO for Array
 *                    Array: Array to be written in FIFO
 * Return         :   Result (1:Success; 0:Fail (not enough free space in FIFO))
 *******************************************************************************/
uint8_t FIFO_WrArrayInIfSpaceAvailable(FIFO_TypeDef* FIFO, void * Array, uint16_t Array_Length)
{
  uint16_t WrapUpLength;
  
  WrapUpLength = FIFO->ArraySize - FIFO->WrPtr;
  
  // Write the array in the FIFO if there's enough free space
  if (FIFO_GetFreeSpace(FIFO) >= Array_Length)
  {
    
    if(WrapUpLength > Array_Length)
    {
      memcpy((void *)((uint8_t *)FIFO->ArrayPtr + FIFO->WrPtr * FIFO->ElementSize), Array, Array_Length * FIFO->ElementSize);
    }
    else
    {
      memcpy((void *)((uint8_t *)FIFO->ArrayPtr + FIFO->WrPtr * FIFO->ElementSize), Array, WrapUpLength * FIFO->ElementSize);
      memcpy((void *)(FIFO->ArrayPtr), (void *)((uint8_t *)Array + WrapUpLength * FIFO->ElementSize), (Array_Length - WrapUpLength) * FIFO->ElementSize);
    }
    
    // Update write pointer w/ wrap-up
    if(FIFO->WrPtr + Array_Length >= FIFO->ArraySize)
    {
      FIFO->WrPtr = FIFO->WrPtr + Array_Length - FIFO->ArraySize;
    }
    else
    {
      FIFO->WrPtr += Array_Length;
    }
      
    return 1;
  }
  else
  {
    return 0;
  }
}

/*******************************************************************************
 * Function Name  :   FIFO_WrArrayIn.
 * Description    :   Write array in FIFO WITHOUT sapce availability check
 *                    ***CAUTION: Array MUST be of the same type than FIFO elements type
 * Input          :   FIFO: Destination FIFO for Array
 *                    Array: Array to be written in FIFO
 * Return         :   None.
 *******************************************************************************/
void FIFO_WrArrayIn(FIFO_TypeDef* FIFO, void * Array, uint16_t Array_Length)
{

  uint16_t WrapUpLength;
  
  WrapUpLength = FIFO->ArraySize - FIFO->WrPtr;

  // Writing the array in the FIFO
  if(WrapUpLength > Array_Length)
  {
    memcpy((void *)((uint8_t *)FIFO->ArrayPtr + FIFO->WrPtr * FIFO->ElementSize), Array, Array_Length * FIFO->ElementSize);
  }
  else
  {
    memcpy((void *)((uint8_t *)FIFO->ArrayPtr + FIFO->WrPtr * FIFO->ElementSize), Array, WrapUpLength * FIFO->ElementSize);
    memcpy((void *)(FIFO->ArrayPtr), (void *)((uint8_t *)Array + WrapUpLength * FIFO->ElementSize), (Array_Length - WrapUpLength) * FIFO->ElementSize);
  }
  
  // Update write pointer w/ wrap-up
  if(FIFO->WrPtr + Array_Length >= FIFO->ArraySize)
  {
    FIFO->WrPtr = FIFO->WrPtr + Array_Length - FIFO->ArraySize;
  }
  else
  {
    FIFO->WrPtr += Array_Length;
  }
  
}

/*******************************************************************************
 * Function Name  :   FIFO_WrElementIfSpaceAvailable.
 * Description    :   Write single element in FIFO if space available.
 *                    ***CAUTION: element MUST be of the same type than FIFO elements type
 * Input          :   FIFO: Destination FIFO for element
 *                    Element: element to be written in FIFO
 * Return         :   Result (1:Success; 0:Fail (not enough free space in FIFO))
 *******************************************************************************/
uint8_t FIFO_WrElementIfSpaceAvailable(FIFO_TypeDef* FIFO, void * Element)
{
  
  // Write element in the FIFO if there's enough free space
  if (FIFO_GetFreeSpace(FIFO) >= 1)
  {
    memcpy((void *)((uint8_t *)FIFO->ArrayPtr + FIFO->WrPtr * FIFO->ElementSize), Element, FIFO->ElementSize);
    
    // Update write pointer w/ wrap-up
    if(FIFO->WrPtr + 1 >= FIFO->ArraySize)
    {
      FIFO->WrPtr = 0;
    }
    else
    {
      FIFO->WrPtr++;
    }
    
    return 1;
  }
  else
  {
    return 0;
  }

}

/*******************************************************************************
 * Function Name  :   FIFO_WrElementIn.
 * Description    :   Write single element in FIFO WITHOUT sapce availability check.
 *                    ***CAUTION: element MUST be of the same type than FIFO elements type
 * Input          :   FIFO: Destination FIFO for element
 *                    Element: element to be written in FIFO
 * Return         :   None.
 *******************************************************************************/
void FIFO_WrElementIn(FIFO_TypeDef* FIFO, void * Element)
{
  
  memcpy((void *)((uint8_t *)FIFO->ArrayPtr + FIFO->WrPtr * FIFO->ElementSize), Element, FIFO->ElementSize);
  
  // Update write pointer w/ wrap-up
  if(FIFO->WrPtr + 1 >= FIFO->ArraySize)
  {
    FIFO->WrPtr = 0;
  }
  else
  {
    FIFO->WrPtr++;
  }
  
}

/*******************************************************************************
 * Function Name  :   FIFO_RdElementIfDataAvailable.
 * Description    :   Read element when FIFO is not empty.
 * Input          :   FIFO: FIFO to read from
 *                    RdElement: Readed element
 * Return         :   Result: (1:Success; 0:No data available).
 *******************************************************************************/
uint8_t FIFO_RdElementIfDataAvailable(FIFO_TypeDef* FIFO, void * RdElement)
{
  if(!FIFO_IsEmpty(FIFO))
  {
    memcpy(RdElement, (void *)((uint8_t *)FIFO->ArrayPtr + FIFO->RdPtr * FIFO->ElementSize), FIFO->ElementSize);
    
    // Update read pointer w/ wrap-up
    if(FIFO->RdPtr + 1 >= FIFO->ArraySize)
    {
      FIFO->RdPtr = 0;
    }
    else
    {
      FIFO->RdPtr++;
    }
    
    return 1;
  }
  else
  {
    return 0;
  }
}

/*******************************************************************************
 * Function Name  :  FIFO_IsEmpty.
 * Description    :  Verify if FIFO is empty.
 * Input          :   FIFO: FIFO to perform the empty validation on
 * Return         :  Result: (1:FIFO is empty; 0:FIFO is not empty).
 *******************************************************************************/
uint8_t FIFO_IsEmpty(FIFO_TypeDef* FIFO)
{
  return (FIFO->RdPtr == FIFO->WrPtr) ? 1 : 0;
}

/*******************************************************************************
 * Function Name  :  FIFO_GetFreeSpace.
 * Description    :  Return free space of FIFO.
 *                    ***Returning available space minus 1 prevent from having to
 *                    treat the ambiguity in the case where WrPtr == RdPtr. In 
 *                    that case (WrPtr == RdPtr), the FIFO could be full or empty.
 * Input          :  FIFO: FIFO to perform free space calculation on
 * Return         :  Result: free space.
 *******************************************************************************/
uint16_t FIFO_GetFreeSpace(FIFO_TypeDef* FIFO)
{
  if (FIFO->WrPtr >= FIFO->RdPtr)
  {
    return FIFO->ArraySize - (FIFO->WrPtr - FIFO->RdPtr) - 1;
  }
  else
  {
    return FIFO->RdPtr - FIFO->WrPtr - 1;
  }
}


