#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
/*******************************************************************************
  Filename:       hal_sleep.c
  Revised:        $Date: 2013-03-07 06:38:43 -0800 (Thu, 07 Mar 2013) $
  Revision:       $Revision: 33411 $

  Description:    This module contains the HAL power management procedures for
                  the CC2540.

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
#line 44 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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
#line 54 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_mcu.h"



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
#line 45 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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
#line 46 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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





#line 47 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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





#line 48 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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





#line 49 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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





#line 58 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\OSAL.h"
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





#line 50 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\osal\\include\\OSAL_Tasks.h"
/**************************************************************************************************
  Filename:       OSAL_Tasks.h
  Revised:        $Date: 2007-10-28 18:41:49 -0700 (Sun, 28 Oct 2007) $
  Revision:       $Revision: 15799 $

  Description:    This file contains the OSAL Task definition and manipulation functions.


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
 * CONSTANTS
 */


/*********************************************************************
 * TYPEDEFS
 */

/*
 * Event handler function prototype
 */
typedef unsigned short (*pTaskEventHandlerFn)( unsigned char task_id, unsigned short event );

/*********************************************************************
 * GLOBAL VARIABLES
 */

extern const pTaskEventHandlerFn tasksArr[];
extern const uint8 tasksCnt;
extern uint16 *tasksEvents;

/*********************************************************************
 * FUNCTIONS
 */

/*
 * Call each of the tasks initailization functions.
 */
extern void osalInitTasks( void );

/*********************************************************************
*********************************************************************/





#line 52 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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





#line 53 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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
#line 54 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
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
#line 55 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll_sleep.h"
/*******************************************************************************
  Filename:       ll_sleep.h
  Revised:        $Date: 2013-02-27 09:25:28 -0800 (Wed, 27 Feb 2013) $
  Revision:       $Revision: 33310 $

  Description:    This file contains the Link Layer (LL) types, constants,
                  API's etc. for Sleep Management for the Bluetooth Low Energy
                  (ULE) Controller

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





#line 53 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll_sleep.h"

/*******************************************************************************
 * MACROS
 */

/*******************************************************************************
 * CONSTANTS
 */

// NanoRisc Execution Mode



// Sleep Management



/*******************************************************************************
 * TYPEDEFS
 */

/*******************************************************************************
 * LOCAL VARIABLES
 */

/*******************************************************************************
 * GLOBAL VARIABLES
 */

extern volatile __data unsigned char phyState;
extern volatile __data unsigned char clkState;

/*******************************************************************************
 * API
 */

extern __near_func void HaltMcuUsingPhyFlag(void);
//
extern __near_func void  LL_TimeToNextRfEvent( uint32 *sleepTimer, uint32 *timeout );
extern __near_func uint8 LL_PowerOffReq( uint8 mode );
extern __near_func void  LL_PowerOnReq( uint8 wakeFromPM3, uint8 wakeForRF );







#line 56 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll_timer2.h"
/*******************************************************************************
  Filename:       ll_timer2.h
  Revised:        $Date: 2012-07-13 06:58:11 -0700 (Fri, 13 Jul 2012) $
  Revision:       $Revision: 30922 $

  Description:    This file contains the Bluetooth Low Energy (BLE) Link
                  Layer (LL) software timer management software for Timer2.

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
*******************************************************************************/









/*******************************************************************************
 * INCLUDES
 */

/*******************************************************************************
 * MACROS
 */






/*******************************************************************************
 * CONSTANTS
 */

// Timer 2 Control Register



/*
** Timer 2 Multiplex Select
*/





//






/*
** Timer 2 Interrupt Masks and Flags
*/



//



//





/*
** Timer 2 Interrupt Masks
*/



//



//





/*
** Timer 2 Event Configuration
*/



//



//
#line 134 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll_timer2.h"
//



//



//
#line 150 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll_timer2.h"

/*
** Timer 2 Miscellanous
*/

#line 162 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll_timer2.h"

/*******************************************************************************
 * TYPEDEFS
 */

/*
** Anchor Point
*/
typedef struct
{
  uint32 coarse;                       // number of 625us ticks at SFD capture
  uint16 fine;                         // number of 31.25ns ticks at SFD capture
} sysTime_t;

