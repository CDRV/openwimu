#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_startup.c"
/**************************************************************************************************
  Filename:       hal_startup.c
  Revised:        $Date: 2012-06-12 12:38:53 -0700 (Tue, 12 Jun 2012) $
  Revision:       $Revision: 30729 $

  Description:    Contains code that needs to run before main()

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
 *************************************************************************************************/
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_board.h"
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
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_defs.h"
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





















#line 101 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\include\\hal_defs.h"

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
#line 2 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\hal\\include\\hal_board.h"
#line 43 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\COMPONENTS\\hal\\target\\CC2540EB\\hal_startup.c"






#pragma language=extended

//
// Locate low_level_init in the CSTART module
//
#pragma location="CSTART"
//
// If the code model is banked, low_level_init must be declared
// __near_func elsa a ?BRET is performed
//

__near_func __root char



__low_level_init(void);

/**************************************************************************************************
 * @fn          __low_level_init
 *
 * @brief      The function __low_level_init is called by the start-up code before doing
 *                the normal initialization of data segments. If the return value is zero,
 *                initialization is not performed.
 *
 * @param       None
 *
 * @return      0 - don't intialize data segments / 1 - do initialization
 **************************************************************************************************/

__near_func __root char



__low_level_init(void)
{
  /*==================================*/
  /*  Initialize hardware.            */
  /*==================================*/
  // Map flash bank with constants into XDATA for access to "ROM mapped as data".





  MEMCTR = (MEMCTR & 0xF8) | 0x01;


  /*==================================*/
  /* Choose if segment initialization */
  /* should be done or not.           */
  /* Return: 0 to omit seg_init       */
  /*         1 to run seg_init        */
  /*==================================*/
  return 1;
}

#pragma language=default

