#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
/**************************************************************************************************
  Filename:       wimu.c

  Description:    This file contains the WIMU application 
                  (based on Simple BLE Peripheral sample application).

**************************************************************************************************/

/*********************************************************************
 * INCLUDES
 */
#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\stdio.h"
/*                      - STDIO.H -

   Subset of ANSI standard I/O function declarations.

   $Revision: 6265 $

   Copyright 1986 - 1999 IAR Systems. All rights reserved.
*/





  #pragma system_include


#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\stdarg.h"
/*                      - STDARG.H -
   The ANSI macros for reading variable argument lists (...).

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

#line 17 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\stdarg.h"




typedef void *va_list[1];

__intrinsic void __va_start(va_list);




/*=====================================*/
/*  These targets has char pushed as   */
/*  word on stack.                     */
/*  Stack grows in negativ direction.  */
/*  (New type of code-generators)      */
/* - - - - - - - - - - - - - - - - - - */
/*     ICC78000 version 4.xx           */
/*     M32C version 3.xx               */
/*=====================================*/
#line 46 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\stdarg.h"

#line 54 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\stdarg.h"



#line 18 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\stdio.h"













#pragma language=save
#pragma language=extended
 int  puts(const char *);

__near_func int  putchar(int);
__near_func int  getchar(void);




 int  sprintf(char *,const char *,...);
 int  vsprintf(char *,const char *,va_list);
 int  printf(const char *,...);
 int  vprintf(const char *,va_list);
 int  scanf(const char *,...);
 int  sscanf(const char *, const char *,...);
 char *gets(char *);
#pragma language=restore


#line 13 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

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





#line 15 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
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





#line 16 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\OSAL_PwrMgr.h"
/**************************************************************************************************
  Filename:       OSAL_PwrMgr.h
  Revised:        $Date: 2007-10-28 18:41:49 -0700 (Sun, 28 Oct 2007) $
  Revision:       $Revision: 15799 $

  Description:    This file contains the OSAL Power Management API.


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
 * MACROS
 */

/*********************************************************************
 * TYPEDEFS
 */

/* These attributes define sleep beheaver. The attributes can be changed
 * for each sleep cycle or when the device characteristic change.
 */
typedef struct
{
  uint16 pwrmgr_task_state;
  uint16 pwrmgr_next_timeout;
  uint16 accumulated_sleep_time;
  uint8  pwrmgr_device;
} pwrmgr_attribute_t;

/* With PWRMGR_ALWAYS_ON selection, there is no power savings and the
 * device is most likely on mains power. The PWRMGR_BATTERY selection allows
 * the HAL sleep manager to enter SLEEP LITE state or SLEEP DEEP state.
 */



/* The PWRMGR_CONSERVE selection turns power savings on, all tasks have to
 * agree. The PWRMGR_HOLD selection turns power savings off.
 */




/*********************************************************************
 * GLOBAL VARIABLES
 */

/* This global variable stores the power management attributes.
 */
extern pwrmgr_attribute_t pwrmgr_attribute;

/*********************************************************************
 * FUNCTIONS
 */

  /*
   * Initialize the power management system.
   *   This function is called from OSAL.
   *
   */
  extern void osal_pwrmgr_init( void );

  /*
   * This function is called by each task to state whether or not this
   * task wants to conserve power. The task will call this function to
   * vote whether it wants the OSAL to conserve power or it wants to
   * hold off on the power savings. By default, when a task is created,
   * its own power state is set to conserve. If the task always wants
   * to converse power, it doesn't need to call this function at all.
   * It is important for the task that changed the power manager task
   * state to PWRMGR_HOLD to switch back to PWRMGR_CONSERVE when the
   * hold period ends.
   */
  extern uint8 osal_pwrmgr_task_state( uint8 task_id, uint8 state );

  /*
   * This function is called on power-up, whenever the device characteristic
   * change (ex. Battery backed coordinator). This function works with the timer
   * to set HAL's power manager sleep state when power saving is entered.
   * This function should be called form HAL initialization. After power up
   * initialization, it should only be called from NWK or ZDO.
   */
  extern void osal_pwrmgr_device( uint8 pwrmgr_device );

  /*
   * This function is called from the main OSAL loop when there are
   * no events scheduled and shouldn't be called from anywhere else.
   */
  extern void osal_pwrmgr_powerconserve( void );

/*********************************************************************
*********************************************************************/





#line 17 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\common\\cc2540\\OnBoard.h"
/**************************************************************************************************
  Filename:       OnBoard.h
  Revised:        $Date: 2008-07-25 17:36:14 -0700 (Fri, 25 Jul 2008) $
  Revision:       $Revision: 17620 $

  Description:    Defines stuff for EVALuation boards
                  This file targets the Chipcon CC2540DB/CC2540EB


  Copyright 2008-2012 Texas Instruments Incorporated. All rights reserved.

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
**************************************************************************************************/




#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"
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
#line 76 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"


#line 84 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

/* ---------------------- Keil Compiler ---------------------- */
#line 104 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"


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
#line 131 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

/* ------------------------------------------------------------------------------------------------
 *                                        Reset Macro
 * ------------------------------------------------------------------------------------------------
 */
#line 142 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

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




#line 199 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"

/**************************************************************************************************
 */
#line 45 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\common\\cc2540\\OnBoard.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_sleep.h"
/**************************************************************************************************
  Filename:       hal_sleep.h
  Revised:        $Date: 2013-02-27 11:32:02 -0800 (Wed, 27 Feb 2013) $
  Revision:       $Revision: 33315 $

  Description:    This file contains the interface to the power management service.


  Copyright 2006-2012 Texas Instruments Incorporated. All rights reserved.

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
 * FUNCTIONS
 */

/*
 * Execute power management procedure
 */
extern void halSleep( uint32 osal_timer );

/*
 * Used in mac_mcu
 */
extern void halSleepWait(uint16 duration);

/*
 * Used in hal_drivers, AN044 - DELAY EXTERNAL INTERRUPTS
 */
extern void halRestoreSleepLevel( void );

/*
 * Used by the interrupt routines to exit from sleep.
 */
extern void halSleepExit(void);

/*
 * Set the max sleep loop time lesser than the T2 rollover period.
 */
extern void halSetMaxSleepLoopTime(uint32 rolloverTime);

/*********************************************************************
*********************************************************************/





#line 46 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\common\\cc2540\\OnBoard.h"


/*********************************************************************
 */
// Internal (MCU) RAM addresses




// Internal (MCU) heap size




// Memory Allocation Heap






// Initialization levels






typedef struct
{
  osal_event_hdr_t hdr;
  uint8             state; // shift
  uint8             keys;  // keys
} keyChange_t;

// Timer clock and power-saving definitions



/* OSAL timer defines */





extern void _itoa(uint16 num, uint8 *buf, uint8 radix);






/* Tx and Rx buffer size defines used by SPIMgr.c */





/* system restart and boot loader used from MTEL.c */
// Restart system from absolute beginning
// Disables interrupts, forces WatchDog reset








/* Reset reason for reset indication */


/* port definition stuff used by MT */
#line 133 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\common\\cc2540\\OnBoard.h"

/* sleep macros required by OSAL_PwrMgr.c */





/* used by MTEL.c */
uint8 OnBoard_SendKeys( uint8 keys, uint8 state );

/*
 * Board specific random number generator
 */
extern uint16 Onboard_rand( void );

/*
 * Get elapsed timer clock counts
 *   reset: reset count register if TRUE
 */
extern uint32 TimerElapsed( void );

/*
 * Initialize the Peripherals
 *    level: 0=cold, 1=warm, 2=ready
 */
extern void InitBoard( uint8 level );

/*
 * Register for all key events
 */
extern uint8 RegisterForKeys( uint8 task_id );

/* Keypad Control Functions */

/*
 * Send "Key Pressed" message to application
 */
extern uint8 OnBoard_SendKeys(  uint8 keys, uint8 shift);

/*
 * Callback routine to handle keys
 */
extern void OnBoard_KeyCallback ( uint8 keys, uint8 state );

/*
 * Perform a soft reset - jump to 0x0
 */
extern __near_func void Onboard_soft_reset( void );


/*********************************************************************
 */

#line 19 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_adc.h"
/**************************************************************************************************
  Filename:       hal_adc.h
  Revised:        $Date: 2013-03-06 13:50:31 -0800 (Wed, 06 Mar 2013) $
  Revision:       $Revision: 33395 $

  Description:    This file contains the interface to the ADC Service.


  Copyright 2005-2010 Texas Instruments Incorporated. All rights reserved.

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









/**************************************************************************************************
 * INCLUDES
 **************************************************************************************************/

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_board.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"
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

#line 101 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"



/* 1 - Green */






  /* 2 - Red */





  /* 3 - Yellow */






/* Push Button Configuration */




/* S1 */



#line 140 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Joystick Center Press */




/* OSAL NV implemented by internal flash pages. */

// Flash is partitioned into 8 banks of 32 KB or 16 pages.


// Flash is constructed of 128 pages of 2 KB.


// SNV can use a larger logical page size to accomodate more or bigger items or extend lifetime.



// CODE banks get mapped into the XDATA range 8000-FFFF.


// The last 16 bytes of the last available page are reserved for flash lock bits.


// NV page definitions must coincide with segment declaration in project *.xcl file.
#line 172 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

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
#line 256 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Debounce */


/* ----------- Push Buttons ---------- */
#line 267 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* LED's */























#line 315 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* XNV */







// The TI reference design uses UART1 Alt. 2 in SPI mode.
#line 356 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Driver Configuration */

/* Set to TRUE enable H/W TIMER usage, FALSE disable it */




/* Set to TRUE enable ADC usage, FALSE disable it */




/* Set to TRUE enable DMA usage, FALSE disable it */




/* Set to TRUE enable Flash access, FALSE disable it */




/* Set to TRUE enable AES usage, FALSE disable it */








/* Set to TRUE enable LCD usage, FALSE disable it */




/* Set to TRUE enable LED usage, FALSE disable it */
#line 400 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Set to TRUE enable KEY usage, FALSE disable it */




/* Set to TRUE enable UART usage, FALSE disable it */
#line 414 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"


  // Always prefer to use DMA over ISR.
#line 444 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\target\\CC2540EB\\hal_board_cfg.h"
  
  // Used to set P2 priority - USART0 over USART1 if both are defined.





  















/*******************************************************************************
*/
#line 2 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_board.h"
#line 54 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_adc.h"

/**************************************************************************************************
 * CONSTANTS
 **************************************************************************************************/

/* Resolution */





/* Channels */
#line 74 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_adc.h"

#line 92 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_adc.h"




/* Vdd Limits */
#line 105 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_adc.h"

/* Reference Voltages */






/**************************************************************************************************
 *                                        FUNCTIONS - API
 **************************************************************************************************/

/*
 * Initialize ADC Service with reference set to default value
 */
extern void HalAdcInit ( void );

/*
 * Read value from a specified ADC Channel at the given resolution
 */
extern uint16 HalAdcRead ( uint8 channel, uint8 resolution );

/*
 * Set the reference voltage for the ADC
 */
extern void HalAdcSetReference ( uint8 reference );

/*
 * Check for minimum Vdd specified.
 */
extern bool HalAdcCheckVdd(uint8 vdd);

/**************************************************************************************************
**************************************************************************************************/





#line 20 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_led.h"
/**************************************************************************************************
  Filename:       hal_led.h
  Revised:        $Date: 2007-07-06 10:42:24 -0700 (Fri, 06 Jul 2007) $
  Revision:       $Revision: 13579 $

  Description:    This file contains the interface to the LED Service.


  Copyright 2005-2007 Texas Instruments Incorporated. All rights reserved.

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
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_board.h"
#line 52 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_led.h"

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

/* LEDS - The LED number is the same as the bit position */






/* Modes */






/* Defaults */





/*********************************************************************
 * TYPEDEFS
 */


/*********************************************************************
 * GLOBAL VARIABLES
 */

/*
 * Initialize LED Service.
 */
extern void HalLedInit( void );

/*
 * Set the LED ON/OFF/TOGGLE.
 */
extern uint8 HalLedSet( uint8 led, uint8 mode );

/*
 * Blink the LED.
 */
extern void HalLedBlink( uint8 leds, uint8 cnt, uint8 duty, uint16 time );

/*
 * Put LEDs in sleep state - store current values
 */
extern void HalLedEnterSleep( void );

/*
 * Retore LEDs from sleep state
 */
extern void HalLedExitSleep( void );

/*
 * Return LED state
 */
extern uint8 HalLedGetState ( void );

/*********************************************************************
*********************************************************************/





#line 21 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_key.h"
/**************************************************************************************************
  Filename:       hal_key.h
  Revised:        $Date: 2007-07-06 10:42:24 -0700 (Fri, 06 Jul 2007) $
  Revision:       $Revision: 13579 $

  Description:    This file contains the interface to the KEY Service.


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









/**************************************************************************************************
 *                                             INCLUDES
 **************************************************************************************************/
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_board.h"
#line 52 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_key.h"
  
/**************************************************************************************************
 * MACROS
 **************************************************************************************************/

/**************************************************************************************************
 *                                            CONSTANTS
 **************************************************************************************************/

/* Interrupt option - Enable or disable */



/* Key state - shift or nornal */












/* Joystick */






/* Buttons */  






/**************************************************************************************************
 * TYPEDEFS
 **************************************************************************************************/
typedef void (*halKeyCBack_t) (uint8 keys, uint8 state);

/**************************************************************************************************
 *                                             GLOBAL VARIABLES
 **************************************************************************************************/
extern bool Hal_KeyIntEnable;

/**************************************************************************************************
 *                                             FUNCTIONS - API
 **************************************************************************************************/

/*
 * Initialize the Key Service
 */
extern void HalKeyInit( void );

/*
 * Configure the Key Service
 */
extern void HalKeyConfig( bool interruptEnable, const halKeyCBack_t cback);

/*
 * Read the Key status
 */
extern uint8 HalKeyRead( void);

/*
 * Enter sleep mode, store important values
 */
extern void HalKeyEnterSleep ( void );

/*
 * Exit sleep mode, retore values
 */
extern uint8 HalKeyExitSleep ( void );

/*
 * This is for internal used by hal_driver
 */
extern void HalKeyPoll ( void );

/*
 * This is for internal used by hal_sleep
 */
extern bool HalKeyPressed( void );

extern uint8 hal_key_keys(void);                                           

extern uint8 hal_key_int_keys(void);

/**************************************************************************************************
**************************************************************************************************/





#line 22 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_lcd.h"
/**************************************************************************************************
  Filename:       hal_lcd.h
  Revised:        $Date: 2007-07-06 10:42:24 -0700 (Fri, 06 Jul 2007) $
  Revision:       $Revision: 13579 $

  Description:    This file contains the interface to the LCD Service.


  Copyright 2005-2007 Texas Instruments Incorporated. All rights reserved.

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









/**************************************************************************************************
 *                                          INCLUDES
 **************************************************************************************************/
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_board.h"
#line 52 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_lcd.h"


  
/**************************************************************************************************
 *                                         CONSTANTS
 **************************************************************************************************/

/* These are used to specify which line the text will be printed */


/*
   This to support LCD with extended number of lines (more than 2).
   Don't use these if LCD doesn't support more than 2 lines
*/
#line 72 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_lcd.h"
 
/**************************************************************************************************
 *                                          MACROS
 **************************************************************************************************/


/**************************************************************************************************
 *                                         TYPEDEFS
 **************************************************************************************************/


/**************************************************************************************************
 *                                     GLOBAL VARIABLES
 **************************************************************************************************/


/**************************************************************************************************
 *                                     FUNCTIONS - API
 **************************************************************************************************/

/*
 * Initialize LCD Service
 */
extern void HalLcdInit(void);

/*
 * Write a string to the LCD
 */
extern void HalLcdWriteString ( char *str, uint8 option);

/*
 * Write a value to the LCD
 */
extern void HalLcdWriteValue ( uint32 value, const uint8 radix, uint8 option);

/*
 * Write a value to the LCD
 */
extern void HalLcdWriteScreen( char *line1, char *line2 );

/*
 * Write a string followed by a value to the LCD
 */
extern void HalLcdWriteStringValue( char *title, uint16 value, uint8 format, uint8 line );

/*
 * Write a string followed by 2 values to the LCD
 */
extern void HalLcdWriteStringValueValue( char *title, uint16 value1, uint8 format1, uint16 value2, uint8 format2, uint8 line );

/*
 * Write a percentage bar to the LCD
 */
extern void HalLcdDisplayPercentBar( char *title, uint8 value );


/**************************************************************************************************
**************************************************************************************************/





#line 23 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_uart.h"
/**************************************************************************************************
  Filename:       hal_uart.h
  Revised:        $Date: 2012-10-17 09:45:25 -0700 (Wed, 17 Oct 2012) $
  Revision:       $Revision: 31844 $

  Description:    This file contains the interface to the UART Service.


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









/***************************************************************************************************
 *                                             INCLUDES
 ***************************************************************************************************/
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_board.h"
#line 52 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_uart.h"

/***************************************************************************************************
 *                                              MACROS
 ***************************************************************************************************/

/***************************************************************************************************
 *                                            CONSTANTS
 ***************************************************************************************************/


/* UART Ports */

/*
   Serial Port Baudrate Settings
   Have to match with baudrate table
*/
#line 79 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_uart.h"

/* Frame Format constant */

/* Stop Bits */



/* Parity settings */




/* Character Size */



/* Flow control */



/* Ports */




/* UART Status */






/* UART Events */






/***************************************************************************************************
 *                                             TYPEDEFS
 ***************************************************************************************************/

typedef void (*halUARTCBack_t) (uint8 port, uint8 event);

typedef struct
{
  // The head or tail is updated by the Tx or Rx ISR respectively, when not polled.
  volatile uint16 bufferHead;
  volatile uint16 bufferTail;
  uint16 maxBufSize;
  uint8 *pBuffer;
} halUARTBufControl_t;

typedef struct
{
  bool                configured;
  uint8               baudRate;
  bool                flowControl;
  uint16              flowControlThreshold;
  uint8               idleTimeout;
  halUARTBufControl_t rx;
  halUARTBufControl_t tx;
  bool                intEnable;
  uint32              rxChRvdTime;
  halUARTCBack_t      callBackFunc;
}halUARTCfg_t;

typedef union
{
  bool paramCTS;
  bool paramRTS;
  bool paramDSR;
  bool paramDTR;
  bool paramCD;
  bool paramRI;
  uint16 baudRate;
  bool flowControl;
  bool flushControl;
}halUARTIoctl_t;


/***************************************************************************************************
 *                                           GLOBAL VARIABLES
 ***************************************************************************************************/


/***************************************************************************************************
 *                                            FUNCTIONS - API
 ***************************************************************************************************/
/*
 *  Initialize UART at the startup
 */
extern void HalUARTInit ( void );

/*
 * Open a port based on the configuration
 */
extern uint8 HalUARTOpen ( uint8 port, halUARTCfg_t *config );

/*
 * Close a port
 */
extern void HalUARTClose ( uint8 port );

/*
 * Read a buffer from the UART
 */
extern uint16 HalUARTRead ( uint8 port, uint8 *pBuffer, uint16 length );

/*
 * Write a buff to the uart *
 */
extern uint16 HalUARTWrite ( uint8 port, uint8 *pBuffer, uint16 length );

/*
 * Write a buffer to the UART
 */
extern uint8 HalUARTIoctl ( uint8 port, uint8 cmd, halUARTIoctl_t *pIoctl );

/*
 * This to support polling
 */
extern void HalUARTPoll( void );

/*
 * Return the number of bytes in the Rx buffer
 */
extern uint16 Hal_UART_RxBufLen ( uint8 port );

/*
 * Return the number of bytes in the Tx buffer
 */
extern uint16 Hal_UART_TxBufLen ( uint8 port );

/*
 * This enable/disable flow control
 */
extern void Hal_UART_FlowControlSet ( uint8 port, bool status );

/*
 * Initialize hardware for UART
 */
extern uint8 HalUART_HW_Init(uint8 port);

/*
 * Abort UART when entering sleep mode
 */
extern void HalUARTSuspend(void);

/*
 * Resume UART after wakeup from sleep
 */
extern void HalUARTResume(void);

/***************************************************************************************************
***************************************************************************************************/





#line 24 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"


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



#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\ble\\include\\att.h"
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





#line 59 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\ble\\include\\att.h"

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

#line 101 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\ble\\include\\att.h"




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

#line 156 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\ble\\include\\att.h"

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





#line 61 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gatt.h"

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





