#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
/**************************************************************************************************
  Filename:     hal_uart.c
  Revised:      $Date: 2013-02-06 09:21:21 -0800 (Wed, 06 Feb 2013) $
  Revision:     $Revision: 33001 $

  Description:  This file contains the interface to the H/W UART driver.


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
 * INCLUDES
 */

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"
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

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"
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
#line 54 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_types.h"
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
#line 82 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_types.h"

/* ----------- KEIL Compiler ----------- */
#line 105 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_types.h"


/* ------------------------------------------------------------------------------------------------
 *                                        Standard Defines
 * ------------------------------------------------------------------------------------------------
 */













/**************************************************************************************************
 */
#line 55 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"


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
#line 76 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"


#line 84 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"

/* ---------------------- Keil Compiler ---------------------- */
#line 104 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"


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
#line 131 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"

/* ------------------------------------------------------------------------------------------------
 *                                        Reset Macro
 * ------------------------------------------------------------------------------------------------
 */
#line 142 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"

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




#line 199 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_mcu.h"

/**************************************************************************************************
 */
#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"



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

#line 101 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"



/* 1 - Green */






  /* 2 - Red */





  /* 3 - Yellow */






/* Push Button Configuration */




/* S1 */



#line 140 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Joystick Center Press */




/* OSAL NV implemented by internal flash pages. */

// Flash is partitioned into 8 banks of 32 KB or 16 pages.


// Flash is constructed of 128 pages of 2 KB.


// SNV can use a larger logical page size to accomodate more or bigger items or extend lifetime.



// CODE banks get mapped into the XDATA range 8000-FFFF.


// The last 16 bytes of the last available page are reserved for flash lock bits.


// NV page definitions must coincide with segment declaration in project *.xcl file.
#line 172 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"

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
#line 256 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Debounce */


/* ----------- Push Buttons ---------- */
#line 267 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* LED's */























#line 315 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* XNV */







// The TI reference design uses UART1 Alt. 2 in SPI mode.
#line 356 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Driver Configuration */

/* Set to TRUE enable H/W TIMER usage, FALSE disable it */




/* Set to TRUE enable ADC usage, FALSE disable it */




/* Set to TRUE enable DMA usage, FALSE disable it */




/* Set to TRUE enable Flash access, FALSE disable it */




/* Set to TRUE enable AES usage, FALSE disable it */








/* Set to TRUE enable LCD usage, FALSE disable it */




/* Set to TRUE enable LED usage, FALSE disable it */
#line 400 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"

/* Set to TRUE enable KEY usage, FALSE disable it */




/* Set to TRUE enable UART usage, FALSE disable it */
#line 414 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"


  // Always prefer to use DMA over ISR.
#line 444 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_board_cfg.h"
  
  // Used to set P2 priority - USART0 over USART1 if both are defined.





  















/*******************************************************************************
*/
#line 45 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_drivers.h"
/**************************************************************************************************
  Filename:       hal_drivers.h
  Revised:        $Date: 2012-07-09 13:23:30 -0700 (Mon, 09 Jul 2012) $
  Revision:       $Revision: 30873 $

  Description:    This file contains the interface to the Drivers service.


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
 * INCLUDES
 **************************************************************************************************/



/**************************************************************************************************
 * CONSTANTS
 **************************************************************************************************/















/**************************************************************************************************
 * GLOBAL VARIABLES
 **************************************************************************************************/

extern uint8 Hal_TaskID;

/**************************************************************************************************
 * FUNCTIONS - API
 **************************************************************************************************/

extern void Hal_Init ( uint8 task_id );

/*
 * Process Serial Buffer
 */
extern uint16 Hal_ProcessEvent ( uint8 task_id, uint16 events );

/*
 * Process Polls
 */
extern void Hal_ProcessPoll (void);

/*
 * Initialize HW
 */
extern void HalDriverInit (void);







/**************************************************************************************************
**************************************************************************************************/
#line 47 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
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