/*******************************************************************************
 * LOCAL VARIABLES
 */

/*******************************************************************************
 * GLOBAL VARIABLES
 */

/*******************************************************************************
 * FUNCTIONS
 */

extern void   llInitTimer2( void );
extern void   llStopTimer2( void );
extern void   llStartTimer2( void );
extern void   llSetT2C1Timeout( uint16 timeout );
extern void   llSetT2C2Timeout( uint16 timeout );
extern void   llSetT2OVFC1Timeout( uint32 timeout );
extern void   llSetT2OVFC2Timeout( uint32 timeout );
extern void   llSetT2LongC1Timeout( uint32 timeout1, uint16 timeout2 );
extern void   llSetT2LongC2Timeout( uint32 timeout1, uint16 timeout2 );
extern void   llSetT2C1Event1( uint16 timeout );
extern void   llSetT2OVFC1Event1( uint32 timeout );
extern void   llSetT2LongC1Event1( uint32 timeout1, uint16 timeout2 );
extern void   llSetT2OVFC2Event2( uint32 timeout );
extern void   llSetT2Delta( uint16 count );
extern void   llDisableT2Ints( void );
extern void   llDisableT2IntsEvts( void );
extern void   llDisableT2E1( void );
extern void   llGetTimer2Capture( uint32 *coarseTime, uint16 *fineTime );
extern uint32 llGetCurrentTime( void );
extern uint16 llGetCurrentFineTime( void );
extern void   llGetFullCurrentTime( uint32 *coarse, uint16 *fine );
//extern void   llGetFullCTandST( uint32 *coarseTime, uint16 *fineTime, uint32 *sleepTime );
extern void   llGetFullCTandST( sysTime_t *curTime, uint32 *sleepTime );
extern uint32 llGetT2OVFC1( void );
extern uint32 llGetT2OVFC2( void );
extern uint16 ll_McuPrecisionCount( void );
//
extern __near_func uint8  ll24BitTimeCompare( uint32 time1, uint32 time2 );
extern __near_func uint32 ll24BitTimeDelta( uint32 time1, uint32 time2 );
extern __near_func uint32 ll24BitAbsTimeDelta( uint32 time1, uint32 time2 );
extern __near_func void   llAdjustTimeForward( sysTime_t *curTime, sysTime_t *adjTime );
extern __near_func void   llAdjustTimeBackward( sysTime_t *curTime, sysTime_t *adjTime );





#line 57 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"
#line 1 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Projects\\ble\\WIMU\\CC2540DB\\..\\..\\..\\..\\Components\\ble\\controller\\include\\ll_math.h"
/*******************************************************************************
  Filename:       ll_math.h
  Revised:        $Date: 2011-02-17 15:41:10 -0800 (Thu, 17 Feb 2011) $
  Revision:       $Revision: 25131 $

  Description:    This file contains the types, contants, API's etc. for math
                  routines.

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
*******************************************************************************/









/*******************************************************************************
 * INCLUDES
 */

/*******************************************************************************
 * MACROS
 */

/*******************************************************************************
 * CONSTANTS
 */

/*******************************************************************************
 * TYPEDEFS
 */

/*******************************************************************************
 * LOCAL VARIABLES
 */

/*******************************************************************************
 * GLOBAL VARIABLES
 */

/*******************************************************************************
 * FUNCTIONS
 */

extern __near_func uint32 llDivide31By16To16( uint32 dividend,
                                            uint16 divisor );






#line 58 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"

/*******************************************************************************
 * MACROS
 */


// Set CC2540 power mode; always use PM2.
#line 73 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"

#line 84 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"

// sleep timer interrupt control




// backup interrupt enable registers before sleep
#line 99 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"

// restore interrupt enable registers before sleep






// convert msec to 625 usec units with round


// convert msec to 32kHz units without round : the ratio of 32 kHz ticks to
// msec ticks is 32768/1000 = 32.768 or 4096/125