#line 27 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"
/*******************************************************************************
  Filename:       hci.h
  Revised:        $Date: 2013-05-14 12:23:59 -0700 (Tue, 14 May 2013) $
  Revision:       $Revision: 34279 $

  Description:    This file contains the Host Controller Interface (HCI) API.
                  It provides the defines, types, and functions for all
                  supported Bluetooth Low Energy (BLE) commands.

                  All Bluetooth and BLE commands are based on:
                  Bluetooth Core Specification, V4.0.0, Vol. 2, Part E.

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
*******************************************************************************/









/*******************************************************************************
 * INCLUDES
 */
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"
/*******************************************************************************
  Filename:       ll.h
  Revised:        $Date: 2013-05-15 05:57:26 -0700 (Wed, 15 May 2013) $
  Revision:       $Revision: 34287 $

  Description:    This file contains the Link Layer (LL) API for the Bluetooth
                  Low Energy (BLE) Controller. It provides the defines, types,
                  and functions for all supported Bluetooth Low Energy (BLE)
                  commands.

                  This API is based on the Bluetooth Core Specification,
                  V4.0.0, Vol. 6.

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
*******************************************************************************/









/*******************************************************************************
 * INCLUDES
 */


/*******************************************************************************
 * MACROS
 */

// check if connection parameter ranges for CI (min/max), SL, and LSTO are valid
#line 72 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"

// check if the CI/SL/LSTO combination is valid
// based on: LSTO > (1 + Slave Latency) * (Connection Interval * 2)
// Note: The CI * 2 requirement based on ESR05 V1.0, Erratum 3904.
// Note: LSTO time is normalized to units of 1.25ms (i.e. 10ms = 8 * 1.25ms).



/*******************************************************************************
 * CONSTANTS
 */

/*
** LL API Status Codes
**
** Note: These status values map directly to the HCI Error Codes.
**       Per the Bluetooth Core Specification, V4.0.0, Vol. 2, Part D.
*/
#line 137 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"
// Internal



// Encryption Key Request Reason Codes




// Disconnect Reason Codes
#line 161 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"

// Disconnect API Parameter
#line 170 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"

/*
** LL API Parameters
*/

// LL Parameter Limits
#line 195 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"

// LL Advertiser Channels





// LL Advertiser Events





// LL Address Type



// Advertiser White List Policy





// Scanner White List Policy



// Initiator White List Policy



// Black List Control



// Advertiser Commands




// LL Scan Commands



// LL Scan Filtering



// LL Scan Types



// LL Tx Power Types



// Data Fragmentation Flag




// Connection Complete Role



// Encryption Related



// Feature Set Related

//



// Receive Flow Control



// Direct Test Mode


//
#line 287 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"
//


//


// Vendor Specific


//















//


//


//


//


//


//


//


//





//
#line 348 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"
//


//


//



// Packet Lengths
#line 365 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"

/*
** Event Parameters
*/

// Advertising Report Data
#line 377 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"
//


// Sleep Clock Accuracy (SCA)
#line 389 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"

/*
** Miscellaneous
*/



/*******************************************************************************
 * TYPEDEFS
 */

typedef uint8 llStatus_t;

// Packet Error Rate Information By Channel
typedef struct
{
  uint16 numPkts[ 37 ];
  uint16 numCrcErr[ 37 ];
} perByChan_t;

/*******************************************************************************
 * LOCAL VARIABLES
 */

/*******************************************************************************
 * GLOBAL VARIABLES
 */

/*******************************************************************************
 * LL OSAL Functions
 */

/*******************************************************************************
 * @fn          LL_Init
 *
 * @brief       This is the Link Layer task initialization called by OSAL. It
 *              must be called once when the software system is started and
 *              before any other function in the LL API is called.
 *
 * input parameters
 *
 * @param       taskId - Task identifier assigned by OSAL.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_Init( uint8 taskId );


/*******************************************************************************
 * @fn          LL_ProcessEvent
 *
 * @brief       This is the Link Layer process event handler called by OSAL.
 *
 * input parameters
 *
 * @param       taskId - Task identifier assigned by OSAL.
 *              events - Event flags to be processed by this task.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      Unprocessed event flags.
 */
extern uint16 LL_ProcessEvent( uint8 task_id, uint16 events );


/*******************************************************************************
 * LL API for HCI
 */

/*******************************************************************************
 * @fn          LL_Reset API
 *
 * @brief       This function is used by the HCI to reset and initialize the
 *              LL Controller.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_Reset( void );


/*******************************************************************************
 * @fn          LL_ReadBDADDR API
 *
 * @brief       This API is called by the HCI to read the controller's
 *              own public device address.
 *
 *              Note: The device's address is stored in NV memory.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       bdAddr  - A pointer to a buffer to hold this device's address.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_ReadBDADDR( uint8 *bdAddr );


/*******************************************************************************
 *
 * @fn          LL_SetRandomAddress API
 *
 * @brief       This function is used to save this device's random address. It
 *              is provided by the Host for devices that are unable to store a
 *              IEEE assigned public address in NV memory.
 *
 * input parameters
 *
 * @param       devAddr - Pointer to a random address (LSO..MSO).
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 *
 */
extern llStatus_t LL_SetRandomAddress( uint8 *devAddr );


/*******************************************************************************
 * @fn          LL_ClearWhiteList API
 *
 * @brief       This API is called by the HCI to clear the White List.
 *
 *              Note: If Scanning is enabled using filtering, and the white
 *                    list policy is "Any", then this command will be
 *                    disallowed.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_ClearWhiteList( void );


/*******************************************************************************
 * @fn          LL_AddWhiteListDevice API
 *
 * @brief       This API is called by the HCI to add a device address and its
 *              type to the White List.
 *
 * input parameters
 *
 * @param       devAddr      - Pointer to a 6 byte device address.
 * @param       addrType     - Public or Random device address.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_WL_TABLE_FULL
 */
extern llStatus_t LL_AddWhiteListDevice( uint8 *devAddr,
                                         uint8 addrType );

/*******************************************************************************
 * @fn          LL_RemoveWhiteListDevice API
 *
 * @brief       This API is called by the HCI to remove a device address and
 *              it's type from the White List.
 *
 * input parameters
 *
 * @param       devAddr  - Pointer to a 6 byte device address.
 * @param       addrType - Public or Random device address.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_WL_TABLE_EMPTY,
 *              LL_STATUS_ERROR_WL_ENTRY_NOT_FOUND
 */
extern llStatus_t LL_RemoveWhiteListDevice( uint8 *devAddr,
                                            uint8 addrType );


/*******************************************************************************
 * @fn          LL_ReadWlSize API
 *
 * @brief       This API is called by the HCI to get the total number of white
 *              list entries that can be stored in the Controller.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       *numEntries - Total number of available White List entries.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_ReadWlSize( uint8 *numEntries );


/*******************************************************************************
 * @fn          LL_NumEmptyWlEntries API
 *
 * @brief       This API is called by the HCI to get the number of White List
 *              entries that are empty.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       *numEmptyEntries - number of empty entries in the White List.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_NumEmptyWlEntries( uint8 *numEmptyEntries );


/*******************************************************************************
 * @fn          LL_Encrypt API
 *
 * @brief       This API is called by the HCI to request the LL to encrypt the
 *              data in the command using the key given in the command.
 *
 *              Note: The parameters are byte ordered MSO to LSO.
 *
 * input parameters
 *
 * @param       *key           - A 128 bit key to be used to calculate the
 *                               session key.
 * @param       *plaintextData - A 128 bit block that is to be encrypted.
 *
 * output parameters
 *
 * @param       *encryptedData - A 128 bit block that is encrypted.
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_Encrypt( uint8 *key,
                              uint8 *plaintextData,
                              uint8 *encryptedData );


/*******************************************************************************
 * @fn          LL_Rand API
 *
 * @brief       This API is called by the HCI to request the LL Controller to
 *              provide a data block with random content.
 *
 *              Note: If the radio is in use, then this operation has to be
 *                    delayed until the radio finishes.
 *
 * input parameters
 *
 * @param       *randData - Pointer to buffer to place a random block of data.
 * @param        dataLen  - The length of the random data block, from 1-255.
 *
 * output parameters
 *
 * @param       *randData - Pointer to buffer containing a block of true random
 *                          data.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_DUE_TO_LIMITED_RESOURCES,
 *              LL_STATUS_ERROR_COMMAND_DISALLOWED,
 *              LL_STATUS_ERROR_BAD_PARAMETER, LL_STATUS_ERROR_RNG_FAILURE
 */
extern llStatus_t LL_Rand( uint8 *randData,
                           uint8 dataLen );


/*******************************************************************************
 * @fn          LL_ReadSupportedStates API
 *
 * @brief       This function is used to provide the HCI with the Link Layer
 *              supported states and supported state/role combinations.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       *states - Eight byte Bit map of supported states/combos.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_ReadSupportedStates( uint8 *states );


/*******************************************************************************
 * @fn          LL_ReadLocalSupportedFeatures API
 *
 * @brief       This API is called by the HCI to read the controller's
 *              Features Set. The Controller indicates which features it
 *              supports.
 *
 * input parameters
 *
 * @param       featureSet  - A pointer to the Feature Set where each bit:
 *                            0: Feature not supported.
 *                            1: Feature supported by controller.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_ReadLocalSupportedFeatures( uint8 *featureSet );


/*******************************************************************************
 * @fn          LL_ReadLocalVersionInfo API
 *
 * @brief       This API is called by the HCI to read the controller's
 *              Version information.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       verNum    - Version of the Bluetooth Controller specification.
 * @param       comId     - Company identifier of the manufacturer of the
 *                          Bluetooth Controller.
 * @param       subverNum - A unique value for each implementation or revision
 *                          of an implementation of the Bluetooth Controller.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_ReadLocalVersionInfo( uint8  *verNum,
                                           uint16 *comId,
                                           uint16 *subverNum );



/*******************************************************************************
 * @fn          LL_CtrlToHostFlowControl API
 *
 * @brief       This function is used to indicate if the LL enable/disable
 *              receive FIFO processing. This function provides support for
 *              Controller to Host flow control.
 *
 * input parameters
 *
 * @param       mode: LL_ENABLE_RX_FLOW_CONTROL, LL_DISABLE_RX_FLOW_CONTROL
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_CtrlToHostFlowControl( uint8 mode );




/*******************************************************************************
 * @fn          LL_ReadRemoteVersionInfo API
 *
 * @brief       This API is called by the HCI to read the peer controller's
 *              Version Information. If the peer's Version Information has
 *              already been received by its request for our Version
 *              Information, then this data is already cached and can be
 *              directly returned to the Host. If the peer's Version Information
 *              is not already cached, then it will be requested from the peer,
 *              and when received, returned to the Host via the
 *              LL_ReadRemoteVersionInfoCback callback.
 *
 *              Note: Only one Version Indication is allowed for a connection.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       connId - The LL connection ID on which to send this data.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_VER_IND_ALREADY_SENT
 */
extern llStatus_t LL_ReadRemoteVersionInfo( uint16 connId );




/*******************************************************************************
 * @fn          LL_ReadTxPowerLevel
 *
 * @brief       This function is used to read a connection's current transmit
 *              power level or the maximum transmit power level.
 *
 * input parameters
 *
 * @param       connId   - The LL connection handle.
 * @param       type     - LL_READ_CURRENT_TX_POWER_LEVEL or
 *                         LL_READ_MAX_TX_POWER_LEVEL
 * @param       *txPower - A signed value from -30..+20, in dBm.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_PARAM_OUT_OF_RANGE,
 *              LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
llStatus_t LL_ReadTxPowerLevel( uint8 connId,
                                uint8 type,
                                int8  *txPower );




/*******************************************************************************
 * @fn          LL_ReadChanMap API
 *
 * @brief       This API is called by the HCI to read the channel map that the
 *              LL controller is using for the LL connection.
 *
 * input parameters
 *
 * @param       connId  - The LL connection handle.
 *
 * output parameters
 *
 * @param       chanMap - A five byte array containing one bit per data channel
 *                        where a 1 means the channel is "used" and a 0 means
 *                        the channel is "unused".
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern llStatus_t LL_ReadChanMap( uint8 connId,
                                  uint8 *chanMap );



/*******************************************************************************
 * @fn          LL_ReadRssi API
 *
 * @brief       This API is called by the HCI to request RSSI. If there is an
 *              active connection for the given connection ID, then the RSSI of
 *              the last received data packet in the LL will be returned. If a
 *              receiver Modem Test is running, then the RF RSSI for the last
 *              received data will be returned. If no valid RSSI value is
 *              available, then LL_RSSI_NOT_AVAILABLE will be returned.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID on which to read last RSSI.
 *
 * output parameters
 *
 * @param       *lastRssi - The last data RSSI received.
 *                          Range: -127dBm..+20dBm, 127=Not Available.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern llStatus_t LL_ReadRssi( uint16 connId,
                               int8   *lastRssi );



/*******************************************************************************
 * @fn          LL_Disconnect API
 *
 * @brief       This API is called by the HCI to terminate a LL connection.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID on which to send this data.
 * @param       reason - The reason for the Host connection termination.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_INACTIVE_CONNECTION
 *              LL_STATUS_ERROR_CTRL_PROC_ALREADY_ACTIVE
 */
extern llStatus_t LL_Disconnect( uint16 connId,
                                 uint8  reason );




/*******************************************************************************
 * @fn          LL_TxData API
 *
 * @brief       This API is called by the HCI to transmit a buffer of data on a
 *              given LL connection. If fragmentation is supported, the HCI must
 *              also indicate whether this is the first Host packet, or a
 *              continuation Host packet. When fragmentation is not supported,
 *              then a start packet should always specified. If the device is in
 *              a connection as a Master and the current connection ID is the
 *              connection for this data, or is in a connection as a Slave, then
 *              the data is written to the TX FIFO (even if the radio is
 *              curerntly active). If this is a Slave connection, and Fast TX is
 *              enabled and Slave Latency is being used, then the amount of time
 *              to the next event is checked. If there's at least a connection
 *              interval plus some overhead, then the next event is re-aligned
 *              to the next event boundary. Otherwise, in all cases, the buffer
 *              pointer will be retained for transmission, and the callback
 *              event LL_TxDataCompleteCback will be generated to the HCI when
 *              the buffer pointer is no longer needed by the LL.
 *
 *              Note: If the return status is LL_STATUS_ERROR_OUT_OF_TX_MEM,
 *                    then the HCI must not release the buffer until it receives
 *                    the LL_TxDataCompleteCback callback, which indicates the
 *                    LL has copied the transmit buffer.
 *
 *              Note: The HCI should not call this routine if a buffer is still
 *                    pending from a previous call. This is fatal!
 *
 *              Note: If the connection should be terminated within the LL
 *                    before the Host knows, attempts by the HCI to send more
 *                    data (after receiving a LL_TxDataCompleteCback) will
 *                    fail (LL_STATUS_ERROR_INACTIVE_CONNECTION).
 *
 * input parameters
 *
 * @param       connId   - The LL connection ID on which to send this data.
 * @param       *pBuf    - A pointer to the data buffer to transmit.
 * @param       len      - The number of bytes to transmit on this connection.
 * @param       fragFlag - LL_DATA_FIRST_PKT_HOST_TO_CTRL:
 *                           Indicates buffer is the start of a
 *                           Host-to-Controller packet.
 *                         LL_DATA_CONTINUATION_PKT:
 *                           Indicates buffer is a continuation of a
 *                           Host-to-Controller packet.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_INACTIVE_CONNECTION,
 *              LL_STATUS_ERROR_OUT_OF_TX_MEM,
 *              LL_STATUS_ERROR_UNEXPECTED_PARAMETER
 */
extern llStatus_t LL_TxData( uint16 connId,
                             uint8  *pBuf,
                             uint8  len,
                             uint8  fragFlag );



/*******************************************************************************
 * @fn          LL_DirectTestTxTest API
 *
 * @brief       This function is used to initiate a BLE PHY level Transmit Test
 *              in Direct Test Mode where the DUT generates test reference
 *              packets at fixed intervals. This test will make use of the
 *              nanoRisc Raw Data Transmit and Receive task.
 *
 *              Note: The BLE device is to transmit at maximum power.
 *              Note: A LL reset should be issued when done using DTM!
 *
 * input parameters
 *
 * @param       txFreq      - Tx RF frequency k=0..39, where F=2402+(k*2MHz).
 * @param       payloadLen  - Number of bytes (0..37)in payload for each packet.
 * @param       payloadType - The type of pattern to transmit.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE
 */
extern llStatus_t LL_DirectTestTxTest( uint8 txFreq,
                                       uint8 payloadLen,
                                       uint8 payloadType );


/*******************************************************************************
 * @fn          LL_DirectTestRxTest API
 *
 * @brief       This function is used to initiate a BLE PHY level Receive Test
 *              in Direct Test Mode where the DUT receives test reference
 *              packets at fixed intervals. This test will make use of the
 *              nanoRisc Raw Data Transmit and Receive task. The received
 *              packets are verified based on the CRC, and metrics are kept.
 *
 *              Note: A LL reset should be issued when done using DTM!
 *
 * input parameters
 *
 * @param       rxFreq - Rx RF frequency k=0..39, where F=2402+(k*2MHz).
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE
 */
extern llStatus_t LL_DirectTestRxTest( uint8 rxFreq );


/*******************************************************************************
 * @fn          LL_DirectTestEnd API
 *
 * @brief       This function is used to end the Direct Test Transmit or Direct
 *              Test Receive tests executing in Direct Test mode. When the raw
 *              task is ended, the LL_DirectTestEndDoneCback callback is called.
 *              If a Direct Test mode operation is not currently active, an
 *              error is returned.
 *
 *              Note: A LL reset is issued upon completion!
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE
 */
extern llStatus_t LL_DirectTestEnd( void );



/*******************************************************************************
 * @fn          LL_SetAdvParam API
 *
 * @brief       This API is called by the HCI to set the Advertiser's
 *              parameters.
 *
 * input parameters
 * @param       advIntervalMin - The minimum Adv interval.
 * @param       advIntervalMax - The maximum Adv interval.
 * @param       advEvtType     - The type of advertisment event.
 * @param       ownAddrType    - The Adv's address type of public or random.
 * @param       directAddrType - Only used for directed advertising.
 * @param       *directAddr    - Only used for directed advertising (NULL otherwise).
 * @param       advChanMap     - A byte containing 1 bit per advertising
 *                               channel. A bit set to 1 means the channel is
 *                               used. The bit positions define the advertising
 *                               channels as follows:
 *                               Bit 0: 37, Bit 1: 38, Bit 2: 39.
 * @param       advWlPolicy    - The Adv white list filter policy.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_NO_ADV_CHAN_FOUND
 */
extern llStatus_t LL_SetAdvParam( uint16 advIntervalMin,
                                  uint16 advIntervalMax,
                                  uint8  advEvtType,
                                  uint8  ownAddrType,
                                  uint8  directAddrType,
                                  uint8  *directAddr,
                                  uint8  advChanMap,
                                  uint8  advWlPolicy );




/*******************************************************************************
 * @fn          LL_SetAdvData API
 *
 * @brief       This API is called by the HCI to set the Advertiser's data.
 *
 *              Note: If the Advertiser is restarted without intervening calls
 *                    to this routine to make updates, then the previously
 *                    defined data will be reused.
 *
 *              Note: If the data happens to be changed while advertising, then
 *                    the new data will be sent on the next advertising event.
 *
 * input parameters
 *
 * @param       advDataLen - The number of scan response bytes: 0..31.
 * @param       advData    - Pointer to the advertiser data, or NULL.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_SetAdvData( uint8 advDataLen,
                                 uint8 *advData );




/*******************************************************************************
 * @fn          LL_SetScanRspData API
 *
 * @brief       This API is called by the HCI to set the Advertiser's Scan
 *              Response data.
 *
 *              Note: If the Advertiser is restarted without intervening calls
 *                    to this routine to make updates, then the previously
 *                    defined data will be reused.
 *
 * input parameters
 *
 * @param       scanRspLen   - The number of scan response bytes: 0..31.
 * @param       *scanRspData - Pointer to the scan response data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_SetScanRspData( uint8 scanRspLen,
                                     uint8 *scanRspData );




/*******************************************************************************
 * @fn          LL_SetAdvControl API
 *
 * @brief       This API is called by the HCI to request the Controller to start
 *              or stop advertising.
 *
 * input parameters
 *
 * @param       advMode - LL_ADV_MODE_ON or LL_ADV_MODE_OFF.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_UNEXPECTED_PARAMETER,
 *              LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE,
 *              LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_SetAdvControl( uint8 advMode );




/*******************************************************************************
 * @fn          LL_ReadAdvChanTxPower
 *
 * @brief       This function is used to read the transmit power level used
 *              for BLE advertising channel packets. Currently, only two
 *              settings are possible, a standard setting of 0 dBm, and a
 *              maximum setting of 4 dBm.
 *
 * input parameters
 *
 * @param       *txPower - A non-null pointer.
 *
 * output parameters
 *
 * @param       *txPower - A signed value from -20..+10, in dBm.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_PARAM_OUT_OF_RANGE
 */
