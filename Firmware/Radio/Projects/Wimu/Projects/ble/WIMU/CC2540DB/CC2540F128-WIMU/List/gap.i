#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\Roles\\gap.c"
/*************************************************************************************************
  Filename:       gap.c
  Revised:        $Date: 2013-05-06 13:33:47 -0700 (Mon, 06 May 2013) $
  Revision:       $Revision: 34153 $

  Description:    This file contains the GAP Configuration API.


  Copyright 2011 Texas Instruments Incorporated. All rights reserved.

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
**************************************************************************************************/

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





#line 41 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\Roles\\gap.c"
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





#line 83 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\include\\gap.h"
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





#line 42 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\Roles\\gap.c"


/*********************************************************************
 * MACROS
 */

/*********************************************************************
 * CONSTANTS
 */

/*********************************************************************
 * GLOBAL VARIABLES
 */

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
 * LOCAL FUNCTION PROTOTYPES
 */

/*********************************************************************
 * API FUNCTIONS
 */

/*********************************************************************
 * Called to setup the device.  Call just once.
 *
 * Public function defined in gap.h.
 */
bStatus_t GAP_DeviceInit(  uint8 taskID,
                           uint8 profileRole,
                           uint8 maxScanResponses,
                           uint8 *pIRK,
                           uint8 *pSRK,
                           uint32 *pSignCounter )
{
  bStatus_t stat = 0x02;   // Return status

  // Valid profile roles and supported combinations
  switch ( profileRole )
  {
    case 0x01:

      {
        stat = 0x00;
      }

      break;

    case 0x02:





      break;

    case 0x04:

      {
        stat = 0x00;
      }

      break;

    case 0x08:





      break;

    case (0x01 | 0x02):
#line 132 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\Roles\\gap.c"
      break;

    case (0x04 | 0x02):
#line 141 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\Roles\\gap.c"
      break;

    case (0x08 | 0x01):
#line 150 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\Roles\\gap.c"
      break;

    // Invalid profile roles
    default:
      stat = 0x02;
      break;
  }

  if ( stat == 0x00 )
  {
    // Setup the device configuration parameters
    stat = GAP_ParamsInit( taskID, profileRole );
    if ( stat == 0x00 )
    {

      {
        GAP_SecParamsInit( pIRK, pSRK, pSignCounter );
      }


#line 192 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\Profiles\\Roles\\gap.c"


      {
        // Initialize GAP Peripheral Device Manager
        (void) GAP_PeriDevMgrInit();


        {
          // Initialize SM Responder
          (void) SM_ResponderInit();
        }

      }

    }
  }

  return ( stat );
}

/*********************************************************************
*********************************************************************/