// max allowed sleep time in ms
// Note: When OSAL timer was updated to 32 bits, the call to halSleep was
//       changed to take a 32-bit osal_timeout value. But since the CC2540
//       previously used a 16 bit ll_McuPrecisionCount, halSleep was modified
//       to limit osal_timeout to 16 bits as well (please see SVN rev. 27618).
//       However, the max value of the 16 bit ll_McuPrecisionCount is about 41s,
//       which is shorter than the max sleep time of 65.535s! So it is possible
//       Timer2 rollover could occur during sleep, which could affect when an
//       OSAL timer event is generated. The OSAL timer software should
//       be updated to use the full 24bit value of Timer2, allowing timer
//       events of up to 2.9 hours, but until this can be done properly, the
//       max sleep duration will be limited to less than ll_McuPrecisionCount.
// Note: Not an issue for BLE as the max sleep time would have to be less
//       than 32s.


/*******************************************************************************
 * CONSTANTS
 */

// POWER CONSERVATION DEFINITIONS
// Sleep mode H/W definitions (enabled with POWER_SAVING compile option).





// HAL power management mode is set according to the power management state.
// The default setting is HAL_SLEEP_OFF. The actual value is tailored to
// different HW platform. Both HAL_SLEEP_TIMER and HAL_SLEEP_DEEP selections
// will turn off the system clock, and halt the MCU. HAL_SLEEP_TIMER can be
// woken up by sleep timer interrupt, I/O interrupt and reset. HAL_SLEEP_DEEP
// can be woken up by I/O interrupt and reset.




// MAX_SLEEP_TIME calculation:
// Sleep timer maximum duration = 0xFFFF7F / 32768 Hz = 511.996 seconds
// Round it to 510 seconds or 510000 ms


// Minimum time to sleep:
// 1. avoid thrashing in-and-out of sleep with short OSAL timer
// 2. define minimum safe sleep period




// This value is used to adjust the sleep timer compare value such that the
// sleep timer compare takes into account the amount of processing time spent in
// function halSleep(). The first value is determined by measuring the number of
// sleep timer ticks from the beginning of the function to entering sleep mode.
// The second value is determined by measuring the number of sleep timer ticks
// from exit of sleep mode to the call to osal_adjust_timers().






// sleep and external interrupt port masks





// for optimized indexing of uint32
#line 193 "D:\\Simon_Dev\\WIMuGPS\\Workspace\\openwimu\\Firmware\\Radio\\Projects\\Wimu\\Components\\hal\\target\\CC2540EB\\hal_sleep.c"

/*******************************************************************************
 * TYPEDEFS
 */

/*******************************************************************************
 * LOCAL VARIABLES
 */

// HAL power management mode is set according to the power management state.
static uint8 halPwrMgtMode = 0;

// Flag to indicate if wake is due to impending radio event.
static uint8 wakeForRF;





/*******************************************************************************
 * GLOBAL VARIABLES
 */

// PCON register value to program when setting power mode
volatile __data uint8 halSleepPconValue = (1 << (0));

/*******************************************************************************
 * Prototypes
 */

// The PCON instruction must be 4-byte aligned. The following code may cause
// excessive power consumption if not aligned. See linker file ".xcl" for
// actual placement.
#pragma location = "SLEEP_CODE"
void halSetSleepMode(void);

void   halSleepSetTimer( uint32 sleepTime, uint32 timeout );
uint32 halSleepReadTimer( void );
uint32 TimerElapsed( void );

