#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
/**************************************************************************************************
  Filename:       gpsprofile.c
  Creation:       Date: 2015-07-23

  Description:    Gps profile (based on simpleGATT Profile)

**************************************************************************************************/

/*********************************************************************
 * INCLUDES
 */
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\bcomdef.h"
/**
  @headerfile:       bcomdef.h

  <!--
  Revised:        $Date: 2012-11-27 14:14:39 -0800 (Tue, 27 Nov 2012) $
  Revision:       $Revision: 32324 $

  Description:    Type definitions and macros for BLE stack.


  Copyright 2009 - 2012 Texas Instruments Incorporated. All rights reserved.

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
  PROVIDED “AS IS?WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
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










/*********************************************************************
 * INCLUDES
 */

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\comdef.h"
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
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_types.h"
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
#line 82 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_types.h"

/* ----------- KEIL Compiler ----------- */
#line 105 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_types.h"


/* ------------------------------------------------------------------------------------------------
 *                                        Standard Defines
 * ------------------------------------------------------------------------------------------------
 */













/**************************************************************************************************
 */
#line 55 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\comdef.h"
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
#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\comdef.h"

/*********************************************************************
 * Lint Keywords
 */


#line 71 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\comdef.h"

/*********************************************************************
 * CONSTANTS
 */

















/*** Generic Status Return Values ***/
#line 107 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\comdef.h"

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





#line 57 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\bcomdef.h"

/*********************************************************************
 * CONSTANTS
 */


  // Set the Controller Configuration
#line 92 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\bcomdef.h"

#line 102 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\bcomdef.h"

/** @defgroup BLE_COMMON_DEFINES BLE Common Defines
 * @{
 */
//! Default Public and Random Address Length


//! Default key length


//! BLE Channel Map length


//! BLE Event mask length


//! BLE Local Name length


//! BLE Maximum Advertising Packet Length


//! BLE Random Number Size


//! BLE Feature Supported length


/** @defgroup BLE_STATUS_VALUES BLE Default BLE Status Values
 * returned as bStatus_t
 * @{
 */
#line 146 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\bcomdef.h"

// GAP Status Return Values - returned as bStatus_t




// ATT Status Return Values - returned as bStatus_t





// L2CAP Status Return Values - returned as bStatus_t


/** @} End BLE_STATUS_VALUES */

/** @defgroup BLE_NV_IDS BLE Non-volatile IDs
 * @{
 */
// Device NV Items -    Range 0 - 0x1F




// Bonding NV Items -   Range  0x20 - 0x5F    - This allows for 10 bondings



// GATT Configuration NV Items - Range  0x70 - 0x79 - This must match the number of Bonding entries


/** @} End BLE_NV_IDS */

/*********************************************************************
 * BLE OSAL GAP GLOBAL Events
 */



/** @defgroup BLE_MSG_IDS BLE OSAL Message ID Events
 *      Reserved Message ID Event Values:<BR>
 *        0xC0 - Key Presses<BR>
 *        0xE0 to 0xFC - App<BR>
 * @{
 */
// GAP - Messages IDs (0xD0 - 0xDF)


// SM - Messages IDs (0xC1 - 0xCF)


// GATT - Messages IDs (0xB0 - 0xBF)



// L2CAP - Messages IDs (0xA0 - 0xAF)



// HCI - Messages IDs (0x90 - 0x9F)




/** @} End BLE_MSG_IDS */

/*********************************************************************
 * TYPEDEFS
 */

  //! BLE Generic Status return: @ref BLE_STATUS_VALUES
typedef Status_t bStatus_t;

/** @} End GAP_MSG_EVENT_DEFINES */


/*********************************************************************
 * System Events
 */

/*********************************************************************
 * Global System Messages
 */

/*********************************************************************
 * MACROS
 */

// TI Base 128-bit UUID: F000XXXX-0451-4000-B000-000000000000



/*********************************************************************
 * GLOBAL VARIABLES
 */

/*********************************************************************
 * FUNCTIONS
 */

/*********************************************************************
*********************************************************************/





#line 13 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\OSAL.h"
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

#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\OSAL.h"

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





#line 59 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\OSAL.h"
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





#line 60 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\OSAL.h"

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





#line 14 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\host\\linkdb.h"
/**************************************************************************************************
  Filename:       linkdb.h
  Revised:        $Date: 2011-11-07 09:13:23 -0800 (Mon, 07 Nov 2011) $
  Revision:       $Revision: 28245 $

  Description:    This file contains the linkDB interface.

  Copyright 2009 - 2011 Texas Instruments Incorporated. All rights reserved.

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
 */

// Special case connection handles


  
// Link state flags






// Link Database Status callback changeTypes



  
// Link Authentication Errors




/*********************************************************************
 * TYPEDEFS
 */

typedef struct
{
  uint8 srk[16];  // Signature Resolving Key
  uint32 signCounter; // Sign Counter 
} linkSec_t;

typedef struct
{
  uint8 ltk[16];             // Long Term Key
  uint16 div;                    // Diversifier
  uint8 rand[8]; // random number
  uint8 keySize;                 // LTK Key Size
} encParams_t;

typedef struct
{
  uint8 taskID;            // Application that controls the link
  uint16 connectionHandle; // Controller connection handle
  uint8 stateFlags;        // LINK_CONNECTED, LINK_AUTHENTICATED...
  uint8 addrType;          // Address type of connected device
  uint8 addr[6];  // Other Device's address
  uint16 connInterval;     // The connection's interval (n * 1.23 ms)
  linkSec_t sec;           // Connection Security related items
  encParams_t *pEncParams; // pointer to LTK, ediv, rand. if needed.
} linkDBItem_t;

// function pointer used to register for a status callback
typedef void (*pfnLinkDBCB_t)( uint16 connectionHandle, uint8 changeType );

// function pointer used to perform specialized link database searches
typedef void (*pfnPerformFuncCB_t)( linkDBItem_t *pLinkItem );

/*********************************************************************
 * GLOBAL VARIABLES
 */

/*********************************************************************
 * PUBLIC FUNCTIONS
 */
  /*
   * linkDB_Init - Initialize the Link Database.
   */
  extern void linkDB_Init( void );

  /*
   * linkDB_Register - Register with this function to receive a callback when
   *              status changes on a connection.
   */
  extern uint8 linkDB_Register( pfnLinkDBCB_t pFunc );

  /*
   * linkDB_Add - Adds a record to the link database.
   */
  extern uint8 linkDB_Add( uint8 taskID, uint16 connectionHandle, uint8  stateFlags, 
                           uint8 addrType, uint8 *pAddr, uint16 connInterval );

  /*
   * linkDB_Remove - Removes a record from the link database.
   */
  extern uint8 linkDB_Remove( uint16 connectionHandle );

  /*
   * linkDB_Update - This function is used to update the stateFlags of 
   *              a link record.
   */
  extern uint8 linkDB_Update( uint16 connectionHandle, uint8 newState );

  /*
   * linkDB_NumActive - returns the number of active connections.
   */
  extern uint8 linkDB_NumActive( void );

  /*
   * linkDB_Find - Find link database item (link information)
   * 
   *    returns a pointer to the link item, NULL if not found
   */
  extern linkDBItem_t *linkDB_Find( uint16 connectionHandle );

  /*
   * linkDB_FindFirst - Find the first link that matches the taskID.
   * 
   *    returns a pointer to the link item, NULL if not found
   */
  extern linkDBItem_t *linkDB_FindFirst( uint8 taskID );

  /*
   * linkDB_State - Check to see if a physical link is in a specific state.
   * 
   *    returns TRUE is the link is in state. FALSE, otherwise.
   */
  extern uint8 linkDB_State( uint16 connectionHandle, uint8 state );

  /*
   * linkDB_Authen - Check to see if the physical link is encrypted and authenticated.
   *    returns SUCCESS if the link is authenticated or 
   *            bleNotConnected - connection handle is invalid, 
   *            LINKDB_ERR_INSUFFICIENT_AUTHEN - link is not encrypted,
   *            LINBDB_ERR_INSUFFICIENT_KEYSIZE - key size encrypted is not large enough,
   *            LINKDB_ERR_INSUFFICIENT_ENCRYPTION - link is encrypted, but not authenticated
   */
  extern uint8 linkDB_Authen( uint16 connectionHandle, uint8 keySize );
  
  /*
   * linkDB_PerformFunc - Perform a function of each connection in the link database.
   */
  extern void linkDB_PerformFunc( pfnPerformFuncCB_t cb );
  
  /*
   * linkDB_Up - Check to see if a physical link is up (connected).
   *    Use like:  uint8 linkDB_Up( uint16 connectionHandle );
   *            connectionHandle - controller link connection handle.
   *            returns TRUE if the link is up. FALSE, otherwise.
   */


  /*
   * linkDB_Encrypted - Check to see if the physical link is encrypted.
   *    Use like:  linkDB_Encrypted( uint16 connectionHandle );
   *            connectionHandle - controller link connection handle.
   *            returns TRUE if the link is authenticated. FALSE, otherwise.
   */

  
/*********************************************************************
*********************************************************************/





#line 15 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\att.h"
/**
  @headerfile:    att.h

  <!--
  Revised:        $Date: 2013-05-01 13:58:23 -0700 (Wed, 01 May 2013) $
  Revision:       $Revision: 34101 $

  Description:    This file contains Attribute Protocol (ATT) definitions
                  and prototypes.


  Copyright 2009-2013 Texas Instruments Incorporated. All rights reserved.

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









/*********************************************************************
 * INCLUDES
 */



#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\ble\\include\\l2cap.h"
/**************************************************************************************************
  Filename:       l2cap.h
  Revised:        $Date: 2012-01-04 14:47:09 -0800 (Wed, 04 Jan 2012) $
  Revision:       $Revision: 28826 $

  Description:    This file contains the L2CAP definitions.


  Copyright 2009-2011 Texas Instruments Incorporated. All rights reserved.

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

// Minimum supported information payload for the Basic information frame (B-frame)


// Minimum supported information payload for the Control frame (C-frame)


// Basic L2CAP header: Length (2 bytes) + Channel ID (2 bytes)


// Minimum size of PDU received from lower layer protocol (incoming
// packet), or delivered to lower layer protocol (outgoing packet).


// L2CAP Channel Identifiers. Identifiers from 0x0001 to 0x003F are
// reserved for specific L2CAP functions. Identifiers 0x0001-0x0003
// are reserved by BR/EDR.






// L2CAP Dynamic Channel Identifiers


	
// Number of Fixed channels: one for each of ATT, Signaling, SMP channels and one Generic Channel


// Number of Protocols supported -- for future use


// Number of Auxiliary channels: one for each of Echo Request, Information
// Request and Connection Parameter Update Request


// Number of Dynamic channels: one per each protocol supported on each physical connection


// Total number of L2CAP channels: Dynamic channels plus Auxiliary channels


// L2CAP Response Timeout expired (RTX) value for Signaling commands (in seconds).
// The RTX timer is used for response timeout or to terminate a dynamic channel
// when the remote device is unresponsive to signaling requests. Its value may
// range from 1 to 60 seconds.


// L2CAP Signaling Codes (type of commands)
#line 114 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\ble\\include\\l2cap.h"

/*********************************************************************
 * Command Reject: Reason Codes
 */
  // Command not understood


  // Signaling MTU exceeded


  // Invalid CID in request


/*********************************************************************
 * Information Request/Response: Info Type
 */
  // Connectionless MTU


  // Extended features supported


  // Fixed channels supported


/*********************************************************************
 * Information Response: Extended Features Mask Values
 */
  // Fixed channels are supported


  // Length of Extended Features bit mask


/*********************************************************************
 * Information Response: Fixed Channels Mask Values
 */
  // Fixed Channel ATT is supported


  // Fixed Channel L2CAP Signaling is supported


  // Fixed Channel SMP is supported


  // Length of Fixed Channels bit mask


/*********************************************************************
 * Information Response: Result Values
 */
  // Success


  // Not supported


/*********************************************************************
 * Connection Parameter Update Response: Result values
 */
  // Connection Parameters accepted


  // Connection Parameters rejected



/*********************************************************************
 * VARIABLES
 */

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * TYPEDEFS
 */

// Invalid CID in Request format
typedef struct
{
  uint16 localCID;  // Destination CID from the rejected command
  uint16 remoteCID; // Source CID from the rejected command
} l2capInvalidCID_t;

// Command Reject Reason Data format
typedef union
{
  uint16 signalMTU;             // Maximum Signaling MTU
  l2capInvalidCID_t invalidCID; // Invalid CID in Request
} l2capReasonData_t;

// Command Reject format
typedef struct
{
  uint16 reason;                // Reason
  l2capReasonData_t reasonData; // Reason Data

  // Shorthand access for union members



} l2capCmdReject_t;

// Echo Request format
typedef struct
{
  uint8 *pData; // Optional data field
  uint16 len;   // Length of data
} l2capEchoReq_t;

// Echo Response format
typedef struct
{
  uint8 *pData; // Optional data field -- must be freed by the application
  uint16 len;   // Length of data
} l2capEchoRsp_t;

// Information Request format
typedef struct
{
  uint16 infoType; // Information type
} l2capInfoReq_t;

// Information Response Data field
typedef union
{
  uint16 connectionlessMTU;                       // Connectionless MTU
  uint32 extendedFeatures;                        // Extended features supported
  uint8 fixedChannels[8]; // Fixed channels supported
} l2capInfo_t;

// Information Response format
typedef struct
{
  uint16 result;    // Result
  uint16 infoType;  // Information type
  l2capInfo_t info; // Content of Info field depends on infoType
} l2capInfoRsp_t;

// Connection Parameter Update Request format
typedef struct
{
  uint16 intervalMin;       // Minimum Interval
  uint16 intervalMax;       // Maximum Interval
  uint16 slaveLatency;      // Slave Latency
  uint16 timeoutMultiplier; // Timeout Multiplier
} l2capParamUpdateReq_t;

// Connection Parameter Update Response format
typedef struct
{
  uint16 result; // Result
} l2capParamUpdateRsp_t;

// Union of all L2CAP Signaling commands
typedef union
{
  // Requests
  l2capEchoReq_t echoReq;
  l2capInfoReq_t infoReq;
  l2capParamUpdateReq_t updateReq;

  // Responses
  l2capCmdReject_t cmdReject;
  l2capEchoRsp_t echoRsp;
  l2capInfoRsp_t infoRsp;
  l2capParamUpdateRsp_t updateRsp;
} l2capSignalCmd_t;

// OSAL L2CAP_SIGNAL_EVENT message format. This message is used to deliver an
// incoming Signaling command up to an upper layer application.
typedef struct
{
  osal_event_hdr_t hdr; // L2CAP_SIGNAL_EVENT and status
  uint16 connHandle;    // connection message was received on
  uint8 id;             // identifier to match responses with requests
  uint8 opcode;         // type of command
  l2capSignalCmd_t cmd; // command data
} l2capSignalEvent_t;

// L2CAP packet structure
typedef struct
{
  uint16 CID;      // local channel id
  uint8 *pPayload; // pointer to information payload. This contains the payload
                   // received from the upper layer protocol (outgoing packet),
                   // or delivered to the upper layer protocol (incoming packet).
  uint16 len;      // length of information payload
} l2capPacket_t;

// OSAL L2CAP_DATA_EVENT message format. This message is used to forward an
// incoming data packet up to an upper layer application.
typedef struct
{
  osal_event_hdr_t hdr; // L2CAP_DATA_EVENT and status
  uint16 connHandle;    // connection packet was received on
  l2capPacket_t pkt;    // received packet
} l2capDataEvent_t;

/*********************************************************************
 * VARIABLES
 */

/*********************************************************************
 * FUNCTIONS
 */

/*
 *  Initialize L2CAP layer.
 */
extern void L2CAP_Init( uint8 taskId );

/*
 *  L2CAP Task event processing function.
 */
extern uint16 L2CAP_ProcessEvent( uint8 taskId, uint16 events );

/*
 * Register a protocol/application with an L2CAP channel.
 */
extern bStatus_t L2CAP_RegisterApp( uint8 taskId, uint16 CID );

/*
 *  Send L2CAP Data Packet.
 */
extern bStatus_t L2CAP_SendData( uint16 connHandle, l2capPacket_t *pPkt );

/*
 * Send Command Reject.
 */
extern bStatus_t L2CAP_CmdReject( uint16 connHandle, uint8 id, l2capCmdReject_t *pCmdReject );

/*
 * Build Command Reject.
 */
extern uint16 L2CAP_BuildCmdReject( uint8 *pBuf, uint8 *pCmd );

/*
 *  Send L2CAP Echo Request.
 */
extern bStatus_t L2CAP_EchoReq( uint16 connHandle, l2capEchoReq_t *pEchoReq, uint8 taskId );

/*
 *  Send L2CAP Information Request.
 */
extern bStatus_t L2CAP_InfoReq( uint16 connHandle, l2capInfoReq_t *pInfoReq, uint8 taskId );

/*
 * Build Information Response.
 */
extern uint16 L2CAP_BuildInfoRsp( uint8 *pBuf, uint8 *pCmd );

/*
 * Parse Information Request.
 */
extern bStatus_t L2CAP_ParseInfoReq( l2capSignalCmd_t *pCmd, uint8 *pData, uint16 len );

/*
 *  Send L2CAP Connection Parameter Update Request.
 */
extern bStatus_t L2CAP_ConnParamUpdateReq( uint16 connHandle, l2capParamUpdateReq_t *pUpdateReq, uint8 taskId );

/*
 * Parse Connection Parameter Update Request.
 */
extern bStatus_t L2CAP_ParseParamUpdateReq( l2capSignalCmd_t *pCmd, uint8 *pData, uint16 len );

/*
 *  Send L2CAP Connection Parameter Update Response.
 */
extern bStatus_t L2CAP_ConnParamUpdateRsp( uint16 connHandle, uint8 id, l2capParamUpdateRsp_t *pUpdateRsp );

/*
 * Build Connection Parameter Update Response.
 */
extern uint16 L2CAP_BuildParamUpdateRsp( uint8 *pBuf, uint8 *pData );

/*
 * Allocate a block of memory at the L2CAP layer.
 */
extern void *L2CAP_bm_alloc( uint16 size );


/*********************************************************************
*********************************************************************/





#line 59 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\att.h"

/*********************************************************************
 * CONSTANTS
 */

// The Exchanging MTU Size is defined as the maximum size of any packet 
// transmitted between a client and a server. A higher layer specification
// defines the default ATT MTU value. The ATT MTU value should be within
// the range 23 to 517 inclusive.



/** @defgroup ATT_METHOD_DEFINES ATT Methods 
 * @{
 */

#line 101 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\att.h"




/** @} End ATT_METHOD_DEFINES */

/*** Opcode fields: bitmasks ***/
// Method (bits 5-0)


// Command Flag (bit 6)


// Authentication Signature Flag (bit 7)


// Size of 16-bit Bluetooth UUID

  
// Size of 128-bit UUID

  
// ATT Response or Confirmation timeout


// Authentication Signature status for received PDU; it's TRUE or FALSE for PDU to be sent




/*********************************************************************
 * Error Response: Error Code
 */

/** @defgroup ATT_ERR_CODE_DEFINES ATT Error Codes
 * @{
 */

#line 156 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\att.h"

/*** Reserved for future use: 0x12 - 0x7F ***/

/*** Application error code defined by a higher layer specification: 0x80-0x9F ***/


  
/** @} End ATT_ERR_CODE_DEFINES */

/*********************************************************************
 * Find Information Response: UUID Format
 */
  // Handle and 16-bit Bluetooth UUID

  
  // Handle and 128-bit UUID

  
// Maximum number of handle and 16-bit UUID pairs in a single Find Info Response


// Maximum number of handle and 128-bit UUID pairs in a single Find Info Response


/*********************************************************************
 * Find By Type Value Response: Handles Infomation (Found Attribute Handle and Group End Handle)
 */
  // Maximum number of handles info in a single Find By Type Value Response


/*********************************************************************
 * Read Multiple Request: Handles
 */
  // Maximum number of handles in a single Read Multiple Request


  // Minimum number of handles in a single Read Multiple Request


/*********************************************************************
 * Execute Write Request: Flags
 */
  // Cancel all prepared writes

  
  // Immediately write all pending prepared values








/*********************************************************************
 * Size of mandatory fields of ATT requests
 */
// Length of Read By Type Request's fixed fields: First handle number (2) + Last handle number (2)


// Length of Prepare Write Request's fixed size: Attribute Handle (2) + Value Offset (2)


/*********************************************************************
 * VARIABLES
 */
extern const uint8 btBaseUUID[16];

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * TYPEDEFS
 */

/**
 * Attribute Protocol PDU format.
 */
typedef struct
{
  uint8 sig;      //!< Authentication Signature status (not included (0), valid (1), invalid (2))
  uint8 cmd;      //!< Command Flag
  uint8 method;   //!< Method
  uint16 len;     //!< Length of Attribute Parameters
  uint8 *pParams; //!< Attribute Parameters
} attPacket_t;

/**
 * Attribute Type format (2 or 16 octet UUID).
 */
typedef struct
{
  uint8 len;                 //!< Length of UUID
  uint8 uuid[16]; //!< 16 or 128 bit UUID
} attAttrType_t;

/**
 * Attribute Type format (2-octet Bluetooth UUID).
 */
typedef struct
{
  uint8 len;                    //!< Length of UUID
  uint8 uuid[2]; //!< 16 bit UUID
} attAttrBtType_t;

/**
 * Error Response format.
 */
typedef struct
{
  uint8 reqOpcode; //!< Request that generated this error response
  uint16 handle;   //!< Attribute handle that generated error response
  uint8 errCode;   //!< Reason why the request has generated error response
} attErrorRsp_t;

/**
 * Exchange MTU Request format.
 */
typedef struct
{
  uint16 clientRxMTU; //!< Client receive MTU size 
} attExchangeMTUReq_t;

/**
 * Exchange MTU Response format.
 */
typedef struct
{
  uint16 serverRxMTU; //!< Server receive MTU size 
} attExchangeMTURsp_t;

/**
 * Find Information Request format.
 */