extern llStatus_t LL_ReadAdvChanTxPower( int8 *txPower );



#line 1215 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"


#line 1244 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"



/*******************************************************************************
 * @fn          LL_EncLtkReply API
 *
 * @brief       This API is called by the HCI to provide the controller with
 *              the Long Term Key (LTK) for encryption. This command is
 *              actually a reply to the link layer's LL_EncLtkReqCback, which
 *              provided the random number and encryption diversifier received
 *              from the Master during an encryption setup.
 *
 *              Note: The key parameter is byte ordered LSO to MSO.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID on which to send this data.
 * @param       *key   - A 128 bit key to be used to calculate the session key.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_EncLtkReply( uint16 connId,
                                  uint8  *key );




/*******************************************************************************
 * @fn          LL_EncLtkNegReply API
 *
 * @brief       This API is called by the HCI to indicate to the controller
 *              that the Long Term Key (LTK) for encryption can not be provided.
 *              This command is actually a reply to the link layer's
 *              LL_EncLtkReqCback, which provided the random number and
 *              encryption diversifier received from the Master during an
 *              encryption setup. How the LL responds to the negative reply
 *              depends on whether this is part of a start encryption or a
 *              re-start encryption after a pause. For the former, an
 *              encryption request rejection is sent to the peer device. For
 *              the latter, the connection is terminated.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID on which to send this data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_EncLtkNegReply( uint16 connId );




/*******************************************************************************
 * @fn          LL_CreateConn API
 *
 * @brief       This API is called by the HCI to create a connection.
 *
 * input parameters
 *
 * @param       scanInterval    - The scan interval.
 * @param       scanWindow      - The scan window.
 * @param       initWlPolicy    - Filter Adv address directly or using WL.
 * @param       peerAddrType    - Peer address is Public or Random.
 * @param       *peerAddr       - The Adv address, or NULL for WL policy.
 * @param       ownAddrType     - This device's address is Public or Random.
 * @param       connIntervalMin - Defines minimum connection interval value.
 * @param       connIntervalMax - Defines maximum connection interval value.
 * @param       connLatency     - The connection's Slave Latency.
 * @param       connTimeout     - The connection's Supervision Timeout.
 * @param       minLength       - Info parameter about min length of connection.
 * @param       maxLength       - Info parameter about max length of connection.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE,
 *              LL_STATUS_ERROR_ILLEGAL_PARAM_COMBINATION,
 *              LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_CreateConn( uint16 scanInterval,
                                 uint16 scanWindow,
                                 uint8  initWlPolicy,
                                 uint8  peerAddrType,
                                 uint8  *peerAddr,
                                 uint8  ownAddrType,
                                 uint16 connIntervalMin,
                                 uint16 connIntervalMax,
                                 uint16 connLatency,
                                 uint16 connTimeout,
                                 uint16 minLength,
                                 uint16 maxLength );




/*******************************************************************************
 * @fn          LL_CreateConnCancel API
 *
 * @brief       This API is called by the HCI to cancel a previously given LL
 *              connection creation command that is still pending. This command
 *              should only be used after the LL_CreateConn command as been
 *              issued, but before the LL_ConnComplete callback.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_CreateConnCancel( void );




/*******************************************************************************
 * @fn          LL_ConnActive
 *
 * @brief       This API is called by the HCI to check if a connection
 *              given by the connection handle is active.
 *
 * input parameters
 *
 * @param       connId - Connection handle.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern llStatus_t LL_ConnActive( uint16 connId );




/*******************************************************************************
 * @fn          LL_ConnUpdate API
 *
 * @brief       This API is called by the HCI to update the connection
 *              parameters by initiating a connection update control procedure.
 *
 * input parameters
 *
 * @param       connId          - The connection ID on which to send this data.
 * @param       connIntervalMin - Defines minimum connection interval value.
 * @param       connIntervalMax - Defines maximum connection interval value.
 * @param       connLatency     - The connection's Slave Latency.
 * @param       connTimeout     - The connection's Supervision Timeout.
 * @param       minLength       - Info parameter about min length of connection.
 * @param       maxLength       - Info parameter about max length of connection.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_INACTIVE_CONNECTION
 *              LL_STATUS_ERROR_CTRL_PROC_ALREADY_ACTIVE,
 *              LL_STATUS_ERROR_ILLEGAL_PARAM_COMBINATION
 */
extern llStatus_t LL_ConnUpdate( uint16 connId,
                                 uint16 connIntervalMin,
                                 uint16 connIntervalMax,
                                 uint16 connLatency,
                                 uint16 connTimeout,
                                 uint16 minLength,
                                 uint16 maxLength );




/*******************************************************************************
 * @fn          LL_ChanMapUpdate API
 *
 * @brief       This API is called by the HCI to update the Host data channels
 *              initiating an Update Data Channel control procedure.
 *
 *              Note: While it isn't specified, it is assumed that the Host
 *                    expects an update channel map on all active connections.
 *
 *              Note: This LL currently only supports one connection.
 *
 * input parameters
 *
 * @param       chanMap - A five byte array containing one bit per data channel
 *                        where a 1 means the channel is "used".
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_ILLEGAL_PARAM_COMBINATION
 */
extern llStatus_t LL_ChanMapUpdate( uint8 *chanMap );




/*******************************************************************************
 * @fn          LL_StartEncrypt API
 *
 * @brief       This API is called by the Master HCI to setup encryption and to
 *              update encryption keys in the LL connection. If the connection
 *              is already in encryption mode, then this command will first
 *              pause the encryption before subsequently running the encryption
 *              setup.
 *
 *              Note: The parameters are byte ordered LSO to MSO.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID on which to send this data.
 * @param       *rand  - Random vector used in device identification.
 * @param       *eDiv  - Encrypted diversifier.
 * @param       *key   - A 128 bit key to be used to calculate the session key.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_FEATURE_NOT_SUPPORTED
 */
extern llStatus_t LL_StartEncrypt( uint16 connId,
                                   uint8  *rand,
                                   uint8  *eDiv,
                                   uint8  *ltk );




/*******************************************************************************
 * @fn          LL_ReadRemoteUsedFeatures API
 *
 * @brief       This API is called by the Master HCI to initiate a feature
 *              setup control process.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID on which to send this data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_ReadRemoteUsedFeatures( uint16 connId );



/*
** Vendor Specific Command API
*/

/*******************************************************************************
 * @fn          LL_EXT_SetRxGain Vendor Specific API
 *
 * @brief       This function is used to to set the RF RX gain.
 *
 * input parameters
 *
 * @param       rxGain - LL_EXT_RX_GAIN_STD, LL_EXT_RX_GAIN_HIGH
 *
 * output parameters
 *
 * @param       cmdComplete - Boolean to indicate the command is still pending.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_SetRxGain( uint8 rxGain,
                                    uint8 *cmdComplete );


/*******************************************************************************
 * @fn          LL_EXT_SetTxPower Vendor Specific API
 *
 * @brief       This function is used to to set the RF TX power.
 *
 * input parameters
 *
 * @param       txPower - LL_EXT_TX_POWER_0_DBM, LL_EXT_TX_POWER_4_DBM
 *
 * output parameters
 *
 * @param       cmdComplete - Boolean to indicate the command is still pending.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_SetTxPower( uint8 txPower,
                                     uint8 *cmdComplete );



/*******************************************************************************
 * @fn          LL_EXT_OnePacketPerEvent Vendor Specific API
 *
 * @brief       This function is used to enable or disable allowing only one
 *              packet per event.
 *
 * input parameters
 *
 * @param       control - LL_EXT_ENABLE_ONE_PKT_PER_EVT,
 *                        LL_EXT_DISABLE_ONE_PKT_PER_EVT
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_OnePacketPerEvent( uint8 control );



/*******************************************************************************
 * @fn          LL_EXT_ClkDivOnHalt Vendor Specific API
 *
 * @brief       This function is used to enable or disable dividing down the
 *              system clock while halted.
 *
 *              Note: This command is disallowed if haltDuringRf is not defined.
 *
 * input parameters
 *
 * @param       control - LL_EXT_ENABLE_CLK_DIVIDE_ON_HALT,
 *                        LL_EXT_DISABLE_CLK_DIVIDE_ON_HALT
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_EXT_ClkDivOnHalt( uint8 control );


/*******************************************************************************
 * @fn          LL_EXT_DeclareNvUsage Vendor Specific API
 *
 * @brief       This HCI Extension API is used to indicate to the Controller
 *              whether or not the Host will be using the NV memory during BLE
 *              operations.
 *
 * input parameters
 *
 * @param       mode - HCI_EXT_NV_IN_USE, HCI_EXT_NV_NOT_IN_USE
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_EXT_DeclareNvUsage( uint8 mode );


/*******************************************************************************
 * @fn          LL_EXT_Decrypt API
 *
 * @brief       This API is called by the HCI to request the LL to decrypt the
 *              data in the command using the key given in the command.
 *
 *              Note: The parameters are byte ordered MSO to LSO.
 *
 * input parameters
 *
 * @param       *key           - A 128 bit key to be used to calculate the
 *                               session key.
 * @param       *encryptedData - A 128 bit block that is encrypted.
 *
 * output parameters
 *
 * @param       *plaintextData - A 128 bit block that is to be encrypted.
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_EXT_Decrypt( uint8 *key,
                                  uint8 *encryptedData,
                                  uint8 *plaintextData );


/*******************************************************************************
 * @fn          LL_EXT_SetLocalSupportedFeatures API
 *
 * @brief       This API is called by the HCI to indicate to the Controller
 *              which features can or can not be used.
 *
 *              Note: Not all features indicated by the Host to the Controller
 *                    are valid. If invalid, they shall be ignored.
 *
 * input parameters
 *
 * @param       featureSet  - A pointer to the Feature Set where each bit:
 *                            0: Feature shall not be used.
 *                            1: Feature can be used.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_EXT_SetLocalSupportedFeatures( uint8 *featureSet );



/*******************************************************************************
 * @fn          LL_EXT_SetFastTxResponseTime API
 *
 * @brief       This API is used to enable or disable the fast TX response
 *              time feature. This can be helpful when a short connection
 *              interval is used in combination with slave latency. In such
 *              a scenario, the response time for sending the TX data packet
 *              can effectively shorten or eliminate slave latency, thereby
 *              increasing power consumption. By disabling, this feature
 *              trades fast response time for less power consumption.
 *
 * input parameters
 *
 * @param       control - LL_EXT_ENABLE_FAST_TX_RESP_TIME,
 *                        LL_EXT_DISABLE_FAST_TX_RESP_TIME
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_COMMAND_DISALLOWED,
 *              LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_SetFastTxResponseTime( uint8 control );




/*******************************************************************************
 * @fn          LL_EXT_SetSlaveLatencyOverride API
 *
 * @brief       This API is used to enable or disable the suspention of slave
 *              latency. This can be helpful when the Slave application knows
 *              it will soon receive something that needs to be handled without
 *              delay.
 *
 * input parameters
 *
 * @param       control - LL_EXT_DISABLE_SL_OVERRIDE,
 *                        LL_EXT_ENABLE_SL_OVERRIDE
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_COMMAND_DISALLOWED,
 *              LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_SetSlaveLatencyOverride( uint8 control );



/*******************************************************************************
 * @fn          LL_EXT_ModemTestTx
 *
 * @brief       This API is used start a continuous transmitter modem test,
 *              using either a modulated or unmodulated carrier wave tone, at
 *              the frequency that corresponds to the specified RF channel. Use
 *              LL_EXT_EndModemTest command to end the test.
 *
 *              Note: A LL reset will be issued by LL_EXT_EndModemTest!
 *              Note: The BLE device will transmit at maximum power.
 *              Note: This API can be used to verify this device meets Japan's
 *                    TELEC regulations.
 *
 * input parameters
 *
 * @param       cwMode - LL_EXT_TX_MODULATED_CARRIER,
 *                       LL_EXT_TX_UNMODULATED_CARRIER
 *              txFreq - Transmit RF channel k=0..39, where BLE F=2402+(k*2MHz).
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE
 */
extern llStatus_t LL_EXT_ModemTestTx( uint8 cwMode,
                                      uint8 txFreq );


/*******************************************************************************
 * @fn          LL_EXT_ModemHopTestTx
 *
 * @brief       This API is used to start a continuous transmitter direct test
 *              mode test using a modulated carrier wave and transmitting a
 *              37 byte packet of Pseudo-Random 9-bit data. A packet is
 *              transmitted on a different frequency (linearly stepping through
 *              all RF channels 0..39) every 625us. Use LL_EXT_EndModemTest
 *              command to end the test.
 *
 *              Note: A LL reset will be issued by LL_EXT_EndModemTest!
 *              Note: The BLE device will transmit at maximum power.
 *              Note: This API can be used to verify this device meets Japan's
 *                    TELEC regulations.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE
 */
extern llStatus_t LL_EXT_ModemHopTestTx( void );


/*******************************************************************************
 * @fn          LL_EXT_ModemTestRx
 *
 * @brief       This API is used to start a continuous receiver modem test
 *              using a modulated carrier wave tone, at the frequency that
 *              corresponds to the specific RF channel. Any received data is
 *              discarded. Receiver gain may be adjusted using the
 *              LL_EXT_SetRxGain command. RSSI may be read during this test by
 *              using the LL_ReadRssi command. Use LL_EXT_EndModemTest command
 *              to end the test.
 *
 *              Note: A LL reset will be issued by LL_EXT_EndModemTest!
 *              Note: The BLE device will transmit at maximum power.
 *
 * input parameters
 *
 * @param       rxFreq - Receiver RF channel k=0..39, where BLE F=2402+(k*2MHz).
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE
 */
extern llStatus_t LL_EXT_ModemTestRx( uint8 rxFreq );


/*******************************************************************************
 * @fn          LL_EXT_EndModemTest
 *
 * @brief       This API is used to shutdown a modem test. A complete link
 *              layer reset will take place.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_UNEXPECTED_STATE_ROLE
 */
extern llStatus_t LL_EXT_EndModemTest( void );


/*******************************************************************************
 * @fn          LL_EXT_SetBDADDR
 *
 * @brief       This API is used to set this device's BLE address (BDADDR).
 *
 *              Note: This command is only allowed when the device's state is
 *                    Standby.
 *
 * input parameters
 *
 * @param       bdAddr  - A pointer to a buffer to hold this device's address.
 *                        An invalid address (i.e. all FF's) will restore this
 *                        device's address to the address set at initialization.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_EXT_SetBDADDR( uint8 *bdAddr );



/*******************************************************************************
 * @fn          LL_EXT_SetSCA
 *
 * @brief       This API is used to set this device's Sleep Clock Accuracy.
 *
 *              Note: For a slave device, this value is directly used, but only
 *                    if power management is enabled. For a master device, this
 *                    value is converted into one of eight ordinal values
 *                    representing a SCA range, as specified in Table 2.2,
 *                    Vol. 6, Part B, Section 2.3.3.1 of the Core specification.
 *
 *              Note: This command is only allowed when the device is not in a
 *                    connection.
 *
 *              Note: The device's SCA value remains unaffected by a HCI_Reset.
 *
 * input parameters
 *
 * @param       scaInPPM - This device's SCA in PPM from 0..500.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_EXT_SetSCA( uint16 scaInPPM );



/*******************************************************************************
 * @fn          LL_EXT_SetFreqTune
 *
 * @brief       This API is used to set the Frequncy Tuning up or down. If the
 *              current setting is already at the max/min value, then no
 *              update is performed.
 *
 *              Note: This is a Production Test Mode only command!
 *
 * input parameters
 *
 * @param       step - LL_EXT_SET_FREQ_TUNE_UP or LL_EXT_SET_FREQ_TUNE_DOWN
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_SetFreqTune( uint8 step );


/*******************************************************************************
 * @fn          LL_EXT_SaveFreqTune
 *
 * @brief       This API is used to save the current Frequency Tuning value to
 *              flash memory. It is restored on reboot or wake from sleep.
 *
 *              Note: This is a Production Test Mode only command!
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_EXT_SaveFreqTune( void );


/*******************************************************************************
 * @fn          LL_EXT_SetMaxDtmTxPower Vendor Specific API
 *
 * @brief       This function is used to set the max RF TX power to be used
 *              when using Direct Test Mode.
 *
 * input parameters
 *
 * @param       txPower - LL_EXT_TX_POWER_MINUS_23_DBM,
 *                        LL_EXT_TX_POWER_MINUS_6_DBM,
 *                        LL_EXT_TX_POWER_0_DBM,
 *                        LL_EXT_TX_POWER_4_DBM
 *
 * output parameters
 *
 * @param       cmdComplete - Boolean to indicate the command is still pending.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_SetMaxDtmTxPower( uint8 txPower );


/*******************************************************************************
 * @fn          LL_EXT_MapPmIoPort Vendor Specific API
 *
 * @brief       This function is used to configure and map a CC254x I/O Port as
 *              a General Purpose I/O (GPIO) output signal that reflects the
 *              Power Management (PM) state of the CC254x device. The GPIO
 *              output will be High on Wake, and Low upon entering Sleep. This
 *              feature can be disabled by specifying LL_EXT_PM_IO_PORT_NONE for
 *              the ioPort (ioPin is then ignored). The system default value
 *              upon hardware reset is disabled. This command can be used to
 *              control an external DC-DC Converter (its actual intent) such has
 *              the TI TPS62730 (or any similar converter that works the same
 *              way). This command should be used with extreme care as it will
 *              override how the Port/Pin was previously configured! This
 *              includes the mapping of Port 0 pins to 32kHz clock output,
 *              Analog I/O, UART, Timers; Port 1 pins to Observables, Digital
 *              Regulator status, UART, Timers; Port 2 pins to an external 32kHz
 *              XOSC. The selected Port/Pin will be configured as an output GPIO
 *              with interrupts masked. Careless use can result in a
 *              reconfiguration that could disrupt the system. It is therefore
 *              the user's responsibility to ensure the selected Port/Pin does
 *              not cause any conflicts in the system.
 *
 *              Note: Only Pins 0, 3 and 4 are valid for Port 2 since Pins 1
 *                    and 2 are mapped to debugger signals DD and DC.
 *
 *              Note: Port/Pin signal change will only occur when Power Savings
 *                    is enabled.
 *
 * input parameters
 *
 * @param       ioPort - LL_EXT_PM_IO_PORT_P0,
 *                       LL_EXT_PM_IO_PORT_P1,
 *                       LL_EXT_PM_IO_PORT_P2,
 *                       LL_EXT_PM_IO_PORT_NONE
 *
 * @param       ioPin  - LL_EXT_PM_IO_PORT_PIN0,
 *                       LL_EXT_PM_IO_PORT_PIN1,
 *                       LL_EXT_PM_IO_PORT_PIN2,
 *                       LL_EXT_PM_IO_PORT_PIN3,
 *                       LL_EXT_PM_IO_PORT_PIN4,
 *                       LL_EXT_PM_IO_PORT_PIN5,
 *                       LL_EXT_PM_IO_PORT_PIN6,
 *                       LL_EXT_PM_IO_PORT_PIN7
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER,
 *              LL_STATUS_ERROR_COMMAND_DISALLOWED
 */
extern llStatus_t LL_EXT_MapPmIoPort( uint8 ioPort, uint8 ioPin );