#line 49 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"





/*********************************************************************
 * GLOBAL FUNCTIONS
 */

void HalUARTIsrDMA(void);

/*********************************************************************
 * LOCAL FUNCTIONS
 */

#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"
/**************************************************************************************************
  Filename:       _hal_uart_dma.c
  Revised:        $Date: 2012-12-12 13:58:27 -0800 (Wed, 12 Dec 2012) $
  Revision:       $Revision: 32579 $

  Description: This file contains the interface to the H/W UART driver by DMA.

  A known defect is that when flow control is enabled, the function HalUARTPollTxTrigDMA() can
  prematurely invoke HAL_DMA_MAN_TRIGGER(HAL_DMA_CH_TX) and clobber that last byte of one txBuf[]
  block transfer with the first byte of the next txBuf[] block transfer.  Additionally, Tx can
  become permanently stalled during heavy use and/or simultaeous heavy radio traffic when using
  DMA for the Tx and hardware flow control.

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

/* ------------------------------------------------------------------------------------------------
 *                                          Includes
 * ------------------------------------------------------------------------------------------------
 */

#line 1 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\string.h"
/*                       - STRING.H -

   The ANSI 'string' function declarations.

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

#line 18 "C:\\Program Files (x86)\\IAR Systems\\Embedded Workbench 6.0\\8051\\inc\\clib\\string.h"















__intrinsic  void *memcpy(void *, const void *, size_t);

__intrinsic  void *memmove(void *, const void *, size_t);

__intrinsic  void *memchr(const void *, int, size_t);

__intrinsic  void *memset(void *, int, size_t);

__intrinsic  int memcmp(const void *, const void *, size_t);

__intrinsic  char *strchr(const char *, int);

__intrinsic  int strcmp(const char *, const char *);

__intrinsic  int strncmp(const char *, const char *, size_t);

__intrinsic  int strcoll(const char *, const char *);

__intrinsic  size_t strlen(const char *);

__intrinsic  size_t strcspn(const char *, const char *);

__intrinsic  size_t strspn(const char *, const char *);

__intrinsic  char *strpbrk(const char *, const char *);

__intrinsic  char *strrchr(const char *, int);

__intrinsic  char *strstr(const char *, const char *);

__intrinsic  char *strcat(char *, const char *);

__intrinsic  char *strncat(char *, const char *, size_t);

__intrinsic  char *strcpy(char *, const char *);

__intrinsic  char *strncpy(char *, const char *, size_t);

__intrinsic  char *strerror(int);

__intrinsic  char *strtok(char *, const char *);

__intrinsic  size_t strxfrm(char *, const char *, size_t);







#line 51 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

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
#line 53 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_board.h"
#line 54 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_dma.h"
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
#line 53 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_dma.h"




/*********************************************************************
 * MACROS
 */





























// Macro for quickly setting the source address of a DMA structure.






// Macro for quickly setting the destination address of a DMA structure.






// Macro for quickly setting the number of bytes to be transferred by the DMA,
// max length is 0x1FFF.
#line 111 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_dma.h"




























































/*********************************************************************
 * CONSTANTS
 */

// Use LEN for transfer count

// Transfer the first byte + the number of bytes indicated by the first byte

// Transfer the number of bytes indicated by the first byte (starting with the first byte)

// Transfer the first byte + the number of bytes indicated by the first byte + 1 more byte

// Transfer the first byte + the number of bytes indicated by the first byte + 2 more bytes










#line 225 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_dma.h"
























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
#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"




/* ------------------------------------------------------------------------------------------------
 *                                           Constants
 * ------------------------------------------------------------------------------------------------
 */

// UxCSR - USART Control and Status Register.
#line 74 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

// UxUCR - USART UART Control Register.
#line 84 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

// UxUCR - USART UART Generic Control

   








#line 120 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

#line 142 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

#line 158 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

#line 188 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"
// Falling edge ISR on P1.4-7 pins.