typedef struct
{
  uint16 startHandle;       //!< First requested handle number (must be first field)
  uint16 endHandle;         //!< Last requested handle number
} attFindInfoReq_t;

/**
 * Handle and its 16-bit Bluetooth UUIDs.
 */
typedef struct
{
  uint16 handle;                //!< Handle
  uint8 uuid[2]; //!< 2-octet Bluetooth UUID
} attHandleBtUUID_t;

/**
 * Handle and its 128-bit UUID.
 */
typedef struct
{
  uint16 handle;             //!< Handle
  uint8 uuid[16]; //!< 16-octect UUID
} attHandleUUID_t;

/**
 * Info data format for Find Information Response (handle-UUID pair).
 */
typedef union
{
  attHandleBtUUID_t btPair[( ( 23 - 2 ) / ( 2 + 2 ) )]; //!< A list of 1 or more handles with their 16-bit Bluetooth UUIDs
  attHandleUUID_t   pair[( ( 23 - 2 ) / ( 2 + 16 ) )];      //!< A list of 1 or more handles with their 128-bit UUIDs
} attFindInfo_t;

/**
 * Find Information Response format.
 */
typedef struct
{
  uint8 numInfo;      //!< Number of attribute handle-UUID pairs found
  uint8 format;       //!< Format of information data
  attFindInfo_t info; //!< Information data whose format is determined by format field
} attFindInfoRsp_t;

/**
 * Find By Type Value Request format.
 */
typedef struct
{
  uint16 startHandle;          //!< First requested handle number (must be first field)
  uint16 endHandle;            //!< Last requested handle number
  attAttrBtType_t type;        //!< 2-octet UUID to find
  uint8 len;                   //!< Length of value
  uint8 value[23-7]; //!< Attribute value to find
} attFindByTypeValueReq_t;

/**
 * Handles Infomation format.
 */
typedef struct
{
  uint16 handle;       //!< Found attribute handle
  uint16 grpEndHandle; //!< Group end handle
} attHandlesInfo_t;

/**
 * Find By Type Value Response format.
 */
typedef struct
{
  uint8 numInfo;                                          //!< Number of handles information found
  attHandlesInfo_t handlesInfo[( ( 23 - 1 ) / 4 )]; //!< List of 1 or more handles information
} attFindByTypeValueRsp_t;

/**
 * Read By Type Request format.
 */
typedef struct
{
  uint16 startHandle; //!< First requested handle number (must be first field)
  uint16 endHandle;   //!< Last requested handle number
  attAttrType_t type; //!< Requested type (2 or 16 octet UUID)
} attReadByTypeReq_t;

/**
 * Read By Type Response format.
 */
typedef struct
{
  uint8 numPairs;                 //!< Number of attribute handle-UUID pairs found
  uint8 len;                      //!< Size of each attribute handle-value pair
  uint8 dataList[23-2]; //!< List of 1 or more attribute handle-value pairs
} attReadByTypeRsp_t;

/**
 * Read Request format.
 */
typedef struct
{
  uint16 handle; //!< Handle of the attribute to be read (must be first field)
} attReadReq_t;

/**
 * Read Response format.
 */
typedef struct
{
  uint8 len;                   //!< Length of value
  uint8 value[23-1]; //!< Value of the attribute with the handle given
} attReadRsp_t;

/**
 * Read Blob Req format.
 */
typedef struct
{
  uint16 handle; //!< Handle of the attribute to be read (must be first field)
  uint16 offset; //!< Offset of the first octet to be read
} attReadBlobReq_t;

/**
 * Read Blob Response format.
 */
typedef struct
{
  uint8 len;                   //!< Length of value
  uint8 value[23-1]; //!< Part of the value of the attribute with the handle given
} attReadBlobRsp_t;

/**
 * Read Multiple Request format.
 */
typedef struct
{
  uint16 handle[( ( 23 - 1 ) / 2 )]; //!< Set of two or more attribute handles (must be first field)
  uint8 numHandles;                   //!< Number of attribute handles
} attReadMultiReq_t;

/**
 * Read Multiple Response format.
 */
typedef struct
{
  uint8 len;                    //!< Length of values
  uint8 values[23-1]; //!< Set of two or more values
} attReadMultiRsp_t;

/**
 * Read By Group Type Request format.
 */
typedef struct
{
  uint16 startHandle; //!< First requested handle number (must be first field)
  uint16 endHandle;   //!< Last requested handle number
  attAttrType_t type; //!< Requested group type (2 or 16 octet UUID)
} attReadByGrpTypeReq_t;

/**
 * Read By Group Type Response format.
 */
typedef struct
{
  uint8 numGrps;                  //!< Number of attribute handle, end group handle and value sets found
  uint8 len;                      //!< Length of each attribute handle, end group handle and value set
  uint8 dataList[23-2]; //!< List of 1 or more attribute handle, end group handle and value
} attReadByGrpTypeRsp_t;

/**
 * Write Request format.
 */
typedef struct
{
  uint16 handle;               //!< Handle of the attribute to be written (must be first field)
  uint8 len;                   //!< Length of value
  uint8 value[23-3]; //!< Value of the attribute to be written
  uint8 sig;                   //!< Authentication Signature status (not included (0), valid (1), invalid (2))
  uint8 cmd;                   //!< Command Flag
} attWriteReq_t;

/**
 * Prepare Write Request format.
 */
typedef struct
{
  uint16 handle;               //!< Handle of the attribute to be written (must be first field)
  uint16 offset;               //!< Offset of the first octet to be written
  uint8 len;                   //!< Length of value
  uint8 value[23-5]; //!< Part of the value of the attribute to be written
} attPrepareWriteReq_t;

/**
 * Prepare Write Response format.
 */
typedef struct
{
  uint16 handle;               //!< Handle of the attribute that has been read
  uint16 offset;               //!< Offset of the first octet to be written
  uint8 len;                   //!< Length of value
  uint8 value[23-5]; //!< Part of the value of the attribute to be written
} attPrepareWriteRsp_t;

/**
 * Execute Write Request format.
 */
typedef struct
{
  uint8 flags; //!< 0x00 - cancel all prepared writes.
               //!< 0x01 - immediately write all pending prepared values.
} attExecuteWriteReq_t;

/**
 * Handle Value Notification format.
 */
typedef struct
{
  uint16 handle;               //!< Handle of the attribute that has been changed (must be first field)
  uint8 len;                   //!< Length of value
  uint8 value[23-3]; //!< New value of the attribute
} attHandleValueNoti_t;

/**
 * Handle Value Indication format.
 */
typedef struct
{
  uint16 handle;               //!< Handle of the attribute that has been changed (must be first field)
  uint8 len;                   //!< Length of value
  uint8 value[23-3]; //!< New value of the attribute
} attHandleValueInd_t;

/**
 * ATT Message format. It's a union of all attribute protocol messages used 
 * between the attribute protocol and upper layer profile/application.
 */
typedef union
{
  // Request messages
  attExchangeMTUReq_t exchangeMTUReq;         //!< ATT Exchange MTU Request
  attFindInfoReq_t findInfoReq;               //!< ATT Find Information Request
  attFindByTypeValueReq_t findByTypeValueReq; //!< ATT Find By Type Vaue Request
  attReadByTypeReq_t readByTypeReq;           //!< ATT Read By Type Request
  attReadReq_t readReq;                       //!< ATT Read Request
  attReadBlobReq_t readBlobReq;               //!< ATT Read Blob Request
  attReadMultiReq_t readMultiReq;             //!< ATT Read Multiple Request
  attReadByGrpTypeReq_t readByGrpTypeReq;     //!< ATT Read By Group Type Request
  attWriteReq_t writeReq;                     //!< ATT Write Request
  attPrepareWriteReq_t prepareWriteReq;       //!< ATT Prepare Write Request
  attExecuteWriteReq_t executeWriteReq;       //!< ATT Execute Write Request

  // Response messages
  attErrorRsp_t errorRsp;                     //!< ATT Error Response
  attExchangeMTURsp_t exchangeMTURsp;         //!< ATT Exchange MTU Response
  attFindInfoRsp_t findInfoRsp;               //!< ATT Find Information Response
  attFindByTypeValueRsp_t findByTypeValueRsp; //!< ATT Find By Type Vaue Response
  attReadByTypeRsp_t readByTypeRsp;           //!< ATT Read By Type Response
  attReadRsp_t readRsp;                       //!< ATT Read Response
  attReadBlobRsp_t readBlobRsp;               //!< ATT Read Blob Response
  attReadMultiRsp_t readMultiRsp;             //!< ATT Read Multiple Response
  attReadByGrpTypeRsp_t readByGrpTypeRsp;     //!< ATT Read By Group Type Response
  attPrepareWriteRsp_t prepareWriteRsp;       //!< ATT Prepare Write Response

  // Indication and Notification messages
  attHandleValueNoti_t handleValueNoti;       //!< ATT Handle Value Notification
  attHandleValueInd_t handleValueInd;         //!< ATT Handle Value Indication
} attMsg_t;

/*********************************************************************
 * VARIABLES
 */

/*********************************************************************
 * API FUNCTIONS
 */

/*-------------------------------------------------------------------
 *  General Utility APIs
 */

/*
 * Parse an attribute protocol message.
 */
extern uint8 ATT_ParsePacket( l2capDataEvent_t *pL2capMsg, attPacket_t *pPkt );

/*
 * Compare two UUIDs. The UUIDs are converted if necessary.
 */
extern uint8 ATT_CompareUUID( const uint8 *pUUID1, uint16 len1, 
                              const uint8 *pUUID2, uint16 len2 );
/*
 * Convert a 16-bit UUID to 128-bit UUID.
 */
extern uint8 ATT_ConvertUUIDto128( const uint8 *pUUID16, uint8 *pUUID128 );

/*
 * Convert a 128-bit UUID to 16-bit UUID.
 */
extern uint8 ATT_ConvertUUIDto16( const uint8 *pUUID128, uint8 *pUUID16 );


/*-------------------------------------------------------------------
 *  Attribute Client Utility APIs
 */

/*
 * Build Error Response.
 */
extern uint16 ATT_BuildErrorRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Error Response.
 */
extern bStatus_t ATT_ParseErrorRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Exchange MTU Request.
 */
extern uint16 ATT_BuildExchangeMTUReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Exchange MTU Respnose.
 */
extern uint16 ATT_BuildExchangeMTURsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Exchange MTU Response.
 */
extern bStatus_t ATT_ParseExchangeMTURsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Find Information Request.
 */
extern uint16 ATT_BuildFindInfoReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Find Information Response.
 */
extern bStatus_t ATT_ParseFindInfoRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Find Information Response.
 */
extern uint16 ATT_BuildFindInfoRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Find By Type Value Request.
 */
extern uint16 ATT_BuildFindByTypeValueReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Find By Type Value Response.
 */
extern uint16 ATT_BuildFindByTypeValueRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Find By Type Value Response.
 */
extern bStatus_t ATT_ParseFindByTypeValueRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Read By Type Request.
 */
extern uint16 ATT_BuildReadByTypeReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Read By Type Response.
 */
extern uint16 ATT_BuildReadByTypeRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Read By Type Response.
 */
extern bStatus_t ATT_ParseReadByTypeRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Read Request.
 */
extern uint16 ATT_BuildReadReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Read Response.
 */
extern uint16 ATT_BuildReadRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Read Response.
 */
extern bStatus_t ATT_ParseReadRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Read Blob Request.
 */
extern uint16 ATT_BuildReadBlobReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Read Blob Response.
 */
extern uint16 ATT_BuildReadBlobRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Read Blob Response.
 */
extern bStatus_t ATT_ParseReadBlobRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Read Multiple Request.
 */
extern uint16 ATT_BuildReadMultiReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Read Multiple Response.
 */
extern uint16 ATT_BuildReadMultiRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Read Multiple Response.
 */
extern bStatus_t ATT_ParseReadMultiRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Read By Group Type Response.
 */
extern uint16 ATT_BuildReadByGrpTypeRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Read By Group Type Response.
 */
extern bStatus_t ATT_ParseReadByGrpTypeRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Write Request.
 */
extern uint16 ATT_BuildWriteReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Write Response.
 */
extern bStatus_t ATT_ParseWriteRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Prepare Write Request.
 */
extern uint16 ATT_BuildPrepareWriteReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Build Prepare Write Response.
 */