/*******************************************************************************
 * @fn          LL_EXT_DisconnectImmed Vendor Specific API
 *
 * @brief       This function is used to disconnect the connection immediately.
 *
 *              Note: The connection (if valid) is immediately terminated
 *                    without notifying the remote device. The Host is still
 *                    notified.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID on which to send this data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern llStatus_t LL_EXT_DisconnectImmed( uint16 connId );




/*******************************************************************************
 * @fn          LL_EXT_PacketErrorRate Vendor Specific API
 *
 * @brief       This function is used to Reset or Read the Packet Error Rate
 *              counters for a connection. When Reset, the counters are cleared;
 *              when Read, the total number of packets received, the number of
 *              packets received with a CRC error, the number of events, and the
 *              number of missed events are returned via a callback.
 *
 *              Note: The counters are only 16 bits. At the shortest connection
 *                    interval, this provides a bit over 8 minutes of data.
 *
 * input parameters
 *
 * @param       connId  - The LL connection ID on which to send this data.
 * @param       command - LL_EXT_PER_RESET, LL_EXT_PER_READ
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern llStatus_t LL_EXT_PacketErrorRate( uint16 connId, uint8 command );




/*******************************************************************************
 * @fn          LL_EXT_PERbyChan Vendor Specific API
 *
 * @brief       This API is called by the HCI to start or end Packet Error Rate
 *              by Channel counter accumulation for a connection. If the
 *              pointer is not NULL, it is assumed there is sufficient memory
 *              for the PER data, per the type perByChan_t. If NULL, then
 *              the operation is considered disabled.
 *
 *              Note: It is the user's responsibility to make sure there is
 *                    sufficient memory for the data, and that the counters
 *                    are cleared prior to first use.
 *
 *              Note: The counters are only 16 bits. At the shortest connection
 *                    interval, this provides a bit over 8 minutes of data.
 *
 * input parameters
 *
 * @param       connId    - The LL connection ID on which to send this data.
 * @param       perByChan - Pointer to PER by Channel data, or NULL.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern llStatus_t LL_EXT_PERbyChan( uint16 connId, perByChan_t *perByChan );



/*******************************************************************************
 * @fn          LL_EXT_ExtendRfRange Vendor Specific API
 *
 * @brief       This function is used to Extend Rf Range using the TI CC2590
 *              2.4 GHz RF Front End device.
 *
 * input parameters
 *
 * @param       cmdComplete - Pointer to get indicatin if command is done.
 *
 * output parameters
 *
 * @param       cmdComplete - Boolean to indicate the command is still pending.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern llStatus_t LL_EXT_ExtendRfRange( uint8 *cmdComplete );


/*******************************************************************************
 * @fn          LL_EXT_HaltDuringRf Vendor Specfic API
 *
 * @brief       This function is used to enable or disable halting the
 *              CPU during RF. The system defaults to enabled.
 *
 * input parameters
 *
 * @param       mode - LL_EXT_HALT_DURING_RF_ENABLE,
 *                     LL_EXT_HALT_DURING_RF_DISABLE
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_COMMAND_DISALLOWED,
 *              LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_HaltDuringRf( uint8 mode );



/*******************************************************************************
 * @fn          LL_EXT_AdvEventNotice Vendor Specific API
 *
 * @brief       This API is called to enable or disable a notification to the
 *              specified task using the specified task event whenever a Adv
 *              event ends. A non-zero taskEvent value is taken to be "enable",
 *              while a zero valued taskEvent is taken to be "disable".
 *
 * input parameters
 *
 * @param       taskID    - User's task ID.
 * @param       taskEvent - User's task event.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_AdvEventNotice( uint8 taskID, uint16 taskEvent );




/*******************************************************************************
 * @fn          LL_EXT_ConnEventNotice Vendor Specific API
 *
 * @brief       This API is called to enable or disable a notification to the
 *              specified task using the specified task event whenever a
 *              Connection event ends. A non-zero taskEvent value is taken to
 *              be "enable", while a zero valued taskEvent is taken to be
 *              "disable".
 *
 *              Note: Currently, only a Slave connection is supported.
 *
 * input parameters
 *
 * @param       taskID    - User's task ID.
 * @param       taskEvent - User's task event.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_INACTIVE_CONNECTION,
 *              LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_ConnEventNotice( uint8 taskID, uint16 taskEvent );



/*******************************************************************************
 * @fn          LL_EXT_BuildRevision Vendor Specific API
 *
 * @brief       This API is used to to set a user revision number or read the
 *              build revision number.
 *
 * input parameters
 *
 * @param       mode       - LL_EXT_SET_USER_REVISION |
 *                           LL_EXT_READ_BUILD_REVISION
 * @param       userRevNum - A 16 bit value the user can set as their own
 *                           revision number
 *
 * output parameters
 *
 * @param       buildRev   - Pointer to returned build revision, if any.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_BAD_PARAMETER
 */
extern llStatus_t LL_EXT_BuildRevision( uint8 mode, uint16 userRevNum, uint8 *buildRev );


/*
**  LL Callbacks to HCI
*/


/*******************************************************************************
 * @fn          LL_ConnectionCompleteCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the Host that
 *              a new connection has been created. For the Slave, this means
 *              a CONNECT_REQ message was received from an Initiator. For the
 *              Master, this means a CONNECT_REQ message was sent in response
 *              to a directed or undirected message addressed to the Initiator.
 *
 * input parameters
 *
 * @param       reasonCode    - LL_STATUS_SUCCESS or ?
 * @param       connId        - The LL connection ID for new connection.
 * @param       role          - LL_LINK_CONNECT_COMPLETE_MASTER or
 *                              LL_LINK_CONNECT_COMPLETE_SLAVE.
 * @param       peerAddrType  - Peer address type (public or random).
 * @param       peerAddr      - Peer address.
 * @param       connInterval  - Connection interval.
 * @param       slaveLatency  - The connection's Slave Latency.
 * @param       connTimeout   - The connection's Supervision Timeout.
 * @param       clockAccuracy - The sleep clock accurracy of the Master. Only
 *                              valid on the Slave. Set to 0x00 for the Master.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_ConnectionCompleteCback( uint8  reasonCode,
                                        uint16 connId,
                                        uint8  role,
                                        uint8  peerAddrType,
                                        uint8  *peerAddr,
                                        uint16 connInterval,
                                        uint16 slaveLatency,
                                        uint16 connTimeout,
                                        uint8  clockAccuracy );




/*******************************************************************************
 * @fn          LL_DisconnectCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the Host that
 *              the connection has been terminated. The cause is given by the
 *              reason code.
 *
 * input parameters
 *
 * @param       connId - The LL connection ID.
 * @param       reason - The reason the connection was terminated.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_DisconnectCback( uint16 connId,
                                uint8  reason );




/*******************************************************************************
 * @fn          LL_ConnParamUpdateCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the Host that
 *              the update parameters control procedure has completed. It is
 *              always made to the Master's Host when the update request has
 *              been sent. It is only made to the Slave's Host when the update
 *              results in a change to the connection interval, and/or the
 *              connection latency, and/or the connection timeout.
 *
 * input parameters
 *
 * @param       connId       - The LL connection ID.
 * @param       connInterval - Connection interval.
 * @param       connLatency  - The connection's Slave Latency.
 * @param       connTimeout  - The connection's Supervision Timeout.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_ConnParamUpdateCback( uint16 connId,
                                     uint16 connInterval,
                                     uint16 connLatency,
                                     uint16 connTimeout );




/*******************************************************************************
 * @fn          LL_ReadRemoteVersionInfoCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the Host the
 *              requested peer's Version information.
 *
 * input parameters
 *
 * @param       status    - Status of callback.
 * @param       connId    - The LL connection ID.
 * @param       verNum    - Version of the Bluetooth Controller specification.
 * @param       comId     - Company identifier of the manufacturer of the
 *                          Bluetooth Controller.
 * @param       subverNum - A unique value for each implementation or revision
 *                          of an implementation of the Bluetooth Controller.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_ReadRemoteVersionInfoCback( uint8  status,
                                           uint16 connId,
                                           uint8  verNum,
                                           uint16 comId,
                                           uint16 subverNum );




/*******************************************************************************
 * @fn          LL_EncChangeCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the Host that
 *              an encryption change has taken place. This results when
 *              the host performs a LL_StartEncrypt when encryption is not
 *              already enabled.
 *
 *              Note: If the key request was rejected, then encryption will
 *                    remain off.
 *
 * input parameters
 *
 * @param       connId  - The LL connection ID for new connection.
 * @param       reason  - LL_ENC_KEY_REQ_ACCEPTED or LL_ENC_KEY_REQ_REJECTED.
 * @param       encEnab - LL_ENCRYPTION_OFF or LL_ENCRYPTION_ON.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_EncChangeCback( uint16 connId,
                               uint8  reason,
                               uint8  encEnab );




/*******************************************************************************
 * @fn          LL_EncKeyRefreshCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the Host that
 *              an encryption key change has taken place. This results when
 *              the host performs a LL_StartEncrypt when encryption is already
 *              enabled.
 *
 * input parameters
 *
 * @param       connId  - The LL connection ID for new connection.
 * @param       reason  - LL_ENC_KEY_REQ_ACCEPTED.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_EncKeyRefreshCback( uint16 connId,
                                   uint8  reason );



#line 2416 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll.h"



/*******************************************************************************
 * @fn          LL_ReadRemoteUsedFeaturesCompleteCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the Host that
 *              the Read Remote Feature Support command as completed.
 *
 * input parameters
 *
 * @param       status      - SUCCESS or control procedure timeout.
 * @param       connId      - The LL connection ID for new connection.
 * @param       featureSet  - A pointer to the Feature Set.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_ReadRemoteUsedFeaturesCompleteCback( uint8  status,
                                                    uint16 connId,
                                                    uint8  *featureSet );




/*******************************************************************************
 * @fn          LL_EncLtkReqCback Callback
 *
 * @brief       This Callback is used by the LL to provide to the Host the
 *              Master's random number and encryption diversifier, and to
 *              request the Host's Long Term Key (LTK).
 *
 * input parameters
 *
 * @param       connId  - The LL connection ID for new connection.
 * @param       randNum - Random vector used in device identification.
 * @param       encDiv  - Encrypted diversifier.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_EncLtkReqCback( uint16 connId,
                               uint8  *randNum,
                               uint8  *encDiv );



/*******************************************************************************
 * @fn          LL_DirectTestEndDone Callback
 *
 * @brief       This Callback is used by the LL to notify the HCI that the
 *              Direct Test End command has completed.
 *
 *
 * input parameters
 *
 * @param       numPackets - The number of packets received. Zero for transmit.
 * @param       mode       - LL_DIRECT_TEST_MODE_TX or LL_DIRECT_TEST_MODE_RX.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS
 */
extern void LL_DirectTestEndDoneCback( uint16 numPackets,
                                       uint8  mode );



/*******************************************************************************
 * @fn          LL_TxDataCompleteCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the HCI that
 *              the HCI's buffer is free for its own use again.
 *
 * input parameters
 *
 * @param       connId   - The LL connection ID on which to send this data.
 * @param       *pBuf    - A pointer to the data buffer to transmit, or NULL.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 ******************************************************************************/
extern void LL_TxDataCompleteCback( uint16 connId,
                                    uint8  *pBuf );




/*******************************************************************************
 * @fn          LL_RxReqDataBufCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the HCI that a
 *              receive data buffer of a given size is needed.
 *
 * input parameters
 *
 * @param       size - Number of bytes in the payload.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      Pointer to allocated buffer, or NULL.
 */
extern uint8 *LL_RxReqDataBufCback( uint8 size );




/*******************************************************************************
 * @fn          LL_RxDataCompleteCback Callback
 *
 * @brief       This Callback is used by the LL to indicate to the HCI that
 *              data has been received and placed in the buffer provided by
 *              the HCI.
 *
 * input parameters
 *
 * @param       connId   - The LL connection ID on which data was received.
 * @param       *pBuf    - A pointer to the receive data buffer provided by
 *                           the HCI.
 * @param       len      - The number of bytes received on this connection.
 * @param       fragFlag - LL_DATA_FIRST_PKT indicates buffer is the start of
 *                           a Host packet.
 *                         LL_DATA_CONTINUATION_PKT: Indicates buffer is a
 *                           continuation of a Host packet.
 * @param       rssi     - The RSSI of this received packet as a signed byte.
 *                         Range: -127dBm..+20dBm, 127=Not Available.
 *
 * output parameters
 *
 * @param       **pBuf   - A double pointer updated to the next receive data
 *                         buffer, or NULL if no next buffer is available.
 *
 * @return      None.
 */
extern void LL_RxDataCompleteCback( uint16 connId,
                                    uint8  *ppBuf,
                                    uint8  len,
                                    uint8  fragFlag,
                                    int8   rssi );



/*******************************************************************************
 * @fn          LL_RandCback API
 *
 * @brief       This Callback is used by the LL to notify the HCI that the true
 *              random number command has been completed.
 *
 *              Note: The length is always given by B_RANDOM_NUM_SIZE.
 *
 * input parameters
 *
 * @param       *randData - Pointer to buffer to place a random block of data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_RandCback( uint8 *randData );


/*******************************************************************************
 * @fn          LL_EXT_SetRxGainCback Callback
 *
 * @brief       This Callback is used by the LL to notify the HCI that the set
 *              RX gain command has been completed.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_EXT_SetRxGainCback( void );


/*******************************************************************************
 * @fn          LL_EXT_SetTxPowerCback Callback
 *
 * @brief       This Callback is used by the LL to notify the HCI that the set
 *              TX power command has been completed.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_EXT_SetTxPowerCback( void );


/*******************************************************************************
 * @fn          LL_EXT_PacketErrorRateCback Callback
 *
 * @brief       This Callback is used by the LL to notify the HCI that the
 *              Packet Error Rate Read command has been completed.
 *
 *              Note: The counters are only 16 bits. At the shortest connection
 *                    interval, this provides a bit over 8 minutes of data.
 *
 * input parameters
 *
 * @param       numPkts   - Number of Packets received.
 * @param       numCrcErr - Number of Packets received with a CRC error.
 * @param       numEvents - Number of Connection Events.
 * @param       numPkts   - Number of Missed Connection Events.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_EXT_PacketErrorRateCback( uint16 numPkts,
                                         uint16 numCrcErr,
                                         uint16 numEvents,
                                         uint16 numMissedEvts );


/*******************************************************************************
 * @fn          LL_EXT_ExtendRfRangeCback Callback
 *
 * @brief       This Callback is used by the LL to notify the HCI that the
 *              Extend Rf Range command has been completed.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void LL_EXT_ExtendRfRangeCback( void );








#line 58 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_assert.h"
/**************************************************************************************************
  Filename:       hal_assert.h
  Revised:        $Date: 2009-02-16 18:03:22 -0800 (Mon, 16 Feb 2009) $
  Revision:       $Revision: 19172 $

  Description:    Describe the purpose and contents of the file.


  Copyright 2006-2007 Texas Instruments Incorporated. All rights reserved.

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
 *                                           Macros
 * ------------------------------------------------------------------------------------------------
 */

/*
 *  HAL_ASSERT( expression ) - The given expression must evaluate as "true" or else the assert
 *  handler is called.  From here, the call stack feature of the debugger can pinpoint where
 * the problem occurred.
 *
 *  HAL_ASSERT_FORCED( ) - If asserts are in use, immediately calls the assert handler.
 *
 *  HAL_ASSERT_STATEMENT( statement ) - Inserts the given C statement but only when asserts
 *  are in use.  This macros allows debug code that is not part of an expression.
 *
 *  HAL_ASSERT_DECLARATION( declaration ) - Inserts the given C declaration but only when asserts
 *  are in use.  This macros allows debug code that is not part of an expression.
 *
 *  Asserts can be disabled for optimum performance and minimum code size (ideal for
 *  finalized, debugged production code).  To disable, define the preprocessor
 *  symbol HALNODEBUG at the project level.
 */


#line 78 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_assert.h"


/*
 *  This macro compares the size of the first parameter to the integer value
 *  of the second parameter.  If they do not match, a compile time error for
 *  negative array size occurs (even gnu chokes on negative array size).
 *
 *  This compare is done by creating a typedef for an array.  No variables are
 *  created and no memory is consumed with this check.  The created type is
 *  used for checking only and is not for use by any other code.  The value
 *  of 10 in this macro is arbitrary, it just needs to be a value larger
 *  than one to result in a positive number for the array size.
 */



/* ------------------------------------------------------------------------------------------------
 *                                          Prototypes
 * ------------------------------------------------------------------------------------------------
 */
void halAssertHandler(void);


/**************************************************************************************************
 */

/**************************************************************************************************
 *                                        FUNCTIONS - API
 **************************************************************************************************/


extern void halAssertHazardLights(void);
#line 59 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"

/*******************************************************************************
 * MACROS
 */

/*******************************************************************************
 * CONSTANTS
 */

/*
** HCI Status
**
** Per the Bluetooth Core Specification, V4.0.0, Vol. 2, Part D.
*/
#line 137 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"

/*
** HCI Command API Parameters
*/

// Send Data Packet Boundary Flags




// Receive Data Packet


// Disconnect Reasons
#line 158 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"

// Tx Power Types



// Host Flow Control





// Device Address Type



// Advertiser Events





// Advertiser Channels





// Advertiser White List Policy





// Advertiser Commands



// Scan Types



// Scan White List Policy



// Scan Filtering



// Scan Commands



// Initiator White List Policy



// Encryption Related



// Direct Test Mode


//
#line 231 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"

// Vendor Specific


//




//


//


//


//


//


//


//


//




//
#line 275 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"
//


//


//



/*
** HCI Event Parameters
*/

// HCI Link Type for Buffer Overflow



/*******************************************************************************
 * TYPEDEFS
 */

typedef uint8 hciStatus_t;

/*
** LE Events
*/

// LE Connection Complete Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  BLEEventCode;
  uint8  status;
  uint16 connectionHandle;
  uint8  role;
  uint8  peerAddrType;
  uint8  peerAddr[6];
  uint16 connInterval;
  uint16 connLatency;
  uint16 connTimeout;
  uint8  clockAccuracy;
} hciEvt_BLEConnComplete_t;

// LE Advertising Report Event
typedef struct
{
  uint8  eventType;                       // advertisment or scan response event type
  uint8  addrType;                        // public or random address type
  uint8  addr[6];                // device address
  uint8  dataLen;                         // length of report data
  uint8  rspData[31];          // report data given by dataLen
  int8   rssi;                            // report RSSI
} hciEvt_DevInfo_t;

typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  BLEEventCode;
  uint8  numDevices;
  hciEvt_DevInfo_t* devInfo;              // pointer to the array of devInfo
} hciEvt_BLEAdvPktReport_t;

// LE Connection Update Complete Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  BLEEventCode;
  uint8  status;
  uint16 connectionHandle;
  uint16 connInterval;
  uint16 connLatency;
  uint16 connTimeout;
} hciEvt_BLEConnUpdateComplete_t;

// LE Read Remote Used Features Complete Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  BLEEventCode;
  uint8  status;
  uint16 connectionHandle;
  uint8  features[8];
} hciEvt_BLEReadRemoteFeatureComplete_t;

// LE Encryption Change Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  BLEEventCode;
  uint16 connHandle;
  uint8  reason;
  uint8  encEnable;
} hciEvt_EncryptChange_t;

// LE Long Term Key Requested Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  BLEEventCode;
  uint16 connHandle;
  uint8  random[8];
  uint16 encryptedDiversifier;
} hciEvt_BLELTKReq_t;

// Number of Completed Packets Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  numHandles;
  uint16 *pConnectionHandle;              // pointer to the connection handle array
  uint16 *pNumCompletedPackets;           // pointer to the number of completed packets array
} hciEvt_NumCompletedPkt_t;

// Command Complete Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  numHciCmdPkt;                    // number of HCI Command Packet
  uint16 cmdOpcode;
  uint8  *pReturnParam;                    // pointer to the return parameter
} hciEvt_CmdComplete_t;

// Command Status Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  cmdStatus;
  uint8  numHciCmdPkt;
  uint16 cmdOpcode;
} hciEvt_CommandStatus_t;

// Hardware Error Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8 hardwareCode;
} hciEvt_HardwareError_t;

// Disconnection Complete Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8  status;
  uint16 connHandle;                      // connection handle
  uint8  reason;
} hciEvt_DisconnComplete_t;

// Data Buffer Overflow Event
typedef struct
{
  osal_event_hdr_t  hdr;
  uint8 linkType;                         // synchronous or asynchronous buffer overflow
} hciEvt_BufferOverflow_t;

// Data structure for HCI Command Complete Event Return Parameter
typedef struct
{
  uint8  status;
  uint16 dataPktLen;
  uint8  numDataPkts;
} hciRetParam_LeReadBufSize_t;

typedef struct
{
  osal_event_hdr_t hdr;
  uint8            *pData;
} hciPacket_t;

typedef struct
{
  osal_event_hdr_t hdr;
  uint8  pktType;
  uint16 connHandle;
  uint8  pbFlag;
  uint16 pktLen;
  uint8  *pData;
} hciDataPacket_t;

// OSAL HCI_DATA_EVENT message format. This message is used to forward incoming
// data messages up to an application
typedef struct
{
  osal_event_hdr_t hdr;                   // OSAL event header
  uint16 connHandle;                      // connection handle
  uint8  pbFlag;                          // data packet boundary flag
  uint16 len;                             // length of data packet
  uint8  *pData;                          // data packet given by len
} hciDataEvent_t;

/*******************************************************************************
 * LOCAL VARIABLES
 */

/*******************************************************************************
 * GLOBAL VARIABLES
 */

/*
** HCI Support Functions
*/

/*******************************************************************************
 * @fn          HCI_bm_alloc API
 *
 * @brief       This API is used to allocate memory using buffer management.
 *
 *              Note: This function should never be called by the application.
 *                    It is only used by HCI and L2CAP_bm_alloc.
 *
 * input parameters
 *
 * @param       size - Number of bytes to allocate from the heap.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      Pointer to buffer, or NULL.
 */