#line 201 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

// For known defects described above in the moduel description, prefer to drive the Tx by ISR vice
// DMA unless H/W flow control is not used and full-throughput on Tx is absolutely essential.




// TRUE or FALSE whether or not to flush the Rx queue when an Rx overrun is detected.
// Note that when HAL_UART_RX_FLUSH is set to TRUE, then uartRxBug and its hunt for where the Rx
// DMA is working is absolutely necessary because the flush can leave the dmaCfg.rxHead stranded.




// Minimum delay before allowing sleep and/or clearing DMA ready-out after a DMA ready-in ISR.
// ST-ticks for 6-msecs plus 1 tick added for when the dmaRdyDly is forced from zero to 0xFF.
// If a greater delay than 6-msec is configured, then the logic should be changed to use a uint16.
//efine DMA_PM_DLY                 198   // 32768 * 0.006 + 1 -> 198.
// This delay should be set as short as possible to work with the max expected latency in the sender
// between its asserting ready-out and its checking of the ready-in response. The RBA Master
// logic in the internal uart-to-uart bridge app checks for ready-in immediately,
// so this is just set to zero.


// The timeout tick is at 32-kHz, so multiply msecs by 33.


#line 243 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

// ST-ticks for 1 byte @ 38.4-kB plus 1 tick added for when the txTick is forced from zero to 0xFF.


/* ------------------------------------------------------------------------------------------------
 *                                           TypeDefs
 * ------------------------------------------------------------------------------------------------
 */




typedef uint16 rxIdx_t;



typedef uint8 txIdx_t;




typedef struct
{
  uint16 rxBuf[300];
  rxIdx_t rxHead;
  rxIdx_t rxTail;





  uint8 txBuf[50];
  volatile txIdx_t txHead;
  txIdx_t txTail;
  uint8 txMT;
#line 289 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

  halUARTCBack_t uartCB;
} uartDMACfg_t;

/* ------------------------------------------------------------------------------------------------
 *                                           Macros
 * ------------------------------------------------------------------------------------------------
 */











#line 318 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

#line 329 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"






/* ------------------------------------------------------------------------------------------------
 *                                           Local Variables
 * ------------------------------------------------------------------------------------------------
 */

// The following two variables are only used when POWER_SAVING is defined.
static volatile uint8 dmaRdyIsr;
static uint8 dmaRdyDly;  // Minimum delay before allowing sleep after detecting RdyIn de-asserted.

static uartDMACfg_t dmaCfg;

/* Used to walk the dmaCfg.rxBuf[] one byte per polling pass as a work-around for the case when
 * full-duplex traffic using Rx & Tx DMA running simultaneously.
 * Although not captured in this UART by DMA case, the _hal_uart_spi.c was able to show that the
 * immediate buffer area around the spiRxIdx consists of "cleared" uint16 values,
 * but 10-16 indices ahead, there are valid SPI packets ready to be parsed.
 */
static rxIdx_t uartRxBug;  // Pre-emptive (not empirically determined necessary) use from SPI case.

/* ------------------------------------------------------------------------------------------------
 *                                          Global Functions
 * ------------------------------------------------------------------------------------------------
 */

void HalUART_DMAIsrDMA(void);

/* ------------------------------------------------------------------------------------------------
 *                                           Local Functions
 * ------------------------------------------------------------------------------------------------
 */

// Invoked by functions in hal_uart.c when this file is included.
static void HalUARTInitDMA(void);
static void HalUARTOpenDMA(halUARTCfg_t *config);
static uint16 HalUARTReadDMA(uint8 *buf, uint16 len);
static uint16 HalUARTWriteDMA(uint8 *buf, uint16 len);
static void HalUARTPollDMA(void);
static uint16 HalUARTRxAvailDMA(void);
static uint8 HalUARTBusyDMA(void);