/*******************************************************************************
 * @fn          halSleep
 *
 * @brief       This function put the CC2540 to sleep. The PCON instruction must
 *              be 4-byte aligned. The following code may cause excessive power
 *              consumption if not aligned. See linker file ".xcl" for actual
 *              placement.
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
#pragma optimize=none
void halSetSleepMode(void)
{
  // WARNING: DO NOT ADD ANY ADDITIONAL CODE; THIS IS A FIXED SIZED SEGMENT!
  PCON = halSleepPconValue;
  // Disallow waking ISR from running in order to give the highest priority to LL_PowerOnReq().
  do { EA = 0; } while (257 == -1);
}

/*******************************************************************************
 * @fn          halSleep
 *
 * @brief       This function is called from the OSAL task loop using and
 *              existing OSAL interface.  It sets the low power mode of the LL
 *              and the CC2540.
 *
 * input parameters
 *
 * @param       osal_timeout - Next OSAL timer timeout, in msec.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
void halSleep( uint32 osal_timeout )
{
  uint32 timeout;
  uint32 llTimeout;
  uint32 sleepTimer;






  // max allowed sleep time in ms
  if (osal_timeout > 40000)
  {
    osal_timeout = 40000;
  }

  // get LL timeout value already converted to 32kHz ticks
  LL_TimeToNextRfEvent( &sleepTimer, &llTimeout );

  // check if no OSAL timeout
  // Note: If the next wake event is due to an OSAL timeout, then wakeForRF
  //       will already be FALSE, and the call to LL_TimeToNExtRfEvent will
  //       already have taken a snapshot of the Sleep Timer.
  if (osal_timeout == 0)
  {
    // use common variable
    timeout = llTimeout;

    // check if there's time before the next radio event
    // Note: Since the OSAL timeout is zero, then if the radio timeout is
    //       not zero, the next wake (if one) will be due to the radio event.
    wakeForRF = (timeout != 0) ? 1 : 0;
  }
  else // OSAL timeout is non-zero
  {
    // convet OSAL timeout to sleep time
    // Note: Could be early by one 32kHz timer tick due to rounding.
    timeout = ((((uint32) (osal_timeout)) * 4096) / 125);

    // so check time to radio event is non-zero, and if so, use shorter value
    if ((llTimeout != 0) && (llTimeout < timeout))
    {
      // use common variable
      timeout = llTimeout;

      // the next ST wake time is due to radio
      wakeForRF = 1;
    }
    else // OSAL timeout will be used to wake
    {
      // so take a snapshot of the sleep timer for sleep based on OSAL timeout
      sleepTimer = halSleepReadTimer();

      // the next ST wake time is not due to radio
      wakeForRF = 0;
    }
  }

  // HAL_SLEEP_PM3 is entered only if the timeout is zero
  halPwrMgtMode = (timeout == 0) ? 3 : 2;






  // check if sleep should be entered
  if ( (timeout > 66) || (timeout == 0) )
  {
    halIntState_t ien0, ien1, ien2;






    ;
    do { EA = 0; } while (355 == -1);

    // check if radio allows sleep, and if so, preps system for shutdown
    if ( LL_PowerOffReq(halPwrMgtMode) == 0 )
    {








      // use this to turn LEDs off during sleep
      HalLedEnterSleep();


      // enable sleep timer interrupt
      if (timeout != 0)
      {
        // check if the time to next wake event is greater than max sleep time
        if (timeout > 16711680 )
        {
          // it is, so limit to max allowed sleep time (~510s)
          halSleepSetTimer( sleepTimer, 16711680 );
        }
        else // not more than allowed sleep time
        {
          // so set sleep time to actual amount
          halSleepSetTimer( sleepTimer, timeout );
        }
      }

      // prep CC254x power mode
      do { SLEEPCMD &= ~((1 << (1)) | (1 << (0))); SLEEPCMD |= halPwrMgtMode; while (!(STLOAD & (1 << (0)))); halSleepPconValue = (1 << (0)); } while (389 == -1);

      // save interrupt enable registers and disable all interrupts
      do { (ien0) = IEN0; (ien1) = IEN1; (ien2) = IEN2; IEN0 &= (1 << (5)); IEN1 &= (1 << (5)); IEN2 &= ((1 << (4))|(1 << (1))); } while (392 == -1);
      do { EA = 1; } while (393 == -1);






      // set CC254x power mode; interrupts are disabled after this function
      // Note: Any ISR that could wake the device from sleep needs to use
      //       CLEAR_SLEEP_MODE(), which will clear the halSleepPconValue flag
      //       used to enter sleep mode, thereby preventing the device from
      //       missing this interrupt.
      halSetSleepMode();






      // check if ST interrupt pending, and if not, clear wakeForRF flag
      // Note: This is needed in case we are not woken by the sleep timer but
      //       by for example a key press. In this case, the flag has to be
      //       cleared as we are not just before a radio event.
      // Note: There is the possiblity that we may wake from an interrupt just
      //       before the sleep timer would have woken us just before a radio
      //       event, in which case power will be wasted as we will probably
      //       enter this routine one or more times before the radio event.
      //       However, this is presumably unusual, and isn't expected to have
      //       much impact on average power consumption.
      if ( (wakeForRF == 1) && !(IRCON & 0x80) )
      {
        wakeForRF = 0;
      }

      // restore interrupt enable registers
      do { IEN0 = (ien0); IEN1 = (ien1); IEN2 = (ien2); } while (428 == -1);

      // power on the LL; blocks until completion
      // Note: This is done here to ensure the 32MHz XOSC has stablized, in
      //       case it is needed (e.g. the ADC is used by the joystick).
      LL_PowerOnReq( (halPwrMgtMode == 3), wakeForRF );




      // use this to turn LEDs back on after sleep
      HalLedExitSleep();






    }

    do { EA = 1; } while (448 == -1);
  }






  return;
}


/*******************************************************************************
 * @fn          halSleepSetTimer
 *
 * @brief       This function sets the CC2540 sleep timer compare value based
 *              on a given snapshot of the sleep timer, and a timeout that is
 *              relative to that snapshot. The snapshot is provided as it may
 *              need to be taken as close to the snapshot of Timer 2 (the radio
 *              timer) as possible so that the time to the next radio event,
 *              when converted to 32kHz ticks, is as accurate as possible in
 *              terms of sleep time. In addition, the offset is adjusted based
 *              on a configurable adjustment to take the sleep handler's
 *              execution time into account. The sleep timer interrupt is then
 *              setup for wake.
 *
 * input parameters
 *
 * @param       sleepTimer - Sleep timer value timeout is relative to.
 * @param       timeout    - Timeout value in 32kHz units.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
void halSleepSetTimer( uint32 sleepTimer, uint32 timeout )
{
  do { IEN0 &= ~(1 << (5)); } while (487 == -1);

  // compute sleep timer compare value
  sleepTimer += timeout;

  // subtract the processing time spent in function halSleep()
  sleepTimer -= 35;

  // set sleep timer compare; ST0 must be written last
  ST2 = ((uint8 *)&sleepTimer)[2];
  ST1 = ((uint8 *)&sleepTimer)[1];
  ST0 = ((uint8 *)&sleepTimer)[0];

  do { IRCON &= ~0x80; } while (500 == -1);
  do { IEN0 |= (1 << (5)); } while (501 == -1);

  return;
}


/*******************************************************************************
 * @fn          halSleepReadTimer
 *
 * @brief       This function reads the CC2540 sleep timer.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      A snapshot of the 24 bit sleep timer.
 */
