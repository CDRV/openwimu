#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"
/**************************************************************************************************
  Filename:       hal_aes.c
  Revised:        $Date: 2009-10-29 16:57:32 -0700 (Thu, 29 Oct 2009) $
  Revision:       $Revision: 21020 $

  Description:    Support for Hardware AES encryption.

  Copyright 2007-2009 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
**************************************************************************************************/

/******************************************************************************
 * INCLUDES
 */
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\osal.h"
/******************************************************************************
  Filename:     OSAL.h
  Revised:      $Date: 2012-02-17 15:07:16 -0800 (Fri, 17 Feb 2012) $
  Revision:     $Revision: 29376 $

  Description:  This API allows the software components in the Z-Stack to be
                written independently of the specifics of the operating system,
                kernel, or tasking environment (including control loops or
                connect-to-interrupt systems).


  Copyright 2004-2011 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product. Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
******************************************************************************/









/*********************************************************************
 * INCLUDES
 */

#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\limits.h"
/*                      - LIMITS.H -

   Integral ANSI element sizes.

   $Revision: 38615 $

   Copyright 1986 - 1999 IAR Systems. All rights reserved.
*/





  #pragma system_include


#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\sysmac.h"
/*                      - SYSMAC.H -

   Defines system macros to maintain source compatibility
   with different IAR compilers.

   $Revision: 6040 $

   Copyright 1986 - 1999 IAR Systems. All rights reserved.
*/





   #pragma system_include










































#line 65 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\sysmac.h"

#line 73 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\sysmac.h"







/* Macro for frmwri and frmrd */


/* Typedefs put here to appear only once */
typedef unsigned int    size_t;
typedef signed int ptrdiff_t;

#line 18 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\limits.h"


























#line 80 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\limits.h"

#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\osal.h"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\comdef.h"
/**************************************************************************************************
  Filename:       comdef.h
  Revised:        $Date: 2010-07-28 08:42:48 -0700 (Wed, 28 Jul 2010) $
  Revision:       $Revision: 23160 $

  Description:    Type definitions and macros.


  Copyright 2004-2008 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
**************************************************************************************************/










/*********************************************************************
 * INCLUDES
 */

/* HAL */
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_types.h"
/**
  @headerfile:    hal_types.h

  <!--

  Revised:        $Date: 2012-08-27 10:59:53 -0700 (Mon, 27 Aug 2012) $
  Revision:       $Revision: 31378 $

  Description:    Describe the purpose and contents of the file.


  Copyright 2006-2009 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
  -->
**************************************************************************************************/




/* Texas Instruments CC2540 */

/* ------------------------------------------------------------------------------------------------
 *                                               Types
 * ------------------------------------------------------------------------------------------------
 */
/** @defgroup HAL_TYPES HAL Types
 * @{
 */
typedef signed   char   int8;     //!< Signed 8 bit integer
typedef unsigned char   uint8;    //!< Unsigned 8 bit integer

typedef signed   short  int16;    //!< Signed 16 bit integer
typedef unsigned short  uint16;   //!< Unsigned 16 bit integer

typedef signed   long   int32;    //!< Signed 32 bit integer
typedef unsigned long   uint32;   //!< Unsigned 32 bit integer

typedef unsigned char   bool;     //!< Boolean data type

typedef uint8           halDataAlign_t; //!< Used for byte alignment
/** @} End HAL_TYPES */

/* ------------------------------------------------------------------------------------------------
 *                               Memory Attributes and Compiler Macros
 * ------------------------------------------------------------------------------------------------
 */

/* ----------- IAR Compiler ----------- */
#line 82 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_types.h"

/* ----------- KEIL Compiler ----------- */
#line 105 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_types.h"


/* ------------------------------------------------------------------------------------------------
 *                                        Standard Defines
 * ------------------------------------------------------------------------------------------------
 */













/**************************************************************************************************
 */
#line 55 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\comdef.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_defs.h"
/**************************************************************************************************
  Filename:       hal_defs.h
  Revised:        $Date: 2012-08-17 16:28:43 -0700 (Fri, 17 Aug 2012) $
  Revision:       $Revision: 31295 $

  Description:    This file contains useful macros and data types


  Copyright 2005-2012 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
**************************************************************************************************/





/* ------------------------------------------------------------------------------------------------
 *                                             Macros
 * ------------------------------------------------------------------------------------------------
 */






















/* takes a byte out of a uint32 : var - uint32,  ByteNum - byte to take out (0 - 3) */





















#line 101 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_defs.h"

/*
 *  This macro is for use by other macros to form a fully valid C statement.
 *  Without this, the if/else conditionals could show unexpected behavior.
 *
 *  For example, use...
 *    #define SET_REGS()  st( ioreg1 = 0; ioreg2 = 0; )
 *  instead of ...
 *    #define SET_REGS()  { ioreg1 = 0; ioreg2 = 0; }
 *  or
 *    #define  SET_REGS()    ioreg1 = 0; ioreg2 = 0;
 *  The last macro would not behave as expected in the if/else construct.
 *  The second to last macro will cause a compiler error in certain uses
 *  of if/else construct
 *
 *  It is not necessary, or recommended, to use this macro where there is
 *  already a valid C statement.  For example, the following is redundant...
 *    #define CALL_FUNC()   st(  func();  )
 *  This should simply be...
 *    #define CALL_FUNC()   func()
 *
 * (The while condition below evaluates false without generating a
 *  constant-controlling-loop type of warning on most compilers.)
 */



/**************************************************************************************************
 */
#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\comdef.h"

/*********************************************************************
 * Lint Keywords
 */


#line 71 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\comdef.h"

/*********************************************************************
 * CONSTANTS
 */

















/*** Generic Status Return Values ***/
#line 107 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\comdef.h"

/*********************************************************************
 * TYPEDEFS
 */

// Generic Status return
typedef uint8 Status_t;

// Data types
typedef int32   int24;
typedef uint32  uint24;

/*********************************************************************
 * Global System Events
 */



/*********************************************************************
 * Global Generic System Messages
 */



// OSAL System Message IDs/Events Reserved for applications (user applications)
// 0xE0 – 0xFC

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */

/*********************************************************************
 * FUNCTIONS
 */

/*********************************************************************
*********************************************************************/





#line 58 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\osal.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\OSAL_Memory.h"
/**************************************************************************************************
  Filename:       OSAL_Memory.h
  Revised:        $Date: 2010-07-28 08:42:48 -0700 (Wed, 28 Jul 2010) $
  Revision:       $Revision: 23160 $
    
  Description:    This module defines the OSAL memory control functions. 
    
            
  Copyright 2004-2007 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, 
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE, 
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com. 
**************************************************************************************************/









/*********************************************************************
 * INCLUDES
 */

 
/*********************************************************************
 * CONSTANTS
 */





/*********************************************************************
 * MACROS
 */
  


/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */
 
/*********************************************************************
 * FUNCTIONS
 */

 /*
  * Initialize memory manager.
  */
  void osal_mem_init( void );

 /*
  * Setup efficient search for the first free block of heap.
  */
  void osal_mem_kick( void );

 /*
  * Allocate a block of memory.
  */




  void *osal_mem_alloc( uint16 size );


 /*
  * Free a block of memory.
  */




  void osal_mem_free( void *ptr );


#line 130 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\OSAL_Memory.h"

#line 137 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\OSAL_Memory.h"