/******************************************************************************
 * @fn      HalUARTInitDMA
 *
 * @brief   Initialize the UART
 *
 * @param   none
 *
 * @return  none
 *****************************************************************************/
static void HalUARTInitDMA(void)
{
  halDMADesc_t *ch;



  PERCFG |= 0x02;     // Set UART1 I/O to Alt. 2 location on P1.

  P1SEL  |= 0xC0;         // Enable Peripheral control of Rx/Tx on Px.
  U1CSR = 0x80;                  // Mode is UART Mode.
  U1UCR = 0x80;                 // Flush it.

  P2DIR &= ~0xC0;
  P2DIR |= 0x40;

  if (0)
  {
    // Setup GPIO for interrupts by falling edge on DMA_RDY_IN.
    P1IEN |= (1 << (4));
    PICTL |= (1 << (2));

    (P1_5 = 1);
    P1DIR |= (1 << (5));
  }

#line 448 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

  // Setup Rx by DMA.
  ch = (dmaCh1234+((3)-1));

  // Abort any pending DMA operations (in case of a soft reset).
  DMAARM = (0x80 | (0x01 << (3)));

  // The start address of the source.
  do { ch->srcAddrH = (uint8)((uint16)(0x70F9) >> 8); ch->srcAddrL = (uint8)((uint16)(0x70F9) & 0xFF); } while (456 == -1);

  // Using the length field to determine how many bytes to transfer.
  do { ch->xferLenV &= ~0xE0; ch->xferLenV |= (0x00 << 5); } while (459 == -1);

  /* The trick is to cfg DMA to xfer 2 bytes for every 1 byte of Rx.
   * The byte after the Rx Data Buffer is the Baud Cfg Register,
   * which always has a known value. So init Rx buffer to inverse of that
   * known value. DMA word xfer will flip the bytes, so every valid Rx byte
   * in the Rx buffer will be preceded by a DMA_PAD char equal to the
   * Baud Cfg Register value.
   */
  do { ch->ctrlA &= ~0x80; ch->ctrlA |= (0x01 << 7); } while (468 == -1);

  // The bytes are transferred 1-by-1 on Rx Complete trigger.
  do { ch->ctrlA &= ~0x60; ch->ctrlA |= (0x02 << 5); } while (471 == -1);
  do { ch->ctrlA &= ~0x1F; ch->ctrlA |= 16; } while (472 == -1);

  // The source address is constant - the Rx Data Buffer.
  do { ch->ctrlB &= ~0xC0; ch->ctrlB |= (0x00 << 6); } while (475 == -1);

  // The destination address is incremented by 1 word after each transfer.
  do { ch->ctrlB &= ~0x30; ch->ctrlB |= (0x01 << 4); } while (478 == -1);
  do { ch->dstAddrH = (uint8)((uint16)(dmaCfg . rxBuf) >> 8); ch->dstAddrL = (uint8)((uint16)(dmaCfg . rxBuf) & 0xFF); } while (479 == -1);
  do { ch->xferLenL = (uint8)(uint16)(300); ch->xferLenV &= ~0x1F; ch->xferLenV |= (uint8)((uint16)(300) >> 8); } while (480 == -1);

  // The DMA is to be polled and shall not issue an IRQ upon completion.
  do { ch->ctrlB &= ~0x08; ch->ctrlB |= (0x00 << 3); } while (483 == -1);

  // Xfer all 8 bits of a byte xfer.
  do { ch->ctrlB &= ~0x04; ch->ctrlB |= (0x00 << 2); } while (486 == -1);

  // DMA has highest priority for memory access.
  do { ch->ctrlB &= ~0x03; ch->ctrlB |= 0x02; } while (489 == -1);

  volatile uint8 dummy = *(volatile uint8 *)0x70F9;  // Clear the DMA Rx trigger.
  DMAIRQ &= ~( 1 << (3) );
  DMAARM = (0x01 << (3));
  (void)memset(dmaCfg.rxBuf, (U1BAUD ^ 0xFF), 300*2);
}