extern void *HCI_bm_alloc( uint16 size );


/*******************************************************************************
 * @fn          HCI_ValidConnTimeParams API
 *
 * @brief       This API is used to check that the connection time parameter
 *              ranges are valid, and that the connection time parameter
 *              combination is valid.
 *
 *              Note: Only connIntervalMax is used as part of the time parameter
 *                    combination check.
 *
 * input parameters
 *
 * @param       connIntervalMin - Minimum connection interval.
 * @param       connIntervalMax - Maximum connection interval.
 * @param       connLatency     - Connection slave latency.
 * @param       connTimeout     - Connection supervision timeout.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      TRUE:  Connection time parameter check is valid.
 *              FALSE: Connection time parameter check is invalid.
 */
extern uint8 HCI_ValidConnTimeParams( uint16 connIntervalMin,
                                      uint16 connIntervalMax,
                                      uint16 connLatency,
                                      uint16 connTimeout );


/*******************************************************************************
 * @fn          HCI_TestAppTaskRegister
 *
 * @brief       HCI vendor specific registration for HCI Test Application.
 *
 * input parameters
 *
 * @param       taskID - The HCI Test Application OSAL task identifer.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void HCI_TestAppTaskRegister( uint8 taskID );


/*******************************************************************************
 * @fn          HCI_GAPTaskRegister
 *
 * @brief       HCI vendor specific registration for Host GAP.
 *
 * input parameters
 *
 * @param       taskID - The Host GAP OSAL task identifer.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void HCI_GAPTaskRegister( uint8 taskID );


/*******************************************************************************
 *
 * @fn          HCI_L2CAPTaskRegister
 *
 * @brief       HCI vendor specific registration for Host L2CAP.
 *
 * input parameters
 *
 * @param       taskID - The Host L2CAP OSAL task identifer.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 *
 */
extern void HCI_L2CAPTaskRegister( uint8 taskID );


/*******************************************************************************
 * @fn          HCI_SMPTaskRegister
 *
 * @brief       HCI vendor specific registration for Host SMP.
 *
 * input parameters
 *
 * @param       taskID - The Host SMP OSAL task identifer.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void HCI_SMPTaskRegister( uint8 taskID );


/*******************************************************************************
 * @fn          HCI_ExtTaskRegister
 *
 * @brief       HCI vendor specific registration for Host extended commands.
 *
 * input parameters
 *
 * @param       taskID - The Host Extended Command OSAL task identifer.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
extern void HCI_ExtTaskRegister( uint8 taskID );



/*******************************************************************************
 * @fn          HCI_SendDataPkt API
 *
 * @brief       This API is used to send a ACL data packet over a connection.
 *
 *              Note: Empty packets are not sent.
 *
 *              Related Events: HCI_NumOfCompletedPacketsEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection ID (handle).
 * @param       pbFlag     - Packet Boundary Flag.
 * @param       pktLen     - Number of bytes of data to transmit.
 * @param       *pData     - Pointer to data buffer to transmit.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      HCI_SUCCESS, HCI_ERROR_CODE_MEM_CAP_EXCEEDED,
 *              HCI_ERROR_CODE_INVALID_HCI_CMD_PARAMS,
 *              HCI_ERROR_CODE_UNKNOWN_CONN_ID
 */
extern hciStatus_t HCI_SendDataPkt( uint16 connHandle,
                                    uint8  pbFlag,
                                    uint16 pktLen,
                                    uint8  *pData );



/*
** HCI API
*/


/*******************************************************************************
 * @fn          HCI_DisconnectCmd API
 *
 * @brief       This BT API is used to terminate a connection.
 *
 *              Related Events: HCI_CommandStatusEvent,
 *                              DisconnectEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 * @param       reason     - Reason for disconnection:
 *                           HCI_DISCONNECT_AUTH_FAILURE,
 *                           HCI_DISCONNECT_REMOTE_USER_TERM,
 *                           HCI_DISCONNECT_REMOTE_DEV_POWER_OFF,
 *                           HCI_DISCONNECT_UNSUPPORTED_REMOTE_FEATURE,
 *                           HCI_DISCONNECT_KEY_PAIRING_NOT_SUPPORTED
 *                           HCI_DISCONNECT_UNACCEPTABLE_CONN_INTERVAL
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      HCI_SUCCESS
 */
extern hciStatus_t HCI_DisconnectCmd( uint16 connHandle,
                                      uint8  reason );




/*******************************************************************************
 * @fn          HCI_ReadRemoteVersionInfoCmd API
 *
 * @brief       This BT API is used to request version information from the
 *              the remote device in a connection.
 *
 *              Related Events: HCI_CommandStatusEvent,
 *                              ReadRemoteVersionInfoEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ReadRemoteVersionInfoCmd( uint16 connHandle );



/*******************************************************************************
 * @fn          HCI_SetEventMaskCmd API
 *
 * @brief       This BT API is used to set the HCI event mask, which is used to
 *              determine which events are supported.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       pMask - Pointer to an eight byte event mask.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_SetEventMaskCmd( uint8 *pMask );


/*******************************************************************************
 * @fn          HCI_Reset API
 *
 * @brief       This BT API is used to reset the Link Layer.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ResetCmd( void );



/*******************************************************************************
 * @fn          HCI_ReadTransmitPowerLevelCmd API
 *
 * @brief       This BT API is used to read the transmit power level.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 * @param       txPwrType  - HCI_READ_CURRENT_TX_POWER_LEVEL,
 *                           HCI_READ_MAXIMUM_TX_POWER_LEVEL
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ReadTransmitPowerLevelCmd( uint16 connHandle,
                                                  uint8  txPwrType );




/*******************************************************************************
 * @fn          HCI_SetControllerToHostFlowCtrlCmd API
 *
 * @brief       This BT API is used by the Host to turn flow control on or off
 *              for data sent from the Controller to Host.
 *
 *              Note: This command is currently not supported.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       flowControlEnable - HCI_CTRL_TO_HOST_FLOW_CTRL_OFF,
 *                                  HCI_CTRL_TO_HOST_FLOW_CTRL_ACL_ON_SYNCH_OFF,
 *                                  HCI_CTRL_TO_HOST_FLOW_CTRL_ACL_OFF_SYNCH_ON,
 *                                  HCI_CTRL_TO_HOST_FLOW_CTRL_ACL_ON_SYNCH_ON
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_SetControllerToHostFlowCtrlCmd( uint8 flowControlEnable );




/*******************************************************************************
 * @fn          HCI_HostBufferSizeCmd API
 *
 * @brief       This BT API is used by the Host to notify the Controller of the
 *              maximum size ACL buffer size the Controller can send to the
 *              Host.
 *
 *              Note: This command is currently ignored by the Controller. It
 *                    is assumed that the Host can always handle the maximum
 *                    BLE data packet size.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       hostAclPktLen        - Host ACL data packet length.
 * @param       hostSyncPktLen       - Host SCO data packet length .
 * @param       hostTotalNumAclPkts  - Host total number of ACL data packets.
 * @param       hostTotalNumSyncPkts - Host total number of SCO data packets.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_HostBufferSizeCmd( uint16 hostAclPktLen,
                                          uint8  hostSyncPktLen,
                                          uint16 hostTotalNumAclPkts,
                                          uint16 hostTotalNumSyncPkts );




/*******************************************************************************
 * @fn          HCI_HostNumCompletedPktCmd API
 *
 * @brief       This BT API is used by the Host to notify the Controller of the
 *              number of HCI data packets that have been completed for each
 *              connection handle since this command was previously sent to the
 *              controller.
 *
 *              The Host_Number_Of_Conpleted_Packets command is a special
 *              command. No event is normally generated after the command
 *              has completed. The command should only be issued by the
 *              Host if flow control in the direction from controller to
 *              the host is on and there is at least one connection, or
 *              if the controller is in local loopback mode.
 *
 *              Note:  The current version of BLE stack does not support
 *                     controller to host flow control. Hence, the command is
 *                     ignored if received.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       numHandles       - Number of connection handles.
 * @param       connHandles      - Array of connection handles.
 * @param       numCompletedPkts - Array of number of completed packets.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_HostNumCompletedPktCmd( uint8  numHandles,
                                               uint16 *connHandles,
                                               uint16 *numCompletedPkts );



/*******************************************************************************
 * @fn          HCI_ReadLocalVersionInfoCmd API
 *
 * @brief       This BT API is used to read the local version information.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ReadLocalVersionInfoCmd( void );


/*******************************************************************************
 * @fn          HCI_ReadLocalSupportedCommandsCmd API
 *
 * @brief       This BT API is used to read the locally supported commands.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ReadLocalSupportedCommandsCmd( void );


/*******************************************************************************
 * @fn          HCI_ReadLocalSupportedFeaturesCmd API
 *
 * @brief       This BT API is used to read the locally supported features.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ReadLocalSupportedFeaturesCmd( void );


/*******************************************************************************
 * @fn          HCI_ReadBDADDRCmd API
 *
 * @brief       This BT API is used to read this device's BLE address (BDADDR).
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ReadBDADDRCmd( void );


/*******************************************************************************
 * @fn          HCI_ReadRssiCmd API
 *
 * @brief       This BT API is used to read the RSSI of the last packet
 *              received on a connection given by the connection handle. If
 *              the Receiver Modem test is running (HCI_EXT_ModemTestRx), then
 *              the RF RSSI for the last received data will be returned. If
 *              there is no RSSI value, then HCI_RSSI_NOT_AVAILABLE will be
 *              returned.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_ReadRssiCmd( uint16 connHandle );

/*
** HCI Low Energy Commands
*/

/*******************************************************************************
 * @fn          HCI_LE_SetEventMaskCmd API
 *
 * @brief       This LE API is used to set the HCI LE event mask, which is used
 *              to determine which LE events are supported.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param        pEventMask - Pointer to LE event mask of 8 bytes.

 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_SetEventMaskCmd( uint8 *pEventMask );


/*******************************************************************************
 * @fn          HCI_LE_ReadBufSizeCmd API
 *
 * @brief       This LE API is used by the Host to determine the maximum ACL
 *              data packet size allowed by the Controller.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReadBufSizeCmd( void );


/*******************************************************************************
 * @fn          HCI_LE_ReadLocalSupportedFeaturesCmd API
 *
 * @brief       This LE API is used to read the LE locally supported features.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReadLocalSupportedFeaturesCmd( void );


/*******************************************************************************
 * @fn          HCI_LE_SetRandomAddressCmd API
 *
 * @brief       This LE API is used to set this device's Random address.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       pRandAddr - Pointer to random address.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_SetRandomAddressCmd( uint8 *pRandAddr );



/*******************************************************************************
 * @fn          HCI_LE_SetAdvParamCmd API
 *
 * @brief       This LE API is used to set the Advertising parameters.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       advIntervalMin  - Minimum allowed advertising interval.
 * @param       advIntervalMax  - Maximum allowed advertising interval.
 * @param       advType         - HCI_CONNECTABLE_UNDIRECTED_ADV,
 *                                HCI_CONNECTABLE_DIRECTED_ADV,
 *                                HCI_SCANNABLE_UNDIRECTED,
 *                                HCI_NONCONNECTABLE_UNDIRECTED_ADV
 * @param       ownAddrType     - HCI_PUBLIC_DEVICE_ADDRESS,
 *                                HCI_RANDOM_DEVICE_ADDRESS
 * @param       directAddrType  - HCI_PUBLIC_DEVICE_ADDRESS,
 *                                HCI_RANDOM_DEVICE_ADDRESS
 * @param       directAddr      - Pointer to address of device when using
 *                                directed advertising.
 * @param       advChannelMap   - HCI_ADV_CHAN_37,
 *                                HCI_ADV_CHAN_38
 *                                HCI_ADV_CHAN_39
 *                                HCI_ADV_CHAN_ALL
 * @param       advFilterPolicy - HCI_ADV_WL_POLICY_ANY_REQ,
 *                                HCI_ADV_WL_POLICY_WL_SCAN_REQ,
 *                                HCI_ADV_WL_POLICY_WL_CONNECT_REQ,
 *                                HCI_ADV_WL_POLICY_WL_ALL_REQ
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_SetAdvParamCmd( uint16 advIntervalMin,
                                          uint16 advIntervalMax,
                                          uint8  advType,
                                          uint8  ownAddrType,
                                          uint8  directAddrType,
                                          uint8  *directAddr,
                                          uint8  advChannelMap,
                                          uint8  advFilterPolicy );




/*******************************************************************************
 * @fn          HCI_LE_SetAdvDataCmd API
 *
 * @brief       This LE API is used to set the Advertising data.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       dataLen - Length of Advertising data.
 * @param       pData   - Pointer to Advertising data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_SetAdvDataCmd( uint8 dataLen,
                                         uint8 *pData );




/*******************************************************************************
 * @fn          HCI_LE_SetScanRspDataCmd API
 *
 * @brief       This LE API is used to set the Advertising Scan Response data.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       dataLen - Length of Scan Response data.
 * @param       pData   - Pointer to Scan Response data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_SetScanRspDataCmd( uint8 dataLen,
                                             uint8 *pData );




/*******************************************************************************
 * @fn          HCI_LE_SetAdvEnableCmd API
 *
 * @brief       This LE API is used to turn Advertising on or off.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       advEnable - HCI_ENABLE_ADV, HCI_DISABLE_ADV
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_SetAdvEnableCmd( uint8 advEnable );




/*******************************************************************************
 * @fn          HCI_LE_ReadAdvChanTxPowerCmd API
 *
 * @brief       This LE API is used to read transmit power when Advertising.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReadAdvChanTxPowerCmd( void );



#line 1240 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"


#line 1266 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\hci.h"



/*******************************************************************************
 * @fn          HCI_LE_CreateConnCmd API
 *
 * @brief       This LE API is used to create a connection.
 *
 *              Related Events: HCI_CommandStatusEvent,
 *                              ConnectionCompleteEvent
 *
 * input parameters
 *
 * @param       scanInterval     - Time between Init scan events.
 * @param       scanWindow       - Time of scan before Init scan event ends.
 *                                 Note: When the scanWindow equals the
 *                                       scanInterval then scanning is
 *                                       continuous.
 * @param       initFilterPolicy - HCI_INIT_WL_POLICY_USE_PEER_ADDR,
 *                                 HCI_INIT_WL_POLICY_USE_WHITE_LIST
 * @param       addrTypePeer     - HCI_PUBLIC_DEVICE_ADDRESS,
 *                                 HCI_RANDOM_DEVICE_ADDRESS
 * @param       peerAddr         - Pointer to peer device's address.
 * @param       ownAddrType      - HCI_PUBLIC_DEVICE_ADDRESS,
 *                                 HCI_RANDOM_DEVICE_ADDRESS
 * @param       connIntervalMin  - Minimum allowed connection interval.
 * @param       connIntervalMax  - Maximum allowed connection interval.
 * @param       connLatency      - Number of skipped events (slave latency).
 * @param       connTimeout      - Connection supervision timeout.
 * @param       minLen           - Info parameter about min length of conn.
 * @param       maxLen           - Info parameter about max length of conn.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_CreateConnCmd( uint16 scanInterval,
                                         uint16 scanWindow,
                                         uint8  initFilterPolicy,
                                         uint8  addrTypePeer,
                                         uint8  *peerAddr,
                                         uint8  ownAddrType,
                                         uint16 connIntervalMin,
                                         uint16 connIntervalMax,
                                         uint16 connLatency,
                                         uint16 connTimeout,
                                         uint16 minLen,
                                         uint16 maxLen );




/*******************************************************************************
 * @fn          HCI_LE_CreateConnCancelCmd API
 *
 * @brief       This LE API is used to cancel a create connection.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_CreateConnCancelCmd( void );



/*******************************************************************************
 * @fn          HCI_LE_ReadWhiteListSizeCmd API
 *
 * @brief       This LE API is used to read the white list.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReadWhiteListSizeCmd( void );


/*******************************************************************************
 * @fn          HCI_LE_ClearWhiteListCmd API
 *
 * @brief       This LE API is used to clear the white list.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ClearWhiteListCmd( void );


/*******************************************************************************
 * @fn          HCI_LE_AddWhiteListCmd API
 *
 * @brief       This LE API is used to add a white list entry.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       addrType - HCI_PUBLIC_DEVICE_ADDRESS, HCI_RANDOM_DEVICE_ADDRESS
 * @param       devAddr  - Pointer to address of device to put in white list.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_AddWhiteListCmd( uint8 addrType,
                                           uint8 *devAddr );


/*******************************************************************************
 * @fn          HCI_LE_RemoveWhiteListCmd API
 *
 * @brief       This LE API is used to remove a white list entry.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       addrType - HCI_PUBLIC_DEVICE_ADDRESS, HCI_RANDOM_DEVICE_ADDRESS
 * @param       devAddr  - Pointer to address of device to remove from the
 *                         white list.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_RemoveWhiteListCmd( uint8 addrType,
                                              uint8 *devAddr );



/*******************************************************************************
 * @fn          HCI_LE_ConnUpdateCmd API
 *
 * @brief       This LE API is used to update the connection parameters.
 *
 *              Related Events: HCI_CommandStatusEvent,
 *                              ConnectionUpdateCompleteEvent
 *
 * input parameters
 *
 * @param       connHandle       - Time between Init scan events.
 * @param       connIntervalMin  - Minimum allowed connection interval.
 * @param       connIntervalMax  - Maximum allowed connection interval.
 * @param       connLatency      - Number of skipped events (slave latency).
 * @param       connTimeout      - Connection supervision timeout.
 * @param       minLen           - Info parameter about min length of conn.
 * @param       maxLen           - Info parameter about max length of conn.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ConnUpdateCmd( uint16 connHandle,
                                         uint16 connIntervalMin,
                                         uint16 connIntervalMax,
                                         uint16 connLatency,
                                         uint16 connTimeout,
                                         uint16 minLen,
                                         uint16 maxLen );




/*******************************************************************************
 * @fn          HCI_LE_SetHostChanClassificationCmd API
 *
 * @brief       This LE API is used to update the current data channel map.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       chanMap - Pointer to the new channel map.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_SetHostChanClassificationCmd( uint8 *chanMap );




/*******************************************************************************
 * @fn          HCI_LE_ReadChannelMapCmd API
 *
 * @brief       This LE API is used to read a connection's data channel map.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReadChannelMapCmd( uint16 connHandle );




/*******************************************************************************
 * @fn          HCI_LE_ReadRemoteUsedFeaturesCmd API
 *
 * @brief       This LE API is used to read the remote device's used features.
 *
 *              Related Events: HCI_CommandStatusEvent,
 *                              ReadRemoteUsedFeaturesCompleteEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReadRemoteUsedFeaturesCmd( uint16 connHandle );



/*******************************************************************************
 * @fn          HCI_LE_EncryptCmd API
 *
 * @brief       This LE API is used to perform an encryption using AES128.
 *
 *              Note: Input parameters are ordered MSB..LSB.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       key       - Pointer to 16 byte encryption key.
 * @param       plainText - Pointer to 16 byte plaintext data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_EncryptCmd( uint8 *key,
                                      uint8 *plainText );


/*******************************************************************************
 * @fn          HCI_LE_RandCmd API
 *
 * @brief       This LE API is used to generate a random number.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_RandCmd( void );



/*******************************************************************************
 * @fn          HCI_LE_StartEncyptCmd API
 *
 * @brief       This LE API is used to start encryption in a connection.
 *
 *              Related Events: HCI_CommandStatusEvent,
 *                              EncChangeEvent or
 *                              EncKeyRefreshEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 * @param       random     - Pointer to eight byte Random number.
 * @param       encDiv     - Pointer to two byte Encrypted Diversifier.
 * @param       ltk        - Pointer to 16 byte Long Term Key.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_StartEncyptCmd( uint16 connHandle,
                                          uint8  *random,
                                          uint8  *encDiv,
                                          uint8  *ltk );




/*******************************************************************************
 * @fn          HCI_LE_LtkReqReplyCmd API
 *
 * @brief       This LE API is used by the Host to send to the Controller a
 *              positive LTK reply.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 * @param       ltk        - Pointer to 16 byte Long Term Key.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_LtkReqReplyCmd( uint16 connHandle,
                                          uint8  *ltk );




/*******************************************************************************
 * @fn          HCI_LE_LtkReqNegReplyCmd API
 *
 * @brief       This LE API is used by the Host to send to the Controller a
 *              negative LTK reply.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       connHandle - Connectin handle.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_LtkReqNegReplyCmd( uint16 connHandle );



/*******************************************************************************
 * @fn          HCI_LE_ReadSupportedStatesCmd API
 *
 * @brief       This LE API is used to read the Controller's supported states.
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReadSupportedStatesCmd( void );


/*******************************************************************************
 * @fn          HCI_LE_ReceiverTestCmd API
 *
 * @brief       This LE API is used to start the receiver Direct Test Mode test.
 *
 *              Note: A HCI reset should be issued when done using DTM!
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       rxFreq - Rx RF frequency:
 *                       k=0..HCI_DTM_NUMBER_RF_CHANS-1, where: F=2402+(k*2MHz)
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_ReceiverTestCmd( uint8 rxFreq );


/*******************************************************************************
 * @fn          HCI_LE_TransmitterTestCmd API
 *
 * @brief       This LE API is used to start the transmit Direct Test Mode test.
 *
 *              Note: The BLE device is to transmit at maximum power!
 *
 *              Note: A HCI reset should be issued when done using DTM!
 *
 * input parameters
 *
 * @param       txFreq      - Tx RF frequency:
 *                            k=0..HCI_DTM_NUMBER_RF_CHANS-1, where:
 *                            F=2402+(k*2MHz)
 * @param       dataLen     - Test data length in bytes:
 *                            0..HCI_DIRECT_TEST_MAX_PAYLOAD_LEN
 * @param       payloadType - Type of packet payload, per Direct Test Mode spec:
 *                            HCI_DIRECT_TEST_PAYLOAD_PRBS9,
 *                            HCI_DIRECT_TEST_PAYLOAD_0x0F,
 *                            HCI_DIRECT_TEST_PAYLOAD_0x55,
 *                            HCI_DIRECT_TEST_PAYLOAD_PRBS15,
 *                            HCI_DIRECT_TEST_PAYLOAD_0xFF,
 *                            HCI_DIRECT_TEST_PAYLOAD_0x00,
 *                            HCI_DIRECT_TEST_PAYLOAD_0xF0,
 *                            HCI_DIRECT_TEST_PAYLOAD_0xAA
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_TransmitterTestCmd( uint8 txFreq,
                                              uint8 dataLen,
                                              uint8 pktPayload );


/*******************************************************************************
 * @fn          HCI_LE_TestEndCmd API
 *
 * @brief       This LE API is used to end the Direct Test Mode test.
 *
 *              Note: A HCI reset should be issued when done using DTM!
 *
 *              Related Events: HCI_CommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_LE_TestEndCmd( void );

/*
** HCI Vendor Specific Comamnds: Link Layer Extensions
*/