/*********************************************************************
*********************************************************************/





#line 59 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\osal.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\osal\\include\\OSAL_Timers.h"
/**************************************************************************************************
  Filename:       OSAL_Timers.h
  Revised:        $Date: 2011-09-16 19:09:24 -0700 (Fri, 16 Sep 2011) $
  Revision:       $Revision: 27618 $

  Description:    This file contains the OSAL Timer definition and manipulation functions.


  Copyright 2004-2009 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, 
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE, 
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com. 
**************************************************************************************************/









/*********************************************************************
 * INCLUDES
 */

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 * the unit is chosen such that the 320us tick equivalent can fit in 
 * 32 bits.
 */


/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */

/*********************************************************************
 * FUNCTIONS
 */

  /*
   * Initialization for the OSAL Timer System.
   */
  extern void osalTimerInit( void );

  /*
   * Set a Timer
   */
  extern uint8 osal_start_timerEx( uint8 task_id, uint16 event_id, uint32 timeout_value );
  
  /*
   * Set a timer that reloads itself.
   */
  extern uint8 osal_start_reload_timer( uint8 taskID, uint16 event_id, uint32 timeout_value );

  /*
   * Stop a Timer
   */
  extern uint8 osal_stop_timerEx( uint8 task_id, uint16 event_id );

  /*
   * Get the tick count of a Timer.
   */
  extern uint32 osal_get_timeoutEx( uint8 task_id, uint16 event_id );

  /*
   * Simulated Timer Interrupt Service Routine
   */

  extern void osal_timer_ISR( void );

  /*
   * Adjust timer tables
   */
  extern void osal_adjust_timers( void );

  /*
   * Update timer tables
   */
  extern void osalTimerUpdate( uint32 updateTime );

  /*
   * Count active timers
   */
  extern uint8 osal_timer_num_active( void );

  /*
   * Set the hardware timer interrupts for sleep mode.
   * These functions should only be called in OSAL_PwrMgr.c
   */
  extern void osal_sleep_timers( void );
  extern void osal_unsleep_timers( void );

 /*
  * Read the system clock - returns milliseconds
  */
  extern uint32 osal_GetSystemClock( void );

  /*
   * Get the next OSAL timer expiration.
   * This function should only be called in OSAL_PwrMgr.c
   */
  extern uint32 osal_next_timeout( void );

/*********************************************************************
*********************************************************************/





#line 60 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\osal.h"

/*********************************************************************
 * MACROS
 */


















/*********************************************************************
 * CONSTANTS
 */

/*** Interrupts ***/


/*********************************************************************
 * TYPEDEFS
 */
typedef struct
{
  void   *next;
  uint16 len;
  uint8  dest_id;
} osal_msg_hdr_t;

typedef struct
{
  uint8  event;
  uint8  status;
} osal_event_hdr_t;

typedef void * osal_msg_q_t;

/*********************************************************************
 * GLOBAL VARIABLES
 */

/*********************************************************************
 * FUNCTIONS
 */

/*** Message Management ***/

  /*
   * Task Message Allocation
   */
  extern uint8 * osal_msg_allocate(uint16 len );

  /*
   * Task Message Deallocation
   */
  extern uint8 osal_msg_deallocate( uint8 *msg_ptr );

  /*
   * Send a Task Message
   */
  extern uint8 osal_msg_send( uint8 destination_task, uint8 *msg_ptr );

  /*
   * Push a Task Message to head of queue
   */
  extern uint8 osal_msg_push_front( uint8 destination_task, uint8 *msg_ptr );

  /*
   * Receive a Task Message
   */
  extern uint8 *osal_msg_receive( uint8 task_id );

  /*
   * Find in place a matching Task Message / Event.
   */
  extern osal_event_hdr_t *osal_msg_find(uint8 task_id, uint8 event);

  /*
   * Enqueue a Task Message
   */
  extern void osal_msg_enqueue( osal_msg_q_t *q_ptr, void *msg_ptr );

  /*
   * Enqueue a Task Message Up to Max
   */
  extern uint8 osal_msg_enqueue_max( osal_msg_q_t *q_ptr, void *msg_ptr, uint8 max );

  /*
   * Dequeue a Task Message
   */
  extern void *osal_msg_dequeue( osal_msg_q_t *q_ptr );

  /*
   * Push a Task Message to head of queue
   */
  extern void osal_msg_push( osal_msg_q_t *q_ptr, void *msg_ptr );

  /*
   * Extract and remove a Task Message from queue
   */
  extern void osal_msg_extract( osal_msg_q_t *q_ptr, void *msg_ptr, void *prev_ptr );


/*** Task Synchronization  ***/

  /*
   * Set a Task Event
   */
  extern uint8 osal_set_event( uint8 task_id, uint16 event_flag );


  /*
   * Clear a Task Event
   */
  extern uint8 osal_clear_event( uint8 task_id, uint16 event_flag );


/*** Interrupt Management  ***/

  /*
   * Register Interrupt Service Routine (ISR)
   */
  extern uint8 osal_isr_register( uint8 interrupt_id, void (*isr_ptr)( uint8* ) );

  /*
   * Enable Interrupt
   */
  extern uint8 osal_int_enable( uint8 interrupt_id );

  /*
   * Disable Interrupt
   */
  extern uint8 osal_int_disable( uint8 interrupt_id );


/*** Task Management  ***/

  /*
   * Initialize the Task System
   */
  extern uint8 osal_init_system( void );

  /*
   * System Processing Loop
   */



  extern void osal_start_system( void );


  /*
   * One Pass Throu the OSAL Processing Loop
   */
  extern void osal_run_system( void );

  /*
   * Get the active task ID
   */
  extern uint8 osal_self( void );


/*** Helper Functions ***/

  /*
   * String Length
   */
  extern int osal_strlen( char *pString );

  /*
   * Memory copy
   */
  extern void *osal_memcpy( void*, const void  *, unsigned int );

  /*
   * Memory Duplicate - allocates and copies
   */
  extern void *osal_memdup( const void  *src, unsigned int len );

  /*
   * Reverse Memory copy
   */
  extern void *osal_revmemcpy( void*, const void  *, unsigned int );

  /*
   * Memory compare
   */
  extern uint8 osal_memcmp( const void  *src1, const void  *src2, unsigned int len );

  /*
   * Memory set
   */
  extern void *osal_memset( void *dest, uint8 value, int len );

  /*
   * Build a uint16 out of 2 bytes (0 then 1).
   */
  extern uint16 osal_build_uint16( uint8 *swapped );

  /*
   * Build a uint32 out of sequential bytes.
   */
  extern uint32 osal_build_uint32( uint8 *swapped, uint8 len );

  /*
   * Convert long to ascii string
   */

    extern uint8 *_ltoa( uint32 l, uint8 * buf, uint8 radix );


  /*
   * Random number generator
   */
  extern uint16 osal_rand( void );

  /*
   * Buffer an uint32 value - LSB first.
   */
  extern uint8* osal_buffer_uint32( uint8 *buf, uint32 val );

  /*
   * Buffer an uint24 value - LSB first
   */
  extern uint8* osal_buffer_uint24( uint8 *buf, uint24 val );

  /*
   * Is all of the array elements set to a value?
   */
  extern uint8 osal_isbufset( uint8 *buf, uint8 val, uint8 len );

/*********************************************************************
*********************************************************************/