/******************************************************************************
 * @fn      HalUARTOpenDMA
 *
 * @brief   Open a port according tp the configuration specified by parameter.
 *
 * @param   config - contains configuration information
 *
 * @return  none
 *****************************************************************************/
static void HalUARTOpenDMA(halUARTCfg_t *config)
{
  dmaCfg.uartCB = config->callBackFunc;

  // Only supporting subset of baudrate for code size - other is possible.
  /*
  HAL_ASSERT((config->baudRate == HAL_UART_BR_9600) ||
                  (config->baudRate == HAL_UART_BR_19200) ||
                  (config->baudRate == HAL_UART_BR_38400) ||
                  (config->baudRate == HAL_UART_BR_57600) ||
                  (config->baudRate == HAL_UART_BR_115200));
  
  */
  if (config->baudRate == 0x07 ||
      config->baudRate == 0x08 ||
      config->baudRate == 0x03 ||
      config->baudRate == 0x04 ||
      config->baudRate == 0x0A)
  {
    U1BAUD = 216;
  }
  else
  {
    U1BAUD = 59;
  }

  switch (config->baudRate)
  {
    case 0x05:
      U1GCR = 6;
      break;
    case 0x06:
      U1GCR = 7;
      break;
    case 0x00:
    case 0x07:
      U1GCR = 8;
      break;
    case 0x01:
    case 0x08:
      U1GCR = 9;
      break;
    case 0x02:
    case 0x03:
      U1GCR = 10;
      break;
    case 0x09:
    case 0x04:
      U1GCR = 11;
      break;
    case 0x0A:
      U1GCR = 12;
      break;
    default:
      // HAL_UART_BR_115200
      U1GCR = 11;
      break;
  }
//    UxBAUD = 0;
//  UxBAUD = 59;
//  UxBAUD = 216;
//  UxGCR = 11;
  
  if (0 || config->flowControl)
  {
    U1UCR = 0x40 | 0x02;      // 8 bits/char; no parity; 1 stop bit; stop bit hi.
    P1SEL |= 0x10;         // Enable Peripheral control of CTS flow control on Px.
  }
  else
  {
    U1UCR = 0x02;                 // 8 bits/char; no parity; 1 stop bit; stop bit hi.
//    UxUCR = UCR_START;
//    UxUCR = UCR_STOP | UCR_SPB;                 // 8 bits/char; no parity; 2 stop bits; stop bit hi.
//    UxUCR = UCR_START | UCR_SPB;                 // 8 bits/char; no parity; 2 stop bits; stop bit lo.
  
  }

  
  U1CSR = (0x80 | 0x40);

  if (0)
  {
    P1IFG = 0;
    P1IF = 0;
    IEN2 |= (1 << (4));
  }
  else if (U1UCR & 0x40)
  {
    // DMA Rx is always on (self-resetting). So flow must be controlled by the S/W polling the
    // circular Rx queue depth. Start by allowing flow.
    (P1_5 = 0);
    P1DIR |= 0x20;
  }


  UTX1IF = 1;  // Prime the ISR pump.

  
//  UxGCR |= GCR_ORDER;
//  UxUCR = 0;
//  UxUCR |= UCR_FLUSH;
//  UxUCR |= UCR_FLOW;
//  UxUCR |= UCR_D9;
//  UxUCR |= UCR_BIT9;
//  UxUCR |= UCR_PARITY;
//  UxUCR |= UCR_SPB;
//  UxUCR |= UCR_STOP;
//  UxUCR |= UCR_START;
  
}

/*****************************************************************************
 * @fn      HalUARTReadDMA
 *
 * @brief   Read a buffer from the UART
 *
 * @param   buf  - valid data buffer at least 'len' bytes in size
 *          len  - max length number of bytes to copy to 'buf'
 *
 * @return  length of buffer that was read
 *****************************************************************************/