/*******************************************************************************
 * @fn          HCI_EXT_SetRxGainCmd API
 *
 * @brief       This HCI Extension API is used to set the receiver gain.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       rxGain - HCI_EXT_RX_GAIN_STD, HCI_EXT_RX_GAIN_HIGH
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetRxGainCmd( uint8 rxGain );


/*******************************************************************************
 * @fn          HCI_EXT_SetTxPowerCmd API
 *
 * @brief       This HCI Extension API is used to set the transmit power.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       txPower - LL_EXT_TX_POWER_MINUS_23_DBM,
 *                        LL_EXT_TX_POWER_MINUS_6_DBM,
 *                        LL_EXT_TX_POWER_0_DBM,
 *                        LL_EXT_TX_POWER_4_DBM
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetTxPowerCmd( uint8 txPower );



/*******************************************************************************
 * @fn          HCI_EXT_OnePktPerEvtCmd API
 *
 * @brief       This HCI Extension API is used to set whether a connection will
 *              be limited to one packet per event.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       control - HCI_EXT_ENABLE_ONE_PKT_PER_EVT,
 *                        HCI_EXT_DISABLE_ONE_PKT_PER_EVT
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_OnePktPerEvtCmd( uint8 control );



/*******************************************************************************
 * @fn          HCI_EXT_ClkDivOnHaltCmd API
 *
 * @brief       This HCI Extension API is used to set whether the system clock
 *              will be divided when the MCU is halted.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       control - HCI_EXT_ENABLE_CLK_DIVIDE_ON_HALT,
 *                        HCI_EXT_DISABLE_CLK_DIVIDE_ON_HALT
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_ClkDivOnHaltCmd( uint8 control );


/*******************************************************************************
 * @fn          HCI_EXT_DeclareNvUsageCmd API
 *
 * @brief       This HCI Extension API is used to indicate to the Controller
 *              whether or not the Host will be using the NV memory during BLE
 *              operations.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       mode - HCI_EXT_NV_IN_USE, HCI_EXT_NV_NOT_IN_USE
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_DeclareNvUsageCmd( uint8 mode );


/*******************************************************************************
 * @fn          HCI_EXT_DecryptCmd API
 *
 * @brief       This HCI Extension API is used to decrypt encrypted data using
 *              AES128.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       key     - Pointer to 16 byte encryption key.
 * @param       encText - Pointer to 16 byte encrypted data.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_DecryptCmd( uint8 *key,
                                       uint8 *encText );


/*******************************************************************************
 * @fn          HCI_EXT_SetLocalSupportedFeaturesCmd API
 *
 * @brief       This HCI Extension API is used to write this devie's supported
 *              features.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       localFeatures - Pointer to eight bytes of local features.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetLocalSupportedFeaturesCmd( uint8 *localFeatures );



/*******************************************************************************
 * @fn          HCI_EXT_SetFastTxResponseTimeCmd API
 *
 * @brief       This HCI Extension API is used to set whether transmit data is
 *              sent as soon as possible even when slave latency is used.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       control - HCI_EXT_ENABLE_FAST_TX_RESP_TIME,
 *                        HCI_EXT_DISABLE_FAST_TX_RESP_TIME
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetFastTxResponseTimeCmd( uint8 control );




/*******************************************************************************
 * @fn          HCI_EXT_SetSlaveLatencyOverrideCmd API
 *
 * @brief       This HCI Extension API is used to to enable or disable
 *              suspending slave latency.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       control - HCI_EXT_ENABLE_SL_OVERRIDE,
 *                        HCI_EXT_DISABLE_SL_OVERRIDE
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetSlaveLatencyOverrideCmd( uint8 control );



/*******************************************************************************
 * @fn          HCI_EXT_ModemTestTxCmd
 *
 * @brief       This API is used start a continuous transmitter modem test,
 *              using either a modulated or unmodulated carrier wave tone, at
 *              the frequency that corresponds to the specified RF channel. Use
 *              HCI_EXT_EndModemTest command to end the test.
 *
 *              Note: A Controller reset will be issued by HCI_EXT_EndModemTest!
 *              Note: The BLE device will transmit at maximum power.
 *              Note: This API can be used to verify this device meets Japan's
 *                    TELEC regulations.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       cwMode - HCI_EXT_TX_MODULATED_CARRIER,
 *                       HCI_EXT_TX_UNMODULATED_CARRIER
 *              txFreq - Transmit RF channel k=0..39, where BLE F=2402+(k*2MHz).
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_ModemTestTxCmd( uint8 cwMode,
                                           uint8 txFreq );


/*******************************************************************************
 * @fn          HCI_EXT_ModemHopTestTxCmd
 *
 * @brief       This API is used to start a continuous transmitter direct test
 *              mode test using a modulated carrier wave and transmitting a
 *              37 byte packet of Pseudo-Random 9-bit data. A packet is
 *              transmitted on a different frequency (linearly stepping through
 *              all RF channels 0..39) every 625us. Use HCI_EXT_EndModemTest
 *              command to end the test.
 *
 *              Note: A Controller reset will be issued by HCI_EXT_EndModemTest!
 *              Note: The BLE device will transmit at maximum power.
 *              Note: This API can be used to verify this device meets Japan's
 *                    TELEC regulations.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_ModemHopTestTxCmd( void );


/*******************************************************************************
 * @fn          HCI_EXT_ModemTestRxCmd
 *
 * @brief       This API is used to start a continuous receiver modem test
 *              using a modulated carrier wave tone, at the frequency that
 *              corresponds to the specific RF channel. Any received data is
 *              discarded. Receiver gain may be adjusted using the
 *              HCI_EXT_SetRxGain command. RSSI may be read during this test
 *              by using the HCI_ReadRssi command. Use HCI_EXT_EndModemTest
 *              command to end the test.
 *
 *              Note: A Controller reset will be issued by HCI_EXT_EndModemTest!
 *              Note: The BLE device will transmit at maximum power.
 *
 * input parameters
 *
 * @param       rxFreq - Receiver RF channel k=0..39, where BLE F=2402+(k*2MHz).
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_ModemTestRxCmd( uint8 rxFreq );


/*******************************************************************************
 * @fn          HCI_EXT_EndModemTestCmd
 *
 * @brief       This API is used to shutdown a modem test. A complete Controller
 *              reset will take place.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_EndModemTestCmd( void );


/*******************************************************************************
 * @fn          HCI_EXT_SetBDADDRCmd
 *
 * @brief       This API is used to set this device's BLE address (BDADDR).
 *
 *              Note: This command is only allowed when the device's state is
 *                    Standby.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       bdAddr  - A pointer to a buffer to hold this device's address.
 *                        An invalid address (i.e. all FF's) will restore this
 *                        device's address to the address set at initialization.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetBDADDRCmd( uint8 *bdAddr );



/*******************************************************************************
 * @fn          HCI_EXT_SetSCACmd
 *
 * @brief       This API is used to set this device's Sleep Clock Accuracy.
 *
 *              Note: For a slave device, this value is directly used, but only
 *                    if power management is enabled. For a master device, this
 *                    value is converted into one of eight ordinal values
 *                    representing a SCA range, as specified in Table 2.2,
 *                    Vol. 6, Part B, Section 2.3.3.1 of the Core specification.
 *
 *              Note: This command is only allowed when the device is not in a
 *                    connection.
 *
 *              Note: The device's SCA value remains unaffected by a HCI_Reset.
 *
 * input parameters
 *
 * @param       scaInPPM - A SCA value in PPM from 0..500.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetSCACmd( uint16 scaInPPM );


/*******************************************************************************
 * @fn          HCI_EXT_EnablePTMCmd
 *
 * @brief       This HCI Extension API is used to enable Production Test Mode.
 *
 *              Note: This function can only be directly called from the
 *                    application and is not available via an external transport
 *                    interface such as RS232. Also, no vendor specific
 *                    command complete will be returned.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_EnablePTMCmd( void );


/*******************************************************************************
 * @fn          HCI_EXT_SetFreqTuneCmd
 *
 * @brief       This HCI Extension API is used to set the frequency tuning up
 *              or down. Setting the mode up/down decreases/increases the amount
 *              of capacitance on the external crystal oscillator.
 *
 *              Note: This is a Production Test Mode only command!
 *
 * input parameters
 *
 * @param       step - HCI_PTM_SET_FREQ_TUNE_UP, HCI_PTM_SET_FREQ_TUNE_DOWN
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetFreqTuneCmd( uint8 step );


/*******************************************************************************
 * @fn          HCI_EXT_SaveFreqTuneCmd
 *
 * @brief       This HCI Extension API is used to save the frequency tuning
 *              value to flash.
 *
 *              Note: This is a Production Test Mode only command!
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SaveFreqTuneCmd( void );


/*******************************************************************************
 * @fn          HCI_EXT_SetMaxDtmTxPowerCmd API
 *
 * @brief       This HCI Extension API is used to set the maximum transmit
 *              output power for Direct Test Mode.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       txPower - LL_EXT_TX_POWER_MINUS_23_DBM,
 *                        LL_EXT_TX_POWER_MINUS_6_DBM,
 *                        LL_EXT_TX_POWER_0_DBM,
 *                        LL_EXT_TX_POWER_4_DBM
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_SetMaxDtmTxPowerCmd( uint8 txPower );


/*******************************************************************************
 * @fn          HCI_EXT_MapPmIoPortCmd Vendor Specific API
 *
 * @brief       This HCI Extension API is used to configure and map a CC254x I/O
 *              Port as a General Purpose I/O (GPIO) output signal that reflects
 *              the Power Management (PM) state of the CC254x device. The GPIO
 *              output will be High on Wake, and Low upon entering Sleep. This
 *              feature can be disabled by specifying HCI_EXT_PM_IO_PORT_NONE
 *              for the ioPort (ioPin is then ignored). The system default value
 *              upon hardware reset is disabled. This command can be used to
 *              control an external DC-DC Converter (its actual intent) such has
 *              the TI TPS62730 (or any similar converter that works the same
 *              way). This command should be used with extreme care as it will
 *              override how the Port/Pin was previously configured! This
 *              includes the mapping of Port 0 pins to 32kHz clock output,
 *              Analog I/O, UART, Timers; Port 1 pins to Observables, Digital
 *              Regulator status, UART, Timers; Port 2 pins to an external 32kHz
 *              XOSC. The selected Port/Pin will be configured as an output GPIO
 *              with interrupts masked. Careless use can result in a
 *              reconfiguration that could disrupt the system. It is therefore
 *              the user's responsibility to ensure the selected Port/Pin does
 *              not cause any conflicts in the system.
 *
 *              Note: Only Pins 0, 3 and 4 are valid for Port 2 since Pins 1
 *                    and 2 are mapped to debugger signals DD and DC.
 *
 *              Note: Port/Pin signal change will only occur when Power Savings
 *                    is enabled.
 *
 * input parameters
 *
 * @param       ioPort - HCI_EXT_PM_IO_PORT_P0,
 *                       HCI_EXT_PM_IO_PORT_P1,
 *                       HCI_EXT_PM_IO_PORT_P2,
 *                       HCI_EXT_PM_IO_PORT_NONE
 *
 * @param       ioPin  - HCI_EXT_PM_IO_PORT_PIN0,
 *                       HCI_EXT_PM_IO_PORT_PIN1,
 *                       HCI_EXT_PM_IO_PORT_PIN2,
 *                       HCI_EXT_PM_IO_PORT_PIN3,
 *                       HCI_EXT_PM_IO_PORT_PIN4,
 *                       HCI_EXT_PM_IO_PORT_PIN5,
 *                       HCI_EXT_PM_IO_PORT_PIN6,
 *                       HCI_EXT_PM_IO_PORT_PIN7
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern llStatus_t HCI_EXT_MapPmIoPortCmd( uint8 ioPort, uint8 ioPin );



/*******************************************************************************
 * @fn          HCI_EXT_DisconnectImmedCmd API
 *
 * @brief       This HCI Extension API is used to disconnect the connection
 *              immediately.
 *
 *              Note: The connection (if valid) is immediately terminated
 *                    without notifying the remote device. The Host is still
 *                    notified.
 *
 * input parameters
 *
 * @param       connHandle - Connection handle.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      HCI_SUCCESS
 */
extern hciStatus_t HCI_EXT_DisconnectImmedCmd( uint16 connHandle );




/*******************************************************************************
 * @fn          HCI_EXT_PacketErrorRate Vendor Specific API
 *
 * @brief       This function is used to Reset or Read the Packet Error Rate
 *              counters for a connection.
 *
 *              Note: The counters are only 16 bits. At the shortest connection
 *                    interval, this provides a bit over 8 minutes of data.
 *
 * input parameters
 *
 * @param       connHandle - The LL connection ID on which to send this data.
 * @param       command    - HCI_EXT_PER_RESET, HCI_EXT_PER_READ
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern hciStatus_t HCI_EXT_PacketErrorRateCmd( uint16 connHandle, uint8 command );




/*******************************************************************************
 * @fn          HCI_EXT_PERbyChanCmd Vendor Specific API
 *
 * @brief       This HCI Extension API is used to start or end Packet Error Rate
 *              by Channel counter accumulation for a connection. If the
 *              pointer is not NULL, it is assumed there is sufficient memory
 *              for the PER data, per the type perByChan_t. If NULL, then
 *              the operation is considered disabled.
 *
 *              Note: It is the user's responsibility to make sure there is
 *                    sufficient memory for the data, and that the counters
 *                    are cleared prior to first use.
 *
 *              Note: The counters are only 16 bits. At the shortest connection
 *                    interval, this provides a bit over 8 minutes of data.
 *
 * input parameters
 *
 * @param       connHandle - The LL connection ID on which to send this data.
 * @param       perByChan  - Pointer to PER by Channel data, or NULL.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, LL_STATUS_ERROR_INACTIVE_CONNECTION
 */
extern hciStatus_t HCI_EXT_PERbyChanCmd( uint16 connHandle, perByChan_t *perByChan );



/*******************************************************************************
 * @fn          HCI_EXT_ExtendRfRangeCmd API
 *
 * @brief       This HCI Extension API is used to Extend Rf Range using the TI
 *              CC2590 2.4 GHz RF Front End device.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_ExtendRfRangeCmd( void );


/*******************************************************************************
 * @fn          HCI_EXT_HaltDuringRfCmd API
 *
 * @brief       This HCI Extension API is used to enable or disable halting the
 *              CPU during RF. The system defaults to enabled.
 *
 *              Related Events: HCI_VendorSpecifcCommandCompleteEvent
 *
 * input parameters
 *
 * @param       mode - HCI_EXT_HALT_DURING_RF_ENABLE,
 *                     HCI_EXT_HALT_DURING_RF_DISABLE
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_HaltDuringRfCmd( uint8 mode );



/*******************************************************************************
 * @fn          HCI_EXT_AdvEventNoticeCmd Vendor Specific API
 *
 * @brief       This HCI Extension API is used to enable or disable a
 *              notification to the specified task using the specified task
 *              event whenever a Adv event ends. A non-zero taskEvent value is
 *              taken to be "enable", while a zero valued taskEvent is taken
 *              to be "disable".
 *
 * input parameters
 *
 * @param       taskID    - User's task ID.
 * @param       taskEvent - User's task event.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_AdvEventNoticeCmd( uint8 taskID, uint16 taskEvent );




/*******************************************************************************
 * @fn          HCI_EXT_ConnEventNoticeCmd Vendor Specific API
 *
 * @brief       This HCI Extension API is used to enable or disable a
 *              notification to the specified task using the specified task
 *              event whenever a Connection event ends. A non-zero taskEvent
 *              value is taken to be "enable", while a zero valued taskEvent
 *              taken to be "disable".
 *
 *              Note: Currently, only a Slave connection is supported.
 *
 * input parameters
 *
 * @param       taskID    - User's task ID.
 * @param       taskEvent - User's task event.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      hciStatus_t
 */
extern hciStatus_t HCI_EXT_ConnEventNoticeCmd( uint8 taskID, uint16 taskEvent );



/*******************************************************************************
 * @fn          HCI_EXT_BuildRevisionCmd Vendor Specific API
 *
 * @brief       This HCI Extension API is used set a user revision number or
 *              read the build revision number.
 *
 * input parameters
 *
 * @param       mode - HCI_EXT_SET_USER_REVISION | HCI_EXT_READ_BUILD_REVISION
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      LL_STATUS_SUCCESS, HCI_ERROR_CODE_INVALID_HCI_CMD_PARAMS
 */
extern hciStatus_t HCI_EXT_BuildRevisionCmd( uint8 mode, uint16 userRevNum );






#line 29 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\include\\gapgattserver.h"
/**************************************************************************************************
  Filename:       gapgattserver.h
  Revised:        $Date: 2009-10-21 07:25:22 -0700 (Wed, 21 Oct 2009) $
  Revision:       $Revision: 20946 $

  Description:    This file contains GAP GATT attribute definitions
                  and prototypes.


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



// Privacy Flag States



// GAP GATT Server Parameters
#line 73 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\include\\gapgattserver.h"

// GAP Services bit fields


// Attribute ID used with application's callback when attribute value is changed OTA



#line 88 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\include\\gapgattserver.h"

/*********************************************************************
 * TYPEDEFS
 */
// Callback to notify when attribute value is changed over the air.
typedef void (*ggsAttrValueChange_t)( uint8 attrId );

// GAP GATT Server callback structure
typedef struct
{
  ggsAttrValueChange_t  pfnAttrValueChange;  // When attribute value is changed OTA
} ggsAppCBs_t;

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

/*********************************************************************
 * API FUNCTIONS
 */

/**
 * @brief   Set a GAP GATT Server parameter.
 *
 * @param   param - Profile parameter ID<BR>
 * @param   len - length of data to right
 * @param   value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).<BR>
 *
 * @return  bStatus_t
 */
extern bStatus_t GGS_SetParameter( uint8 param, uint8 len, void *value );

/**
 * @brief   Get a GAP GATT Server parameter.
 *
 * @param   param - Profile parameter ID<BR>
 * @param   value - pointer to data to put.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).<BR>
 *
 * @return  bStatus_t
 */
extern bStatus_t GGS_GetParameter( uint8 param, void *value );

/**
 * @brief   Add function for the GAP GATT Service.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  SUCCESS: Service added successfully.<BR>
 *          INVALIDPARAMETER: Invalid service field.<BR>
 *          FAILURE: Not enough attribute handles available.<BR>
 *          bleMemAllocError: Memory allocation error occurred.<BR>
 */