#line 43 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.h"
/**************************************************************************************************
  Filename:       hal_aes.h
  Revised:        $Date: 2012-05-23 14:51:42 -0700 (Wed, 23 May 2012) $
  Revision:       $Revision: 30615 $

  Description:    Support for HW/SW AES encryption.


  Copyright 2007-2012 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
**************************************************************************************************/









/* AES Engine is default to hardware AES. To turn on software AES, #define one of the followings:
 * #define SOFTWARE_AES TRUE, uses software aes  ( slowest setting )
 * #define SW_AES_AND_KEY_EXP TRUE, enables software aes with key expansion ( improves speed at the cost of 176 bytes of data (RAM) )
 */




extern void HalAesInit( void );
extern void AesLoadBlock( uint8 * );
extern void AesStartBlock( uint8 *, uint8 * );
extern void AesStartShortBlock( uint8 *, uint8 * );
extern void AesLoadIV(uint8 *);
extern void AesDmaSetup( uint8 *, uint16, uint8 *, uint16 );
extern void AesLoadKey( uint8 * );

extern void (*pSspAesEncrypt)( uint8 *, uint8 * );
extern void ssp_HW_KeyInit (uint8 *);
extern void sspKeyExpansion (uint8 *, uint8 *);

extern void sspAesEncryptHW (uint8 *, uint8 *);
extern void sspAesEncryptKeyExp (uint8 *, uint8 *);
extern void sspAesEncryptBasic (uint8 *, uint8 *);

extern void sspAesDecryptHW( uint8 *, uint8 * );
extern void sspAesDecrypt( uint8 *key, uint8 *buf );

// AES Status




// Macro for setting the mode of the AES operation





// AES Modes
#line 93 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.h"

// Macro for issuing AES command





// AES Commands





// Macro for starting the AES module for either encryption, decryption,
// key or initialisation vector loading.


/* Used by DMA macros to shift 1 to create a mask for DMA registers. */



/* AES registers */



#line 125 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.h"

#line 44 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_dma.h"
/**************************************************************************************************
  Filename:      hal_dma.h
  Revised:        $Date: 2011-08-23 08:53:54 -0700 (Tue, 23 Aug 2011) $
  Revision:       $Revision: 27253 $

  Description:   This file contains the interface to the DMA Service.


  Copyright 2007-2010 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, 
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE, 
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com. 
**************************************************************************************************/









/*********************************************************************
 * INCLUDES
 */

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_board.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"
/*******************************************************************************
  Filename:       hal_board_cfg.h
  Revised:        $Date: 2013-02-27 11:32:02 -0800 (Wed, 27 Feb 2013) $
  Revision:       $Revision: 33315 $

  Description:

  Abstract board-specific registers, addresses, & initialization for H/W based on the
  Texas Instruments CC254x (8051 core).


  Copyright 2006-2013 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
*******************************************************************************/









/*******************************************************************************
 * INCLUDES
 */

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"
/**************************************************************************************************
  Filename:       hal_mcu.h
  Revised:        $Date: 2012-07-13 06:58:11 -0700 (Fri, 13 Jul 2012) $
  Revision:       $Revision: 30922 $

  Description:    Describe the purpose and contents of the file.


  Copyright 2006-2010 Texas Instruments Incorporated. All rights reserved.

  IMPORTANT: Your use of this Software is limited to those specific rights
  granted under the terms of a software license agreement between the user
  who downloaded the software, his/her employer (which must be your employer)
  and Texas Instruments Incorporated (the "License").  You may not use this
  Software unless you agree to abide by the terms of the License. The License
  limits your use, and you acknowledge, that the Software may not be modified,
  copied or distributed unless embedded on a Texas Instruments microcontroller
  or used solely and exclusively in conjunction with a Texas Instruments radio
  frequency transceiver, which is integrated into your product.  Other than for
  the foregoing purpose, you may not use, reproduce, copy, prepare derivative
  works of, modify, distribute, perform, display or sell this Software and/or
  its documentation for any purpose.

  YOU FURTHER ACKNOWLEDGE AND AGREE THAT THE SOFTWARE AND DOCUMENTATION ARE
  PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY, TITLE,
  NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL
  TEXAS INSTRUMENTS OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER CONTRACT,
  NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR OTHER
  LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
  INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE
  OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT
  OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
  (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

  Should you have any questions regarding your right to use this Software,
  contact Texas Instruments Incorporated at www.TI.com.
**************************************************************************************************/




/*
 *  Target : Texas Instruments CC2540 (8051 core)
 *
 */


/* ------------------------------------------------------------------------------------------------
 *                                           Includes
 * ------------------------------------------------------------------------------------------------
 */




/* ------------------------------------------------------------------------------------------------
 *                                        Target Defines
 * ------------------------------------------------------------------------------------------------
 */



/* ------------------------------------------------------------------------------------------------
 *                                     Compiler Abstraction
 * ------------------------------------------------------------------------------------------------
 */

/* ---------------------- IAR Compiler ---------------------- */


#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"
/**************************************************************************************************
 *                                        - ioCC2540.h -
 *
 * Header file with definitions for the Texas Instruments CC2540 low-power System-on-Chip:
 * an 8051-based MCU with 2.4 GHz Bluetooth low energy RF transceiver, and up to 256 kB FLASH.
 *
 * This file supports the IAR Embedded Workbench for 8051.
 *
 **************************************************************************************************
 */




/* ------------------------------------------------------------------------------------------------
 *                                      Compiler Abstraction
 * ------------------------------------------------------------------------------------------------
 */

#pragma language=extended
#line 41 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 77 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"


/* ------------------------------------------------------------------------------------------------
 *                                        Interrupt Vectors
 * ------------------------------------------------------------------------------------------------
 */
#line 101 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

/* ------------------------------------------------------------------------------------------------
 *                                     Interrupt Alias
 * ------------------------------------------------------------------------------------------------
 */



/* ------------------------------------------------------------------------------------------------
 *                                      SFR Bit Alias
 * ------------------------------------------------------------------------------------------------
 */

/*       USBIE     P2IE              ,   not in a bit addressable register                   */

/* ------------------------------------------------------------------------------------------------
 *                                            SFRs
 * ------------------------------------------------------------------------------------------------
 */

/*
 *   SFRs with an address ending with 0 or 8 are bit accessible.
 *   They are defined with the SFRBIT() macro that sets the name of each bit.
 */

/* Port 0                                                                           */
__sfr __no_init volatile union { unsigned char P0; struct { unsigned char P0_0 : 1; unsigned char P0_1 : 1; unsigned char P0_2 : 1; unsigned char P0_3 : 1; unsigned char P0_4 : 1; unsigned char P0_5 : 1; unsigned char P0_6 : 1; unsigned char P0_7 : 1; }; } @ 0x80;
__sfr __no_init volatile unsigned char SP @ 0x81;   /*  Stack Pointer                                      */
__sfr __no_init volatile unsigned char DPL0 @ 0x82;   /*  Data Pointer 0 Low Byte                            */
__sfr __no_init volatile unsigned char DPH0 @ 0x83;   /*  Data Pointer 0 High Byte                           */
__sfr __no_init volatile unsigned char DPL1 @ 0x84;   /*  Data Pointer 1 Low Byte                            */
__sfr __no_init volatile unsigned char DPH1 @ 0x85;   /*  Data Pointer 1 High Byte                           */
__sfr __no_init volatile unsigned char U0CSR @ 0x86;   /*  USART 0 Control and Status                         */
__sfr __no_init volatile unsigned char PCON @ 0x87;   /*  Power Mode Control                                 */