static uint16 HalUARTReadDMA(uint8 *buf, uint16 len)
{
  uint16 cnt;

  for (cnt = 0; cnt < len; cnt++)
  {
    if (!((uint8)U1BAUD == (((dmaCfg . rxBuf[(dmaCfg . rxHead)]) >> 8) & 0xFF)))
    {
      break;
    }
    *buf++ = (*(volatile uint8 *)(dmaCfg . rxBuf+(dmaCfg . rxHead)));
    (dmaCfg . rxBuf[(dmaCfg . rxHead)] = ((uint16)(((0) & 0x00FF) + ((((U1BAUD ^ 0xFF)) & 0x00FF) << 8))));
    do { if (++(dmaCfg . rxHead) >= 300) { (dmaCfg . rxHead) = 0; } } while (639 == -1);
  }

  if (!0 && (U1UCR & 0x40))
  {
    if (HalUARTRxAvailDMA() < (300 - 1))
    {
      (P1_5 = 0);  // Re-enable the flow asap (i.e. not wait until next uart poll).
    }
  }

  return cnt;
}

/******************************************************************************
 * @fn      HalUARTWriteDMA
 *
 * @brief   Write a buffer to the UART, enforcing an all or none policy if the requested length
 *          exceeds the space available.
 *
 * @param   buf - pointer to the buffer that will be written, not freed
 *          len - length of
 *
 * @return  length of the buffer that was sent
 *****************************************************************************/
static uint16 HalUARTWriteDMA(uint8 *buf, uint16 len)
{

  // Enforce all or none.
  if ((dmaCfg . txHead > dmaCfg . txTail) ? (dmaCfg . txHead - dmaCfg . txTail - 1) : (50 - dmaCfg . txTail + dmaCfg . txHead - 1) < len)
  {
    return 0;
  }

  for (uint16 cnt = 0; cnt < len; cnt++)
  {
    dmaCfg.txBuf[dmaCfg.txTail] = *buf++;
    dmaCfg.txMT = 0;

    if (dmaCfg.txTail >= 50-1)
    {
      dmaCfg.txTail = 0;
    }
    else
    {
      dmaCfg.txTail++;
    }

    // Keep re-enabling ISR as it might be keeping up with this loop due to other ints.
    IEN2 |= 0x08;
  }
#line 739 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

  return len;
}

/******************************************************************************
 * @fn      HalUARTPollDMA
 *
 * @brief   Poll a USART module implemented by DMA, including the hybrid solution in which the Rx
 *          is driven by DMA but the Tx is driven by ISR.
 *
 * @param   none
 *
 * @return  none
 *****************************************************************************/
static void HalUARTPollDMA(void)
{
  uint8 evt = 0;
  uint16 cnt;

#line 793 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"





  if (!((uint8)U1BAUD == (((dmaCfg . rxBuf[(dmaCfg . rxHead)]) >> 8) & 0xFF)))
  {
    if (((uint8)U1BAUD == (((dmaCfg . rxBuf[(uartRxBug)]) >> 8) & 0xFF)))
    {
      do {
        do { if (++(dmaCfg . rxHead) >= 300) { (dmaCfg . rxHead) = 0; } } while (803 == -1);
      } while (!((uint8)U1BAUD == (((dmaCfg . rxBuf[(dmaCfg . rxHead)]) >> 8) & 0xFF)));

      uartRxBug = dmaCfg.rxHead;
      dmaCfg.rxTail = dmaCfg.rxHead;
    }
    do { if (++(uartRxBug) >= 300) { (uartRxBug) = 0; } } while (809 == -1);
  }

  cnt = HalUARTRxAvailDMA();  // Wait to call until after the above DMA Rx bug work-around.

#line 832 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"
  if (cnt != 0)
  {
    evt = 0x04;
  }


  if (cnt >= (300 - 16))
  {
    evt |= 0x01;
  }
  else if (cnt >= (300 - 1))
  {
    evt |= 0x02;

    if (!0 && (U1UCR & 0x40))
    {
      (P1_5 = 1);  // Disable Rx flow.
    }
  }

  if (dmaCfg.txMT)
  {
    dmaCfg.txMT = 0;
    evt |= 0x10;
  }

  if ((evt != 0) && (dmaCfg.uartCB != 0))
  {
    dmaCfg.uartCB(2-1, evt);
  }

  if (0 && (dmaRdyDly == 0) && !HalUARTBusyDMA())
  {
    (P1_5 = 1);
  }
}