extern bStatus_t GGS_AddService( uint32 services );

/**
 * @brief   Delete function for the GAP GATT Service.
 *
 * @param   services - services to delete. This is a bit map and can
 *                     contain more than one service.
 *
 * @return  SUCCESS: Service deleted successfully.<BR>
 *          FAILURE: Service not found.<BR>
 */
extern bStatus_t GGS_DelService( uint32 services );

/**
 * @brief   Registers the application callback function.
 *
 *          Note: Callback registration is needed only when the
 *                Device Name is made writable. The application
 *                will be notified when the Device Name is changed
 *                over the air.
 *
 * @param   appCallbacks - pointer to application callbacks.
 *
 * @return  none
 */
extern void GGS_RegisterAppCBs( ggsAppCBs_t *appCallbacks );

/**
 * @brief   Set a GGS Parameter value. Use this function to change
 *          the default GGS parameter values.
 *
 * @param   value - new GGS param value
 *
 * @return  void
 */
extern void GGS_SetParamValue( uint16 value );

/**
 * @brief   Get a GGS Parameter value.
 *
 * @param   none
 *
 * @return  GGS Parameter value
 */
extern uint16 GGS_GetParamValue( void );

/*********************************************************************
 * TASK FUNCTIONS - Don't call these. These are system functions.
 */

/*********************************************************************
*********************************************************************/





#line 31 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
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





#line 32 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\DevInfo\\devinfoservice.h"
/**************************************************************************************************
  Filename:       devinfoservice.h
  Revised:        $Date $
  Revision:       $Revision $

  Description:    This file contains the Device Information service definitions and
                  prototypes.


  Copyright 2012  Texas Instruments Incorporated. All rights reserved.

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

// Device Information Service Parameters
#line 67 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\DevInfo\\devinfoservice.h"

// Device Information Service UUIDs
#line 79 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\DevInfo\\devinfoservice.h"

// IEEE 11073 authoritative body values





// System ID length


  // PnP ID length


  



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
 * DevInfo_AddService- Initializes the Device Information service by registering
 *          GATT attributes with the GATT server.
 *
 */

extern bStatus_t DevInfo_AddService( void );

/*********************************************************************
 * @fn      DevInfo_SetParameter
 *
 * @brief   Set a Device Information parameter.
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
bStatus_t DevInfo_SetParameter( uint8 param, uint8 len, void *value );

/*
 * DevInfo_GetParameter - Get a Device Information parameter.
 *
 *    param - Profile parameter ID
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 */
extern bStatus_t DevInfo_GetParameter( uint8 param, void *value );

/*********************************************************************
*********************************************************************/





#line 33 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Batt\\battservice.h"
/**************************************************************************************************
  Filename:       battservice.h
  Revised:        $Date $
  Revision:       $Revision $

  Description:    This file contains the Battery service definitions and
                  prototypes.

 Copyright 2011-2013 Texas Instruments Incorporated. All rights reserved.

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


// Battery Service UUIDs



// Battery Service Get/Set Parameters


// Callback events



/*********************************************************************
 * TYPEDEFS
 */

// Battery Service callback function
//typedef void (*battServiceCB_t)(uint8 event);


/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

// Callback when a characteristic value has changed
typedef  void (*batteryChange_t)( uint8 paramID );

typedef struct
{
  batteryChange_t        pfnBatteryChange;  // Called when characteristic value changes
} batteryCBs_t;

/*********************************************************************
 * API FUNCTIONS
 */

/*********************************************************************
 * @fn      Batt_AddService
 *
 * @brief   Initializes the Battery service by registering
 *          GATT attributes with the GATT server.
 *
 * @return  Success or Failure
 */
extern bStatus_t Batt_AddService( void );

/*********************************************************************
 * @fn      Batt_Register
 *
 * @brief   Register a callback function with the Battery Service.
 *
 * @param   pfnServiceCB - Callback function.
 *
 * @return  None.
 */
extern bStatus_t Batt_Register( batteryCBs_t *appCallbacks );

/*********************************************************************
 * @fn      Batt_SetParameter
 *
 * @brief   Set a Battery Service parameter.
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
extern bStatus_t Batt_SetParameter( uint8 param, uint8 len, void *value );

/*********************************************************************
 * @fn      Batt_GetParameter
 *
 * @brief   Get a Battery parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to get.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
extern bStatus_t Batt_GetParameter( uint8 param, void *value );

/*********************************************************************
 * @fn          Batt_HandleConnStatusCB
 *
 * @brief       Battery Service link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
void Batt_HandleConnStatusCB( uint16 connHandle, uint8 changeType );

/*********************************************************************
*********************************************************************/





#line 34 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Actimetry\\actimetryservice.h"
/**************************************************************************************************
  Filename:       actimetryservice.h

  Description:    Actimetry service definitions and prototypes. Based on
                  Gyroscope service from Sensors profile.
                  
                  The service consists of one characteristic which stores
                  the 20-byte value defined by specification. It allows 
                  to send this data via notifications or read it directly.

**************************************************************************************************/









/*********************************************************************
 * INCLUDES
 */

/*********************************************************************
 * CONSTANTS
 */

// If uncommented 128 bit UUIDs are used
//#define WIMU_LONG_UUIDS
/* 
  128 bit Version 1 UUIDs generated on http://www.uuidgenerator.net/
  Macro as in Components\ble\include\bcomdef.h 
*/
#line 42 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Actimetry\\actimetryservice.h"

// Service UUIDs





  
// Profile Parameters





// Actimetry control flags

  
// Sensor Profile Services bit fields


// Length of sensor data in bytes


/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

// Callback when a characteristic value has changed
typedef  void (*actimetryChange_t)( uint8 paramID );

typedef struct
{
  actimetryChange_t        pfnActimetryChange;  // Called when characteristic value changes
} actimetryCBs_t;


/*********************************************************************
 * API FUNCTIONS
 */


/*
 * Actimetry_AddService- Initializes the Sensor GATT Profile service by registering
 *          GATT attributes with the GATT server.
 *
 * @param   services - services to add. This is a bit map and can
 *                     contain more than one service.
 */
extern bStatus_t Actimetry_AddService( uint32 services );

/*
 * Actimetry_RegisterAppCBs - Registers the application callback function.
 *                    Only call this function once.
 *
 *    appCallbacks - pointer to application callbacks.
 */
extern bStatus_t Actimetry_RegisterAppCBs( actimetryCBs_t *appCallbacks );

/*
 * Actimetry_SetParameter - Set a Sensor GATT Profile parameter.
 *
 *    param - Profile parameter ID
 *    len   - length of data to write
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 */
extern bStatus_t Actimetry_SetParameter( uint8 param, uint8 len, void *value );

/*
 * Actimetry_GetParameter - Get a Sensor GATT Profile parameter.
 *
 *    param - Profile parameter ID
 *    value - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 */
extern bStatus_t Actimetry_GetParameter( uint8 param, void *value );


/*********************************************************************
*********************************************************************/





#line 35 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Gps\\gpsservice.h"
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




#line 22 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Gps\\gpsservice.h"
  
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





#line 36 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\TimeService\\timeservice.h"
/**************************************************************************************************
  Filename:       timeservice.h
  Revised:        $Date $
  Revision:       $Revision $

  Description:    This file contains the Current Time service definitions and
                  prototypes according to the BLE standard

**************************************************************************************************/









/*********************************************************************
 * INCLUDES
 */

/*********************************************************************
 * CONSTANTS
 */


// Service UUIDs



// Parameters


/*********************************************************************
 * TYPEDEFS
 */

// Service callback function
//typedef void (*battServiceCB_t)(uint8 event);


/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * Profile Callbacks
 */

// Callback when a characteristic value has changed
typedef  void (*timeChange_t)( uint8 paramID );

typedef struct
{
  timeChange_t        pfnTimeChange;  // Called when characteristic value changes
} timeCBs_t;

/*********************************************************************
 * API FUNCTIONS
 */

/*********************************************************************
 * @fn      Time_AddService
 *
 * @brief   Initializes the Current Time service by registering
 *          GATT attributes with the GATT server.
 *
 * @return  Success or Failure
 */
extern bStatus_t Time_AddService( void );

/*********************************************************************
 * @fn      Time_Register
 *
 * @brief   Register a callback function with the Current Time Service.
 *
 * @param   pfnServiceCB - Callback function.
 *
 * @return  None.
 */
extern bStatus_t Time_Register( timeCBs_t *appCallbacks );

/*********************************************************************
 * @fn      Time_SetParameter
 *
 * @brief   Set a Current Time Service parameter.
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
extern bStatus_t Time_SetParameter( uint8 param, uint8 len, void *value );

/*********************************************************************
 * @fn      Time_GetParameter
 *
 * @brief   Get a Current Time parameter.
 *
 * @param   param - Profile parameter ID
 * @param   value - pointer to data to get.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return  bStatus_t
 */
extern bStatus_t Time_GetParameter( uint8 param, void *value );

/*********************************************************************
 * @fn          Time_HandleConnStatusCB
 *
 * @brief       Current Time Service link status change handler function.
 *
 * @param       connHandle - connection handle
 * @param       changeType - type of change
 *
 * @return      none
 */
void Time_HandleConnStatusCB( uint16 connHandle, uint8 changeType );

/*********************************************************************
*********************************************************************/





#line 37 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Roles\\peripheral.h"
/**
  @headerfile:    peripheral.h
  $Date: 2013-05-01 13:58:23 -0700 (Wed, 01 May 2013) $
  $Revision: 34101 $

  @mainpage TI BLE GAP Peripheral Role

  This GAP profile advertises and allows connections.

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

/*-------------------------------------------------------------------
 * CONSTANTS
 */

/** @defgroup GAPROLE_PROFILE_PARAMETERS GAP Role Parameters
 * @{
 */
#line 86 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\Roles\\peripheral.h"
/** @} End GAPROLE_PROFILE_PARAMETERS */

/*-------------------------------------------------------------------
 * TYPEDEFS
 */

/**
 * GAP Peripheral Role States.
 */
typedef enum
{
  GAPROLE_INIT = 0,                       //!< Waiting to be started
  GAPROLE_STARTED,                        //!< Started but not advertising
  GAPROLE_ADVERTISING,                    //!< Currently Advertising
  GAPROLE_WAITING,                        //!< Device is started but not advertising, is in waiting period before advertising again
  GAPROLE_WAITING_AFTER_TIMEOUT,          //!< Device just timed out from a connection but is not yet advertising, is in waiting period before advertising again
  GAPROLE_CONNECTED,                      //!< In a connection
  GAPROLE_ERROR                           //!< Error occurred - invalid state
} gaprole_States_t;

/**
 *  Possible actions the peripheral device may take if an unsuccessful parameter
 *  update is received.
 *
 *  Parameters for GAPRole_SendUpdateParam() only
 */





/*-------------------------------------------------------------------
 * MACROS
 */

/*-------------------------------------------------------------------
 * Profile Callbacks
 */

/**
 * Callback when the connection parameteres are updated.
 */
typedef void (*gapRolesParamUpdateCB_t)( uint16 connInterval,
                                         uint16 connSlaveLatency,
                                         uint16 connTimeout );

/**
 * Callback when the device has been started.  Callback event to
 * the Notify of a state change.
 */
typedef void (*gapRolesStateNotify_t)( gaprole_States_t newState );

/**
 * Callback when the device has read an new RSSI value during a connection.
 */
typedef void (*gapRolesRssiRead_t)( int8 newRSSI );

/**
 * Callback structure - must be setup by the application and used when gapRoles_StartDevice() is called.
 */
typedef struct
{
  gapRolesStateNotify_t    pfnStateChange;  //!< Whenever the device changes state
  gapRolesRssiRead_t       pfnRssiRead;     //!< When a valid RSSI is read from controller
} gapRolesCBs_t;

/*-------------------------------------------------------------------
 * API FUNCTIONS
 */

/**
 * @defgroup GAPROLES_PERIPHERAL_API GAP Peripheral Role API Functions
 *
 * @{
 */

/**
 * @brief       Set a GAP Role parameter.
 *
 *  NOTE: You can call this function with a GAP Parameter ID and it will set the
 *        GAP Parameter.  GAP Parameters are defined in (gap.h).  Also,
 *        the "len" field must be set to the size of a "uint16" and the
 *        "pValue" field must point to a "uint16".
 *
 * @param       param - Profile parameter ID: @ref GAPROLE_PROFILE_PARAMETERS
 * @param       len - length of data to write
 * @param       pValue - pointer to data to write.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return      SUCCESS or INVALIDPARAMETER (invalid paramID)
 */
extern bStatus_t GAPRole_SetParameter( uint16 param, uint8 len, void *pValue );

/**
 * @brief       Get a GAP Role parameter.
 *
 *  NOTE: You can call this function with a GAP Parameter ID and it will get a
 *        GAP Parameter.  GAP Parameters are defined in (gap.h).  Also, the
 *        "pValue" field must point to a "uint16".
 *
 * @param       param - Profile parameter ID: @ref GAPROLE_PROFILE_PARAMETERS
 * @param       pValue - pointer to location to get the value.  This is dependent on
 *          the parameter ID and WILL be cast to the appropriate
 *          data type (example: data type of uint16 will be cast to
 *          uint16 pointer).
 *
 * @return      SUCCESS or INVALIDPARAMETER (invalid paramID)
 */
extern bStatus_t GAPRole_GetParameter( uint16 param, void *pValue );

/**
 * @brief       Does the device initialization.  Only call this function once.
 *
 * @param       pAppCallbacks - pointer to application callbacks.
 *
 * @return      SUCCESS or bleAlreadyInRequestedMode
 */
extern bStatus_t GAPRole_StartDevice( gapRolesCBs_t *pAppCallbacks );

/**
 * @brief       Terminates the existing connection.
 *
 * @return      SUCCESS or bleIncorrectMode
 */
extern bStatus_t GAPRole_TerminateConnection( void );

/**
 * @brief       Update the parameters of an existing connection
 *
 * @param       connInterval - the new connection interval
 * @param       latency - the new slave latency
 * @param       connTimeout - the new timeout value
 * @param       handleFailure - what to do if the update does not occur.
 *              Method may choose to terminate connection, try again, or take no action
 *
 * @return      SUCCESS, bleNotConnected or bleInvalidRange
 */
extern bStatus_t GAPRole_SendUpdateParam( uint16 minConnInterval, uint16 maxConnInterval,
                                          uint16 latency, uint16 connTimeout, uint8 handleFailure );

/**
 * @brief       Register application's callbacks.
 *
 * @param       pParamUpdateCB - pointer to param update callback.
 *
 * @return      none
 */
extern void GAPRole_RegisterAppCBs( gapRolesParamUpdateCB_t *pParamUpdateCB );

/**
 * @} End GAPROLES_PERIPHERAL_API
 */


/*-------------------------------------------------------------------
 * TASK FUNCTIONS - Don't call these. These are system functions.
 */

/**
 * @internal
 *
 * @brief       Initialization function for the GAP Role Task.
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
extern void GAPRole_Init( uint8 task_id );

/**
 * @internal
 *
 * @brief       GAP Role Task event processor.
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
extern uint16 GAPRole_ProcessEvent( uint8 task_id, uint16 events );

/*-------------------------------------------------------------------
-------------------------------------------------------------------*/





#line 42 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"


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





#line 45 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.h"
/**************************************************************************************************
  Filename:       wimu.h

  Description:    This file contains the WIMU application 
                  (based on Simple BLE Peripheral sample application)
                  definitions and prototypes.

**************************************************************************************************/









/*********************************************************************
 * INCLUDES
 */


/*********************************************************************
 * DATA TYPES
 */
  
/*********************************************************************
 * CONSTANTS
 */
  
// Simple BLE Peripheral Task Events



  


/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * FUNCTIONS
 */

/*
 * Task Initialization for the BLE Application
 */
extern void WIMU_Init( uint8 task_id );

/*
 * Task Event Processor for the BLE Application
 */
extern uint16 WIMU_ProcessEvent( uint8 task_id, uint16 events );

/*********************************************************************
*********************************************************************/





#line 47 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\SensorProfile\\st_util.h"
/**************************************************************************************************
  Filename:       st_util.h
  Revised:        $Date: 2012-11-27 14:16:18 -0800 (Tue, 27 Nov 2012) $
  Revision:       $Revision: 32325 $

  Description:    Utilties for Sensor Tag services


  Copyright 2012  Texas Instruments Incorporated. All rights reserved.

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
 * MACROS
 */
#line 53 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\Profiles\\SensorProfile\\st_util.h"

// Using 16-bit UUID






/*-------------------------------------------------------------------
 * FUNCTIONS
 */

/*********************************************************************
 * @fn      utilExtractUuid16
 *
 * @brief   Extracts a 16-bit UUID from a GATT attribute
 *
 * @param   pAttr - pointer to attribute
 *
 * @param   pValue - pointer to UUID to be extracted
 *
 * @return  Success or Failure
 */
bStatus_t utilExtractUuid16(gattAttribute_t *pAttr, uint16 *pValue);



#line 50 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"






/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

// ====== Debugging settings ======
/*
  For debugging purposes, code optomization was disabled.
  It can be re-enabled in Options/ C/C++ compiler / Optimizations
*/

// If uncommented, data provided in packets is random
//#define WIMU_RANDOM_DATA

// For debuggin purposes
//#define WIMU_DEBUG


// ====== WIMU UART settings ======
   


//#define WIMU_UART_BAUDRATE HAL_UART_BR_2400
//#define WIMU_UART_BAUDRATE HAL_UART_BR_4800
//#define WIMU_UART_BAUDRATE HAL_UART_BR_9600
//#define WIMU_UART_BAUDRATE HAL_UART_BR_14400
//#define WIMU_UART_BAUDRATE HAL_UART_BR_19200
//#define WIMU_UART_BAUDRATE HAL_UART_BR_28800
//#define WIMU_UART_BAUDRATE HAL_UART_BR_38400
//#define WIMU_UART_BAUDRATE HAL_UART_BR_57600
//#define WIMU_UART_BAUDRATE HAL_UART_BR_76800
//#define WIMU_UART_BAUDRATE HAL_UART_BR_115200






// ====== WIMU Message Protocole ======


#line 107 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"



//#define WIMU_ACTIMETRY_DATALEN        40     // Expected data length for IMU Data, including header and CRC
//#define WIMU_BATTERY_DATALEN          5      // Expected data length for BATTERY Data, including header and CRC
//#define WIMU_GPS_NAVIGATION_DATALEN   103    // Expected data length for GPS Data, including header and CRC
//#define WIMU_DEVINFO_DATALEN          36     // Expected data length for Dev Info, including header and CRC

// ====== Application configuration ======   

// How often to perform periodic event

   
// ====== BLE stack configuration ======   
  
// What is the advertising interval when device is discoverable (units of 625us, 160=100ms)


/*
  This is set to true to renegotiate the connection interval
*/
// Whether to enable automatic parameter update request when a connection is formed


// Limited discoverable mode advertises for 30.72s, and then stops
// General discoverable mode advertises indefinitely




/*
  Adjust the connection interval so that there is less 
  than 4 notifications that have to be transferred on each connection
  event.
*/
// Minimum connection interval (units of 1.25ms, 80=100ms) if automatic parameter update request is enabled


// Maximum connection interval (units of 1.25ms, 800=1000ms) if automatic parameter update request is enabled


// Slave latency to use if automatic parameter update request is enabled



// Supervision timeout value (units of 10ms, 1000=10s) if automatic parameter update request is enabled


// Company Identifier: Texas Instruments Inc. (13)




// Length of bd addr as a string






/*********************************************************************
 * TYPEDEFS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */

//uint16 packetCount=0;
//bool sensorsReadEnabler = true;
//static uint16 numCalls=0;
//static uint16 seqNums[200];

/*********************************************************************
 * EXTERNAL VARIABLES
 */

/*********************************************************************
 * EXTERNAL FUNCTIONS
 */

/*********************************************************************
 * LOCAL VARIABLES
 */

static uint8 WIMU_TaskID;   // Task ID for internal task/event processing

// GAP - SCAN RSP data (max size = 31 bytes)
static uint8 scanRspData[] =
{
  // complete name
  0x0B,   // length of this data
  0x09,
  'W',   
  'I',   
  'M',   
  'U',
  '3',
  '-',
  'x',
  'x',
  'x',
  'x',

  // connection interval range
 /* 0x05,   // length of this data
  GAP_ADTYPE_SLAVE_CONN_INTERVAL_RANGE,
  LO_UINT16( DEFAULT_DESIRED_MIN_CONN_INTERVAL ),  
  HI_UINT16( DEFAULT_DESIRED_MIN_CONN_INTERVAL ),
  LO_UINT16( DEFAULT_DESIRED_MAX_CONN_INTERVAL ),  
  HI_UINT16( DEFAULT_DESIRED_MAX_CONN_INTERVAL ),

  // Tx power level
  0x02,   // length of this data
  GAP_ADTYPE_POWER_LEVEL,
  0       // 0dBm*/
};