/* Interrupt Flags                                                                  */
__sfr __no_init volatile union { unsigned char TCON; struct { unsigned char IT0 : 1; unsigned char RFERRIF : 1; unsigned char IT1 : 1; unsigned char URX0IF : 1; unsigned char _TCON4 : 1; unsigned char ADCIF : 1; unsigned char _TCON6 : 1; unsigned char URX1IF : 1; }; } @ 0x88;
__sfr __no_init volatile unsigned char P0IFG @ 0x89;   /*  Port 0 Interrupt Status Flag                       */
__sfr __no_init volatile unsigned char P1IFG @ 0x8A;   /*  Port 1 Interrupt Status Flag                       */
__sfr __no_init volatile unsigned char P2IFG @ 0x8B;   /*  Port 2 Interrupt Status Flag                       */
__sfr __no_init volatile unsigned char PICTL @ 0x8C;   /*  Port Interrupt Control                             */
__sfr __no_init volatile unsigned char P1IEN @ 0x8D;   /*  Port 1 Interrupt Mask                              */
__sfr __no_init volatile unsigned char _SFR8E @ 0x8E;   /*  not used                                           */
__sfr __no_init volatile unsigned char P0INP @ 0x8F;   /*  Port 0 Input Mode                                  */

/* Port 1                                                                           */
__sfr __no_init volatile union { unsigned char P1; struct { unsigned char P1_0 : 1; unsigned char P1_1 : 1; unsigned char P1_2 : 1; unsigned char P1_3 : 1; unsigned char P1_4 : 1; unsigned char P1_5 : 1; unsigned char P1_6 : 1; unsigned char P1_7 : 1; }; } @ 0x90;
__sfr __no_init volatile unsigned char _SFR91 @ 0x91;   /*  reserved                                           */
__sfr __no_init volatile unsigned char DPS @ 0x92;   /*  Data Pointer Select                                */
__sfr __no_init volatile unsigned char MPAGE @ 0x93;   /*  Memory Page Select                                 */
__sfr __no_init volatile unsigned char T2CTRL @ 0x94;   /*  Timer2 Control Register                            */
__sfr __no_init volatile unsigned char ST0 @ 0x95;   /*  Sleep Timer 0                                      */
__sfr __no_init volatile unsigned char ST1 @ 0x96;   /*  Sleep Timer 1                                      */
__sfr __no_init volatile unsigned char ST2 @ 0x97;   /*  Sleep Timer 2                                      */

/*  Interrupt Flags 2                                                               */
__sfr __no_init volatile union { unsigned char S0CON; struct { unsigned char ENCIF_0 : 1; unsigned char ENCIF_1 : 1; unsigned char _S0CON2 : 1; unsigned char _S0CON3 : 1; unsigned char _S0CON4 : 1; unsigned char _S0CON5 : 1; unsigned char _S0CON6 : 1; unsigned char _S0CON7 : 1; }; } @ 0x98;
__sfr __no_init volatile unsigned char _SFR99 @ 0x99;   /*  reserved                                           */
__sfr __no_init volatile unsigned char IEN2 @ 0x9A;   /*  Interrupt Enable 2                                 */
__sfr __no_init volatile unsigned char S1CON @ 0x9B;   /*  Interrupt Flags 3                                  */
__sfr __no_init volatile unsigned char T2CSPCFG @ 0x9C;   /*  Timer2 CSP Interface Configuration (legacy name)   */
__sfr __no_init volatile unsigned char T2EVTCFG @ 0x9C;   /*  Timer2 Event Output Configuration                  */
__sfr __no_init volatile unsigned char SLEEPSTA @ 0x9D;   /*  Sleep Status                                       */
__sfr __no_init volatile unsigned char CLKCONSTA @ 0x9E;   /*  Clock Control Status                               */
__sfr __no_init volatile unsigned char FMAP @ 0x9F;   /*  Flash Bank Map                                     */

/* Port 2                                                                           */
__sfr __no_init volatile union { unsigned char P2; struct { unsigned char P2_0 : 1; unsigned char P2_1 : 1; unsigned char P2_2 : 1; unsigned char P2_3 : 1; unsigned char P2_4 : 1; unsigned char _P2_5 : 1; unsigned char _P2_6 : 1; unsigned char _P2_7 : 1; }; } @ 0xA0;
__sfr __no_init volatile unsigned char T2IRQF @ 0xA1;   /* Timer2 Interrupt Flags                              */
__sfr __no_init volatile unsigned char T2M0 @ 0xA2;   /* Timer2 Multiplexed Register 0                       */
__sfr __no_init volatile unsigned char T2M1 @ 0xA3;   /* Timer2 Multiplexed Register 1                       */
__sfr __no_init volatile unsigned char T2MOVF0 @ 0xA4;   /* Timer2 Multiplexed Overflow Register 0              */
__sfr __no_init volatile unsigned char T2MOVF1 @ 0xA5;   /* Timer2 Multiplexed Overflow Register 1              */
__sfr __no_init volatile unsigned char T2MOVF2 @ 0xA6;   /* Timer2 Multiplexed Overflow Register 2              */
__sfr __no_init volatile unsigned char T2IRQM @ 0xA7;   /* Timer2 Interrupt Mask                               */

/* Interrupt Enable 0                                                               */
__sfr __no_init volatile union { unsigned char IEN0; struct { unsigned char RFERRIE : 1; unsigned char ADCIE : 1; unsigned char URX0IE : 1; unsigned char URX1IE : 1; unsigned char ENCIE : 1; unsigned char STIE : 1; unsigned char _IEN06 : 1; unsigned char EA : 1; }; } @ 0xA8;
__sfr __no_init volatile unsigned char IP0 @ 0xA9;   /*  Interrupt Priority 0                               */
__sfr __no_init volatile unsigned char _SFRAA @ 0xAA;   /*  not used                                           */
__sfr __no_init volatile unsigned char P0IEN @ 0xAB;   /*  Port 0 Interrupt Mask                              */
__sfr __no_init volatile unsigned char P2IEN @ 0xAC;   /*  Port 2 Interrupt Mask                              */
__sfr __no_init volatile unsigned char STLOAD @ 0xAD;   /*  Sleep Timer Load Status                            */
__sfr __no_init volatile unsigned char PMUX @ 0xAE;   /*  Power Down Signal MUX                              */
__sfr __no_init volatile unsigned char T1STAT @ 0xAF;   /*  Timer 1 Status                                     */

__sfr __no_init volatile unsigned char _SFRB0 @ 0xB0;   /*  not used                                           */
__sfr __no_init volatile unsigned char ENCDI @ 0xB1;   /*  Encryption/Decryption Input Data                   */
__sfr __no_init volatile unsigned char ENCDO @ 0xB2;   /*  Encryption/Decryption Output Data                  */
__sfr __no_init volatile unsigned char ENCCS @ 0xB3;   /*  Encryption/Decryption Control and Status           */
__sfr __no_init volatile unsigned char ADCCON1 @ 0xB4;   /*  ADC Control 1                                      */
__sfr __no_init volatile unsigned char ADCCON2 @ 0xB5;   /*  ADC Control 2                                      */
__sfr __no_init volatile unsigned char ADCCON3 @ 0xB6;   /*  ADC Control 3                                      */
__sfr __no_init volatile unsigned char _SFRB7 @ 0xB7;   /*  reserved                                           */