extern uint16 ATT_BuildPrepareWriteRsp( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Prepare Write Response.
 */
extern bStatus_t ATT_ParsePrepareWriteRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Execute Write Request.
 */
extern uint16 ATT_BuildExecuteWriteReq( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Execute Write Response.
 */
extern bStatus_t ATT_ParseExecuteWriteRsp( uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Build Handle Value Indication.
 */
extern uint16 ATT_BuildHandleValueInd( uint8 *pBuf, uint8 *pMsg );

/*
 * Parse Handle Value Indication.
 */
extern bStatus_t ATT_ParseHandleValueInd( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );


/*-------------------------------------------------------------------
 *  Attribute Server Utility APIs
 */

/*
 * Parse Exchange MTU Request.
 */
extern bStatus_t ATT_ParseExchangeMTUReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Find Information Request.
 */
extern bStatus_t ATT_ParseFindInfoReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Find By Type Value Request.
 */
extern bStatus_t ATT_ParseFindByTypeValueReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Read By Type Request.
 */
extern bStatus_t ATT_ParseReadByTypeReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Read Request.
 */
extern bStatus_t ATT_ParseReadReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Write Blob Request.
 */
extern bStatus_t ATT_ParseReadBlobReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Read Multiple Request.
 */
extern bStatus_t ATT_ParseReadMultiReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Write Request.
 */
extern bStatus_t ATT_ParseWriteReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Execute Write Request.
 */
extern bStatus_t ATT_ParseExecuteWriteReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Prepare Write Request.
 */
extern bStatus_t ATT_ParsePrepareWriteReq( uint8 sig, uint8 cmd, uint8 *pParams, uint16 len, attMsg_t *pMsg );

/*
 * Parse Handle Value Confirmation.
 */
extern bStatus_t ATT_ParseHandleValueCfm( uint8 *pParams, uint16 len, attMsg_t *pMsg );


/*-------------------------------------------------------------------
 *  Attribute Client Public APIs
 */

/**
 * @defgroup ATT_CLIENT_API ATT Client API Functions
 * 
 * @{
 */

/**
 * @brief   Send Exchange MTU Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ExchangeMTUReq( uint16 connHandle, attExchangeMTUReq_t *pReq );

/**
 * @brief   Send Find Information Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_FindInfoReq( uint16 connHandle, attFindInfoReq_t *pReq );

/**
 * @brief   Send Find By Type Value Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_FindByTypeValueReq( uint16 connHandle, attFindByTypeValueReq_t *pReq );

/**
 * @brief   Send Read By Type Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadByTypeReq( uint16 connHandle, attReadByTypeReq_t *pReq );

/**
 * @brief   Send Read Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadReq( uint16 connHandle, attReadReq_t *pReq );

/**
 * @brief   Send Read Blob Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadBlobReq( uint16 connHandle, attReadBlobReq_t *pReq );

/**
 * @brief   Send Read Multiple Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadMultiReq( uint16 connHandle, attReadMultiReq_t *pReq );

/**
 * @brief   Send Read By Group Type Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadByGrpTypeReq( uint16 connHandle, attReadByGrpTypeReq_t *pReq );

/**
 * @brief   Send Write Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleLinkEncrypted: Connection is already encrypted.<BR>
 */
extern bStatus_t ATT_WriteReq( uint16 connHandle, attWriteReq_t *pReq );

/**
 * @brief   Send Prepare Write Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_PrepareWriteReq( uint16 connHandle, attPrepareWriteReq_t *pReq );

/**
 * @brief   Send Execute Write Request.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ExecuteWriteReq( uint16 connHandle, attExecuteWriteReq_t *pReq );

/**
 * @brief   Send Handle Value Confirmation.
 *
 * @param   connHandle - connection to use
 *
 * @return  SUCCESS: Confirmation was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid confirmation field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_HandleValueCfm( uint16 connHandle );

/**
 * @}
 */

/*-------------------------------------------------------------------
 *  Attribute Server Public APIs
 */

/**
 * @defgroup ATT_SERVER_API ATT Server API Functions
 * 
 * @{
 */

/**
 * @brief   Send Error Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to error response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ErrorRsp( uint16 connHandle, attErrorRsp_t *pRsp );

/**
 * @brief   Send Exchange MTU Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to request to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ExchangeMTURsp( uint16 connHandle, attExchangeMTURsp_t *pRsp );

/**
 * @brief   Send Find Information Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_FindInfoRsp( uint16 connHandle, attFindInfoRsp_t *pRsp );

/**
 * @brief   Send Find By Tyep Value Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_FindByTypeValueRsp( uint16 connHandle, attFindByTypeValueRsp_t *pRsp );

/**
 * @brief   Send Read By Type Respond.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadByTypeRsp( uint16 connHandle, attReadByTypeRsp_t *pRsp );

/**
 * @brief   Send Read Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadRsp( uint16 connHandle, attReadRsp_t *pRsp );

/**
 * @brief   Send Read Blob Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadBlobRsp( uint16 connHandle, attReadBlobRsp_t *pRsp );

/**
 * @brief   Send Read Multiple Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadMultiRsp( uint16 connHandle, attReadMultiRsp_t *pRsp ) ;

/**
 * @brief   Send Read By Group Type Respond.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ReadByGrpTypeRsp( uint16 connHandle, attReadByGrpTypeRsp_t *pRsp );

/**
 * @brief   Send Write Response.
 *
 * @param   connHandle - connection to use
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_WriteRsp( uint16 connHandle );

/**
 * @brief   Send Prepare Write Response.
 *
 * @param   connHandle - connection to use
 * @param   pRsp - pointer to response to be sent
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_PrepareWriteRsp( uint16 connHandle, attPrepareWriteRsp_t *pRsp );

/**
 * @brief   Send Execute Write Response.
 *
 * @param   connHandle - connection to use
 *
 * @return  SUCCESS: Response was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid response field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_ExecuteWriteRsp( uint16 connHandle );

/**
 * @brief   Send Handle Value Notification.
 *
 * @param   connHandle - connection to use
 * @param   pNoti - pointer to notification to be sent
 *
 * @return  SUCCESS: Notification was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid notification field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_HandleValueNoti( uint16 connHandle, attHandleValueNoti_t *pNoti );

/**
 * @brief   Send Handle Value Indication.
 *
 * @param   connHandle - connection to use
 * @param   pInd - pointer to indication to be sent
 *
 * @return  SUCCESS: Indication was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid indication field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t ATT_HandleValueInd( uint16 connHandle, attHandleValueInd_t *pInd );

/**
 * @}
 */

/**
 * @brief   Set a ATT Parameter value.  Use this function to change 
 *          the default ATT parameter values.
 *
 * @param   value - new param value
 *
 * @return  void
 */
extern void ATT_SetParamValue( uint16 value );

/**
 * @brief   Get a ATT Parameter value.
 *
 * @param   none
 *
 * @return  ATT Parameter value
 */
extern uint16 ATT_GetParamValue( void );


/*********************************************************************
*********************************************************************/





#line 16 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt.h"
/**
  @headerfile:       gatt.h
  $Date: 2009-06-29 16:20:52 -0700 (Mon, 29 Jun 2009) $
  $Revision: 20240 $

  @mainpage BLE GATT API

  Description:    This file contains Generic Attribute Profile (GATT)
                  definitions and prototypes.<BR><BR>

  \image html HighLevelGATT.PNG

  \htmlinclude GATTDesc.html

  Copyright 2009-2011 Texas Instruments Incorporated. All rights reserved.

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
*/









/*********************************************************************
 * INCLUDES
 */





/*********************************************************************
 * CONSTANTS
 */
 
/** @defgroup GATT_PERMIT_BITMAPS_DEFINES GATT Attribute Access Permissions Bit Fields
 * @{
 */

#line 76 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt.h"

/** @} End GATT_PERMIT_BITMAPS_DEFINES */


/** @defgroup GATT_NUM_PREPARE_WRITES_DEFINES GATT Maximum Number of Prepare Writes
 * @{
 */





/** @} End GATT_NUM_PREPARE_WRITES_DEFINES */


/** @defgroup GATT_ENCRYPT_KEY_SIZE_DEFINES GATT Encryption Key Size
 * @{
 */



/** @} End GATT_ENCRYPT_KEY_SIZE_DEFINES */


/** @defgroup GATT_MAX_ATTR_SIZE_DEFINES GATT Maximum Attribute Value Length
 * @{
 */



/** @} End GATT_MAX_ATTR_SIZE_DEFINES */

// GATT Maximum number of connections (including loopback)


 // GATT Base Method


// Attribute handle defintions




/*********************************************************************
 * VARIABLES
 */

/*********************************************************************
 * MACROS
 */

// Attribute Access Permissions
#line 134 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt.h"

// Check for different UUID types
#line 146 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt.h"

/*********************************************************************
 * TYPEDEFS
 */
  
/**
 * GATT Read By Type Request format.
 */
typedef struct
{
  uint8 discCharsByUUID;  //!< Whether this is a GATT Discover Characteristics by UUID sub-procedure
  attReadByTypeReq_t req; //!< Read By Type Request
} gattReadByTypeReq_t;

/**
 * GATT Prepare Write Request format.
 */
typedef struct
{
  uint16 handle; //!< Handle of the attribute to be written (must be first field)
  uint16 offset; //!< Offset of the first octet to be written
  uint8 len;     //!< Length of value
  uint8 *pValue; //!< Part of the value of the attribute to be written (must be allocated)
} gattPrepareWriteReq_t;

/**
 * GATT Write Long Request format. Do not change the order of the members.
 */
typedef struct
{
  uint8 reliable;            //!< Whether reliable writes requested (always FALSE for Write Long)
  gattPrepareWriteReq_t req; //!< GATT Prepare Write Request
  uint16 lastOffset;         //!< Offset of last Prepare Write Request sent
} gattWriteLongReq_t;

/**
 * GATT Reliable Writes Request format. Do not change the order of the members.
 */
typedef struct
{
  uint8 reliable;              //!< Whether reliable writes requested (always TRUE for Reliable Writes)
  attPrepareWriteReq_t *pReqs; //!< Arrary of Prepare Write Requests (must be allocated)
  uint8 numReqs;               //!< Number of Prepare Write Requests
  uint8 index;                 //!< Index of last Prepare Write Request sent
  uint8 flags;                 //!< 0x00 - cancel all prepared writes.
                               //!< 0x01 - immediately write all pending prepared values.
} gattReliableWritesReq_t;

/**
 * GATT Message format. It's a union of all attribute protocol/profile messages
 * used between the attribute protocol/profile and upper layer application.
 */
typedef union
{
  // Request messages
  attExchangeMTUReq_t exchangeMTUReq;              //!< ATT Exchange MTU Request
  attFindInfoReq_t findInfoReq;                    //!< ATT Find Information Request
  attFindByTypeValueReq_t findByTypeValueReq;      //!< ATT Find By Type Vaue Request
  attReadByTypeReq_t readByTypeReq;                //!< ATT Read By Type Request
  attReadReq_t readReq;                            //!< ATT Read Request
  attReadBlobReq_t readBlobReq;                    //!< ATT Read Blob Request
  attReadMultiReq_t readMultiReq;                  //!< ATT Read Multiple Request
  attReadByGrpTypeReq_t readByGrpTypeReq;          //!< ATT Read By Group Type Request
  attWriteReq_t writeReq;                          //!< ATT Write Request
  attPrepareWriteReq_t prepareWriteReq;            //!< ATT Prepare Write Request
  attExecuteWriteReq_t executeWriteReq;            //!< ATT Execute Write Request
  gattReadByTypeReq_t gattReadByTypeReq;           //!< GATT Read By Type Request
  gattWriteLongReq_t gattWriteLongReq;             //!< GATT Long Write Request
  gattReliableWritesReq_t gattReliableWritesReq;   //!< GATT Reliable Writes Request

  // Response messages
  attErrorRsp_t errorRsp;                          //!< ATT Error Response
  attExchangeMTURsp_t exchangeMTURsp;              //!< ATT Exchange MTU Response
  attFindInfoRsp_t findInfoRsp;                    //!< ATT Find Information Response
  attFindByTypeValueRsp_t findByTypeValueRsp;      //!< ATT Find By Type Vaue Response
  attReadByTypeRsp_t readByTypeRsp;                //!< ATT Read By Type Response
  attReadRsp_t readRsp;                            //!< ATT Read Response
  attReadBlobRsp_t readBlobRsp;                    //!< ATT Read Blob Response
  attReadMultiRsp_t readMultiRsp;                  //!< ATT Read Multiple Response
  attReadByGrpTypeRsp_t readByGrpTypeRsp;          //!< ATT Read By Group Type Response
  attPrepareWriteRsp_t prepareWriteRsp;            //!< ATT Prepare Write Response

  // Indication and Notification messages
  attHandleValueNoti_t handleValueNoti;            //!< ATT Handle Value Notification
  attHandleValueInd_t handleValueInd;              //!< ATT Handle Value Indication
} gattMsg_t;

/**
 * GATT OSAL GATT_MSG_EVENT message format. This message is used to forward an
 * incoming attribute protocol/profile message up to upper layer application.
 */
typedef struct
{
  osal_event_hdr_t hdr; //!< GATT_MSG_EVENT and status
  uint16 connHandle;    //!< Connection message was received on
  uint8 method;         //!< Type of message
  gattMsg_t msg;        //!< Attribute protocol/profile message
} gattMsgEvent_t;

/**
 * GATT Attribute Type format.
 */
typedef struct
{
  uint8 len;         //!< Length of UUID
  const uint8 *uuid; //!< Pointer to UUID
} gattAttrType_t;

/**
 * GATT Attribute format.
 */
typedef struct attAttribute_t
{
  gattAttrType_t type; //!< Attribute type (2 or 16 octet UUIDs)
  uint8 permissions;   //!< Attribute permissions
  uint16 handle;       //!< Attribute handle - assigned internally by attribute server
  uint8* const pValue; //!< Attribute value - encoding of the octet array is defined in 
                       //!< the applicable profile. The maximum length of an attribute 
                       //!< value shall be 512 octets.
} gattAttribute_t;

/**
 * GATT Service format.
 */
typedef struct
{
  uint16 numAttrs; //!< Number of attributes in attrs

  /** Array of attribute records. 
   *  NOTE: The list must start with a Service attribute followed by
   *        all attributes associated with this Service attribute. 
   */
  gattAttribute_t *attrs;
} gattService_t;

/*********************************************************************
 * VARIABLES
 */

/*********************************************************************
 * API FUNCTIONS
 */

/*-------------------------------------------------------------------
 * GATT Client Public APIs
 */

/**
 * @defgroup GATT_CLIENT_API GATT Client API Functions
 * 
 * @{
 */

/**
 * @brief   Initialize the Generic Attribute Profile Client.
 *
 * @return  SUCCESS
 */
extern bStatus_t GATT_InitClient( void );

/**
 * @brief   Register to receive incoming ATT Indications or Notifications
 *          of attribute values.
 *
 * @param   taskId – task to forward indications or notifications to
 *
 * @return  void
 */
extern void GATT_RegisterForInd( uint8 taskId );

/**
 * @brief   The Prepare Write Request is used to request the server to
 *          prepare to write the value of an attribute.
 *
 *          Note: This function is needed only for GATT testing.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_PrepareWriteReq( uint16 connHandle, attPrepareWriteReq_t *pReq, uint8 taskId );

/**
 * @brief   The Execute Write Request is used to request the server to
 *          write or cancel the write of all the prepared values currently
 *          held in the prepare queue from this client.
 *
 *          Note: This function is needed only for GATT testing.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ExecuteWriteReq( uint16 connHandle, attExecuteWriteReq_t *pReq, uint8 taskId );

/**
 * @}
 */

/*-------------------------------------------------------------------
 * GATT Server Public APIs
 */

/**
 * @defgroup GATT_SERVER_API GATT Server API Functions
 * 
 * @{
 */

/**
 * @brief   Initialize the Generic Attribute Profile Server.
 *
 * @return  SUCCESS
 */
extern bStatus_t GATT_InitServer( void );

/**
 * @brief   Register a service attribute list with the GATT Server. A service
 *          is composed of characteristics or references to other services.
 *          Each characteristic contains a value and may contain optional 
 *          information about the value. There are two types of services:
 *          primary service and secondary service.
 *
 *          A service definition begins with a service declaration and ends 
 *          before the next service declaration or the maximum Attribute Handle.
 *
 *          A characteristic definition begins with a characteristic declaration
 *          and ends before the next characteristic or service declaration or 
 *          maximum Attribute Handle.
 *
 *          The attribute server will only keep a pointer to the attribute
 *          list, so the calling application will have to maintain the code
 *          and RAM associated with this list.
 *
 * @param   pService - pointer to service attribute list to be registered
 *
 * @return  SUCCESS: Service registered successfully.<BR>
 *          INVALIDPARAMETER: Invalid service field.<BR>
 *          FAILURE: Not enough attribute handles available.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t GATT_RegisterService( gattService_t *pService );

/**
 * @brief   Deregister a service attribute list with the GATT Server.
 *
 *          NOTE: It's the caller's responsibility to free the service attribute
 *          list returned from this API.
 *
 * @param   handle - handle of service to be deregistered
 * @param   pService - pointer to deregistered service (to be returned)
 *
 * @return  SUCCESS: Service deregistered successfully.<BR>
 *          FAILURE: Service not found.<BR>
 */
extern bStatus_t GATT_DeregisterService( uint16 handle, gattService_t *pService );

/**
 * @brief   Register to receive incoming ATT Requests.
 *
 * @param   taskId – task to forward requests to
 *
 * @return  void
 */
extern void GATT_RegisterForReq( uint8 taskId );

/**
 * @brief   Verify the permissions of an attribute for reading.
 *
 * @param   connHandle - connection to use
 * @param   permissions - attribute permissions
 *
 * @return  SUCCESS: Attribute can be read.<BR>
 *          ATT_ERR_READ_NOT_PERMITTED: Attribute cannot be read.<BR>
 *          ATT_ERR_INSUFFICIENT_AUTHEN: Attribute requires authentication.<BR>
 *          ATT_ERR_INSUFFICIENT_KEY_SIZE: Key Size used for encrypting is insufficient.<BR>
 *          ATT_ERR_INSUFFICIENT_ENCRYPT: Attribute requires encryption.<BR>
 */
extern bStatus_t GATT_VerifyReadPermissions( uint16 connHandle, uint8 permissions );

/**
 * @brief   Verify the permissions of an attribute for writing.
 *
 * @param   connHandle - connection to use
 * @param   permissions - attribute permissions
 * @param   pReq - pointer to write request
 *
 * @return  SUCCESS: Attribute can be written.<BR>
 *          ATT_ERR_READ_NOT_PERMITTED: Attribute cannot be written.<BR>
 *          ATT_ERR_INSUFFICIENT_AUTHEN: Attribute requires authentication.<BR>
 *          ATT_ERR_INSUFFICIENT_KEY_SIZE: Key Size used for encrypting is insufficient.<BR>
 *          ATT_ERR_INSUFFICIENT_ENCRYPT: Attribute requires encryption.<BR>
 */
extern bStatus_t GATT_VerifyWritePermissions( uint16 connHandle, uint8 permissions, attWriteReq_t *pReq );

/**
 * @brief   Send out a Service Changed Indication.
 *
 * @param   connHandle - connection to use
 * @param   taskId - task to be notified of confirmation
 *
 * @return  SUCCESS: Indication was sent successfully.<BR>
 *          FAILURE: Service Changed attribute not found.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A confirmation is pending with this client.<BR>
 */
extern uint8 GATT_ServiceChangedInd( uint16 connHandle, uint8 taskId );

/**
 * @brief   Find the attribute record for a given handle and UUID.
 *
 * @param   startHandle - first handle to look for
 * @param   endHandle - last handle to look for
 * @param   pUUID - pointer to UUID to look for
 * @param   len - length of UUID
 * @param   pHandle - handle of owner of attribute (to be returned)
 * 
 * @return  Pointer to attribute record. NULL, otherwise.
 */
extern gattAttribute_t *GATT_FindHandleUUID( uint16 startHandle, uint16 endHandle, const uint8 *pUUID,
                                             uint16 len, uint16 *pHandle );
/**
 * @brief   Find the attribute record for a given handle
 *
 * @param   handle - handle to look for
 * @param   pHandle - handle of owner of attribute (to be returned)
 * 
 * @return  Pointer to attribute record. NULL, otherwise.
 */
extern gattAttribute_t *GATT_FindHandle( uint16 handle, uint16 *pHandle );

/**
 * @brief   Find the next attribute of the same type for a given attribute.
 *
 * @param   pAttr - pointer to attribute to find a next for
 * @param   endHandle - last handle to look for
 * @param   service - handle of owner service
 * @param   pLastHandle - handle of last attribute (to be returned)
 * 
 * @return  Pointer to next attribute record. NULL, otherwise.
 */
extern gattAttribute_t *GATT_FindNextAttr( gattAttribute_t *pAttr, uint16 endHandle,
                                           uint16 service, uint16 *pLastHandle );
/**
 * @brief   Get the number of attributes for a given service
 *
 * @param   handle - service handle to look for
 * 
 * @return  Number of attributes. 0, otherwise.
 */
extern uint16 GATT_ServiceNumAttrs( uint16 handle );

/**
 * @}
 */

/*-------------------------------------------------------------------
 * GATT Server Sub-Procedure APIs
 */

/**
 * @defgroup GATT_SERVER_SUB_PROCEDURE_API GATT Server Sub-Procedure API Functions
 * 
 * @{
 */

/**
 * @brief   This sub-procedure is used when a server is configured to 
 *          indicate a characteristic value to a client and expects an
 *          attribute protocol layer acknowledgement that the indication
 *          was successfully received.
 *
 *          The ATT Handle Value Indication is used in this sub-procedure.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT message.
 *          The type of the message will be ATT_HANDLE_VALUE_CFM.
 *
 *          Note: This sub-procedure is complete when ATT_HANDLE_VALUE_CFM
 *                (with SUCCESS or bleTimeout status) is received by the 
 *                calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pInd - pointer to indication to be sent
 * @param   authenticated - whether an authenticated link is required
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Indication was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A confirmation is pending with this client.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_Indication( uint16 connHandle, attHandleValueInd_t *pInd, 
                                  uint8 authenticated, uint8 taskId );
/**
 * @brief   This sub-procedure is used when a server is configured to 
 *          notify a characteristic value to a client without expecting
 *          any attribute protocol layer acknowledgement that the 
 *          notification was successfully received.
 *
 *          The ATT Handle Value Notification is used in this sub-procedure.
 *
 *          Note: A notification may be sent at any time and does not
 *          invoke a confirmation.
 *
 *          No confirmation will be sent to the calling application task for
 *          this sub-procedure.
 *
 * @param   connHandle - connection to use
 * @param   pNoti - pointer to notification to be sent
 * @param   authenticated - whether an authenticated link is required
 *
 * @return  SUCCESS: Notification was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_Notification( uint16 connHandle, attHandleValueNoti_t *pNoti,
                                    uint8 authenticated );
/**
 * @}
 */

/*-------------------------------------------------------------------
 * GATT Client Sub-Procedure APIs
 */

/**
 * @defgroup GATT_CLIENT_SUB_PROCEDURE_API GATT Client Sub-Procedure API Functions
 * 
 * @{
 */

/**
 * @brief   This sub-procedure is used by the client to set the ATT_MTU
 *          to the maximum possible value that can be supported by both
 *          devices when the client supports a value greater than the
 *          default ATT_MTU for the Attribute Protocol. This sub-procedure
 *          shall only be initiated once during a connection.
 *
 *          The ATT Exchange MTU Request is used by this sub-procedure.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT message.
 *          The type of the message will be either ATT_EXCHANGE_MTU_RSP or
 *          ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_EXCHANGE_MTU_RSP
 *                (with SUCCESS or bleTimeout status) or ATT_ERROR_RSP (with
 *                SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ExchangeMTU( uint16 connHandle, attExchangeMTUReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used by a client to discover all 
 *          the primary services on a server.
 *
 *          The ATT Read By Group Type Request is used with the Attribute
 *          Type parameter set to the UUID for "Primary Service". The
 *          Starting Handle is set to 0x0001 and the Ending Handle is
 *          set to 0xFFFF.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_READ_BY_GRP_TYPE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_BY_GRP_TYPE_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application
 *                task.
 *
 * @param   connHandle - connection to use
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_DiscAllPrimaryServices( uint16 connHandle, uint8 taskId );

/**
 * @brief   This sub-procedure is used by a client to discover a specific
 *          primary service on a server when only the Service UUID is
 *          known. The primary specific service may exist multiple times 
 *          on a server. The primary service being discovered is identified
 *          by the service UUID.
 *
 *          The ATT Find By Type Value Request is used with the Attribute
 *          Type parameter set to the UUID for "Primary Service" and the
 *          Attribute Value set to the 16-bit Bluetooth UUID or 128-bit
 *          UUID for the specific primary service. The Starting Handle shall
 *          be set to 0x0001 and the Ending Handle shall be set to 0xFFFF.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_FIND_BY_TYPE_VALUE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_FIND_BY_TYPE_VALUE_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pValue - pointer to value to look for
 * @param   len - length of value
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_DiscPrimaryServiceByUUID( uint16 connHandle, uint8 *pValue,
                                                uint8 len, uint8 taskId );
/**
 * @brief   This sub-procedure is used by a client to find include
 *          service declarations within a service definition on a 
 *          server. The service specified is identified by the service
 *          handle range.
 *
 *          The ATT Read By Type Request is used with the Attribute
 *          Type parameter set to the UUID for "Included Service". The
 *          Starting Handle is set to starting handle of the specified
 *          service and the Ending Handle is set to the ending handle
 *          of the specified service.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_READ_BY_TYPE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_BY_TYPE_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   startHandle - starting handle
 * @param   endHandle - end handle
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_FindIncludedServices( uint16 connHandle, uint16 startHandle,
                                            uint16 endHandle, uint8 taskId );
/**
 * @brief   This sub-procedure is used by a client to find all the 
 *          characteristic declarations within a service definition on
 *          a server when only the service handle range is known. The
 *          service specified is identified by the service handle range.
 *
 *          The ATT Read By Type Request is used with the Attribute Type
 *          parameter set to the UUID for "Characteristic". The Starting
 *          Handle is set to starting handle of the specified service and
 *          the Ending Handle is set to the ending handle of the specified
 *          service.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_READ_BY_TYPE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_BY_TYPE_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   startHandle - starting handle
 * @param   endHandle - end handle
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_DiscAllChars( uint16 connHandle, uint16 startHandle,
                                    uint16 endHandle, uint8 taskId );
/**
 * @brief   This sub-procedure is used by a client to discover service 
 *          characteristics on a server when only the service handle 
 *          ranges are known and the characteristic UUID is known. 
 *          The specific service may exist multiple times on a server.
 *          The characteristic being discovered is identified by the 
 *          characteristic UUID.
 *
 *          The ATT Read By Type Request is used with the Attribute Type
 *          is set to the UUID for "Characteristic" and the Starting
 *          Handle and Ending Handle parameters is set to the service
 *          handle range.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_READ_BY_TYPE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_BY_TYPE_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_DiscCharsByUUID( uint16 connHandle, attReadByTypeReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used by a client to find all the 
 *          characteristic descriptor’s Attribute Handles and Attribute
 *          Types within a characteristic definition when only the 
 *          characteristic handle range is known. The characteristic 
 *          specified is identified by the characteristic handle range.
 *
 *          The ATT Find Information Request is used with the Starting
 *          Handle set to starting handle of the specified characteristic
 *          and the Ending Handle set to the ending handle of the specified
 *          characteristic. The UUID Filter parameter is NULL (zero length).
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_FIND_INFO_RSP or
 *          ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_FIND_INFO_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   startHandle - starting handle
 * @param   endHandle - end handle
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_DiscAllCharDescs( uint16 connHandle, uint16 startHandle,
                                        uint16 endHandle, uint8 taskId );
/**
 * @brief   This sub-procedure is used to read a Characteristic Value
 *          from a server when the client knows the Characteristic Value
 *          Handle. The ATT Read Request is used with the Attribute Handle
 *          parameter set to the Characteristic Value Handle. The Read 
 *          Response returns the Characteristic Value in the Attribute
 *          Value parameter.
 *
 *          The Read Response only contains a Characteristic Value that
 *          is less than or equal to (ATT_MTU – 1) octets in length. If 
 *          the Characteristic Value is greater than (ATT_MTU – 1) octets
 *          in length, the Read Long Characteristic Value procedure may
 *          be used if the rest of the Characteristic Value is required.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT message.
 *          The type of the message will be either ATT_READ_RSP or
 *          ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_RSP
 *                (with SUCCESS or bleTimeout status) or ATT_ERROR_RSP (with
 *                SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ReadCharValue( uint16 connHandle, attReadReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to read a Characteristic Value
 *          from a server when the client only knows the characteristic
 *          UUID and does not know the handle of the characteristic.
 *
 *          The ATT Read By Type Request is used to perform the sub-procedure.
 *          The Attribute Type is set to the known characteristic UUID and
 *          the Starting Handle and Ending Handle parameters shall be set
 *          to the range over which this read is to be performed. This is
 *          typically the handle range for the service in which the 
 *          characteristic belongs.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT messages.
 *          The type of the message will be either ATT_READ_BY_TYPE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_BY_TYPE_RSP
 *                (with SUCCESS or bleTimeout status) or ATT_ERROR_RSP (with
 *                SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ReadUsingCharUUID( uint16 connHandle, attReadByTypeReq_t *pReq, uint8 taskId );
/**
 * @brief   This sub-procedure is used to read a Characteristic Value from
 *          a server when the client knows the Characteristic Value Handle
 *          and the length of the Characteristic Value is longer than can 
 *          be sent in a single Read Response Attribute Protocol message.
 *
 *          The ATT Read Blob Request is used in this sub-procedure.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_READ_BLOB_RSP or
 *          ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_BLOB_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ReadLongCharValue( uint16 connHandle, attReadBlobReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to read multiple Characteristic Values
 *          from a server when the client knows the Characteristic Value 
 *          Handles. The Attribute Protocol Read Multiple Requests is used 
 *          with the Set Of Handles parameter set to the Characteristic Value
 *          Handles. The Read Multiple Response returns the Characteristic
 *          Values in the Set Of Values parameter.
 *
 *          The ATT Read Multiple Request is used in this sub-procedure.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT message.
 *          The type of the message will be either ATT_READ_MULTI_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_MULTI_RSP
 *                (with SUCCESS or bleTimeout status) or ATT_ERROR_RSP (with
 *                SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ReadMultiCharValues( uint16 connHandle, attReadMultiReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to write a Characteristic Value
 *          to a server when the client knows the Characteristic Value
 *          Handle and the client does not need an acknowledgement that
 *          the write was successfully performed. This sub-procedure
 *          only writes the first (ATT_MTU – 3) octets of a Characteristic
 *          Value. This sub-procedure can not be used to write a long
 *          characteristic; instead the Write Long Characteristic Values
 *          sub-procedure should be used.
 * 
 *          The ATT Write Command is used for this sub-procedure. The
 *          Attribute Handle parameter shall be set to the Characteristic
 *          Value Handle. The Attribute Value parameter shall be set to
 *          the new Characteristic Value.
 *
 *          No response will be sent to the calling application task for this
 *          sub-procedure. If the Characteristic Value write request is the 
 *          wrong size, or has an invalid value as defined by the profile, 
 *          then the write will not succeed and no error will be generated 
 *          by the server.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to command to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_WriteNoRsp( uint16 connHandle, attWriteReq_t *pReq );

/**
 * @brief   This sub-procedure is used to write a Characteristic Value
 *          to a server when the client knows the Characteristic Value 
 *          Handle and the ATT Bearer is not encrypted. This sub-procedure
 *          shall only be used if the Characteristic Properties authenticated
 *          bit is enabled and the client and server device share a bond as
 *          defined in the GAP.
 *
 *          This sub-procedure only writes the first (ATT_MTU – 15) octets
 *          of an Attribute Value. This sub-procedure cannot be used to 
 *          write a long Attribute.
 *
 *          The ATT Write Command is used for this sub-procedure. The
 *          Attribute Handle parameter shall be set to the Characteristic
 *          Value Handle. The Attribute Value parameter shall be set to 
 *          the new Characteristic Value authenticated by signing the
 *          value, as defined in the Security Manager.
 *
 *          No response will be sent to the calling application task for this
 *          sub-procedure. If the authenticated Characteristic Value that is 
 *          written is the wrong size, or has an invalid value as defined by 
 *          the profile, or the signed value does not authenticate the client,
 *          then the write will not succeed and no error will be generated by
 *          the server.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to command to be sent
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleLinkEncrypted: Connection is already encrypted.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_SignedWriteNoRsp( uint16 connHandle, attWriteReq_t *pReq );

/**
 * @brief   This sub-procedure is used to write a characteristic value
 *          to a server when the client knows the characteristic value
 *          handle. This sub-procedure only writes the first (ATT_MTU-3)
 *          octets of a characteristic value. This sub-procedure can not
 *          be used to write a long attribute; instead the Write Long 
 *          Characteristic Values sub-procedure should be used.
 *
 *          The ATT Write Request is used in this sub-procedure. The 
 *          Attribute Handle parameter shall be set to the Characteristic
 *          Value Handle. The Attribute Value parameter shall be set to
 *          the new characteristic.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT message.
 *          The type of the message will be either ATT_WRITE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_WRITE_RSP
 *                (with SUCCESS or bleTimeout status) or ATT_ERROR_RSP (with
 *                SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_WriteCharValue( uint16 connHandle, attWriteReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to write a Characteristic Value to
 *          a server when the client knows the Characteristic Value Handle
 *          but the length of the Characteristic Value is longer than can 
 *          be sent in a single Write Request Attribute Protocol message.
 *
 *          The ATT Prepare Write Request and Execute Write Request are
 *          used to perform this sub-procedure.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_PREPARE_WRITE_RSP,
 *          ATT_EXECUTE_WRITE_RSP or ATT_ERROR_RSP (if an error occurred on
 *          the server).
 *
 *          Note: This sub-procedure is complete when either ATT_PREPARE_WRITE_RSP
 *                (with bleTimeout status), ATT_EXECUTE_WRITE_RSP (with SUCCESS
 *                or bleTimeout status), or ATT_ERROR_RSP (with SUCCESS status)
 *                is received by the calling application task.
 *
 *          Note: The 'pReq->pValue' pointer will be freed when the sub-procedure
 *                is complete. 
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_WriteLongCharValue( uint16 connHandle, gattPrepareWriteReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to write a Characteristic Value to
 *          a server when the client knows the Characteristic Value Handle,
 *          and assurance is required that the correct Characteristic Value
 *          is going to be written by transferring the Characteristic Value
 *          to be written in both directions before the write is performed.
 *          This sub-procedure can also be used when multiple values must 
 *          be written, in order, in a single operation.
 *
 *          The sub-procedure has two phases, the first phase prepares the
 *          characteristic values to be written.  Once this is complete, 
 *          the second phase performs the execution of all of the prepared
 *          characteristic value writes on the server from this client.
 *
 *          In the first phase, the ATT Prepare Write Request is used.
 *          In the second phase, the attribute protocol Execute Write
 *          Request is used.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_PREPARE_WRITE_RSP,
 *          ATT_EXECUTE_WRITE_RSP or ATT_ERROR_RSP (if an error occurred on
 *          the server).
 *
 *          Note: This sub-procedure is complete when either ATT_PREPARE_WRITE_RSP
 *                (with bleTimeout status), ATT_EXECUTE_WRITE_RSP (with SUCCESS
 *                or bleTimeout status), or ATT_ERROR_RSP (with SUCCESS status)
 *                is received by the calling application task. 
 *
 *          Note: The 'pReqs' pointer will be freed when the sub-procedure is
 *                complete. 
 *
 * @param   connHandle - connection to use
 * @param   pReqs - pointer to requests to be sent (must be allocated)
 * @param   numReqs - number of requests in pReq
 * @param   flags - execute write request flags
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ReliableWrites( uint16 connHandle, attPrepareWriteReq_t *pReqs, 
                                      uint8 numReqs, uint8 flags, uint8 taskId );
/**
 * @brief   This sub-procedure is used to read a characteristic descriptor
 *          from a server when the client knows the characteristic descriptor
 *          declaration’s Attribute handle.
 *
 *          The ATT Read Request is used for this sub-procedure. The Read
 *          Request is used with the Attribute Handle parameter set to the 
 *          characteristic descriptor handle. The Read Response returns the
 *          characteristic descriptor value in the Attribute Value parameter.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT message.
 *          The type of the message will be either ATT_READ_RSP or
 *          ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_RSP
 *                (with SUCCESS or bleTimeout status) or ATT_ERROR_RSP (with
 *                SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ReadCharDesc( uint16 connHandle, attReadReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to read a characteristic descriptor
 *          from a server when the client knows the characteristic descriptor
 *          declaration’s Attribute handle and the length of the characteristic
 *          descriptor declaration is longer than can be sent in a single Read
 *          Response attribute protocol message.
 *
 *          The ATT Read Blob Request is used to perform this sub-procedure.
 *          The Attribute Handle parameter shall be set to the characteristic
 *          descriptor handle. The Value Offset parameter shall be the offset
 *          within the characteristic descriptor to be read.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_READ_BLOB_RSP or
 *          ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_READ_BLOB_RSP
 *                (with bleProcedureComplete or bleTimeout status) or ATT_ERROR_RSP
 *                (with SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_ReadLongCharDesc( uint16 connHandle, attReadBlobReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to write a characteristic
 *          descriptor value to a server when the client knows the
 *          characteristic descriptor handle.
 *
 *          The ATT Write Request is used for this sub-procedure. The
 *          Attribute Handle parameter shall be set to the characteristic
 *          descriptor handle. The Attribute Value parameter shall be
 *          set to the new characteristic descriptor value.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive an OSAL GATT_MSG_EVENT message.
 *          The type of the message will be either ATT_WRITE_RSP
 *          or ATT_ERROR_RSP (if an error occurred on the server).
 *
 *          Note: This sub-procedure is complete when either ATT_WRITE_RSP
 *                (with SUCCESS or bleTimeout status) or ATT_ERROR_RSP (with
 *                SUCCESS status) is received by the calling application task.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_WriteCharDesc( uint16 connHandle, attWriteReq_t *pReq, uint8 taskId );

/**
 * @brief   This sub-procedure is used to write a Characteristic Value to
 *          a server when the client knows the Characteristic Value Handle
 *          but the length of the Characteristic Value is longer than can 
 *          be sent in a single Write Request Attribute Protocol message.
 *
 *          The ATT Prepare Write Request and Execute Write Request are
 *          used to perform this sub-procedure.
 *
 *          If the return status from this function is SUCCESS, the calling
 *          application task will receive multiple OSAL GATT_MSG_EVENT messages.
 *          The type of the messages will be either ATT_PREPARE_WRITE_RSP,
 *          ATT_EXECUTE_WRITE_RSP or ATT_ERROR_RSP (if an error occurred on
 *          the server).
 *
 *          Note: This sub-procedure is complete when either ATT_PREPARE_WRITE_RSP
 *                (with bleTimeout status), ATT_EXECUTE_WRITE_RSP (with SUCCESS
 *                or bleTimeout status), or ATT_ERROR_RSP (with SUCCESS status)
 *                is received by the calling application task.
 *
 *          Note: The 'pReq->pValue' pointer will be freed when the sub-procedure
 *                is complete.
 *
 * @param   connHandle - connection to use
 * @param   pReq - pointer to request to be sent
 * @param   taskId - task to be notified of response
 *
 * @return  SUCCESS: Request was sent successfully.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.v
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A response is pending with this server.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 *          bleTimeout: Previous transaction timed out.<BR>
 */
extern bStatus_t GATT_WriteLongCharDesc( uint16 connHandle, gattPrepareWriteReq_t *pReq, uint8 taskId );

/**
 * @}
 */

/*-------------------------------------------------------------------
 * Internal API - This function is only called from GATT Qualification modules.
 */

  /**
   * @internal
   *
   * @brief       Set the next available attribute handle.
   *
   * @param       handle - next attribute handle.
   *
   * @return      none
   */
extern void GATT_SetNextHandle( uint16 handle );

/*-------------------------------------------------------------------
 * TASK API - These functions must only be called by OSAL.
 */

/**
 * @internal
 *
 * @brief   GATT Task initialization function.
 *
 * @param   taskId - GATT task ID.
 *
 * @return  void
 */
extern void GATT_Init( uint8 taskId );

/**
 * @internal
 *
 * @brief   GATT Task event processing function.
 *
 * @param   taskId - GATT task ID
 * @param   events - GATT events.
 *
 * @return  events not processed
 */
extern uint16 GATT_ProcessEvent( uint8 taskId, uint16 events );

/*********************************************************************
*********************************************************************/





#line 17 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt_uuid.h"
/**************************************************************************************************
  Filename:       gatt_uuid.h
  Revised:        $Date: 2009-06-29 16:20:52 -0700 (Mon, 29 Jun 2009) $
  Revision:       $Revision: 20240 $

  Description:    This file contains Generic Attribute Profile (GATT)
                  UUID types.


  Copyright 2010-2013 Texas Instruments Incorporated. All rights reserved.

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

/*
 * WARNING: The 16-bit UUIDs are assigned by the Bluetooth SIG and published
 *          in the Bluetooth Assigned Numbers page. Do not change these values.
 *          Changing them will cause Bluetooth interoperability issues.
 */

/**
 * GATT Services
 */



/**
 * GATT Declarations
 */





/**
 * GATT Descriptors
 */
#line 89 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt_uuid.h"

/**
 * GATT Characteristics
 */
#line 99 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt_uuid.h"

/**
 * GATT Units
 */
#line 111 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt_uuid.h"

#line 136 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt_uuid.h"



#line 148 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt_uuid.h"

#line 170 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt_uuid.h"

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * VARIABLES
 */

/**
 * GATT Services
 */
extern const uint8 gapServiceUUID[];
extern const uint8 gattServiceUUID[];

/**
 * GATT Attribute Types
 */
extern const uint8 primaryServiceUUID[];
extern const uint8 secondaryServiceUUID[];
extern const uint8 includeUUID[];
extern const uint8 characterUUID[];

/**
 * GATT Characteristic Descriptors
 */
extern const uint8 charExtPropsUUID[];
extern const uint8 charUserDescUUID[];
extern const uint8 clientCharCfgUUID[];
extern const uint8 clientCharCfg2UUID[];
extern const uint8 servCharCfgUUID[];
extern const uint8 charFormatUUID[];
extern const uint8 charAggFormatUUID[];
extern const uint8 validRangeUUID[];
extern const uint8 extReportRefUUID[];
extern const uint8 reportRefUUID[];

/**
 * GATT Characteristic Types
 */
extern const uint8 deviceNameUUID[];
extern const uint8 appearanceUUID[];
extern const uint8 periPrivacyFlagUUID[];
extern const uint8 reconnectAddrUUID[];
extern const uint8 periConnParamUUID[];
extern const uint8 serviceChangedUUID[];
extern const uint8 manuNameUUID[];
extern const uint8 serialNumUUID[];
extern const uint8 manuAddrUUID[];

/*********************************************************************
 * FUNCTIONS
 */
extern const uint8 *GATT_FindUUIDRec( uint8 *pUUID, uint8 len );

/*********************************************************************
*********************************************************************/





#line 18 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\include\\gattservapp.h"
/**
  @headerfile:       gattservapp.h
  $Date: 2009-06-29 16:20:52 -0700 (Mon, 29 Jun 2009) $
  $Revision: 20240 $

  @mainpage BLE GATT Server Application API

  Description:    This file contains the GATT Server Application (GATTServApp)
                  definitions and prototypes.<BR><BR>

  \image html HighLevelGATTServApp.PNG

  <BR>
  <h2>Functional Description</h2>
  <p>The GATT Server Application (GATTServApp) provides the following abilities:</p>
  <ul>
  <li><b>Service Registration</b> - This API is used to register a service's
         attribute list and callback functions with the GATT Server Application.</li>
  <li><b>Service Deregistration</b> - This API is used to deregister a service's
         attribute list and callback functions from the GATT Server Application.</li>
  <li><b>GATT Service Addition</b> - This API is the add function for the GATT
         Service. It registers the GATT Service's attribute list and callback
         functions with the GATT Server Application.</li>
  <li><b>GATT Service Deletion</b> - This API is the delete function for the
         GATT Service. It deregisters the GATT Service's attribute list and
         callback functions from the GATT Server Application.</li>
  </ul><BR>

  <h2>Service Attribute List</h2>
  <p>A profile may support one or more services. Each of the services may support
     characteristics or references to other services. Each characteristic contains
     a value and may contain optional descriptors. The service, characteristic,
     characteristic value and descriptors are all stored as attributes on the server.
     The service attribute list to be registered with the GATT Server must start
     with a Service attribute followed by all the attributes associated with that
     Service attribute.
  </p><BR><BR>

  \image html GATTAttributeList.PNG

  <BR>
  <h2>Service Callback Functions</h2>
  <p>The encoding of each attribute value is defined in the applicable profile.
     The GATT Server doesn't directly access the attribute value for reading
     or writing. It uses the Read and Write callback functions provided by the
     registering profile to execute the incoming Attribute Protocol (ATT) Read
     and Write request respectively.
  </p><BR><BR><BR><BR><BR><BR>

  Copyright 2009 - 2012 Texas Instruments Incorporated. All rights reserved.

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

/** @defgroup GATT_SERV_MSG_EVENT_DEFINES GATT Server Message IDs
 * @{
 */



/** @} End GATT_SERV_MSG_EVENT_DEFINES */


/** @defgroup GATT_PROP_BITMAPS_DEFINES GATT Characteristic Properties Bit Fields
 * @{
 */

#line 120 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\include\\gattservapp.h"

/** @} End GATT_PROP_BITMAPS_DEFINES */

/** @defgroup GATT_EXT_PROP_BITMAPS_DEFINES GATT Characteristic Extended Properties Bit Fields
 * @{
 */




/** @} End GATT_EXT_PROP_BITMAPS_DEFINES */

/** @defgroup GATT_CLIENT_CFG_BITMAPS_DEFINES GATT Client Characteristic Configuration Bit Fields
 * @{
 */




/** @} End GATT_CLIENT_CFG_BITMAPS_DEFINES */

/** @defgroup GATT_SERV_CFG_BITMAPS_DEFINES GATT Server Characteristic Configuration Bit Fields
 * @{
 */



/** @} End GATT_SERV_CFG_BITMAPS_DEFINES */



/** @defgroup GATT_FORMAT_TYPES_DEFINES GATT Characteristic Format Types
 * @{
 */

#line 182 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\include\\gattservapp.h"

/** @} End GATT_FORMAT_TYPES_DEFINES */

/** @defgroup GATT_NS_TYPES_DEFINES GATT Namespace Types
 * @{
 */




/** @} End GATT_NS_TYPES_DEFINES */

/** @defgroup GATT_NS_BT_DESC_DEFINES GATT Bluetooth Namespace Descriptions
 * @{
 */



/** @} End GATT_NS_BT_DESC_DEFINES */

// All profile services bit fields


// GATT Services bit fields


#line 216 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\include\\gattservapp.h"

// GATT Server Parameters


/*********************************************************************
 * VARIABLES
 */

/*********************************************************************
 * MACROS
 */

// The number of attribute records in a given attribute table


// The handle of a service is the handle of the first attribute


// The handle of the first included service (i = 1) is the value of the second attribute


/*********************************************************************
 * TYPEDEFS
 */

/**
 * @defgroup GATT_SERV_APP_CB_API GATT Server App Callback API Functions
 *
 * @{
 */

/**
 * @brief   Callback function prototype to read an attribute value.
 *
 * @param   connHandle - connection request was received on
 * @param   pAttr - pointer to attribute
 * @param   pValue - pointer to data to be read (to be returned)
 * @param   pLen - length of data (to be returned)
 * @param   offset - offset of the first octet to be read
 * @param   maxLen - maximum length of data to be read
 *
 * @return  SUCCESS: Read was successfully.<BR>
 *          Error, otherwise: ref ATT_ERR_CODE_DEFINES.<BR>
 */
typedef bStatus_t (*pfnGATTReadAttrCB_t)( uint16 connHandle, gattAttribute_t *pAttr,
                                          uint8 *pValue, uint8 *pLen, uint16 offset,
                                          uint8 maxLen );
/**
 * @brief   Callback function prototype to write an attribute value.
 *
 * @param   connHandle - connection request was received on
 * @param   pAttr - pointer to attribute
 * @param   pValue - pointer to data to be written
 * @param   pLen - length of data
 * @param   offset - offset of the first octet to be written
 *
 * @return  SUCCESS: Write was successfully.<BR>
 *          Error, otherwise: ref ATT_ERR_CODE_DEFINES.<BR>
 */
typedef bStatus_t (*pfnGATTWriteAttrCB_t)( uint16 connHandle, gattAttribute_t *pAttr,
                                           uint8 *pValue, uint8 len, uint16 offset );
/**
 * @brief   Callback function prototype to authorize a Read or Write operation
 *          on a given attribute.
 *
 * @param   connHandle - connection request was received on
 * @param   pAttr - pointer to attribute
 * @param   opcode - request opcode (ATT_READ_REQ or ATT_WRITE_REQ)
 *
 * @return  SUCCESS: Operation authorized.<BR>
 *          ATT_ERR_INSUFFICIENT_AUTHOR: Authorization required.<BR>
 */
typedef bStatus_t (*pfnGATTAuthorizeAttrCB_t)( uint16 connHandle, gattAttribute_t *pAttr,
                                               uint8 opcode );
/**
 * @}
 */

/**
 * GATT Structure for Characteristic Presentation Format Value.
 */
typedef struct
{
  uint8 format;    //!< Format of the value of this characteristic
  uint8 exponent;  //!< A sign integer which represents the exponent of an integer
  uint16 unit;     //!< Unit of this attribute as defined in the data dictionary
  uint8 nameSpace; //!< Name space of the description
  uint16 desc;     //!< Description of this attribute as defined in a higher layer profile
} gattCharFormat_t;

/**
 * GATT Structure for Client Characteristic Configuration.
 */
typedef struct
{
  uint16 connHandle; //!< Client connection handle
  uint8  value;      //!< Characteristic configuration value for this client
} gattCharCfg_t;

/**
 * GATT Structure for service callback functions - must be setup by the application
 * and used when GATTServApp_RegisterService() is called.
 */
typedef struct
{
  pfnGATTReadAttrCB_t pfnReadAttrCB;           //!< Read callback function pointer
  pfnGATTWriteAttrCB_t pfnWriteAttrCB;         //!< Write callback function pointer
  pfnGATTAuthorizeAttrCB_t pfnAuthorizeAttrCB; //!< Authorization callback function pointer
} gattServiceCBs_t;

/**
 * GATT Server App event header format.
 */
typedef struct
{
  osal_event_hdr_t  hdr;           //!< GATT_SERV_MSG_EVENT and status
  uint16 connHandle;               //!< Connection message was received on
  uint8 method;                    //!< GATT type of command. Ref: @ref GATT_SERV_MSG_EVENT_DEFINES
} gattEventHdr_t;

/**
 * GATT_CLIENT_CHAR_CFG_UPDATED_EVENT message format.  This message is sent to
 * the app when a Client Characteristic Configuration is updated.
 */
typedef struct
{
  osal_event_hdr_t hdr; //!< GATT_SERV_MSG_EVENT and status
  uint16 connHandle;    //!< Connection message was received on
  uint8 method;         //!< GATT_CLIENT_CHAR_CFG_UPDATED_EVENT
  uint16 attrHandle;    //!< attribute handle
  uint16 value;         //!< attribute new value
} gattClientCharCfgUpdatedEvent_t;


/*********************************************************************
 * VARIABLES
 */

/*********************************************************************
 * API FUNCTIONS
 */

/**
 * @defgroup GATT_SERV_APP_API GATT Server App API Functions
 *
 * @{
 */

/**
 * @brief   Register your task ID to receive event messages
 *          from the GATT Server Application.
 *
 * @param   taskID - Default task ID to send events.
 *
 * @return  none
 */
extern void GATTServApp_RegisterForMsg( uint8 taskID );

/**
 * @brief   Register a service's attribute list and callback functions with
 *          the GATT Server Application.
 *
 * @param   pAttrs - Array of attribute records to be registered
 * @param   numAttrs - Number of attributes in array
 * @param   pServiceCBs - Service callback function pointers
 *
 * @return  SUCCESS: Service registered successfully.<BR>
 *          INVALIDPARAMETER: Invalid service field.<BR>
 *          FAILURE: Not enough attribute handles available.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t GATTServApp_RegisterService( gattAttribute_t *pAttrs, uint16 numAttrs,
                                              const gattServiceCBs_t *pServiceCBs );
/**
 * @brief   Deregister a service's attribute list and callback functions from
 *          the GATT Server Application.
 *
 *          NOTE: It's the caller's responsibility to free the service attribute
 *          list returned from this API.
 *
 * @param   handle - handle of service to be deregistered
 * @param   p2pAttrs - pointer to array of attribute records (to be returned)
 *
 * @return  SUCCESS: Service deregistered successfully.
 *          FAILURE: Service not found.
 */
bStatus_t GATTServApp_DeregisterService( uint16 handle, gattAttribute_t **p2pAttrs );

/**
 * @brief       Find the attribute record within a service attribute
 *              table for a given attribute value pointer.
 *
 * @param       pAttrTbl - pointer to attribute table
 * @param       numAttrs - number of attributes in attribute table
 * @param       pValue - pointer to attribute value
 *
 * @return      Pointer to attribute record. NULL, if not found.
 */
extern gattAttribute_t *GATTServApp_FindAttr( gattAttribute_t *pAttrTbl,
                                              uint16 numAttrs, uint8 *pValue );
/**
 * @brief   Add function for the GATT Service.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  SUCCESS: Service added successfully.<BR>
 *          INVALIDPARAMETER: Invalid service field.<BR>
 *          FAILURE: Not enough attribute handles available.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t GATTServApp_AddService( uint32 services );

/**
 * @brief   Delete function for the GATT Service.
 *
 * @param   services - services to delete. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  SUCCESS: Service deleted successfully.<BR>
 *          FAILURE: Service not found.<BR>
 */
extern bStatus_t GATTServApp_DelService( uint32 services );

/**
 * @brief   Set a GATT Server parameter.
 *
 * @param   param - Profile parameter ID
 * @param   len - length of data to right
 * @param   pValue - pointer to data to write. This is dependent on the
 *                   parameter ID and WILL be cast to the appropriate
 *                   data type (example: data type of uint16 will be cast
 *                   to uint16 pointer).
 *
 * @return  SUCCESS: Parameter set successful
 *          FAILURE: Parameter in use
 *          INVALIDPARAMETER: Invalid parameter
 *          bleInvalidRange: Invalid value
 *          bleMemAllocError: Memory allocation failed
 */
extern bStatus_t GATTServApp_SetParameter( uint8 param, uint8 len, void *pValue );

/**
 * @brief   Get a GATT Server parameter.
 *
 * @param   param - Profile parameter ID
 * @param   pValue - pointer to data to put. This is dependent on the
 *                   parameter ID and WILL be cast to the appropriate
 *                   data type (example: data type of uint16 will be
 *                   cast to uint16 pointer).
 *
 * @return  SUCCESS: Parameter get successful
 *          INVALIDPARAMETER: Invalid parameter
 */
extern bStatus_t GATTServApp_GetParameter( uint8 param, void *pValue );

/**
 * @brief   Update the Client Characteristic Configuration for a given
 *          Client.
 *
 *          Note: This API should only be called from the Bond Manager.
 *
 * @param   connHandle - connection handle.
 * @param   attrHandle - attribute handle.
 * @param   value - characteristic configuration value.
 *
 * @return  SUCCESS: Parameter get successful
 *          INVALIDPARAMETER: Invalid parameter
 */
extern bStatus_t GATTServApp_UpdateCharCfg( uint16 connHandle, uint16 attrHandle, uint16 value );

/**
 * @brief   Initialize the client characteristic configuration table.
 *
 *          Note: Each client has its own instantiation of the Client
 *                Characteristic Configuration. Reads/Writes of the Client
 *                Characteristic Configuration only only affect the
 *                configuration of that client.
 *
 * @param   connHandle - connection handle (0xFFFF for all connections).
 * @param   charCfgTbl - client characteristic configuration table.
 *
 * @return  none
 */
extern void GATTServApp_InitCharCfg( uint16 connHandle, gattCharCfg_t *charCfgTbl );

/**
 * @brief   Read the client characteristic configuration for a given
 *          client.
 *
 *          Note: Each client has its own instantiation of the Client
 *                Characteristic Configuration. Reads of the Client
 *                Characteristic Configuration only shows the configuration
 *                for that client.
 *
 * @param   connHandle - connection handle.
 * @param   charCfgTbl - client characteristic configuration table.
 *
 * @return  attribute value
 */
extern uint16 GATTServApp_ReadCharCfg( uint16 connHandle, gattCharCfg_t *charCfgTbl );

/**
 * @brief   Write the client characteristic configuration for a given
 *          client.
 *
 *          Note: Each client has its own instantiation of the Client
 *                Characteristic Configuration. Writes of the Client
 *                Characteristic Configuration only only affect the
 *                configuration of that client.
 *
 * @param   connHandle - connection handle.
 * @param   charCfgTbl - client characteristic configuration table.
 * @param   value - attribute new value.
 *
 * @return  Success or Failure
 */
extern uint8 GATTServApp_WriteCharCfg( uint16 connHandle, gattCharCfg_t *charCfgTbl, uint16 value );

/**
 * @brief   Process the client characteristic configuration
 *          write request for a given client.
 *
 * @param   connHandle - connection message was received on.
 * @param   pAttr - pointer to attribute.
 * @param   pValue - pointer to data to be written.
 * @param   len - length of data.
 * @param   offset - offset of the first octet to be written.
 * @param   validCfg - valid configuration.
 *
 * @return  Success or Failure
 */
extern bStatus_t GATTServApp_ProcessCCCWriteReq( uint16 connHandle, gattAttribute_t *pAttr,
                                          uint8 *pValue, uint8 len, uint16 offset,
                                          uint16 validCfg );

/**
 * @brief   Process Client Charateristic Configuration change.
 *
 * @param   charCfgTbl - characteristic configuration table.
 * @param   pValue - pointer to attribute value.
 * @param   authenticated - whether an authenticated link is required.
 * @param   attrTbl - attribute table.
 * @param   numAttrs - number of attributes in attribute table.
 * @param   taskId - task to be notified of confirmation.
 *
 * @return  Success or Failure
 */
extern bStatus_t GATTServApp_ProcessCharCfg( gattCharCfg_t *charCfgTbl, uint8 *pValue,
                                        uint8 authenticated, gattAttribute_t *attrTbl,
                                        uint16 numAttrs, uint8 taskId );

/**
 * @brief   Build and send the GATT_CLIENT_CHAR_CFG_UPDATED_EVENT to
 *          the application.
 *
 * @param   connHandle - connection handle
 * @param   attrHandle - attribute handle
 * @param   value - attribute new value
 *
 * @return  none
 */
extern void GATTServApp_SendCCCUpdatedEvent( uint16 connHandle, uint16 attrHandle, uint16 value );

/**
 * @brief   Send out a Service Changed Indication.
 *
 * @param   connHandle - connection to use
 * @param   taskId - task to be notified of confirmation
 *
 * @return  SUCCESS: Indication was sent successfully.<BR>
 *          FAILURE: Service Changed attribute not found.<BR>
 *          INVALIDPARAMETER: Invalid connection handle or request field.<BR>
 *          MSG_BUFFER_NOT_AVAIL: No HCI buffer is available.<BR>
 *          bleNotConnected: Connection is down.<BR>
 *          blePending: A confirmation is pending with this client.<BR>
 */
extern bStatus_t GATTServApp_SendServiceChangedInd( uint16 connHandle, uint8 taskId );

/**
 * @brief       Read an attribute. If the format of the attribute value
 *              is unknown to GATT Server, use the callback function
 *              provided by the Service.
 *
 * @param       connHandle - connection message was received on
 * @param       pAttr - pointer to attribute
 * @param       service - handle of owner service
 * @param       pValue - pointer to data to be read
 * @param       pLen - length of data to be read
 * @param       offset - offset of the first octet to be read
 * @param       maxLen - maximum length of data to be read
 *
 * @return      Success or Failure
 */
extern uint8 GATTServApp_ReadAttr( uint16 connHandle, gattAttribute_t *pAttr,
                                   uint16 service, uint8 *pValue, uint8 *pLen,
                                   uint16 offset, uint8 maxLen );

/**
 * @brief   Write attribute data
 *
 * @param   connHandle - connection message was received on
 * @param   handle - attribute handle
 * @param   pValue - pointer to data to be written
 * @param   len - length of data
 * @param   offset - offset of the first octet to be written
 *
 * @return  Success or Failure
 */
extern uint8 GATTServApp_WriteAttr( uint16 connHandle, uint16 handle,
                                    uint8 *pValue, uint16 len, uint16 offset );

/**
 * @}
 */

/**
 * @brief   Set a GATT Server Application Parameter value. Use this
 *          function to change the default GATT parameter values.
 *
 * @param   value - new param value
 *
 * @return  void
 */
extern void GATTServApp_SetParamValue( uint16 value );

/**
 * @brief   Get a GATT Server Application Parameter value.
 *
 * @param   none
 *
 * @return  GATT Parameter value
 */
extern uint16 GATTServApp_GetParamValue( void );

/*-------------------------------------------------------------------
 * TASK API - These functions must only be called by OSAL.
 */

/**
 * @internal
 *
 * @brief   Initialize the GATT Server Test Application.
 *
 * @param   taskId - Task identifier for the desired task
 *
 * @return  void
 *
 */
extern void GATTServApp_Init( uint8 taskId );

/**
 * @internal
 *
 * @brief   GATT Server Application Task event processor. This function
 *          is called to process all events for the task. Events include
 *          timers, messages and any other user defined events.
 *
 * @param   task_id - The OSAL assigned task ID.
 * @param   events - events to process. This is a bit map and can
 *                   contain more than one event.
 *
 * @return  none
 */
extern uint16 GATTServApp_ProcessEvent( uint8 taskId, uint16 events );


/*********************************************************************
*********************************************************************/





#line 19 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Roles\\gapbondmgr.h"
/**
  @headerfile:    gapbondmgr.h
  $Date: 2011-03-03 15:46:41 -0800 (Thu, 03 Mar 2011) $
  $Revision: 12 $

  @mainpage TI BLE GAP Bond Manager

  This GAP profile manages bonded connections between devices.<BR><BR>

  When operating as a slave, this profile will automatically respond
  to SM Pairing Requests from a connected master device.  When operating
  as a master, this profile will automatically respond to SM Slave
  Security Requests from a connected slave device.

  After pairing, if keys were exchanged and bonding was specified, this
  profile will save the device and key information of the connected device,
  so that, on future connections, the bonded devices can establish an
  encrypted link without pairing.<BR><BR>

  This GAP Bond Manager will handle all of the pairing and bonding actions
  automatically and can be controlled by setting control parameters:<BR>
     * GAPBondMgr_SetParameter()<BR>
     * GAPBondMgr_GetParameter()<BR><BR>

  Reference: @ref GAPBOND_PROFILE_PARAMETERS <BR><BR>


  Copyright 2010-2013 Texas Instruments Incorporated. All rights reserved.

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
  PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
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
*/









/*-------------------------------------------------------------------
 * INCLUDES
 */
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"
/**
  @headerfile:    gap.h
  $Date: 2013-05-01 13:58:23 -0700 (Wed, 01 May 2013) $
  $Revision: 34101 $

  @mainpage BLE GAP API

  This file contains the interface to the GAP.

  \image html HighLevelGAP.PNG

  \htmlinclude GAPDesc.html

  \image html CentralDeviceDiscoveryProcess.PNG

  A central device can scan for advertising peripheral and broadcaster devices. The Observer process
  is similar to the central process except that will not receive the SCAN_RSP data.
 <BR><BR>
  The central device will initialize the device, then ask for a device discovery.  The GAP will
  setup the link layer to scan and it will filter incoming advertisements and SCAN_RSPs
  based on the type of device discovery parameters passed in when GAP_DeviceDiscoveryRequest() was called.
  Then, when the scan is complete, it will return an array of devices that pass through its filter.
  <BR><BR>

  \image html CentralLinkEstablishmentProcess.PNG

  After the Device Discovery Process, the central device can establish a connection with a peripheral
  device by calling GAP_EstablishLinkRequest().  When the link has been established the GAP will send
  back the @ref GAP_LINK_ESTABLISHED_EVENT [GAP_LinkEstablished].
  <BR><BR>

  \image html CentralPairingProcess.PNG

  After a link is established, the central device can initiate a pairing process to either encrypt the
  link or exchange keys for bonding.
  <BR><BR><BR><BR><BR><BR>

  Copyright 2009 - 2013 Texas Instruments Incorporated. All rights reserved.

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
  PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
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
*/










/*-------------------------------------------------------------------
 * INCLUDES
 */
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\ble\\include\\sm.h"
/**
  @headerfile:    sm.h
  $Date: 2012-10-29 13:32:07 -0700 (Mon, 29 Oct 2012) $
  $Revision: 31951 $

  @mainpage BLE SM API

  This file contains the interface to the SM.


  Copyright 2009 - 2012 Texas Instruments Incorporated. All rights reserved.

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
  PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED,
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
*/









/*-------------------------------------------------------------------
 * INCLUDES
 */



/*-------------------------------------------------------------------
 * MACROS
 */

/*-------------------------------------------------------------------
 * CONSTANTS
 */
/** @defgroup SM_IO_CAP_DEFINES SM I/O Capabilities
 * @{
 */





/** @} End SM_IO_CAP_DEFINES */



/** @defgroup SM_PASSKEY_TYPE_DEFINES SM Passkey Types (Bit Masks)
 * @{
 */


/** @} End SM_PASSKEY_TYPE_DEFINES */

/** @defgroup SM_BONDING_FLAGS_DEFINES SM AuthReq Bonding Flags
 * Bonding flags 0x02 and 0x03 are reserved.
 * @{
 */


/** @} End SM_BONDING_FLAGS_DEFINES */






/*-------------------------------------------------------------------
 * General TYPEDEFS
 */

/**
 * SM_NEW_RAND_KEY_EVENT message format.  This message is sent to the
 * requesting task.
 */
typedef struct
{
  osal_event_hdr_t  hdr;      //!< SM_NEW_RAND_KEY_EVENT and status
  uint8 newKey[16];       //!< New key value - if status is SUCCESS
} smNewRandKeyEvent_t;

/**
 * Key Distribution field  - True or False fields
 */
typedef struct
{
  unsigned int sEncKey:1;    //!< Set to distribute slave encryption key
  unsigned int sIdKey:1;     //!< Set to distribute slave identity key
  unsigned int sSign:1;      //!< Set to distribute slave signing key
  unsigned int mEncKey:1;    //!< Set to distribute master encryption key
  unsigned int mIdKey:1;     //!< Set to distribute master identity key
  unsigned int mSign:1;      //!< Set to distribute master signing key
  unsigned int reserved:2;   //!< Reserved - not to be used
} keyDist_t;

/**
 * Link Security Requirements
 */
typedef struct
{
  uint8 ioCaps;               //!< I/O Capabilities (ie.
  uint8 oobAvailable;         //!< True if Out-of-band key available
  uint8 oob[16];          //!< Out-Of-Bounds key
  uint8 authReq;              //!< Authentication Requirements
  keyDist_t keyDist;          //!< Key Distribution mask
  uint8 maxEncKeySize;        //!< Maximum Encryption Key size (7-16 bytes)
} smLinkSecurityReq_t;

/**
 * Link Security Information
 */
typedef struct
{
  uint8 ltk[16];              //!< Long Term Key (LTK)
  uint16 div;                     //!< LTK Diversifier
  uint8 rand[8];  //!< LTK random number
  uint8 keySize;                  //!< LTK Key Size (7-16 bytes)
} smSecurityInfo_t;

/**
 * Link Identity Information
 */
typedef struct
{
  uint8 irk[16];          //!< Identity Resolving Key (IRK)
  uint8 bd_addr[6];  //!< The advertiser may set this to zeroes to not disclose its BD_ADDR (public address).
} smIdentityInfo_t;

/**
 * Signing Information
 */
typedef struct
{
  uint8  srk[16]; //!< Signature Resolving Key (CSRK)
  uint32 signCounter; //!< Sign Counter
} smSigningInfo_t;

/**
 * Pairing Request & Response - authReq field
 */
typedef struct
{
  unsigned int bonding:2;    //!< Bonding flags
  unsigned int mitm:1;       //!< Man-In-The-Middle (MITM)
  unsigned int reserved:5;   //!< Reserved - don't use
} authReq_t;

/*-------------------------------------------------------------------
 * GLOBAL VARIABLES
 */

/**
 * @defgroup SM_API Security Manager API Functions
 *
 * @{
 */

/*-------------------------------------------------------------------
 * FUNCTIONS - MASTER API - Only use these in a master device
 */

/**
 * @brief       Initialize SM Initiator on a master device.
 *
 * @return      SUCCESS
 */
extern bStatus_t SM_InitiatorInit( void );

/**
 * @brief       Start the pairing process.  This function is also
 *              called if the device is already bound.
 *
 * NOTE:        Only one pairing process at a time per device.
 *
 * @param       initiator - TRUE to start pairing as Initiator.
 * @param       taskID - task ID to send results.
 * @param       connectionHandle - Link's connection handle
 * @param       pSecReqs - Security parameters for pairing
 *
 * @return      SUCCESS,<BR>
 *              INVALIDPARAMETER,<BR>
 *              bleAlreadyInRequestedMode
 */
extern bStatus_t SM_StartPairing(  uint8 initiator,
                                   uint8 taskID,
                                   uint16 connectionHandle,
                                   smLinkSecurityReq_t *pSecReqs );

/**
 * @brief       Send Start Encrypt through HCI
 *
 * @param       connHandle - Connection Handle
 * @param       pLTK - pointer to 16 byte lkt
 * @param       div - div or ediv
 * @param       pRandNum - pointer to 8 byte random number
 * @param       keyLen - length of LTK (bytes)
 *
 * @return      SUCCESS,<BR>
 *              INVALIDPARAMETER,<BR>
 *              other from HCI/LL
 */
extern bStatus_t SM_StartEncryption( uint16 connHandle, uint8 *pLTK,
                                   uint16 div, uint8 *pRandNum, uint8 keyLen );


/*-------------------------------------------------------------------
 * FUNCTIONS - SLAVE API - Only use these in a slave device
 */

/**
 * @brief       Initialize SM Responder on a slave device.
 *
 * @return      SUCCESS
 */
extern bStatus_t SM_ResponderInit( void );

/*-------------------------------------------------------------------
 * FUNCTIONS - GENERAL API - both master and slave
 */

/**
 * @brief       Generate a key with a random value.
 *
 * @param       taskID - task ID to send results.
 *
 * @return      SUCCESS,<BR>
 *              bleNotReady,<BR>
 *              bleMemAllocError,<BR>
 *              FAILURE
 */
extern bStatus_t SM_NewRandKey( uint8 taskID );

/**
 * @brief       Calculate a new Private Resolvable address.
 *
 * @param       pIRK - Identity Root Key.
 * @param       pNewAddr - pointer to place to put new calc'd address
 *
 * @return      SUCCESS - if started,<BR>
 *              INVALIDPARAMETER
 */
extern bStatus_t SM_CalcRandomAddr( uint8 *pIRK, uint8 *pNewAddr );

/**
 * @brief       Resolve a Private Resolveable Address.
 *
 * @param       pIRK - pointer to the IRK
 * @param       pAddr - pointer to the random address
 *
 * @return      SUCCESS - match,<BR>
 *              FAILURE - don't match,<BR>
 *              INVALIDPARAMETER - parameters invalid
 */
extern bStatus_t SM_ResolveRandomAddrs( uint8 *pIRK, uint8 *pAddr );

/**
 * @brief       Encrypt the plain text data with the key..
 *
 * @param       pKey - key data
 * @param       pPlainText - Plain text data
 * @param       pResult - place to put the encrypted result
 *
 * @return      SUCCESS - if started,<BR>
 *              INVALIDPARAMETER - one of the parameters are NULL,<BR>
 *              bleAlreadyInRequestedMode,<BR>
 *              bleMemAllocError
 */
extern bStatus_t SM_Encrypt( uint8 *pKey, uint8 *pPlainText, uint8 *pResult );

/**
 * @brief       Generate an outgoing Authentication Signature.
 *
 * @param       pData - message data
 * @param       len - length of pData
 * @param       pAuthenSig - place to put new signature
 *
 * @return      SUCCESS - signature authentication generated,<BR>
 *              INVALIDPARAMETER - pData or pAuthenSig is NULL,<BR>
 *              bleMemAllocError
 */
extern bStatus_t SM_GenerateAuthenSig( uint8 *pData, uint8 len, uint8 *pAuthenSig );

/**
 * @brief       Verify an Authentication Signature.
 *
 * @param       connHandle - connection to verify against.
 * @param       authentication - TRUE if requires an authenticated CSRK, FALSE if not
 * @param       pData - message data
 * @param       len - length of pData
 * @param       pAuthenSig - message signature to verify
 *
 * @return      SUCCESS - signature authentication verified,<BR>
 *              FAILURE - if not verified,<BR>
 *              bleNotConnected - Connection not found,<BR>
 *              INVALIDPARAMETER - pData or pAuthenSig is NULL, or signCounter is invalid,<BR>
 *              bleMemAllocError
 */
extern bStatus_t SM_VerifyAuthenSig( uint16 connHandle,
                                      uint8 authentication,
                                      uint8 *pData,
                                      uint8 len,
                                      uint8 *pAuthenSig );

/**
 * @brief       Update the passkey for the pairing process.
 *
 * @param       pPasskey - pointer to the 6 digit passkey
 * @param       connectionHandle - connection handle to link.
 *
 * @return      SUCCESS,<BR>
 *              bleIncorrectMode - Not pairing,<BR>
 *              INVALIDPARAMETER - link is incorrect
 */
extern bStatus_t SM_PasskeyUpdate( uint8 *pPasskey, uint16 connectionHandle );

/**
 * @} End SM_API
 */

/*-------------------------------------------------------------------
 * TASK API - These functions must only be called OSAL.
 */

  /**
   * @internal
   *
   * @brief       SM Task Initialization Function.
   *
   * @param       taskID - SM task ID.
   *
   * @return      void
   */
  extern void SM_Init( uint8 task_id );

  /**
   * @internal
   *
   * @brief       SM Task event processing function.
   *
   * @param       taskID - SM task ID
   * @param       events - SM events.
   *
   * @return      events not processed
   */
  extern uint16 SM_ProcessEvent( uint8 task_id, uint16 events );

/*-------------------------------------------------------------------
-------------------------------------------------------------------*/





#line 84 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"

/*-------------------------------------------------------------------
 * MACROS
 */

/*-------------------------------------------------------------------
 * CONSTANTS
 */

/** @defgroup BLE_GAP_DEFINES BLE GAP Constants and Structures
 * @{
 */

/** @defgroup GAP_MSG_EVENT_DEFINES GAP Message IDs
 * @{
 */
#line 116 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"
/** @} End GAP_MSG_EVENT_DEFINES */

/** @defgroup GAP_CONN_HANDLE_DEFINES GAP Special Connection Handles
 * Used by GAP_TerminateLinkReq()
 * @{
 */


/** @} End GAP_CONN_HANDLE_DEFINES */

/** @defgroup GAP_PROFILE_ROLE_DEFINES GAP Profile Roles
 * Bit mask values
 * @{
 */




/** @} End GAP_PROFILE_ROLE_DEFINES */

/**
 * @defgroup GAP_PARAMETER_ID_DEFINES GAP Parameter IDs
 * Used in place of gapParamIDs_t.
 * @{
 */
// Timers
#line 148 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"

// Constants
#line 176 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"

// Proprietary






#line 197 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"

/** @} End GAP_PARAMETER_ID_DEFINES */

/** @defgroup GAP_DEVDISC_MODE_DEFINES GAP Device Discovery Modes
 * @{
 */




/** @} End GAP_DEVDISC_MODE_DEFINES */

/** @defgroup GAP_ADDR_TYPE_DEFINES GAP Address Types
 * @{
 */




/** @} End GAP_ADDR_TYPE_DEFINES */

/** @defgroup GAP_ADVERTISEMENT_TYPE_DEFINES GAP Advertiser Event Types
 * for eventType field in gapAdvertisingParams_t, gapDevRec_t and gapDeviceInfoEvent_t
 * @{
 */





/** @} End GAP_ADVERTISEMENT_TYPE_DEFINES */

/** @defgroup GAP_FILTER_POLICY_DEFINES GAP Advertiser Filter Scan Parameters
 * @{
 */




/** @} End GAP_FILTER_POLICY_DEFINES */

//! Advertiser Channel Map


//! Maximum Pairing Passcode/Passkey value.  Range of a passkey can be 0 - 999,999.


/** Sign Counter Initialized - Sign counter hasn't been used yet.  Used when setting up
 *  a connection's signing information.
 */


/** @defgroup GAP_ADVCHAN_DEFINES GAP Advertisement Channel Map
 * @{
 */




/** @} End GAP_ADVCHAN_DEFINES */

/** @defgroup GAP_WHITELIST_DEFINES GAP White List Options
 * @{
 */


/** @} End GAP_WHITELIST_DEFINES */

/** @defgroup GAP_ADTYPE_DEFINES GAP Advertisment Data Types
 * These are the data type identifiers for the data tokens in the advertisement data field.
 * @{
 */
#line 291 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"
/** @} End GAP_ADTYPE_DEFINES */

/** @defgroup GAP_ADTYPE_FLAGS_MODES GAP ADTYPE Flags Discovery Modes
 * @{
 */



/** @} End GAP_ADTYPE_FLAGS_MODES */

/** @defgroup GAP_APPEARANCE_VALUES GAP Appearance Values
 * @{
 */
#line 333 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"
/** @} End GAP_APPEARANCE_VALUES */

/*-------------------------------------------------------------------
 * TYPEDEFS - Initialization and Configuration
 */

/**
 * GAP Parameters IDs: @ref GAP_PARAMETER_ID_DEFINES
 */
typedef uint16 gapParamIDs_t;

/**
 * GAP event header format.
 */
typedef struct
{
  osal_event_hdr_t  hdr;           //!< GAP_MSG_EVENT and status
  uint8 opcode;                    //!< GAP type of command. Ref: @ref GAP_MSG_EVENT_DEFINES
} gapEventHdr_t;

/**
 * GAP_RANDOM_ADDR_CHANGED_EVENT message format.  This message is sent to the
 * app when the random address changes.
 */
typedef struct
{
  osal_event_hdr_t  hdr;              //!< GAP_MSG_EVENT and status
  uint8 opcode;                       //!< GAP_RANDOM_ADDR_CHANGED_EVENT
  uint8 addrType;                     //!< Address type: @ref GAP_ADDR_TYPE_DEFINES
  uint8 newRandomAddr[6];    //!< the new calculated private addr
} gapRandomAddrEvent_t;

/**
 * Connection parameters for the peripheral device.  These numbers are used
 * to compare against connection events and request connection parameter
 * updates with the master.
 */
typedef struct
{
  /** Minimum value for the connection event (interval. 0x0006 - 0x0C80 * 1.25 ms) */
  uint16 intervalMin;
  /** Maximum value for the connection event (interval. 0x0006 - 0x0C80 * 1.25 ms) */
  uint16 intervalMax;
  /** Number of LL latency connection events (0x0000 - 0x03e8) */
  uint16 latency;
  /** Connection Timeout (0x000A - 0x0C80 * 10 ms) */
  uint16 timeout;
} gapPeriConnectParams_t;

/**
 * GAP_DEVICE_INIT_DONE_EVENT message format.  This message is sent to the
 * app when the Device Initialization is done [initiated by calling
 * GAP_DeviceInit()].
 */
typedef struct
{
  osal_event_hdr_t  hdr;              //!< GAP_MSG_EVENT and status
  uint8 opcode;                       //!< GAP_DEVICE_INIT_DONE_EVENT
  uint8 devAddr[6];          //!< Device's BD_ADDR
  uint16 dataPktLen;                  //!< HC_LE_Data_Packet_Length
  uint8 numDataPkts;                  //!< HC_Total_Num_LE_Data_Packets
} gapDeviceInitDoneEvent_t;

/**
 * GAP_SIGNATURE_UPDATED_EVENT message format.  This message is sent to the
 * app when the signature counter has changed.  This message is to inform the
 * application in case it wants to save it to be restored on reboot or reconnect.
 * This message is sent to update a connection's signature counter and to update
 * this device's signature counter.  If devAddr == BD_ADDR, then this message pertains
 * to this device.
 */
typedef struct
{
  osal_event_hdr_t  hdr;              //!< GAP_MSG_EVENT and status
  uint8 opcode;                       //!< GAP_SIGNATURE_UPDATED_EVENT
  uint8 addrType;                     //!< Device's address type for devAddr
  uint8 devAddr[6];          //!< Device's BD_ADDR, could be own address
  uint32 signCounter;                 //!< new Signed Counter
} gapSignUpdateEvent_t;

/**
 * GAP_DEVICE_INFO_EVENT message format.  This message is sent to the
 * app during a Device Discovery Request, when a new advertisement or scan
 * response is received.
 */
typedef struct
{
  osal_event_hdr_t  hdr;    //!< GAP_MSG_EVENT and status
  uint8 opcode;             //!< GAP_DEVICE_INFO_EVENT
  uint8 eventType;          //!< Advertisement Type: @ref GAP_ADVERTISEMENT_TYPE_DEFINES
  uint8 addrType;           //!< address type: @ref GAP_ADDR_TYPE_DEFINES
  uint8 addr[6];   //!< Address of the advertisement or SCAN_RSP
  int8 rssi;                //!< Advertisement or SCAN_RSP RSSI
  uint8 dataLen;            //!< Length (in bytes) of the data field (evtData)
  uint8 *pEvtData;          //!< Data field of advertisement or SCAN_RSP
} gapDeviceInfoEvent_t;

/*-------------------------------------------------------------------
 * TYPEDEFS - Device Discovery
 */

/**
 * Type of device discovery (Scan) to perform.
 */
typedef struct
{
  uint8 taskID;       //!< Requesting App's Task ID, used to return results
  uint8 mode;         //!< Discovery Mode: @ref GAP_DEVDISC_MODE_DEFINES
  uint8 activeScan;   //!< TRUE for active scanning
  uint8 whiteList;    //!< TRUE to only allow advertisements from devices in the white list.
} gapDevDiscReq_t;

/**
 * Type of device discovery (Scan) to perform.
 */
typedef struct
{
  uint8 eventType;        //!< Indicates advertising event type used by the advertiser: @ref GAP_ADVERTISEMENT_TYPE_DEFINES
  uint8 addrType;         //!< Address Type: @ref GAP_ADDR_TYPE_DEFINES
  uint8 addr[6]; //!< Device's Address
} gapDevRec_t;

/**
 * GAP_DEVICE_DISCOVERY_EVENT message format. This message is sent to the
 * Application after a scan is performed.
 */
typedef struct
{
  osal_event_hdr_t  hdr; //!< GAP_MSG_EVENT and status
  uint8 opcode;          //!< GAP_DEVICE_DISCOVERY_EVENT
  uint8 numDevs;         //!< Number of devices found during scan
  gapDevRec_t *pDevList; //!< array of device records
} gapDevDiscEvent_t;

/**
 * Advertising Parameters
 */
typedef struct
{
  uint8 eventType;          //!< Advertise Event Type: @ref GAP_ADVERTISEMENT_TYPE_DEFINES
  uint8 initiatorAddrType;  //!< Initiator's address type: @ref GAP_ADDR_TYPE_DEFINES
  uint8 initiatorAddr[6];  //!< Initiator's addr - used only with connectable directed eventType (ADV_EVTTYPE_CONNECTABLE_DIRECTED).
  uint8 channelMap;         //!< Channel Map: Bit mask @ref GAP_ADVCHAN_DEFINES
  uint8 filterPolicy;       //!< Filer Policy: @ref GAP_FILTER_POLICY_DEFINES. Ignored when directed advertising is used.
} gapAdvertisingParams_t;

/**
 * GAP_MAKE_DISCOVERABLE_DONE_EVENT message format.  This message is sent to the
 * app when the Advertise config is complete.
 */
typedef struct
{
  osal_event_hdr_t  hdr; //!< GAP_MSG_EVENT and status
  uint8 opcode;          //!< GAP_MAKE_DISCOVERABLE_DONE_EVENT
  uint16 interval;       //!< actual advertising interval selected by controller
} gapMakeDiscoverableRspEvent_t;

/**
 * GAP_END_DISCOVERABLE_DONE_EVENT message format.  This message is sent to the
 * app when the Advertising has stopped.
 */
typedef struct
{
  osal_event_hdr_t  hdr; //!< GAP_MSG_EVENT and status
  uint8 opcode;          //!< GAP_END_DISCOVERABLE_DONE_EVENT
} gapEndDiscoverableRspEvent_t;

/**
 * GAP_ADV_DATA_UPDATE_DONE_EVENT message format.  This message is sent to the
 * app when Advertising Data Update is complete.
 */
typedef struct
{
  osal_event_hdr_t  hdr; //!< GAP_MSG_EVENT and status
  uint8 opcode;          //!< GAP_ADV_DATA_UPDATE_DONE_EVENT
  uint8 adType;          //!< TRUE if advertising data, FALSE if SCAN_RSP
} gapAdvDataUpdateEvent_t;

/*-------------------------------------------------------------------
 * TYPEDEFS - Link Establishment
 */

/**
 * Establish Link Request parameters
 */
typedef struct
{
  uint8 taskID;               //!< Requesting App/Profile's Task ID
  uint8 highDutyCycle;        //!< TRUE to high duty cycle scan, FALSE if not.
  uint8 whiteList;            //!< Determines use of the white list: @ref GAP_WHITELIST_DEFINES
  uint8 addrTypePeer;         //!< Address type of the advertiser: @ref GAP_ADDR_TYPE_DEFINES
  uint8 peerAddr[6]; //!< Advertiser's address
} gapEstLinkReq_t;

/**
 * Update Link Parameters Request parameters
 */
typedef struct
{
  uint16 connectionHandle; //!< Connection handle of the update
  uint16 intervalMin;      //!< Minimum Connection Interval
  uint16 intervalMax;      //!< Maximum Connection Interval
  uint16 connLatency;      //!< Connection Latency
  uint16 connTimeout;      //!< Connection Timeout
} gapUpdateLinkParamReq_t;

/**
 * GAP_LINK_ESTABLISHED_EVENT message format.  This message is sent to the app
 * when the link request is complete.<BR>
 * <BR>
 * For an Observer, this message is sent to complete the Establish Link Request.<BR>
 * For a Peripheral, this message is sent to indicate that a link has been created.
 */
typedef struct
{
  osal_event_hdr_t  hdr;     //!< GAP_MSG_EVENT and status
  uint8 opcode;              //!< GAP_LINK_ESTABLISHED_EVENT
  uint8 devAddrType;         //!< Device address type: @ref GAP_ADDR_TYPE_DEFINES
  uint8 devAddr[6]; //!< Device address of link
  uint16 connectionHandle;   //!< Connection Handle from controller used to ref the device
  uint16 connInterval;       //!< Connection Interval
  uint16 connLatency;        //!< Conenction Latency
  uint16 connTimeout;        //!< Connection Timeout
  uint8 clockAccuracy;       //!< Clock Accuracy
} gapEstLinkReqEvent_t;

/**
 * GAP_LINK_PARAM_UPDATE_EVENT message format.  This message is sent to the app
 * when the connection parameters update request is complete.
 */
typedef struct
{
  osal_event_hdr_t hdr;     //!< GAP_MSG_EVENT and status
  uint8 opcode;             //!< GAP_LINK_PARAM_UPDATE_EVENT
  uint8 status;             //!< bStatus_t
  uint16 connectionHandle;  //!< Connection handle of the update
  uint16 connInterval;      //!< Requested connection interval
  uint16 connLatency;       //!< Requested connection latency
  uint16 connTimeout;       //!< Requested connection timeout
} gapLinkUpdateEvent_t;

/**
 * GAP_LINK_TERMINATED_EVENT message format.  This message is sent to the
 * app when a link to a device is terminated.
 */
typedef struct
{
  osal_event_hdr_t  hdr;   //!< GAP_MSG_EVENT and status
  uint8 opcode;            //!< GAP_LINK_TERMINATED_EVENT
  uint16 connectionHandle; //!< connection Handle
  uint8 reason;            //!< termination reason from LL
} gapTerminateLinkEvent_t;

/*-------------------------------------------------------------------
 * TYPEDEFS - Authentication, Bounding and Pairing
 */

/**
 * GAP_PASSKEY_NEEDED_EVENT message format.  This message is sent to the
 * app when a Passkey is needed from the app's user interface.
 */
typedef struct
{
  osal_event_hdr_t  hdr;        //!< GAP_MSG_EVENT and status
  uint8 opcode;                 //!< GAP_PASSKEY_NEEDED_EVENT
  uint8 deviceAddr[6]; //!< address of device to pair with, and could be either public or random.
  uint16 connectionHandle;      //!< Connection handle
  uint8 uiInputs;               //!< Pairing User Interface Inputs - Ask user to input passcode
  uint8 uiOutputs;              //!< Pairing User Interface Outputs - Display passcode
} gapPasskeyNeededEvent_t;

/**
 * GAP_AUTHENTICATION_COMPLETE_EVENT message format.  This message is sent to the app
 * when the authentication request is complete.
 */
typedef struct
{
  osal_event_hdr_t  hdr;           //!< GAP_MSG_EVENT and status
  uint8 opcode;                    //!< GAP_AUTHENTICATION_COMPLETE_EVENT
  uint16 connectionHandle;         //!< Connection Handle from controller used to ref the device
  uint8 authState;                 //!< TRUE if the pairing was authenticated (MITM)
  smSecurityInfo_t *pSecurityInfo; //!< BOUND - security information from this device
  smIdentityInfo_t *pIdentityInfo; //!< BOUND - identity information
  smSigningInfo_t *pSigningInfo;   //!< Signing information
  smSecurityInfo_t *pDevSecInfo;   //!< BOUND - security information from connected device
} gapAuthCompleteEvent_t;

/**
 * securityInfo and identityInfo are only used if secReqs.bondable == BOUND, which means that
 * the device is already bound and we should use the security information and keys.
 */
typedef struct
{
  uint16 connectionHandle;      //!< Connection Handle from controller,
  smLinkSecurityReq_t  secReqs; //!< Pairing Control info
} gapAuthParams_t;

/**
 * GAP_SLAVE_REQUESTED_SECURITY_EVENT message format.  This message is sent to the app
 * when a Slave Security Request is received.
 */
typedef struct
{
  osal_event_hdr_t  hdr;        //!< GAP_MSG_EVENT and status
  uint8 opcode;                 //!< GAP_SLAVE_REQUESTED_SECURITY_EVENT
  uint16 connectionHandle;      //!< Connection Handle
  uint8 deviceAddr[6]; //!< address of device requesting security
  uint8 authReq;                //!< Authentication Requirements: Bit 2: MITM, Bits 0-1: bonding (0 - no bonding, 1 - bonding)

} gapSlaveSecurityReqEvent_t;

/**
 * GAP_BOND_COMPLETE_EVENT message format.  This message is sent to the
 * app when a bonding is complete.  This means that a key is loaded and the link is encrypted.
 */
typedef struct
{
  osal_event_hdr_t  hdr;   //!< GAP_MSG_EVENT and status
  uint8 opcode;            //!< GAP_BOND_COMPLETE_EVENT
  uint16 connectionHandle; //!< connection Handle
} gapBondCompleteEvent_t;

/**
 * Pairing Request fields - the parsed fields of the SMP Pairing Request command.
 */
typedef struct
{
  uint8 ioCap;         //!< Pairing Request ioCap field
  uint8 oobDataFlag;   //!< Pairing Request OOB Data Flag field
  uint8 authReq;       //!< Pairing Request Auth Req field
  uint8 maxEncKeySize; //!< Pairing Request Maximum Encryption Key Size field
  keyDist_t keyDist;   //!< Pairing Request Key Distribution field
} gapPairingReq_t;

/**
 * GAP_PAIRING_REQ_EVENT message format.<BR>
 * <BR>
 * This message is sent to the
 * app when an unexpected Pairing Request is received.  The application is
 * expected to setup for a Security Manager pairing/bonding.<BR>
 * <BR>
 * To setup an SM Pairing, the application should call GAP_Authenticate() with these "pairReq" fields.<BR>
 * <BR>
* NOTE: This message should only be sent to peripheral devices.
 */
typedef struct
{
  osal_event_hdr_t hdr;    //!< GAP_MSG_EVENT and status
  uint8 opcode;            //!< GAP_PAIRING_REQ_EVENT
  uint16 connectionHandle; //!< connection Handle
  gapPairingReq_t pairReq; //!< The Pairing Request fields received.
} gapPairingReqEvent_t;

/**
 * GAP Advertisement/Scan Response Data Token - These data items are stored as low byte first (OTA
 * format).  The data space for these items are passed in and maintained by
 * the calling application
 */
typedef struct
{
  uint8 adType;     //!< ADTYPE value: @ref GAP_ADTYPE_DEFINES
  uint8 attrLen;    //!< Number of bytes in the attribute data
  uint8 *pAttrData; //!< pointer to Attribute data
} gapAdvDataToken_t;

/** @} End BLE_GAP_DEFINES */

/*-------------------------------------------------------------------
 * GLOBAL VARIABLES
 */

/**
 * @defgroup GAP_API GAP API Functions
 *
 * @{
 */

/*-------------------------------------------------------------------
 * FUNCTIONS - Initialization and Configuation
 */

  /**
   * @brief       Called to setup the device.  Call just once on initialization.
   *
   *   NOTE: When initialization is complete, the calling app will be
   *         sent the GAP_DEVICE_INIT_DONE_EVENT
   *
   * @param       taskID - Default task ID to send events.
   * @param       profileRole - GAP Profile Roles: @ref GAP_PROFILE_ROLE_DEFINES
   * @param       maxScanResponses - maximum number to scan responses
   *                we can receive during a device discovery.
   * @param       pIRK - pointer to Identity Root Key, NULLKEY (all zeroes) if the app
   *                wants the GAP to generate the key.
   * @param       pSRK - pointer to Sign Resolving Key, NULLKEY if the app
   *                wants the GAP to generate the key.
   * @param       pSignCounter - 32 bit value used in the SM Signing
   *                algorithm that shall be initialized to zero and incremented
   *                with every new signing. This variable must also be maintained
   *                by the application.
   *
   * @return      SUCCESS - Processing, expect GAP_DEVICE_INIT_DONE_EVENT, <BR>
   *              INVALIDPARAMETER - for invalid profile role or role combination, <BR>
   *              bleIncorrectMode - trouble communicating with HCI
   */
  extern bStatus_t GAP_DeviceInit(  uint8 taskID,
                           uint8 profileRole,
                           uint8 maxScanResponses,
                           uint8 *pIRK,
                           uint8 *pSRK,
                           uint32 *pSignCounter );

  /**
   * @brief       Called to setup a GAP Advertisement/Scan Response data token.
   *
   * NOTE:        The data in these items are stored as low byte first (OTA format).
   *              The passed in structure "token" should be allocated by the calling app/profile
   *              and not released until after calling GAP_RemoveAdvToken().
   *
   * @param       pToken - Advertisement/Scan response token to write.
   *
   * @return      SUCCESS - advertisement token added to the GAP list <BR>
   *              INVALIDPARAMETER - Invalid Advertisement Type or pAttrData is NULL <BR>
   *              INVALID_MEM_SIZE - The tokens take up too much space and don't fit into Advertisment data and Scan Response Data<BR>
   *              bleInvalidRange - token ID already exists.<BR>
   *              bleIncorrectMode - not a peripheral device<BR>
   *              bleMemAllocError - memory allocation failure,
   */
  extern bStatus_t GAP_SetAdvToken( gapAdvDataToken_t *pToken );

  /**
   * @brief       Called to read a GAP Advertisement/Scan Response data token.
   *
   * @param       adType - Advertisement type to get
   *
   * @return      pointer to the advertisement data token structure, NULL if not found.
   */
  extern gapAdvDataToken_t *GAP_GetAdvToken( uint8 adType );

  /**
   * @brief       Called to remove a GAP Advertisement/Scan Response data token.
   *
   * @param       adType - Advertisement type to remove
   *
   * @return      pointer to the token structure removed from the GAP ADType list
   *              NULL if the requested adType wasn't found.
   */
  extern gapAdvDataToken_t *GAP_RemoveAdvToken( uint8 adType );

  /**
   * @brief       Called to rebuild and load Advertisement and Scan Response data from existing
   *              GAP Advertisement Tokens.
   *
   * @return      SUCCESS or bleIncorrectMode
   */
  extern bStatus_t GAP_UpdateAdvTokens( void );

 /**
   * @brief       Set a GAP Parameter value.  Use this function to change
   *              the default GAP parameter values.
   *
   * @param       paramID - parameter ID: @ref GAP_PARAMETER_ID_DEFINES
   * @param       paramValue - new param value
   *
   * @return      SUCCESS or INVALIDPARAMETER (invalid paramID)
   */
  extern bStatus_t GAP_SetParamValue( gapParamIDs_t paramID, uint16 paramValue );

  /**
   * @brief       Get a GAP Parameter value.
   *
   * @param       paramID - parameter ID: @ref GAP_PARAMETER_ID_DEFINES
   *
   * @return      GAP Parameter value or 0xFFFF if invalid
   */
  extern uint16 GAP_GetParamValue( gapParamIDs_t paramID );

  /**
   * @brief       Setup the device's address type.  If ADDRTYPE_PRIVATE_RESOLVE
   *              is selected, the address will change periodically.
   *
   * @param       addrType - @ref GAP_ADDR_TYPE_DEFINES
   * @param       pStaticAddr - Only used with ADDRTYPE_STATIC
   *                       or ADDRTYPE_PRIVATE_NONRESOLVE type.<BR>
   *                   NULL to auto generate otherwise the application
   *                   can specify the address value
   *
   * @return      SUCCESS: address type updated,<BR>
   *              bleNotReady: Can't be called until GAP_DeviceInit() is called
   *                   and the init process is completed,<BR>
   *              bleIncorrectMode: can't change with an active connection,<BR>
   *               or INVALIDPARAMETER.<BR>
   *
   *              If return value isn't SUCCESS, the address type remains
   *              the same as before this call.
   */
  extern bStatus_t GAP_ConfigDeviceAddr( uint8 addrType, uint8 *pStaticAddr );

  /**
   * @brief       Register your task ID to receive extra (unwanted)
   *              HCI status and complete events.
   *
   * @param       taskID - Default task ID to send events.
   *
   * @return      none
   */
  extern void GAP_RegisterForHCIMsgs( uint8 taskID );

/*-------------------------------------------------------------------
 * FUNCTIONS - Device Discovery
 */

  /**
   * @brief       Start a device discovery scan.
   *
   * @param       pParams - Device Discovery parameters
   *
   * @return      SUCCESS: scan started,<BR>
   *              bleIncorrectMode: invalid profile role,<BR>
   *              bleAlreadyInRequestedMode: not available<BR>
   */
  extern bStatus_t GAP_DeviceDiscoveryRequest( gapDevDiscReq_t *pParams );

  /**
   * @brief       Cancel an existing device discovery request.
   *
   * @param       taskID - used to return GAP_DEVICE_DISCOVERY_EVENT
   *
   * @return      SUCCESS: cancel started,<BR>
   *              bleInvalidTaskID: Not the task that started discovery,<BR>
   *              bleIncorrectMode: not in discovery mode<BR>
   */
  extern bStatus_t GAP_DeviceDiscoveryCancel( uint8 taskID );

  /**
   * @brief       Setup or change advertising.  Also starts advertising.
   *
   * @param       taskID - used to return GAP_DISCOVERABLE_RESPONSE_EVENT
   * @param       pParams - advertising parameters
   *
   * @return      SUCCESS: advertising started,<BR>
   *              bleIncorrectMode: invalid profile role,<BR>
   *              bleAlreadyInRequestedMode: not available at this time,<BR>
   *              bleNotReady: advertising data isn't set up yet.<BR>
   */
  extern bStatus_t GAP_MakeDiscoverable( uint8 taskID, gapAdvertisingParams_t *pParams );

  /**
   * @brief       Setup or change advertising and scan response data.
   *
   *    NOTE:  if the return status from this function is SUCCESS,
   *           the task isn't complete until the GAP_ADV_DATA_UPDATE_DONE_EVENT
   *           is sent to the calling application task.
   *
   * @param       taskID - task ID of the app requesting the change
   * @param       adType - TRUE - advertisement data, FALSE  - scan response data
   * @param       dataLen - Octet length of advertData
   * @param       pAdvertData - advertising or scan response data
   *
   * @return      SUCCESS: data accepted,<BR>
   *              bleIncorrectMode: invalid profile role,<BR>
   */
  extern bStatus_t GAP_UpdateAdvertisingData( uint8 taskID, uint8 adType,
                                      uint8 dataLen, uint8 *pAdvertData );

  /**
   * @brief       Stops advertising.
   *
   * @param       taskID - of task that called GAP_MakeDiscoverable
   *
   * @return      SUCCESS: stopping discoverable mode,<BR>
   *              bleIncorrectMode: not in discoverable mode,<BR>
   *              bleInvalidTaskID: not correct task<BR>
   */
  extern bStatus_t GAP_EndDiscoverable( uint8 taskID );

  /**
   * @brief       Resolves a private address against an IRK.
   *
   * @param       pIRK - pointer to the IRK
   * @param       pAddr - pointer to the Resovable Private address
   *
   * @return      SUCCESS: match,<BR>
   *              FAILURE: don't match,<BR>
   *              INVALIDPARAMETER: parameters invalid<BR>
   */
  extern bStatus_t GAP_ResolvePrivateAddr( uint8 *pIRK, uint8 *pAddr );

/*-------------------------------------------------------------------
 * FUNCTIONS - Link Establishment
 */

  /**
   * @brief       Establish a link to a slave device.
   *
   * @param       pParams - link establishment parameters
   *
   * @return      SUCCESS: started establish link process,<BR>
   *              bleIncorrectMode: invalid profile role,<BR>
   *              bleNotReady: a scan is in progress,<BR>
   *              bleAlreadyInRequestedMode: can’t process now,<BR>
   *              bleNoResources: Too many links<BR>
   */
  extern bStatus_t GAP_EstablishLinkReq( gapEstLinkReq_t *pParams );

  /**
   * @brief       Terminate a link connection.
   *
   * @param       taskID - requesting app's task id.
   * @param       connectionHandle - connection handle of link to terminate
   *                  or @ref GAP_CONN_HANDLE_DEFINES
   *
   * @return      SUCCESS: Terminate started,<BR>
   *              bleIncorrectMode: No Link to terminate,<BR>
   *              bleInvalidTaskID: not app that established link<BR>
   */
  extern bStatus_t GAP_TerminateLinkReq( uint8 taskID, uint16 connectionHandle );

  /**
   * @brief       Update the link parameters to a slave device.
   *
   * @param       pParams - link update parameters
   *
   * @return      SUCCESS: started update link process,<BR
   *              INVALIDPARAMETER: one of the parameters were invalid,<BR>
   *              bleIncorrectMode: invalid profile role,<BR>
   *              bleNotConnected: not in a connection<BR>
   */
  extern bStatus_t GAP_UpdateLinkParamReq( gapUpdateLinkParamReq_t *pParams );

  /**
   * @brief       Returns the number of active connections.
   *
   * @return      Number of active connections.
   */
  extern uint8 GAP_NumActiveConnections( void );

/*-------------------------------------------------------------------
 * FUNCTIONS - Pairing
 */

  /**
   * @brief       Start the Authentication process with the requested device.
   *              This function is used to Initiate/Allow pairing.
   *              Called by both master and slave device (Central and Peripheral).
   *
   * NOTE:        This function is called after the link is established.
   *
   * @param       pParams - Authentication parameters
   * @param       pPairReq - Enter these parameters if the Pairing Request was already received.
   *              NULL, if waiting for Pairing Request or if initiating.
   *
   * @return      SUCCESS,<BR>
   *              bleIncorrectMode: Not correct profile role,<BR>
   *              INVALIDPARAMETER, <BR>
   *              bleNotConnected,<BR>
   *              bleAlreadyInRequestedMode,<BR>
   *              FAILURE - not workable.<BR>
   */
  extern bStatus_t GAP_Authenticate( gapAuthParams_t *pParams, gapPairingReq_t *pPairReq );

  /**
   * @brief       Send a Pairing Failed message and end any existing pairing.
   *
   * @param       connectionHandle - connection handle.
   * @param       reason - Pairing Failed reason code.
   *
   * @return      SUCCESS - function was successful,<BR>
   *              bleMemAllocError - memory allocation error,<BR>
   *              INVALIDPARAMETER - one of the parameters were invalid,<BR>
   *              bleNotConnected - link not found,<BR>
   *              bleInvalidRange - one of the parameters were not within range.
   */
  extern bStatus_t GAP_TerminateAuth( uint16 connectionHandle, uint8 reason );

  /**
   * @brief       Update the passkey in string format.  This function is called by the
   *              application/profile in response to receiving the
   *              GAP_PASSKEY_NEEDED_EVENT message.
   *
   * NOTE:        This function is the same as GAP_PasscodeUpdate(), except that
   *              the passkey is passed in as a string format.
   *
   * @param       pPasskey - new passkey - pointer to numeric string (ie. "019655" ).
   *              This string's range is "000000" to "999999".
   * @param       connectionHandle - connection handle.
   *
   * @return      SUCCESS: will start pairing with this entry,<BR>
   *              bleIncorrectMode: Link not found,<BR>
   *              INVALIDPARAMETER: passkey == NULL or passkey isn't formatted properly.<BR>
   */
  extern bStatus_t GAP_PasskeyUpdate( uint8 *pPasskey, uint16 connectionHandle );

  /**
   * @brief       Update the passkey in a numeric value (not string).
   *              This function is called by the application/profile in response
   *              to receiving the GAP_PASSKEY_NEEDED_EVENT message.
   *
   * NOTE:        This function is the same as GAP_PasskeyUpdate(), except that
   *              the passkey is passed in as a non-string format.
   *
   * @param       passcode - not string - range: 0 - 999,999.
   * @param       connectionHandle - connection handle.
   *
   * @return      SUCCESS: will start pairing with this entry,<BR>
   *              bleIncorrectMode: Link not found,<BR>
   *              INVALIDPARAMETER: passkey == NULL or passkey isn't formatted properly.<BR>
   */
  extern bStatus_t GAP_PasscodeUpdate( uint32 passcode, uint16 connectionHandle );

  /**
   * @brief       Generate a Slave Requested Security message to the master.
   *
   * @param       connectionHandle - connection handle.
   * @param       authReq - Authentication Requirements: Bit 2: MITM, Bits 0-1: bonding (0 - no bonding, 1 - bonding)
   *
   * @return      SUCCESS: will send,<BR>
   *              bleNotConnected: Link not found,<BR>
   *              bleIncorrectMode: wrong GAP role, must be a Peripheral Role<BR>
   */
  extern bStatus_t GAP_SendSlaveSecurityRequest( uint16 connectionHandle, uint8 authReq );

  /**
   * @brief       Set up the connection to accept signed data.
   *
   * NOTE:        This function is called after the link is established.
   *
   * @param       connectionHandle - connection handle of the signing information
   * @param       authenticated - TRUE if the signing information is authenticated, FALSE otherwise
   * @param       pParams - signing parameters
   *
   * @return      SUCCESS, <BR>
   *              bleIncorrectMode: Not correct profile role,<BR>
   *              INVALIDPARAMETER, <BR>
   *              bleNotConnected,<BR>
   *              FAILURE: not workable.<BR>
   */
  extern bStatus_t GAP_Signable( uint16 connectionHandle, uint8 authenticated, smSigningInfo_t *pParams );

  /**
   * @brief       Set up the connection's bound paramaters.
   *
   * NOTE:        This function is called after the link is established.
   *
   * @param       connectionHandle - connection handle of the signing information
   * @param       authenticated - this connection was previously authenticated
   * @param       pParams - the connected device's security parameters
   * @param       startEncryption - whether or not to start encryption
   *
   * @return      SUCCESS, <BR>
   *              bleIncorrectMode: Not correct profile role,<BR>
   *              INVALIDPARAMETER, <BR>
   *              bleNotConnected,<BR>
   *              FAILURE: not workable.<BR>
   */
  extern bStatus_t GAP_Bond( uint16 connectionHandle, uint8 authenticated,
                             smSecurityInfo_t *pParams, uint8 startEncryption );

/**
 * @} End GAP_API
 */

/*-------------------------------------------------------------------
 * Internal API - These functions are only called from gap.c module.
 */

  /**
   * @internal
   *
   * @brief       Setup the device configuration parameters.
   *
   * @param       taskID - Default task ID to send events.
   * @param       profileRole - GAP Profile Roles
   *
   * @return      SUCCESS or bleIncorrectMode
   */
  extern bStatus_t GAP_ParamsInit( uint8 taskID, uint8 profileRole );

  /**
   * @internal
   *
   * @brief       Setup the device security configuration parameters.
   *
   * @param       pIRK - pointer to Identity Root Key, NULLKEY (all zeroes) if the app
   *                wants the GAP to generate the key.
   * @param       pSRK - pointer to Sign Resolving Key, NULLKEY if the app
   *                wants the GAP to generate the key.
   * @param       pSignCounter - 32 bit value used in the SM Signing
   *                algorithm that shall be initialized to zero and incremented
   *                with every new signing. This variable must also be maintained
   *                by the application.
   *
   * @return      none
   */
  extern void GAP_SecParamsInit( uint8 *pIRK, uint8 *pSRK, uint32 *pSignCounter );

  /**
   * @internal
   *
   * @brief       Initialize the GAP Peripheral Dev Manager.
   *
   * @param       none
   *
   * @return      SUCCESS or bleMemAllocError
   */
  extern bStatus_t GAP_PeriDevMgrInit( void );

  /**
   * @internal
   *
   * @brief       Initialize the GAP Central Dev Manager.
   *
   * @param       maxScanResponses - maximum number to scan responses
   *                we can receive during a device discovery.
   *
   * @return      SUCCESS or bleMemAllocError
   */
  extern bStatus_t GAP_CentDevMgrInit( uint8 maxScanResponses );

  /**
   * @internal
   *
   * @brief       Register the GAP Central Connection processing functions.
   *
   * @param       none
   *
   * @return      none
   */
  extern void GAP_CentConnRegister( void );


/*-------------------------------------------------------------------
 * TASK API - These functions must only be called OSAL.
 */

  /**
   * @internal
   *
   * @brief       GAP Task initialization function.
   *
   * @param       taskID - GAP task ID.
   *
   * @return      void
   */
  extern void GAP_Init( uint8 task_id );

  /**
   * @internal
   *
   * @brief       GAP Task event processing function.
   *
   * @param       taskID - GAP task ID
   * @param       events - GAP events.
   *
   * @return      events not processed
   */
  extern uint16 GAP_ProcessEvent( uint8 task_id, uint16 events );


/*-------------------------------------------------------------------
-------------------------------------------------------------------*/





#line 71 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Roles\\gapbondmgr.h"

/*-------------------------------------------------------------------
 * CONSTANTS
 */








/** @defgroup GAPBOND_CONSTANTS_NAME GAP Bond Manager Constants
 * @{
 */

/** @} End GAPBOND_CONSTANTS_NAME */

/** @defgroup GAPBOND_PROFILE_PARAMETERS GAP Bond Manager Parameters
 * @{
 */
#line 108 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Roles\\gapbondmgr.h"
/** @} End GAPBOND_PROFILE_PARAMETERS */

/** @defgroup GAPBOND_PAIRING_MODE_DEFINES GAP Bond Manager Pairing Modes
 * @{
 */



/** @} End GAPBOND_PAIRING_MODE_DEFINES */

/** @defgroup GAPBOND_IO_CAP_DEFINES GAP Bond Manager I/O Capabilities
 * @{
 */





/** @} End GAPBOND_IO_CAP_DEFINES */

/** @defgroup GAPBOND_KEY_DIST_DEFINES GAP Bond Manager Key Distribution
 * @{
 */
#line 137 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Roles\\gapbondmgr.h"
/** @} End GAPBOND_IO_CAP_DEFINES */


/** @defgroup GAPBOND_PAIRING_STATE_DEFINES GAP Bond Manager Pairing States
 * @{
 */



/** @} End GAPBOND_PAIRING_STATE_DEFINES */

/** @defgroup SMP_PAIRING_FAILED_DEFINES Pairing failure status values
 * @{
 */
#line 160 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Roles\\gapbondmgr.h"
/** @} End SMP_PAIRING_FAILED_DEFINES */

/** @defgroup GAPBOND_BONDING_FAILURE_DEFINES Bonding Failure Actions
 * @{
 */




/** @} End GAPBOND_BONDING_FAILURE_DEFINES */

/*-------------------------------------------------------------------
 * TYPEDEFS
 */


/**
 * Passcode Callback Function
 */
typedef void (*pfnPasscodeCB_t)
(
  uint8  *deviceAddr,                   //!< address of device to pair with, and could be either public or random.
  uint16 connectionHandle,              //!< Connection handle
  uint8  uiInputs,                      //!< Pairing User Interface Inputs - Ask user to input passcode
  uint8  uiOutputs                      //!< Pairing User Interface Outputs - Display passcode
 );

/**
 * Pairing State Callback Function
 */
typedef void (*pfnPairStateCB_t)
(
  uint16 connectionHandle,              //!< Connection handle
  uint8  state,                         //!< Pairing state @ref GAPBOND_PAIRING_STATE_DEFINES
  uint8  status                         //!< Pairing status
);

/**
 * Callback Registration Structure
 */
typedef struct
{
  pfnPasscodeCB_t     passcodeCB;       //!< Passcode callback
  pfnPairStateCB_t    pairStateCB;      //!< Pairing state callback
} gapBondCBs_t;

/*-------------------------------------------------------------------
 * MACROS
 */

/*-------------------------------------------------------------------
 * API FUNCTIONS
 */

/**
 * @defgroup GAPROLES_BONDMGR_API GAP Bond Manager API Functions
 *
 * @{
 */

/**
 * @brief       Set a GAP Bond Manager parameter.
 *
 *  NOTE: You can call this function with a GAP Parameter ID and it will set the
 *        GAP Parameter.  GAP Parameters are defined in (gap.h).  Also,
 *        the "len" field must be set to the size of a "uint16" and the
 *        "pValue" field must point to a "uint16".
 *
 * @param       param - Profile parameter ID: @ref GAPBOND_PROFILE_PARAMETERS
 * @param       len - length of data to write
 * @param       pValue - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return      SUCCESS or INVALIDPARAMETER (invalid paramID)
 */
extern bStatus_t GAPBondMgr_SetParameter( uint16 param, uint8 len, void *pValue );

/**
 * @brief       Get a GAP Bond Manager parameter.
 *
 *  NOTE: You can call this function with a GAP Parameter ID and it will get a
 *        GAP Parameter.  GAP Parameters are defined in (gap.h).  Also, the
 *        "pValue" field must point to a "uint16".
 *
 * @param       param - Profile parameter ID: @ref GAPBOND_PROFILE_PARAMETERS
 * @param       pValue - pointer to location to get the value.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return      SUCCESS or INVALIDPARAMETER (invalid paramID)
 */
extern bStatus_t GAPBondMgr_GetParameter( uint16 param, void *pValue );

/**
 * @brief       Notify the Bond Manager that a connection has been made.
 *
 *   NOTE:      The GAP Peripheral/Central Role profile will
 *              call this function, if they are included in the project.
 *
 * @param       addrType - device's address type. Reference GAP_ADDR_TYPE_DEFINES in gap.h
 * @param       pDevAddr - device's address
 * @param       connHandle - connection handle
 * @param       role - master or slave role.  Reference GAP_PROFILE_ROLE_DEFINES in gap.h
 *
 * @return      SUCCESS, otherwise failure
 */
extern bStatus_t GAPBondMgr_LinkEst( uint8 addrType, uint8 *pDevAddr, uint16 connHandle, uint8 role );

/**
 * @brief       Resolve an address from bonding information.
 *
 * @param       addrType - device's address type. Reference GAP_ADDR_TYPE_DEFINES in gap.h
 * @param       pDevAddr - device's address
 * @param       pResolvedAddr - pointer to buffer to put the resolved address
 *
 * @return      bonding index (0 - (GAP_BONDINGS_MAX-1) if found,
 *              GAP_BONDINGS_MAX if not found
 */
extern uint8 GAPBondMgr_ResolveAddr( uint8 addrType, uint8 *pDevAddr, uint8 *pResolvedAddr );

/**
 * @brief       Set/clear the service change indication in a bond record.
 *
 * @param       connectionHandle - connection handle of the connected device or 0xFFFF
 *                                 if all devices in database.
 * @param       setParam - TRUE to set the service change indication, FALSE to clear it.
 *
 * @return      SUCCESS - bond record found and changed,<BR>
 *              bleNoResources - bond record not found (for 0xFFFF connectionHandle),<BR>
 *              bleNotConnected - connection not found - connectionHandle is invalid (for non-0xFFFF connectionHandle).
 */
extern bStatus_t GAPBondMgr_ServiceChangeInd( uint16 connectionHandle, uint8 setParam );

/**
 * @brief       Update the Characteristic Configuration in a bond record.
 *
 * @param       connectionHandle - connection handle of the connected device or 0xFFFF
 *                                 if all devices in database.
 * @param       attrHandle - attribute handle.
 * @param       value - characteristic configuration value.
 *
 * @return      SUCCESS - bond record found and changed,<BR>
 *              bleNoResources - bond record not found (for 0xFFFF connectionHandle),<BR>
 *              bleNotConnected - connection not found - connectionHandle is invalid (for non-0xFFFF connectionHandle).
 */
extern bStatus_t GAPBondMgr_UpdateCharCfg( uint16 connectionHandle, uint16 attrHandle, uint16 value );

/**
 * @brief       Register callback functions with the bond manager.
 *
 *   NOTE:      There is no need to register a passcode callback function
 *              if the passcode will be handled with the GAPBOND_DEFAULT_PASSCODE parameter.
 *
 * @param       pCB - pointer to callback function structure.
 *
 * @return      none
 */
extern void GAPBondMgr_Register( gapBondCBs_t *pCB );

/**
 * @brief       Respond to a passcode request.
 *
 * @param       connectionHandle - connection handle of the connected device or 0xFFFF
 *                                 if all devices in database.
 * @param       status - SUCCESS if passcode is available, otherwise see @ref SMP_PAIRING_FAILED_DEFINES.
 * @param       passcode - integer value containing the passcode.
 *
 * @return      SUCCESS - bond record found and changed,<BR>
 *              bleIncorrectMode - Link not found.
 */
extern bStatus_t GAPBondMgr_PasscodeRsp( uint16 connectionHandle, uint8 status, uint32 passcode );

/**
 * @brief       This is a bypass mechanism to allow the bond manager to process
 *              GAP messages.
 *
 *   NOTE:      This is an advanced feature and shouldn't be called unless
 *              the normal GAP Bond Manager task ID registration is overridden.
 *
 * @param       pMsg - GAP event message
 *
 * @return      none
 */
extern void GAPBondMgr_ProcessGAPMsg( gapEventHdr_t *pMsg );

/**
 * @brief       This function will check the length of a Bond Manager NV Item.
 *
 * @param       id - NV ID.
 * @param       len - lengths in bytes of item.
 *
 * @return      SUCCESS or FAILURE
 */
extern uint8 GAPBondMgr_CheckNVLen( uint8 id, uint8 len );

/**
 * @} End GAPROLES_BONDMGR_API
 */



/*-------------------------------------------------------------------
 * TASK FUNCTIONS - Don't call these. These are system functions.
 */

/**
 * @internal
 *
 * @brief       Initialization function for the GAP Bond Manager Task.
 *          This is called during initialization and should contain
 *          any application specific initialization (ie. hardware
 *          initialization/setup, table initialization, power up
 *          notificaiton ... ).
 *
 * @param       the ID assigned by OSAL.  This ID should be
 *                    used to send messages and set timers.
 *
 * @return      void
 */
extern void GAPBondMgr_Init( uint8 task_id );

/**
 * @internal
 *
 * @brief       GAP Bond Manager Task event processor.
 *          This function is called to process all events for the task.
 *          Events include timers, messages and any other user defined
 *          events.
 *
 * @param   task_id  - The OSAL assigned task ID.
 * @param   events - events to process.  This is a bit map and can
 *                   contain more than one event.
 *
 * @return      events not processed
 */
extern uint16 GAPBondMgr_ProcessEvent( uint8 task_id, uint16 events );

/*-------------------------------------------------------------------
-------------------------------------------------------------------*/





#line 20 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.h"
/**************************************************************************************************
  Filename:       gpsprofile.h
  Creation:       Date: 2015-07-23

  Description:    Gps profile (based on simpleGATT Profile)

**************************************************************************************************/









/*********************************************************************
 * INCLUDES
 */

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\util\\WIMU\\wimu_util.h"








// WIMU sensor data packet size

  

  

  

  

  

  

  

   
//#define RAND_SINGED_SHORT osal_rand()-32768
  
//#define RAND_UNSINGED_SHORT osal_rand()

// Unsigned sensor values
typedef struct {
  uint16 x;
  uint16 y;
  uint16 z;
} WIMU_uSensors_t;

// Signed sensor values
typedef struct {
  int16 x;
  int16 y;
  int16 z;
} WIMU_sensors_t;

// WIMU actimetry imu data packet 
typedef struct {
  uint16 seq;
  WIMU_sensors_t acc;
  WIMU_sensors_t gyr;
  WIMU_sensors_t mag;
} WIMU_actimetry_imu_packet_t;

// WIMU actimetry quaternion data packet 
typedef struct {
  float q0;
  float q1;
  float q2;
  float q3;
} WIMU_actimetry_quaternion_packet_t;

// WIMU battery sensor data packet 
typedef struct {
  uint8 batteryValue;
} WIMU_battery_packet_t;

// WIMU device information
typedef struct
{
  uint16  serialNumber;
  uint8	  hardRevision;
  uint8	  firmSoftRevision[29]; //should always be 29 in length (without \r\n)
} WIMU_DevInfoFrame_t;

// WIMU gps sensor data packet
typedef struct
{
  uint16          year;
  uint8           month;
  uint8           day;
  uint8           hours;
  uint8           minutes;
  uint8           seconds;
  
} date_time_t;

typedef struct
{
  uint16          flags;
  uint16          instantSpeed;
  int32           latitude;
  int32           longitude;
  int8            elevation[3];
  uint16          heading;
} locationAndSpeed_t;
  
typedef struct
{
  uint16          flags;
  uint8           beaconsInSolution;
  uint8           beaconsInView;
  uint16          timeFirstFix;
  uint32          ehpe;               // Estimated Horizontal Position Error
  uint32          evpe;               // Estimated Vertical Position Error
  uint8           hdop;               // Horizontal Dilution of Precision
  uint8           vdop;               // Vertical Dilution of Precision
  
} positionQuality_t;

typedef struct
{
  date_time_t         date_time;
  locationAndSpeed_t  loc_speed;
  positionQuality_t   quality;
} WIMU_GPSFrame_t;

// WIMU Current time structure
typedef struct
{
  date_time_t   date_time;
  uint8         day_of_week; // 0=Undefined, 1 = Monday, ...
} dayDateTime_t;

typedef struct
{
  dayDateTime_t day_date_time;
  uint8         fractions256;
} exactTime256_t;

typedef struct
{
  exactTime256_t  exact_time;
  uint8           adjust_reason; // See https://developer.bluetooth.org/gatt/characteristics/Pages/CharacteristicViewer.aspx?u=org.bluetooth.characteristic.current_time.xml
} currentTime_t;

// IMU Config Structure
// NOTE: Not using full WIMU Config, since it would be larger than 22 bytes (limit of attributes size)
typedef struct {
  uint16  enabled_modules;
  uint8   sampling_rate;
  uint8   acc_range;
  uint8   gyro_range;
  uint8   mag_range;
} IMU_Config_t;

typedef struct {
  uint8   status;
  uint16  rec_id;
} RemControl_t;


// Event flags



//static void WIMU_packetInitRand(uint16 seq, WIMU_packet_t* packet);
//static void WIMU_packetInitZero(uint16 seq, WIMU_packet_t* packet);

/**
  * Initialise a packet  with random data
  */
/*
static void WIMU_packetInitRand(uint16 seq, WIMU_actimetry_packet_t* packet){

  packet->seq = seq;
  
  packet->acc.x = RAND_UNSINGED_SHORT;
  packet->acc.y = RAND_UNSINGED_SHORT;
  packet->acc.z = RAND_UNSINGED_SHORT;

  packet->gyr.x = RAND_UNSINGED_SHORT;
  packet->gyr.y = RAND_UNSINGED_SHORT;
  packet->gyr.z = RAND_UNSINGED_SHORT;

  packet->mag.x = RAND_SINGED_SHORT;
  packet->mag.y = RAND_SINGED_SHORT;
  packet->mag.z = RAND_SINGED_SHORT;
  
}
*/




#line 22 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.h"
  
/*********************************************************************
 * CONSTANTS
 */

// Profile Parameters




  
// Simple Profile Service UUID

  





// Simple Keys Profile Services bit fields


/*********************************************************************
 * TYPEDEFS
 */


/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

/*********************************************************************
 * API FUNCTIONS 
 */

/*
 * Gps_AddService- Initializes the Gps Profile service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 */
extern bStatus_t Gps_AddService( uint32 services );

/*
 * Gps_SetParameter - Set a Gps Profile parameter.
 *
 *    param - Profile parameter ID
 *    len - length of data to right
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate 
 *          data type (example: data type of uint16 will be cast to 
 *          uint16 pointer).
 */
extern bStatus_t Gps_SetParameter( uint8 param, uint8 len, void *value );
  
/*
 * Gps_GetParameter - Get a Gps Profile parameter.
 *
 *    param - Profile parameter ID
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate 
 *          data type (example: data type of uint16 will be cast to 
 *          uint16 pointer).
 */
extern bStatus_t Gps_GetParameter( uint8 param, void *value );

/*********************************************************************
*********************************************************************/





#line 22 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\GPS\\gpsservice.c"

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */



/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */
// Simple GATT Profile Service UUID: 0xFFF0
const uint8 gpsServUUID[2] =
{ 
  ((0x1819) & 0xFF), (((0x1819) >> 8) & 0xFF)
};

// GPS_FEATURES_UUID
const uint8 gpsFeaturesUUID[2] =
{ 
  ((0x2A6A) & 0xFF), (((0x2A6A) >> 8) & 0xFF)
};

// GPS_LOCATION_AND_SPEED_UUID
const uint8 gpsLocationAndSpeedUUID[2] =
{ 
  ((0x2A67) & 0xFF), (((0x2A67) >> 8) & 0xFF)
};

// GPS_DATE_TIME_UUID
const uint8 gpsDateTimeUUID[2] =
{ 
  ((0x2A08) & 0xFF), (((0x2A08) >> 8) & 0xFF)
};

// GPS_POSITION_QUALITY_UUID
const uint8 gpsPositionQualityUUID[2] =
{ 
  ((0x2A69) & 0xFF), (((0x2A69) >> 8) & 0xFF)
};

/*********************************************************************
 * EXTERNAL VARIABLES
 */

/*********************************************************************
 * EXTERNAL FUNCTIONS
 */

/*********************************************************************
 * LOCAL VARIABLES
 */

/*********************************************************************
 * Profile Attributes - variables
 */

// Gps Service attribute
static const gattAttrType_t gpsService = { 2, gpsServUUID };

// gpsFeatures Properties
static uint8 gpsFeaturesProps = 0x02;

// gpsFeatures Value
static uint8 gpsFeatures[4] = {0x00, 0x00, 0x60, 0x5D};

// gpsLocationAndSpeed Properties
static uint8 gpsLocationAndSpeedProps = 0x10;

// gpsLocationAndSpeed Value
static uint8 gpsLocationAndSpeed[17] = {0x00, 0x00,             // flags
                                        0x00, 0x00,             // speed
                                        0x00, 0x00, 0x00, 0x00, // latitude
                                        0x00, 0x00, 0x00, 0x00, // longitude
                                        0x00, 0x00, 0x00,       // elevation
                                        0x00, 0x00};             // heading

static gattCharCfg_t gpsLocationAndSpeedClientCharCfg[( 3 + 1 )];

// gpsDateTime Properties
static uint8 gpsDateTimeProps = 0x02 | 0x10;

// gpsDateTime Value
static uint8 gpsDateTime[7] = {         0x00, 0x00,             // year
                                        0x00,                   // month
                                        0x00,                   // day
                                        0x00,                   // hours
                                        0x00,                   // minutes
                                        0x00};                  // seconds

static gattCharCfg_t gpsDateTimeClientCharCfg[( 3 + 1 )];

// gpsPositionQuality Properties
static uint8 gpsPositionQualityProps = 0x02;// | GATT_PROP_NOTIFY;  notifications are excluded

// gpsPositionQuality Value
static uint8 gpsPositionQuality[16] = {0x00, 0x00,                  // flags
                                       0x00,                        // nb of Beacons in Solution
                                       0x00,                        // nb of Beacons in View
                                       0x00, 0x00,                  // Time to First Fix
                                       0x00, 0x00, 0x00, 0x00,      // EHPE
                                       0x00, 0x00, 0x00, 0x00,      // EVPE
                                       0x00,                        // HDOP
                                       0x00};                       // VDOP

//static gattCharCfg_t gpsPositionQualityClientCharCfg[GATT_MAX_NUM_CONN];

/*********************************************************************
 * Profile Attributes - Table
 */

static gattAttribute_t gpsAttrTbl[11] = 
{
  // Simple Profile Service
  { 
    { 2, primaryServiceUUID }, /* type */
    0x01,                         /* permissions */
    0,                                        /* handle */
    (uint8 *)&gpsService                      /* pValue */
  },

    // gpsFeatures Declaration
    { 
      { 2, characterUUID },
      0x01, 
      0,
      &gpsFeaturesProps 
    },

      // gpsFeatures Value
      { 
        { 2, gpsFeaturesUUID },
        0x01, 
        0, 
        gpsFeatures 
      },

    // gpsLocationAndSpeed Declaration
    { 
      { 2, characterUUID },
      0x01, 
      0,
      &gpsLocationAndSpeedProps 
    },

      // gpsLocationAndSpeed Value
      { 
        { 2, gpsLocationAndSpeedUUID },
        0x01, 
        0, 
        gpsLocationAndSpeed 
      },

      // gpsLocationAndSpeed Client Characteristic Configuration
      {
        { 2, clientCharCfgUUID },
        0x01 | 0x02,
        0,
        (uint8 *)gpsLocationAndSpeedClientCharCfg
      },
      
    // gpsDateTime Declaration
    { 
      { 2, characterUUID },
      0x01, 
      0,
      &gpsDateTimeProps 
    },

      // gpsDateTime Value
      { 
        { 2, gpsDateTimeUUID },
        0x01, 
        0, 
        gpsDateTime 
      },

      // gpsDateTime Client Characteristic Configuration
      {
        { 2, clientCharCfgUUID },
        0x01 | 0x02,
        0,
        (uint8 *)gpsDateTimeClientCharCfg
      },
      
    // gpsPositionQuality Declaration
    { 
      { 2, characterUUID },
      0x01, 
      0,
      &gpsPositionQualityProps
    },

      // gpsPositionQuality Value
      { 
        { 2, gpsPositionQualityUUID },
        0x01, 
        0, 
        gpsPositionQuality
      }/*,                              // Notifications are excluded

      // gpsPositionQuality Client Characteristic Configuration
      {
        { ATT_BT_UUID_SIZE, clientCharCfgUUID },
        GATT_PERMIT_READ | GATT_PERMIT_WRITE,
        0,
        (uint8 *)gpsPositionQualityClientCharCfg
      }*/
};


/*********************************************************************
 * LOCAL FUNCTIONS
 */
static uint8 gps_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr, 
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen );
static bStatus_t gps_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                 uint8 *pValue, uint8 len, uint16 offset );

static void gps_HandleConnStatusCB( uint16 connHandle, uint8 changeType );


/*********************************************************************
 * PROFILE CALLBACKS
 */
// Gps Profile Service Callbacks
const gattServiceCBs_t gpsCBs =
{
  gps_ReadAttrCB,  // Read callback function pointer
  gps_WriteAttrCB, // Write callback function pointer
  0                       // Authorization callback function pointer
};

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      Gps_AddService
 *
 * @brief   Initializes the Gps Profile service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  Success or Failure
 */
bStatus_t Gps_AddService( uint32 services )
{
  uint8 status = 0x00;

  // Initialize Client Characteristic Configuration attributes
  GATTServApp_InitCharCfg( 0xFFFF, gpsLocationAndSpeedClientCharCfg );
  
  // Notifications are excluded
  //GATTServApp_InitCharCfg( INVALID_CONNHANDLE, gpsPositionQualityClientCharCfg );
  GATTServApp_InitCharCfg( 0xFFFF, gpsDateTimeClientCharCfg );
  
  // Register with Link DB to receive link status change callback
  (void) linkDB_Register( gps_HandleConnStatusCB );  
  
  if ( services & 0x00000001 )
  {
    // Register GATT attribute list and CBs with GATT Server App
    status = GATTServApp_RegisterService( gpsAttrTbl, 
                                          ( sizeof( gpsAttrTbl ) / sizeof( gattAttribute_t ) ),
                                          &gpsCBs );
  }

  return ( status );
}

/*********************************************************************
 * @fn      Gps_SetParameter
 *
 * @brief   Set a Gps Profile parameter.
 *
 * @param   param - Profile parameter ID
 * @param   len - length of data to right
 * @param   value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate 
 *          data type (example: data type of uint16 will be cast to 
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Gps_SetParameter( uint8 param, uint8 len, void *value )
{
  bStatus_t ret = 0x00;
  switch ( param )
  {
    case 0:
      if ( len == sizeof(gpsFeatures) ) 
      {
        (void) osal_memcpy( gpsFeatures, value, sizeof(gpsFeatures) );
      }
      else
      {
        ret = 0x18;
      }
      break;

    case 1:
      if ( len == sizeof(locationAndSpeed_t) ) 
      {
        (void) osal_memcpy( gpsLocationAndSpeed, value, sizeof(locationAndSpeed_t) );
        
        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( gpsLocationAndSpeedClientCharCfg, gpsLocationAndSpeed, 0,
                                   gpsAttrTbl, ( sizeof( gpsAttrTbl ) / sizeof( gattAttribute_t ) ),
                                   0xFF );
      }
      else
      {
        ret = 0x18;
      }
    break;
    
    case 3:
      if ( len == sizeof(date_time_t) ) 
      {
        (void) osal_memcpy( gpsDateTime, value, sizeof(date_time_t) );
        
        // See if Notification has been enabled
        GATTServApp_ProcessCharCfg( gpsDateTimeClientCharCfg, gpsDateTime, 0,
                                   gpsAttrTbl, ( sizeof( gpsAttrTbl ) / sizeof( gattAttribute_t ) ),
                                   0xFF );
      }
      else
      {
        ret = 0x18;
      }
    break;
      
    case 2:
      if ( len == sizeof(positionQuality_t) ) 
      {
        (void) osal_memcpy( gpsPositionQuality, value, sizeof(positionQuality_t) );
        
        // See if Notification has been enabled
        // Notifications are excluded (https://developer.bluetooth.org)
/*        GATTServApp_ProcessCharCfg( gpsPositionQualityClientCharCfg, gpsPositionQuality, FALSE,
                                   gpsAttrTbl, GATT_NUM_ATTRS( gpsAttrTbl ),
                                   INVALID_TASK_ID );*/
      }
      else
      {
        ret = 0x18;
      }
      break;
  }
  
  return ( ret );
}