/**************************************************************************************************
 * @fn      HalUARTRxAvailDMA()
 *
 * @brief   Calculate Rx Buffer length - the number of bytes in the buffer.
 *
 * @param   none
 *
 * @return  length of current Rx Buffer
 **************************************************************************************************/
static uint16 HalUARTRxAvailDMA(void)
{
  // First, synchronize the Rx tail marker with where the DMA Rx engine is working.
  rxIdx_t tail = dmaCfg.rxTail;

  do
  {
    if (!((uint8)U1BAUD == (((dmaCfg . rxBuf[(tail)]) >> 8) & 0xFF)))
    {
      break;
    }

    do { if (++(tail) >= 300) { (tail) = 0; } } while (890 == -1);
  } while (tail != dmaCfg.rxHead);

  dmaCfg.rxTail = tail;

  uint16 cnt = tail - dmaCfg.rxHead;

  // If the DMA Rx may have overrun the circular queue, investigate further.
  if ((cnt == 0) && ((uint8)U1BAUD == (((dmaCfg . rxBuf[(tail)]) >> 8) & 0xFF)))
  {
    /* Ascertain whether this polling is racing with the DMA Rx which may have clocked in a byte
     * since walking the tail. The Rx queue has wrapped only if the byte before the head is new.
     */
    tail = dmaCfg.rxHead;
    do { if ((tail)-- == 0) { (tail) = 300-1; } } while (904 == -1);

    if (((uint8)U1BAUD == (((dmaCfg . rxBuf[(tail)]) >> 8) & 0xFF)))
    {
      if (1)
      {
        (void)memset(dmaCfg.rxBuf, (U1BAUD ^ 0xFF), 300*2);

        uartRxBug = dmaCfg.rxHead;
        dmaCfg.rxTail = dmaCfg.rxHead;
      }
      else
      {
        cnt = 300;
      }
    }
    else
    {
      cnt = 1;
    }
  }
  else if (cnt > 300)  // If the tail has wrapped at the end of the Rx queue.
  {
    cnt += 300;
  }

  return cnt;
}

/******************************************************************************
 * @fn      HalUARTBusyDMA
 *
 * @brief   Query the UART hardware & buffers before entering PM mode 1, 2 or 3.
 *
 * @param   None
 *
 * @return  TRUE if the UART H/W is busy or buffers are not empty; FALSE otherwise.
 *****************************************************************************/
static uint8 HalUARTBusyDMA( void )
{

  return !((!(U1CSR & (0x01 | 0x04))) && (HalUARTRxAvailDMA() == 0) &&
           (dmaCfg.txHead == dmaCfg.txTail));




}

#line 1017 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"

/******************************************************************************
 * @fn      HalUART_DMAIsrDMA
 *
 * @brief   Handle the Tx done DMA ISR.
 *
 * @param   none
 *
 * @return  none
 *****************************************************************************/
void HalUART_DMAIsrDMA(void)
{
#line 1049 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"
}

#line 1078 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\_hal_uart_dma.c"


/***************************************************************************************************
 * @fn      halUartTxIsr
 *
 * @brief   UART Transmit Interrupt
 *
 * @param   None
 *
 * @return  None
 ***************************************************************************************************/



_Pragma("vector=0x73") __near_func __interrupt void halUart1TxIsr(void); _Pragma("vector=0x73") __near_func __interrupt void halUart1TxIsr(void)