/*  Interrupt Enable 1                                                              */
__sfr __no_init volatile union { unsigned char IEN1; struct { unsigned char DMAIE : 1; unsigned char T1IE : 1; unsigned char T2IE : 1; unsigned char T3IE : 1; unsigned char T4IE : 1; unsigned char P0IE : 1; unsigned char _IEN16 : 1; unsigned char _IEN17 : 1; }; } @ 0xB8;
__sfr __no_init volatile unsigned char IP1 @ 0xB9;   /*  Interrupt Priority 1                               */
__sfr __no_init volatile unsigned char ADCL @ 0xBA;   /*  ADC Data Low                                       */
__sfr __no_init volatile unsigned char ADCH @ 0xBB;   /*  ADC Data High                                      */
__sfr __no_init volatile unsigned char RNDL @ 0xBC;   /*  Random Number Generator Low Byte                   */
__sfr __no_init volatile unsigned char RNDH @ 0xBD;   /*  Random Number Generator High Byte                  */
__sfr __no_init volatile unsigned char SLEEPCMD @ 0xBE;   /*  Sleep Mode Control Command                         */
__sfr __no_init volatile unsigned char _SFRBF @ 0xBF;   /*  reserved                                           */

/*  Interrupt Flags 4                                                               */
__sfr __no_init volatile union { unsigned char IRCON; struct { unsigned char DMAIF : 1; unsigned char T1IF : 1; unsigned char T2IF : 1; unsigned char T3IF : 1; unsigned char T4IF : 1; unsigned char P0IF : 1; unsigned char _IRCON6 : 1; unsigned char STIF : 1; }; } @ 0xC0;
__sfr __no_init volatile unsigned char U0DBUF @ 0xC1;   /*  USART 0 Receive/Transmit Data Buffer               */
__sfr __no_init volatile unsigned char U0BAUD @ 0xC2;   /*  USART 0 Baud Rate Control                          */
__sfr __no_init volatile unsigned char T2MSEL @ 0xC3;   /*  Timer2 Multiplex Select                            */
__sfr __no_init volatile unsigned char U0UCR @ 0xC4;   /*  USART 0 UART Control                               */
__sfr __no_init volatile unsigned char U0GCR @ 0xC5;   /*  USART 0 Generic Control                            */
__sfr __no_init volatile unsigned char CLKCONCMD @ 0xC6;   /*  Clock Control Command                              */
__sfr __no_init volatile unsigned char MEMCTR @ 0xC7;   /*  Memory System Control                              */

__sfr __no_init volatile unsigned char _SFRC8 @ 0xC8;   /*  not used                                           */
__sfr __no_init volatile unsigned char WDCTL @ 0xC9;   /*  Watchdog Timer Control                             */
__sfr __no_init volatile unsigned char T3CNT @ 0xCA;   /*  Timer 3 Counter                                    */
__sfr __no_init volatile unsigned char T3CTL @ 0xCB;   /*  Timer 3 Control                                    */
__sfr __no_init volatile unsigned char T3CCTL0 @ 0xCC;   /*  Timer 3 Channel 0 Capture/Compare Control          */
__sfr __no_init volatile unsigned char T3CC0 @ 0xCD;   /*  Timer 3 Channel 0 Capture/Compare Value            */
__sfr __no_init volatile unsigned char T3CCTL1 @ 0xCE;   /*  Timer 3 Channel 1 Capture/Compare Control          */
__sfr __no_init volatile unsigned char T3CC1 @ 0xCF;   /*  Timer 3 Channel 1 Capture/Compare Value            */

 /*  Program Status Word                                                            */
__sfr __no_init volatile union { unsigned char PSW; struct { unsigned char P : 1; unsigned char F1 : 1; unsigned char OV : 1; unsigned char RS0 : 1; unsigned char RS1 : 1; unsigned char F0 : 1; unsigned char AC : 1; unsigned char CY : 1; }; } @ 0xD0;
__sfr __no_init volatile unsigned char DMAIRQ @ 0xD1;   /*  DMA Interrupt Flag                                 */
__sfr __no_init volatile unsigned char DMA1CFGL @ 0xD2;   /*  DMA Channel 1-4 Configuration Address Low Byte     */
__sfr __no_init volatile unsigned char DMA1CFGH @ 0xD3;   /*  DMA Channel 1-4 Configuration Address High Byte    */
__sfr __no_init volatile unsigned char DMA0CFGL @ 0xD4;   /*  DMA Channel 0 Configuration Address Low Byte       */
__sfr __no_init volatile unsigned char DMA0CFGH @ 0xD5;   /*  DMA Channel 0 Configuration Address High Byte      */
__sfr __no_init volatile unsigned char DMAARM @ 0xD6;   /*  DMA Channel Arm                                    */
__sfr __no_init volatile unsigned char DMAREQ @ 0xD7;   /*  DMA Channel Start Request and Status               */

/*  Timers 1/3/4 Interrupt Mask/Flag                                                */
__sfr __no_init volatile union { unsigned char TIMIF; struct { unsigned char T3OVFIF : 1; unsigned char T3CH0IF : 1; unsigned char T3CH1IF : 1; unsigned char T4OVFIF : 1; unsigned char T4CH0IF : 1; unsigned char T4CH1IF : 1; unsigned char T1OVFIM : 1; unsigned char _TIMIF7 : 1; }; } @ 0xD8;
__sfr __no_init volatile unsigned char _SFRD9 @ 0xD9;   /*  reserved                                           */
__sfr __no_init volatile unsigned char T1CC0L @ 0xDA;   /*  Timer 1 Channel 0 Capture/Compare Value Low Byte   */
__sfr __no_init volatile unsigned char T1CC0H @ 0xDB;   /*  Timer 1 Channel 0 Capture/Compare Value High Byte  */
__sfr __no_init volatile unsigned char T1CC1L @ 0xDC;   /*  Timer 1 Channel 1 Capture/Compare Value Low Byte   */
__sfr __no_init volatile unsigned char T1CC1H @ 0xDD;   /*  Timer 1 Channel 1 Capture/Compare Value High Byte  */
__sfr __no_init volatile unsigned char T1CC2L @ 0xDE;   /*  Timer 1 Channel 2 Capture/Compare Value Low Byte   */
__sfr __no_init volatile unsigned char T1CC2H @ 0xDF;   /*  Timer 1 Channel 2 Capture/Compare Value High Byte  */

__sfr __no_init volatile unsigned char ACC @ 0xE0;   /*  Accumulator                                        */
__sfr __no_init volatile unsigned char _SFRE1 @ 0xE1;   /*  reserved                                           */
__sfr __no_init volatile unsigned char T1CNTL @ 0xE2;   /*  Timer 1 Counter Low                                */
__sfr __no_init volatile unsigned char T1CNTH @ 0xE3;   /*  Timer 1 Counter High                               */
__sfr __no_init volatile unsigned char T1CTL @ 0xE4;   /*  Timer 1 Control And Status                         */
__sfr __no_init volatile unsigned char T1CCTL0 @ 0xE5;   /*  Timer 1 Channel 0 Capture/Compare Control          */
__sfr __no_init volatile unsigned char T1CCTL1 @ 0xE6;   /*  Timer 1 Channel 1 Capture/Compare Control          */
__sfr __no_init volatile unsigned char T1CCTL2 @ 0xE7;   /*  Timer 1 Channel 2 Capture/Compare Control          */