/*********************************************************************
 * @fn      Gps_GetParameter
 *
 * @brief   Get a Gps Profile parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to put.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate 
 *          data type (example: data type of uint16 will be cast to 
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
bStatus_t Gps_GetParameter( uint8 param, void *value )
{
  bStatus_t ret = 0x00;
  switch ( param )
  {
    case 0:
      osal_memcpy (value, gpsFeatures, sizeof(gpsFeatures) );
      break;

    case 1:
      osal_memcpy (value, gpsLocationAndSpeed, sizeof(locationAndSpeed_t) );
      break;      

    case 3:
      osal_memcpy (value, gpsDateTime, sizeof(date_time_t) );
      break;      

    case 2:
      osal_memcpy (value, gpsPositionQuality, sizeof(positionQuality_t) );
      break;  

    default:
      ret = 0x02;
      break;
  }
  
  return ( ret );
}

/*********************************************************************
 * @fn          gps_ReadAttrCB
 *
 * @brief       Read an attribute.
 *
 * @param       connHandle - connection message was received on
 * @param       pAttr - pointer to attribute
 * @param       pValue - pointer to data to be read
 * @param       pLen - length of data to be read
 * @param       offset - offset of the first octet to be read
 * @param       maxLen - maximum length of data to be read
 *
 * @return      Success or Failure
 */