// GAP - Advertisement data (max size = 31 bytes, though this is
// best kept short to conserve power while advertisting)
static uint8 advertData[] =
{
  // Flags; this sets the device to use limited discoverable
  // mode (advertises for 30 seconds at a time) instead of general
  // discoverable mode (advertises indefinitely)
  0x02,   // length of this data
  0x01,
  0x02 | 0x04,

  // service UUID, to notify central devices what services are included
  // in this peripheral
  0x07,   // length of this data



  0x02,

  // some of the UUID's, but not all
  ((0x70ee) & 0xFF), (((0x70ee) >> 8) & 0xFF),
  ((0x1819) & 0xFF),
  (((0x1819) >> 8) & 0xFF),
  ((0x180F) & 0xFF),
  (((0x180F) >> 8) & 0xFF),
  ((0x1805) & 0xFF),
  (((0x1805) >> 8) & 0xFF)
};

// GAP GATT Attributes
static uint8 attDeviceName[5] = "WIMU3";

uint8 rx_byte[256];
uint16 rx_index=0;
uint16 rx_len=0;

/*********************************************************************
 * LOCAL FUNCTIONS
 */
static void performPeriodicTask( void );
static void WIMU_UARTCallback (uint8 port, uint8 event);
static void WIMU_updateProfileSensors( void );
uint8 WIMU_getEndOfFrame_Position(void);
//void WIMU_SyncRX();
// Consistent Overhead Byte Stuffing algorithm (COBS) implementation (https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing)
void COBS_StuffData(const unsigned char *ptr, unsigned long length, unsigned char *dst);
void COBS_UnStuffData(const unsigned char *ptr, unsigned long length, unsigned char *dst);

/*********************************************************************
 * PROFILE CALLBACKS
 */

// GAP Role Callbacks
static gapRolesCBs_t WIMU_PeripheralCBs =
{
  ((void *) 0),                           // Profile State Change Callbacks
  ((void *) 0)                            // When a valid RSSI is read from controller (not used by application)
};

// GAP Bond Manager Callbacks
static gapBondCBs_t WIMU_BondMgrCBs =
{
  ((void *) 0),                     // Passcode callback (not used by application)
  ((void *) 0)                      // Pairing / Bonding state Callback (not used by application)
};


static void WIMU_openUART( void ){
    
    osal_memset(&rx_byte[0],0xFF, 256);
  
    halUARTCfg_t uartConf;
    
    uartConf.configured =         1;
    uartConf.baudRate =           0x0A;
    uartConf.flowControl =        0x00;
    uartConf.flowControlThreshold=128; // Not used
    uartConf.idleTimeout =        6; // Not used
    uartConf.rx.maxBufSize =      256; // Not used
    uartConf.tx.maxBufSize =      50; // Not used
    uartConf.intEnable =          1;
    uartConf.callBackFunc =       &WIMU_UARTCallback;
        
    HalUARTOpen(0x01, &uartConf);
    
};

void WIMU_requestDevInfo( void ){
  uint8 msg[2] = {4, 0};
  uint8 stuffed[4];
  
  COBS_StuffData(&msg[0], 3, &stuffed[0]);
  stuffed[3] = 0x00;
  
  HalUARTWrite(0x01, stuffed, 4);
}
/*
void WIMU_requestConfig( void ){
  uint8 msg[2] = {WIMU_MSGTYPE_CONFIG, 0};
  uint8 stuffed[4];
  
  COBS_StuffData(&msg[0], 3, &stuffed[0]);
  stuffed[3] = WIMU_SYNC_BYTE;
  
  HalUARTWrite(WIMU_UART_PORT, stuffed, 4);
}*/

void WIMU_setControlMode( uint8* config ){
  uint8 msg[2 + sizeof(RemControl_t)];
  msg[0] = 5;
  msg[1] = sizeof(RemControl_t);
  osal_memcpy(&msg[2], config, sizeof(RemControl_t));
  uint8 stuffed[2 + sizeof(RemControl_t) + 2];
  stuffed[2 + sizeof(RemControl_t) + 1] = 0x00;
  
  COBS_StuffData(&msg[0], 2 + sizeof(RemControl_t), &stuffed[0]);
    
  HalUARTWrite(0x01, stuffed, 2 + sizeof(RemControl_t) + 2);
}

void WIMU_setCurrentTime( uint8* current ){
  uint8 msg[2 + sizeof(currentTime_t)];
  msg[0] = 6;
  msg[1] = sizeof(currentTime_t);
  osal_memcpy(&msg[2], current, sizeof(currentTime_t));
  
  uint8 stuffed[2 + sizeof(currentTime_t) + 2];
  stuffed[2 + sizeof(currentTime_t) + 1] = 0x00;
  
  COBS_StuffData(&msg[0], 2 + sizeof(currentTime_t), &stuffed[0]);
    
  HalUARTWrite(0x01, stuffed, 2 + sizeof(currentTime_t) + 2);
}

/*********************************************************************
 * PUBLIC FUNCTIONS
 */

/*********************************************************************
 * @fn      WIMU_Init
 *
 * @brief   Initialization function for the Simple BLE Peripheral App Task.
 *          This is called during initialization and should contain
 *          any application specific initialization (ie. hardware
 *          initialization/setup, table initialization, power up
 *          notificaiton ... ).
 *
 * @param   task_id - the ID assigned by OSAL.  This ID should be
 *                    used to send messages and set timers.
 *
 * @return  none
 */
void WIMU_Init( uint8 task_id )
{
  WIMU_TaskID = task_id;

  // Setup the GAP Peripheral Role Profile
  {
    
    // Start advertising upon initialization
    uint8 initial_advertising_enable = 1;
    
    // By setting this to zero, the device will go into the waiting state after
    // being discoverable for 30.72 seconds, and will not being advertising again
    // until the enabler is set back to TRUE
    uint16 gapRole_AdvertOffTime = 0;

    uint8 enable_update_request = 0;
    uint16 desired_min_interval = 4;
    uint16 desired_max_interval = 4;
    uint16 desired_slave_latency = 0;
    uint16 desired_conn_timeout = 1600;

    // Set the GAP Role Parameters
    GAPRole_SetParameter( 0x305, sizeof( uint8 ), &initial_advertising_enable );
    GAPRole_SetParameter( 0x306, sizeof( uint16 ), &gapRole_AdvertOffTime );

    GAPRole_SetParameter( 0x308, sizeof ( scanRspData ), scanRspData );
    GAPRole_SetParameter( 0x307, sizeof( advertData ), advertData );

    GAPRole_SetParameter( 0x310, sizeof( uint8 ), &enable_update_request );
    GAPRole_SetParameter( 0x311, sizeof( uint16 ), &desired_min_interval );
    GAPRole_SetParameter( 0x312, sizeof( uint16 ), &desired_max_interval );
    GAPRole_SetParameter( 0x313, sizeof( uint16 ), &desired_slave_latency );
    GAPRole_SetParameter( 0x314, sizeof( uint16 ), &desired_conn_timeout );
    
  }

  // Set the GAP Characteristics
  uint8 devNamePermission = 0x01|0x02; 
  GGS_SetParameter( 6, sizeof ( uint8 ), &devNamePermission );
  GGS_SetParameter( 0, (20+1), attDeviceName );

  // Set advertising interval
  {
    uint16 advInt = 160;

    GAP_SetParamValue( 6, advInt );
    GAP_SetParamValue( 7, advInt );
    GAP_SetParamValue( 8, advInt );
    GAP_SetParamValue( 9, advInt );
  }

  // Setup the GAP Bond Manager
/*  {
    uint32 passkey = 0; // passkey "000000"
    uint8 pairMode = GAPBOND_PAIRING_MODE_WAIT_FOR_REQ;
    uint8 mitm = TRUE;
    uint8 ioCap = GAPBOND_IO_CAP_DISPLAY_ONLY;
    uint8 bonding = TRUE;
    GAPBondMgr_SetParameter( GAPBOND_DEFAULT_PASSCODE, sizeof ( uint32 ), &passkey );
    GAPBondMgr_SetParameter( GAPBOND_PAIRING_MODE, sizeof ( uint8 ), &pairMode );
    GAPBondMgr_SetParameter( GAPBOND_MITM_PROTECTION, sizeof ( uint8 ), &mitm );
    GAPBondMgr_SetParameter( GAPBOND_IO_CAPABILITIES, sizeof ( uint8 ), &ioCap );
    GAPBondMgr_SetParameter( GAPBOND_BONDING_ENABLED, sizeof ( uint8 ), &bonding );
  }*/

  // Initialize GATT attributes
  GGS_AddService( 0xFFFFFFFF );            // GAP
  GATTServApp_AddService( 0xFFFFFFFF );    // GATT attributes
  
  Actimetry_AddService( 0xFFFFFFFF );      // Actimetry Service
  DevInfo_AddService();                           // Device Information Service
  Batt_AddService();                              // Battery Service
  Gps_AddService(0xFFFFFFFF);              // Gps service
  Time_AddService();                              // Current Time Service






  // Enable clock divide on halt
  // This reduces active current while radio is active and CC254x MCU
  // is halted
  //HCI_EXT_ClkDivOnHaltCmd( HCI_EXT_ENABLE_CLK_DIVIDE_ON_HALT );

#line 468 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

  // Initialize UART
  HalUARTInit();
  
  osal_memset(&rx_byte[rx_index],0xFF, 256);
  
  // Open UART
  WIMU_openUART();
  
  // Setup a delayed profile startup
  osal_set_event( WIMU_TaskID, 0x0001 );
  
  osal_set_event( WIMU_TaskID, 0x305);
  
  // Request dev info
//  WIMU_requestDevInfo();
}

/*********************************************************************
 * @fn      WIMU_ProcessEvent
 *
 * @brief   Simple BLE Peripheral Application Task event processor.  This function
 *          is called to process all events for the task.  Events
 *          include timers, messages and any other user defined events.
 *
 * @param   task_id  - The OSAL assigned task ID.
 * @param   events - events to process.  This is a bit map and can
 *                   contain more than one event.
 *
 * @return  events not processed
 */
uint16 WIMU_ProcessEvent( uint8 task_id, uint16 events )
{

  (void) task_id; // OSAL required parameter that isn't used in this function
///////////////////////////////////////////////////////
  if ( events & 0x8000 )
  {
    uint8 *pMsg;

    if ( (pMsg = osal_msg_receive( WIMU_TaskID )) != ((void *) 0) )
    {
      //WIMU_ProcessOSALMsg( (osal_event_hdr_t *)pMsg );

      // Release the OSAL message
      (void) osal_msg_deallocate( pMsg );
    }

    // return unprocessed events
    return (events ^ 0x8000);
  }
/////////////////////////////////////////
  if ( events & 0x0001 )
  {
    // Start the Device
    (void) GAPRole_StartDevice( &WIMU_PeripheralCBs );

    // Start Bond Manager
    (void) GAPBondMgr_Register( &WIMU_BondMgrCBs );

//    // Open UART
   // WIMU_openUART();
        
    // Set timer for first periodic event
    osal_start_timerEx( WIMU_TaskID, 0x0002, 5 );

    return ( events ^ 0x0001 );
  }
//////////////////////////////////////////////
  if ( events & 0x0002 )
  {
    // Restart timer
    if ( 5 )
    {
      osal_start_timerEx( WIMU_TaskID, 0x0002, 5 );
    }

    // Perform periodic application task
    performPeriodicTask();

    return (events ^ 0x0002);
  }
  
/////////////////////////////////////////////
  if ( events & 0x305 )
  {

    // Request dev info
    WIMU_requestDevInfo();
        
    // Request module config
    //WIMU_requestConfig();
    
    return (events ^ 0x305);
  }
/////////////////////////////////////////////
  if ( events & 0x0008){
    //uint8 config;
    uint8 config[sizeof(RemControl_t)];
    Actimetry_GetParameter(15, &config);
    
    WIMU_setControlMode(config);
    
    return (events ^ 0x0008);
  }
  
/////////////////////////////////////////////
  if ( events & 0x0010){
    uint8 currentTime[sizeof(currentTime_t)];
    
    Time_GetParameter(0, &currentTime);
    
    WIMU_setCurrentTime(currentTime);
    
    return (events ^ 0x0010);
  }

  
  
#line 597 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\Source\\wimu.c"

  // Discard unknown events
  return 0;
}


/*********************************************************************
 * @fn      performPeriodicTask
 *
 * @brief   Perform a periodic application task. This function gets
 *          called every five seconds as a result of the SBP_PERIODIC_EVT
 *          OSAL event. In this example, the value of the third
 *          characteristic in the SimpleGATTProfile service is retrieved
 *          from the profile, and then copied into the value of the
 *          the fourth characteristic.
 *
 * @param   none
 *
 * @return  none
 */
static void performPeriodicTask( void )
{

}

/*********************************************************************
 * @fn      WIMU_UARTCallback
 *
 * @brief   Called by the UART task when new data is received
 *
 * @param   none
 *
 * @return  none
 */
static void WIMU_UARTCallback(uint8 port, uint8 event)
{

  if (port==0x01) {
      WIMU_updateProfileSensors();
  }
  
}

/*********************************************************************
 * @fn      WIMU_updateProfileSensors
 *
 * @brief   Called by the application to read sensors data
 *          and put data in profiles
 *
 * @param   none
 *
 * @return  none
 */

static void WIMU_updateProfileSensors ( void )
{ 
  static uint16 numBytes=0;
  static uint8 msgCount=0;
//  uint8 i;
  uint8 end_pos=0;
  uint8 msgType;

  // Process new data on UART port
  numBytes = Hal_UART_RxBufLen(0x01);
  if (numBytes>256){
    numBytes = 256;
  }
  if (rx_index+numBytes > 256){
    // Error: overflow detected!
    rx_index=0;
  }

  HalUARTRead (0x01, &rx_byte[rx_index], numBytes); // Read data
  rx_index+=numBytes;
  
  // Check if we got the end of the message (SYNC byte)
  end_pos = WIMU_getEndOfFrame_Position();
  
  // Process message, if we got enough data
  /////////////////////////////////////////
  while ( end_pos > 0){
    // Unpack the data
    uint8 unstuffed[128];
    COBS_UnStuffData(&rx_byte[0], end_pos, &unstuffed[0]);
    msgType = unstuffed[0];
    rx_len = unstuffed[1];
    msgCount++;
    
    switch(msgType){
      /////////////////
      // DEVICE INFO
      /////////////////
    case 4:{
          WIMU_DevInfoFrame_t devinfo;
          osal_memcpy(&devinfo,&unstuffed[2],sizeof(devinfo));
          //printf("DevInfo\n");
          
          DevInfo_SetParameter( 2, 2, &devinfo.serialNumber );
          DevInfo_SetParameter( 4, sizeof(uint8), &devinfo.hardRevision );
          DevInfo_SetParameter( 3, 29, &devinfo.firmSoftRevision[0] );
          DevInfo_SetParameter( 5, 29, &devinfo.firmSoftRevision[0] );          

          if(scanRspData[8] == 'x' && scanRspData[9] == 'x' && scanRspData[10] == 'x' && scanRspData[11] == 'x')
          {
            uint8 serialNumber[4] = {0};
            sprintf ((char *)serialNumber, "00%X", devinfo.serialNumber);
            scanRspData[8] = serialNumber[0];
            scanRspData[9] = serialNumber[1];
            scanRspData[10] = serialNumber[2];
            scanRspData[11] = serialNumber[3];
            GAP_UpdateAdvertisingData( WIMU_TaskID, 0, sizeof(scanRspData), scanRspData );
          }
          
          // Set sampling rate of the module
          //Actimetry_SetParameter( ACTIMETRY_CONFIG, 1, &devinfo.samplingRate);
    } 
        break;
        
        ///////////////
        // Battery
        ///////////////
    case 3:{	// Battery Data
      WIMU_battery_packet_t batteryData;
      
      // Process Data
      osal_memcpy(&batteryData,&unstuffed[2],sizeof(batteryData));           
                   
      // Update Battery values in the profile
      Batt_SetParameter( 0, sizeof(WIMU_battery_packet_t), &batteryData );
          
          //GAP_UpdateAdvertisingData( WIMU_TaskID, FALSE, sizeof(scanRspData), scanRspData );
    }
        break;
        
        ///////////////
        // IMU
        ///////////////
    case 1:{ //IMU Data{
      WIMU_actimetry_imu_packet_t        imuData;
      WIMU_actimetry_quaternion_packet_t quaternionData;
      osal_memcpy(&imuData,&unstuffed[2],sizeof(imuData));
      osal_memcpy(&quaternionData,&unstuffed[2 + sizeof(imuData)],sizeof(WIMU_actimetry_quaternion_packet_t));
                    
      // Update Actimetry values in the profile
      Actimetry_SetParameter( 12, sizeof(WIMU_actimetry_imu_packet_t), &imuData );
      Actimetry_SetParameter( 13, sizeof(WIMU_actimetry_quaternion_packet_t), &quaternionData );
    }
        break;
        
        ///////////////
        // GPS
        ///////////////        
    case 2:{
      WIMU_GPSFrame_t gpsData;
      osal_memcpy(&gpsData,&unstuffed[2],sizeof(gpsData));
      
      // Update values in profile
      Gps_SetParameter( 1, sizeof(locationAndSpeed_t), &gpsData.loc_speed );
      Gps_SetParameter( 2, sizeof(positionQuality_t), &gpsData.quality );
      Gps_SetParameter( 3, sizeof(date_time_t), &gpsData.date_time );
    }
    break;
    
    // Date and time    
    case 6:{
        currentTime_t currentTime;
        osal_memcpy(&currentTime,&unstuffed[2],sizeof(currentTime));
        Time_SetParameter(0, sizeof(currentTime_t), &currentTime );
    } break;
    
    // WIMU Config
    case 7:{
        //printf("Config\n");
        IMU_Config_t config;
        osal_memcpy(&config, &unstuffed[2], sizeof(IMU_Config_t));
        Actimetry_SetParameter( 14, sizeof(IMU_Config_t), &config);
    }break;
    
    // WIMU Control
    case 5:{
        RemControl_t control;
        osal_memcpy(&control, &unstuffed[2], sizeof(RemControl_t));
        Actimetry_SetParameter( 15, sizeof(RemControl_t), &control);
    }break;
    
    
    default:
      break;
    }
    
    // Remove bytes from data buffer
    //printf("#%d: %d, %d\n\r", msgCount, unstuffed[0], unstuffed[1]);
    osal_memcpy(&rx_byte[0],&rx_byte[end_pos+1],rx_index - end_pos);
    rx_index -= end_pos+1;
    osal_memset(&rx_byte[rx_index],0xFF, 256 - rx_index - 1);
    
    end_pos = WIMU_getEndOfFrame_Position();
  }
   
}

uint8 WIMU_getEndOfFrame_Position(void){
  uint8 end_pos=0;
  uint16 i;
  for (i=0; i<rx_index; i++){
    if (rx_byte[i] == 0x00){
      end_pos=i;
      break;
    }
  }
  
  return end_pos;
}


/*
 * StuffData byte stuffs "length" bytes of
 * data at the location pointed to by "ptr",
 * writing the output to the location pointed
 * to by "dst".
 */


void COBS_StuffData(const unsigned char *ptr,
unsigned long length, unsigned char *dst)
{
  const unsigned char *end = ptr + length;
  unsigned char *code_ptr = dst++;
  unsigned char code = 0x01;

  while (ptr < end)
  {
    if (*ptr == 0)
      (*code_ptr = (code), code_ptr = dst++, code = 0x01);
    else
    {
      *dst++ = *ptr;
      if (++code == 0xFF)
        (*code_ptr = (code), code_ptr = dst++, code = 0x01);
    }
    ptr++;
  }

  (*code_ptr = (code), code_ptr = dst++, code = 0x01);
}

/*
 * Defensive UnStuffData, which prevents poorly
 * conditioned data at *ptr from over-running
 * the available buffer at *dst.
 */

void COBS_UnStuffData(const unsigned char *ptr,
unsigned long length, unsigned char *dst)
{
  const unsigned char *end = ptr + length;
  while (ptr < end)
  {
    int i, code = *ptr++;
    for (i=1; ptr<end && i<code; i++)
      *dst++ = *ptr++;
    if (code < 0xFF)
      *dst++ = 0;
  }
}
/*********************************************************************
*********************************************************************/