/*  Interrupt Flags 5                                                               */
__sfr __no_init volatile union { unsigned char IRCON2; struct { unsigned char P2IF : 1; unsigned char UTX0IF : 1; unsigned char UTX1IF : 1; unsigned char P1IF : 1; unsigned char WDTIF : 1; unsigned char _IRCON25 : 1; unsigned char _IRCON26 : 1; unsigned char _IRCON27 : 1; }; } @ 0xE8;
__sfr __no_init volatile unsigned char _SFRE9 @ 0xE9;   /*  reserved                                           */
__sfr __no_init volatile unsigned char T4CNT @ 0xEA;   /*  Timer 4 Counter                                    */
__sfr __no_init volatile unsigned char T4CTL @ 0xEB;   /*  Timer 4 Control                                    */
__sfr __no_init volatile unsigned char T4CCTL0 @ 0xEC;   /*  Timer 4 Channel 0 Capture/Compare Control          */
__sfr __no_init volatile unsigned char T4CC0 @ 0xED;   /*  Timer 4 Channel 0 Capture/Compare Value            */
__sfr __no_init volatile unsigned char T4CCTL1 @ 0xEE;   /*  Timer 4 Channel 1 Capture/Compare Control          */
__sfr __no_init volatile unsigned char T4CC1 @ 0xEF;   /*  Timer 4 Channel 1 Capture/Compare Value            */

__sfr __no_init volatile unsigned char B @ 0xF0;   /*  B Register                                         */
__sfr __no_init volatile unsigned char PERCFG @ 0xF1;   /*  Peripheral I/O Control                             */
__sfr __no_init volatile unsigned char ADCCFG @ 0xF2;   /*  ADC Input Configuration (legacy name)              */
__sfr __no_init volatile unsigned char APCFG @ 0xF2;   /*  Analog Periferal I/O Configuration                 */
__sfr __no_init volatile unsigned char P0SEL @ 0xF3;   /*  Port 0 Function Select                             */
__sfr __no_init volatile unsigned char P1SEL @ 0xF4;   /*  Port 1 Function Select                             */
__sfr __no_init volatile unsigned char P2SEL @ 0xF5;   /*  Port 2 Function Select                             */
__sfr __no_init volatile unsigned char P1INP @ 0xF6;   /*  Port 1 Input Mode                                  */
__sfr __no_init volatile unsigned char P2INP @ 0xF7;   /*  Port 2 Input Mode                                  */

/*  USART 1 Control and Status                                                      */
__sfr __no_init volatile union { unsigned char U1CSR; struct { unsigned char U1ACTIVE : 1; unsigned char U1TX_BYTE : 1; unsigned char U1RX_BYTE : 1; unsigned char U1ERR : 1; unsigned char U1FE : 1; unsigned char U1SLAVE : 1; unsigned char U1RE : 1; unsigned char U1MODE : 1; }; } @ 0xF8;
__sfr __no_init volatile unsigned char U1DBUF @ 0xF9;   /*  USART 1 Receive/Transmit Data Buffer               */
__sfr __no_init volatile unsigned char U1BAUD @ 0xFA;   /*  USART 1 Baud Rate Control                          */
__sfr __no_init volatile unsigned char U1UCR @ 0xFB;   /*  USART 1 UART Control                               */
__sfr __no_init volatile unsigned char U1GCR @ 0xFC;   /*  USART 1 Generic Control                            */
__sfr __no_init volatile unsigned char P0DIR @ 0xFD;   /*  Port 0 Direction                                   */
__sfr __no_init volatile unsigned char P1DIR @ 0xFE;   /*  Port 1 Direction                                   */
__sfr __no_init volatile unsigned char P2DIR @ 0xFF;   /*  Port 2 Direction                                   */


/* ------------------------------------------------------------------------------------------------
 *                                       Xdata Radio Registers
 * ------------------------------------------------------------------------------------------------
 */
/* Radio Control Registers */



/* ------------------------------------------------------------------------------------------------
 *                                       Xdata USB Registers
 * ------------------------------------------------------------------------------------------------
 */
#line 329 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

/* ------------------------------------------------------------------------------------------------
 *                                       Xdata Registers
 * ------------------------------------------------------------------------------------------------
 */
/* Observability Control */
#line 345 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

/* Chip Identification */



/* Debug Interface DMA Write to Flash */


/* Flash Controller */
#line 360 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

/* Chip Information */



/* IR Generation Control */


/* Clock Loss Detector */


/* Timer 1 Channels (only mapped as XREG) */
#line 378 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"
/* Definition which includes channels represented in SFR (additional XREG mapping of SFR) */
#line 394 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"
/* Pointers for array access */



/* Sleep Timer Capture Control */






/* Op.Amp. Control */




/* Analog Comparator Control */


/* ------------------------------------------------------------------------------------------------
 *                                      Xdata Mapped SFRs
 * ------------------------------------------------------------------------------------------------
 */

/*
 *   Most SFRs are also accessible through XDATA address space.  The register definitions for
 *   this type of access are listed below.  The register names are identical to the SFR names
 *   but with the prefix X_ to denote an XDATA register.
 *
 *   Some SFRs are not accessible through XDATA space.  For clarity, entries are included for these
 *   registers.  They have a prefix of _NA to denote "not available."
 *
 *   For register descriptions, refer to the actual SFR declartions elsewhere in this file.
 */

#line 437 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 446 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 455 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 465 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 474 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 483 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 492 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 501 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 510 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 519 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 528 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 537 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 546 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 555 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 565 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

#line 574 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\ioCC2540.h"

/* ------------------------------------------------------------------------------------------------
 *                                       Flash
 * ------------------------------------------------------------------------------------------------
 */



/* ------------------------------------------------------------------------------------------------
 */


#pragma language=default


/**************************************************************************************************
 */
#line 76 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"


#line 84 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

/* ---------------------- Keil Compiler ---------------------- */
#line 104 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"


/* ------------------------------------------------------------------------------------------------
 *                                        Interrupt Macros
 * ------------------------------------------------------------------------------------------------
 */




typedef unsigned char halIntState_t;





  /* IAR library uses XCH instruction with EA. It may cause the higher priority interrupt to be
   * locked out, therefore, may increase interrupt latency.  It may also create a lockup condition.
   * This workaround should only be used with 8051 using IAR compiler. When IAR fixes this by
   * removing XCH usage in its library, compile the following macros to null to disable them.
   */
#line 131 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

/* ------------------------------------------------------------------------------------------------
 *                                        Reset Macro
 * ------------------------------------------------------------------------------------------------
 */
#line 142 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

/* disable interrupts, set watchdog timer, wait for reset */


/* ------------------------------------------------------------------------------------------------
 *                                        CC2540 rev numbers
 * ------------------------------------------------------------------------------------------------
 */





/* ------------------------------------------------------------------------------------------------
 *                                        CC2540 sleep common code
 * ------------------------------------------------------------------------------------------------
 */

/* PCON bit definitions */


/* SLEEPCMD bit definitions */



/* SLEEPSTA bit definitions */



/* SLEEPCMD and SLEEPSTA bit definitions */



/* CLKCONCMD bit definitions */






/* STLOAD */




#line 199 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

/**************************************************************************************************
 */
#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"



/*******************************************************************************
 * CONSTANTS
 */