static uint8 gps_ReadAttrCB( uint16 connHandle, gattAttribute_t *pAttr, 
                            uint8 *pValue, uint8 *pLen, uint16 offset, uint8 maxLen )
{
  bStatus_t status = 0x00;

  // If attribute permissions require authorization to read, return error
  if ( ( (pAttr->permissions) & 0x10 ) )
  {
    // Insufficient authorization
    return ( 0x08 );
  }
 
  if ( pAttr->type.len == 2 )
  {
    // 16-bit UUID
    uint16 uuid = ((uint16)(((pAttr->type . uuid[0]) & 0x00FF) + (((pAttr->type . uuid[1]) & 0x00FF) << 8)));
    switch ( uuid )
    {
      case 0x2A6A:
        *pLen = 4;
        osal_memcpy( pValue, pAttr->pValue, 4 );
        break;
        
      case 0x2A67:
        *pLen = sizeof(locationAndSpeed_t);
        osal_memcpy( pValue, pAttr->pValue, sizeof(locationAndSpeed_t) );
        break;

      case 0x2A08:
        *pLen = sizeof(date_time_t);
        osal_memcpy( pValue, pAttr->pValue, sizeof(date_time_t) );
        break;
        
      case 0x2A69:
        *pLen = sizeof(positionQuality_t);
        osal_memcpy( pValue, pAttr->pValue, sizeof(positionQuality_t) );
        break;
        
      default:
        // Should never get here!
        *pLen = 0;
        status = 0x0a;
        break;
    }
  }
  else
  {
    // 128-bit UUID
    *pLen = 0;
    status = 0x01;
  }

  return ( status );
}