{
  { halIntState_t _isrIntState = EA; do { EA = 1; } while (1095 == -1);;

  if (dmaCfg.txHead == dmaCfg.txTail)
  {
    IEN2 &= ~0x08;
    dmaCfg.txMT = 1;
  }
  else
  {
    UTX1IF = 0;
    U1DBUF = dmaCfg.txBuf[dmaCfg.txHead++];

    if ((50 != 256) && (dmaCfg.txHead >= 50))
    {
      dmaCfg.txHead = 0;
    }
  }

  EA = _isrIntState; };
}


/**************************************************************************************************
*/
#line 66 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
#line 76 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"

/******************************************************************************
 * @fn      HalUARTInit
 *
 * @brief   Initialize the UART
 *
 * @param   none
 *
 * @return  none
 *****************************************************************************/
void HalUARTInit(void)
{
#line 99 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
  HalUARTInitDMA();
#line 111 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
}

/******************************************************************************
 * @fn      HalUARTOpen
 *
 * @brief   Open a port according tp the configuration specified by parameter.
 *
 * @param   port   - UART port
 *          config - contains configuration information
 *
 * @return  Status of the function call
 *****************************************************************************/
uint8 HalUARTOpen(uint8 port, halUARTCfg_t *config)
{




  if (port == 0x01)  HalUARTOpenDMA(config);
#line 151 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"

  return 0x00;
}

/*****************************************************************************
 * @fn      HalUARTRead
 *
 * @brief   Read a buffer from the UART
 *
 * @param   port - USART module designation
 *          buf  - valid data buffer at least 'len' bytes in size
 *          len  - max length number of bytes to copy to 'buf'
 *
 * @return  length of buffer that was read
 *****************************************************************************/
uint16 HalUARTRead(uint8 port, uint8 *buf, uint16 len)
{




  if (port == 0x01)  return HalUARTReadDMA(buf, len);
#line 186 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"

#line 196 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
  return 0;

}

/******************************************************************************
 * @fn      HalUARTWrite
 *
 * @brief   Write a buffer to the UART.
 *
 * @param   port - UART port
 *          buf  - pointer to the buffer that will be written, not freed
 *          len  - length of
 *
 * @return  length of the buffer that was sent
 *****************************************************************************/
uint16 HalUARTWrite(uint8 port, uint8 *buf, uint16 len)
{




  if (port == 0x01)  return HalUARTWriteDMA(buf, len);
#line 231 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"

#line 242 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
  return 0;

}

/******************************************************************************
 * @fn      HalUARTSuspend
 *
 * @brief   Suspend UART hardware before entering PM mode 1, 2 or 3.
 *
 * @param   None
 *
 * @return  None
 *****************************************************************************/
void HalUARTSuspend( void )
{



}

/******************************************************************************
 * @fn      HalUARTResume
 *
 * @brief   Resume UART hardware after exiting PM mode 1, 2 or 3.
 *
 * @param   None
 *
 * @return  None
 *****************************************************************************/
void HalUARTResume( void )
{



}

/***************************************************************************************************
 * @fn      HalUARTPoll
 *
 * @brief   Poll the UART.
 *
 * @param   none
 *
 * @return  none
 *****************************************************************************/
void HalUARTPoll(void)
{
#line 300 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
  HalUARTPollDMA();
#line 312 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
}

/**************************************************************************************************
 * @fn      Hal_UART_RxBufLen()
 *
 * @brief   Calculate Rx Buffer length - the number of bytes in the buffer.
 *
 * @param   port - UART port
 *
 * @return  length of current Rx Buffer
 **************************************************************************************************/
uint16 Hal_UART_RxBufLen( uint8 port )
{




  if (port == 0x01)  return HalUARTRxAvailDMA();
#line 343 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"

#line 351 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
  return 0;

}

void HalUARTIsrDMA(void)
{
#line 367 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_uart.c"
  HalUART_DMAIsrDMA();



}

/******************************************************************************
******************************************************************************/