/* Board Identifier */





/* Clock Speed */



/* Sleep Clock */




// For non-USB, assume external, unless an internal crystal is explicitly indicated.






// Minimum Time for Stable External 32kHz Clock (in ms)


/* LCD Max Chars and Buffer */



/* LED Configuration */

#line 101 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"



/* 1 - Green */






  /* 2 - Red */





  /* 3 - Yellow */






/* Push Button Configuration */




/* S1 */



#line 140 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Joystick Center Press */




/* OSAL NV implemented by internal flash pages. */

// Flash is partitioned into 8 banks of 32 KB or 16 pages.


// Flash is constructed of 128 pages of 2 KB.


// SNV can use a larger logical page size to accomodate more or bigger items or extend lifetime.



// CODE banks get mapped into the XDATA range 8000-FFFF.


// The last 16 bytes of the last available page are reserved for flash lock bits.


// NV page definitions must coincide with segment declaration in project *.xcl file.
#line 172 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

// Re-defining Z_EXTADDR_LEN here so as not to include a Z-Stack .h file.








// Used by DMA macros to shift 1 to create a mask for DMA registers.







/* Critical Vdd Monitoring to prevent flash damage or radio lockup. */

// Vdd/3 / Internal Reference X ENOB --> (Vdd / 3) / 1.15 X 127







/*******************************************************************************
 * MACROS
 */

/* Cache Prefetch Control */




/* Setting Clocks */

// switch to the 16MHz HSOSC and wait until it is stable






// switch to the 32MHz XOSC and wait until it is stable






// set 32kHz OSC and wait until it is stable

















/* Board Initialization */
#line 256 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Debounce */


/* ----------- Push Buttons ---------- */
#line 267 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* LED's */























#line 315 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* XNV */







// The TI reference design uses UART1 Alt. 2 in SPI mode.
#line 356 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Driver Configuration */

/* Set to TRUE enable H/W TIMER usage, FALSE disable it */




/* Set to TRUE enable ADC usage, FALSE disable it */




/* Set to TRUE enable DMA usage, FALSE disable it */




/* Set to TRUE enable Flash access, FALSE disable it */




/* Set to TRUE enable AES usage, FALSE disable it */








/* Set to TRUE enable LCD usage, FALSE disable it */




/* Set to TRUE enable LED usage, FALSE disable it */
#line 400 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Set to TRUE enable KEY usage, FALSE disable it */




/* Set to TRUE enable UART usage, FALSE disable it */
#line 414 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"


  // Always prefer to use DMA over ISR.
#line 444 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"
  
  // Used to set P2 priority - USART0 over USART1 if both are defined.





  















/*******************************************************************************
*/
#line 2 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_board.h"
#line 53 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_dma.h"




/*********************************************************************
 * MACROS
 */





























// Macro for quickly setting the source address of a DMA structure.






// Macro for quickly setting the destination address of a DMA structure.






// Macro for quickly setting the number of bytes to be transferred by the DMA,
// max length is 0x1FFF.
#line 111 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_dma.h"




























































/*********************************************************************
 * CONSTANTS
 */

// Use LEN for transfer count

// Transfer the first byte + the number of bytes indicated by the first byte

// Transfer the number of bytes indicated by the first byte (starting with the first byte)

// Transfer the first byte + the number of bytes indicated by the first byte + 1 more byte

// Transfer the first byte + the number of bytes indicated by the first byte + 2 more bytes










#line 225 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_dma.h"
























/*********************************************************************
 * TYPEDEFS
 */

// Bit fields of the 'lenModeH'



// Bit fields of the 'ctrlA'




// Bit fields of the 'ctrlB'






typedef struct {
  uint8 srcAddrH;
  uint8 srcAddrL;
  uint8 dstAddrH;
  uint8 dstAddrL;
  uint8 xferLenV;
  uint8 xferLenL;
  uint8 ctrlA;
  uint8 ctrlB;
} halDMADesc_t;

/*********************************************************************
 * GLOBAL VARIABLES
 */

extern halDMADesc_t dmaCh0;
extern halDMADesc_t dmaCh1234[4];

/*********************************************************************
 * FUNCTIONS - API
 */

void HalDmaInit( void );









/******************************************************************************
******************************************************************************/
#line 45 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"

/******************************************************************************
 * MACROS
 */

/******************************************************************************
 * CONSTANTS
 */

/******************************************************************************
 * TYPEDEFS
 */

/******************************************************************************
 * LOCAL VARIABLES
 */

/******************************************************************************
 * GLOBAL VARIABLES
 */

void (*pSspAesEncrypt)( uint8 *, uint8 * ) = (void*)0;

/******************************************************************************
 * FUNCTION PROTOTYPES
 */
void aesDmaInit( void );


/******************************************************************************
 * @fn      aesDmaInit
 *
 * @brief   Initilize DMA for AES engine
 *
 * input parameters
 *
 * @param   None
 *
 * @return  None
 */
void aesDmaInit( void )
{
  halDMADesc_t *ch;

  /* Fill in DMA channel 1 descriptor and define it as input */
  ch = (dmaCh1234+((1)-1));
  do { ch->dstAddrH = (uint8)((uint16)(0x70B1) >> 8); ch->dstAddrL = (uint8)((uint16)(0x70B1) & 0xFF); } while (91 == -1);              /* Input of the AES module */
  do { ch->xferLenV &= ~0xE0; ch->xferLenV |= (0x00 << 5); } while (92 == -1);         /* Using the length field */
  do { ch->ctrlA &= ~0x80; ch->ctrlA |= (0x00 << 7); } while (93 == -1);   /* One byte is transferred each time */
  do { ch->ctrlA &= ~0x60; ch->ctrlA |= (0x00 << 5); } while (94 == -1);    /* A single byte is transferred each time */
  do { ch->ctrlA &= ~0x1F; ch->ctrlA |= 29; } while (95 == -1);      /* Setting the AES module to generate the DMA trigger */
  do { ch->ctrlB &= ~0xC0; ch->ctrlB |= (0x01 << 6); } while (96 == -1);          /* The address for data fetch is incremented by 1 byte */
  do { ch->ctrlB &= ~0x30; ch->ctrlB |= (0x00 << 4); } while (97 == -1);          /* The destination address is constant */
  do { ch->ctrlB &= ~0x08; ch->ctrlB |= (0x00 << 3); } while (98 == -1);       /* The DMA complete interrupt flag is not set at completion */
  do { ch->ctrlB &= ~0x04; ch->ctrlB |= (0x00 << 2); } while (99 == -1);          /* Transferring all 8 bits in each byte */
  do { ch->ctrlB &= ~0x03; ch->ctrlB |= 0x02; } while (100 == -1);         /* DMA has priority */

  /* Fill in DMA channel 2 descriptor and define it as output */
  ch = (dmaCh1234+((2)-1));
  do { ch->srcAddrH = (uint8)((uint16)(0x70B2) >> 8); ch->srcAddrL = (uint8)((uint16)(0x70B2) & 0xFF); } while (104 == -1);           /* Start address of the segment */
  do { ch->xferLenV &= ~0xE0; ch->xferLenV |= (0x00 << 5); } while (105 == -1);         /* Using the length field */
  do { ch->ctrlA &= ~0x80; ch->ctrlA |= (0x00 << 7); } while (106 == -1);   /* One byte is transferred each time */
  do { ch->ctrlA &= ~0x60; ch->ctrlA |= (0x00 << 5); } while (107 == -1);    /* A single byte is transferred each time */
  do { ch->ctrlA &= ~0x1F; ch->ctrlA |= 30; } while (108 == -1);      /* Setting the AES module to generate the DMA trigger */
  do { ch->ctrlB &= ~0xC0; ch->ctrlB |= (0x00 << 6); } while (109 == -1);          /* The address for data fetch is constant */
  do { ch->ctrlB &= ~0x30; ch->ctrlB |= (0x01 << 4); } while (110 == -1);          /* The destination address is incremented by 1 byte */
  do { ch->ctrlB &= ~0x08; ch->ctrlB |= (0x00 << 3); } while (111 == -1);       /* The DMA complete interrupt flag is not set at completion */
  do { ch->ctrlB &= ~0x04; ch->ctrlB |= (0x00 << 2); } while (112 == -1);          /* Transferring all 8 bits in each byte */
  do { ch->ctrlB &= ~0x03; ch->ctrlB |= 0x02; } while (113 == -1);         /* DMA has priority */
}