uint32 halSleepReadTimer( void )
{
  uint32 sleepTimer;

  // read the sleep timer
  // Note: Read of ST0 latches ST1 and ST2.
  ((uint8 *)&sleepTimer)[0] = ST0;
  ((uint8 *)&sleepTimer)[1] = ST1;
  ((uint8 *)&sleepTimer)[2] = ST2;
  ((uint8 *)&sleepTimer)[3] = 0;

  return( sleepTimer );
}


/*******************************************************************************
 * @fn          TimerElapsed
 *
 * @brief       Determine the number of OSAL timer ticks elapsed during sleep.
 *
 * input parameters
 *
 * @param       None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      Number of timer ticks elapsed during sleep.
 */
uint32 TimerElapsed( void )
{
  return( 0 );
}


/*******************************************************************************
 * @fn          halRestoreSleepLevel
 *
 * @brief       Restore the deepest timer sleep level.
 *
 * input parameters
 *
 * @param       None
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
void halRestoreSleepLevel( void )
{
  // Stub



}


/*******************************************************************************
 * @fn          halSleepTimerIsr
 *
 * @brief       Sleep timer ISR.
 *
 * input parameters
 *
 * None.
 *
 * output parameters
 *
 * @param       None.
 *
 * @return      None.
 */
_Pragma("vector=0x2B") __near_func __interrupt void halSleepTimerIsr(void); _Pragma("vector=0x2B") __near_func __interrupt void halSleepTimerIsr(void)
{
  { halIntState_t _isrIntState = EA; do { EA = 1; } while (599 == -1);;

  do { IRCON &= ~0x80; } while (601 == -1);





  ;

  EA = _isrIntState; };

  return;
}

/*******************************************************************************
 */