/*********************************************************************
 * @fn      gps_WriteAttrCB
 *
 * @brief   Validate attribute data prior to a write operation
 *
 * @param   connHandle - connection message was received on
 * @param   pAttr - pointer to attribute
 * @param   pValue - pointer to data to be written
 * @param   len - length of data
 * @param   offset - offset of the first octet to be written
 *
 * @return  Success or Failure
 */
static bStatus_t gps_WriteAttrCB( uint16 connHandle, gattAttribute_t *pAttr,
                                 uint8 *pValue, uint8 len, uint16 offset )
{
  bStatus_t status = 0x00;
  
  uint16 uuid = ((uint16)(((pAttr->type . uuid[0]) & 0x00FF) + (((pAttr->type . uuid[1]) & 0x00FF) << 8)));
  switch ( uuid )
  {
    case 0x2902:
      status = GATTServApp_ProcessCCCWriteReq( connHandle, pAttr, pValue, len,
                                               offset, 0x0001 );
      break;

    default:
      status = 0x0a;
      break;
  }
  
  return ( status );
}

/*********************************************************************
 * @fn          gps_HandleConnStatusCB
 *
 * @brief       Gps Profile link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
static void gps_HandleConnStatusCB( uint16 connHandle, uint8 changeType )
{ 
  // Make sure this is not loopback connection
  if ( connHandle != 0xFFFE )
  {
    // Reset Client Char Config if connection has dropped
    if ( ( changeType == 1 )      ||
         ( ( changeType == 2 ) &&
           ( !linkDB_State( (connHandle), 0x01 ) ) ) )
    {
      GATTServApp_InitCharCfg( connHandle, gpsLocationAndSpeedClientCharCfg ); 
      //GATTServApp_InitCharCfg( connHandle, gpsPositionQualityClientCharCfg );
      GATTServApp_InitCharCfg( connHandle, gpsDateTimeClientCharCfg );
    }
  }
}


/*********************************************************************
*********************************************************************/