#line 216 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"

/******************************************************************************
 * @fn      AesLoadIV
 *
 * @brief   Writes IV into the CC2540
 *
 * input parameters
 *
 * @param   IV  - Pointer to IV.
 *
 * @return  None
 */
void AesLoadIV( uint8 *IV )
{

  halDMADesc_t *ch = (dmaCh1234+((1)-1));

  /* Modify descriptors for channel 1 */
  do { ch->srcAddrH = (uint8)((uint16)(IV) >> 8); ch->srcAddrL = (uint8)((uint16)(IV) & 0xFF); } while (234 == -1);
  do { ch->xferLenL = (uint8)(uint16)(16); ch->xferLenV &= ~0x1F; ch->xferLenV |= (uint8)((uint16)(16) >> 8); } while (235 == -1);

  /* Arm DMA channel 1 */
  DMAIRQ &= ~( 1 << (1) );
  DMAARM = (0x01 << (1));
  do {
    asm("NOP");
  } while (!(DMAARM & (0x01 << (1))));

  /* Set AES mode */
  do { ENCCS = (ENCCS & ~0x07) | (0x06); } while(0);

  /* Kick it off, block until AES is ready */
  ENCCS |= 0x01;
  while( !(ENCCS & 0x08) );
#line 257 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"
}

/******************************************************************************
 * @fn      AesLoadKey
 *
 * @brief   Writes the key into the CC2540
 *
 * input parameters
 *
 * @param   AesKey  - Pointer to AES Key.
 *
 * @return  None
 */
void AesLoadKey( uint8 *AesKey )
{

  halDMADesc_t *ch = (dmaCh1234+((1)-1));

  /* Modify descriptors for channel 1 */
  do { ch->srcAddrH = (uint8)((uint16)(AesKey) >> 8); ch->srcAddrL = (uint8)((uint16)(AesKey) & 0xFF); } while (276 == -1);
  do { ch->xferLenL = (uint8)(uint16)(16); ch->xferLenV &= ~0x1F; ch->xferLenV |= (uint8)((uint16)(16) >> 8); } while (277 == -1);

  /* Arm DMA channel 1 */
  DMAIRQ &= ~( 1 << (1) );
  DMAARM = (0x01 << (1));
  do {
    asm("NOP");
  } while (!(DMAARM & (0x01 << (1))));

  /* Set AES mode */
  do { ENCCS = (ENCCS & ~0x07) | (0x04); } while(0);

  /* Kick it off, block until AES is ready */
  ENCCS |= 0x01;
  while( !(ENCCS & 0x08) );
#line 299 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"
}


/******************************************************************************
 * @fn      AesDmaSetup
 *
 * @brief   Sets up DMA of 16 byte block using CC2540 HW aes encryption engine
 *
 * input parameters
 *
 * @param   Cstate  - Pointer to output data.
 * @param   msg_out_len - message out length
 * @param   msg_in  - pointer to input data.
 * @param   msg_in_len - message in length
 *
 * output parameters
 *
 * @param   Cstate  - Pointer to encrypted data.
 *
 * @return  None
 *
 */
void AesDmaSetup( uint8 *Cstate, uint16 msg_out_len, uint8 *msg_in, uint16 msg_in_len )
{
  halDMADesc_t *ch;

  /* Modify descriptors for channel 1 */
  ch = (dmaCh1234+((1)-1));
  do { ch->srcAddrH = (uint8)((uint16)(msg_in) >> 8); ch->srcAddrL = (uint8)((uint16)(msg_in) & 0xFF); } while (327 == -1);
  do { ch->xferLenL = (uint8)(uint16)(msg_in_len); ch->xferLenV &= ~0x1F; ch->xferLenV |= (uint8)((uint16)(msg_in_len) >> 8); } while (328 == -1);

  /* Modify descriptors for channel 2 */
  ch = (dmaCh1234+((2)-1));
  do { ch->dstAddrH = (uint8)((uint16)(Cstate) >> 8); ch->dstAddrL = (uint8)((uint16)(Cstate) & 0xFF); } while (332 == -1);
  do { ch->xferLenL = (uint8)(uint16)(msg_out_len); ch->xferLenV &= ~0x1F; ch->xferLenV |= (uint8)((uint16)(msg_out_len) >> 8); } while (333 == -1);

  /* Arm DMA channels 1 and 2 */
  DMAIRQ &= ~( 1 << (1) );
  DMAARM = (0x01 << (1));
  do {
    asm("NOP");
  } while (!(DMAARM & (0x01 << (1))));
  DMAIRQ &= ~( 1 << (2) );
  DMAARM = (0x01 << (2));
  do {
    asm("NOP");
  } while (!(DMAARM & (0x01 << (2))));
}


/******************************************************************************
 * @fn      HalAesInit
 *
 * @brief   Initilize AES engine
 *
 * input parameters
 *
 * @param   None
 *
 * @return  None
 */
void HalAesInit( void )
{

  /* Init DMA channels 1 and 2 */
  aesDmaInit();

}

/******************************************************************************
 * @fn      ssp_HW_KeyInit
 *
 * @brief   Writes the key into AES engine
 *
 * input parameters
 *
 * @param   AesKey  - Pointer to AES Key.
 *
 * @return  None
 */
void ssp_HW_KeyInit( uint8 *AesKey )
{
  do { ENCCS = (ENCCS & ~0x70) | (0x40); } while (0);
  AesLoadKey( AesKey );
}

/******************************************************************************
 * @fn      sspAesEncryptHW
 *
 * @brief   Encrypts 16 byte block using AES encryption engine
 *
 * input parameters
 *
 * @param   AesKey  - Pointer to AES Key.
 * @param   Cstate  - Pointer to input data.
 *
 * output parameters
 *
 * @param   Cstate  - Pointer to encrypted data.
 *
 * @return  None
 *
 */
void sspAesEncryptHW( uint8 *AesKey, uint8 *Cstate )
{
  (void)AesKey;


  /* Setup DMA for AES encryption */
  AesDmaSetup( Cstate, 16, Cstate, 16 );
  do { ENCCS = (ENCCS & ~0x07) | (0x00); } while(0);

  /* Kick it off, block until DMA is done */
  ENCCS |= 0x01;
  while( !(DMAIRQ & ( 1 << (2) )) );
#line 422 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_aes.c"
}
