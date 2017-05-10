//******************************************************************************
//  WIMuGPS - GPS Module
//
//  Description: This is the internal GPS module. Currently, a MN5010HS is used
//				 communicating using UART (port USCI A2).
//
//  Author: Simon Brière, ing., M. Sc. A.
//  Initial Version: 25 May 2009
//
//  Modifications: 
//  October 8th, 2009 - Added Stop function
//  June 28th, 2010   - Added SIRF support
//  January 7th, 2011 - Changed clock source from ACLK to SMCLK
//  January 11th, 2011 - Added support for RTC.
//  March 1st, 2011 - Added config support
//	May 12th, 2011 - Added Trickle Power support
//  July 13th, 2011 - Changed Trickle Power behavious to activate only when a first fix was made
//  July 27th, 2011 - Added gps_has_fix flag to identify when GPS has a fix
//******************************************************************************

#include "gps.h"
#include "GPS_driver.h"
#include "RTC.h"
#include "config.h"

#include "datalogger.h" //For Logging

#include <string.h> //for memset, strncmp
#include <time.h>
#include <stdio.h>

unsigned char gps_rx[GPS_RX_BUF_NUM][GPS_RX_BUFFER];
unsigned char gps_tx[GPS_TX_BUF_NUM][GPS_TX_BUFFER];

unsigned char gps_rx_rd_ptr; // Actual RX read index
unsigned char gps_rx_wr_ptr; // Actual RX write index
unsigned char gps_tx_rd_ptr; // Actual TX read index
unsigned char gps_tx_wr_ptr; // Actual TX write index

uint16_t gps_time_drift; //Counter to update the RTC time with GPS time to minimize drift.

volatile unsigned char gps_rx_index;
volatile unsigned char gps_tx_index;

volatile unsigned char gps_rx_queue;
volatile unsigned char gps_tx_queue;

unsigned short gps_tx_len[GPS_TX_BUF_NUM];
unsigned short gps_rx_len[GPS_RX_BUF_NUM];

//BOOL gps_alive;
//unsigned char gps_count;

BOOL gps_rx_ready;
BOOL gps_got_ffix;
BOOL gps_has_fix;
BOOL gps_sleep;
unsigned char gps_nofix_count;

SIRF_Cmds last_gps_cmd;

extern char buf[32];
//------------------------------------------------------------------------------
// INIT_GPS
//------------------------------------------------------------------------------
// Initialization function for the GPS module. Currently, USCI_A2 in UART
// mode is used to interface the chip.
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if initialization was successfully completed
// 0xYY, if initialization wasn't successfully completed where YY=error code
//------------------------------------------------------------------------------
Error_TypeDef GPS_Init(void){

        GPS_Config();
        GPS_1PPS_IRQConfig(ENABLE);
        if(GPS_PowerAndWakeup() == 0){
        /*{
           printf("GPS power up sequence OK!!!\n");  
        }
        else
        {*/
          //printf("GPS power up sequence FAIL!!!\n");
          return ERROR_POWER;
        }
    	
	// Variables initialization
	//////////////////////////
	gps_rx_rd_ptr = 0;
	gps_rx_wr_ptr = 0;
	gps_tx_rd_ptr = 0;
	gps_tx_wr_ptr = 0;
	gps_rx_index  = 0;
	gps_tx_index  = 0;
	
	gps_rx_queue  = 0;
	gps_tx_queue  = 0;
	
	gps_rx_ready  = FALSE;

	gps_got_ffix = FALSE;
	gps_has_fix = FALSE;
	gps_nofix_count=0;
	gps_time_drift=0;
	//gps_alive = TRUE;
	//gps_count = 0;
	
	memset(&gps_rx, 0, GPS_RX_BUFFER * GPS_RX_BUF_NUM);
	memset(&gps_tx, 0, GPS_TX_BUFFER * GPS_TX_BUF_NUM);
	memset(&gps_rx_len,255,GPS_RX_BUF_NUM*sizeof(short));
	memset(&gps_tx_len, 0, GPS_TX_BUF_NUM*sizeof(short));

        last_gps_cmd = SIRF_CMD_NONE;
	
	return ERROR_NONE;
}

//------------------------------------------------------------------------------
// START_GPS
//------------------------------------------------------------------------------
// Startup function for the GPS module. 
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if startup was successfully completed
// 0xYY, if startup wasn't successfully completed and where YY=error code
//------------------------------------------------------------------------------
Error_TypeDef GPS_Start(void){
	//unsigned char i;
        uint16_t timeout = 4000;
	#if GPS_MODE==GPS_SIRF
		unsigned char bin[64];
	#endif
	// Interrupt enable
	///////////////////
        GPS_ConfigTxIRQ(ENABLE);
	
	//Wakeup GPS
	//#ifndef DEV_BOARD
		/*P9OUT &= ~(BIT6);
	   	P9DIR |= BIT6;
		sleep(100);
		P9DIR &= ~(BIT6);*/
		
		/*#ifdef GPS_MODE_1
			sleep(500);
			
			P9OUT |= BIT7;		//GPS_SM high
			us_sleep(2000);
			P9OUT &= ~(BIT7);	//GPS_SM low
		#endif*/
		
		
	//#endif
	
	// *** To calculate checksums: http://www.hhhh.org/wiml/proj/nmeaxor.html ***
	//sleep(200); //Enable to initialize correctly the first time - otherwise, will be ok with watchdog
	//sleep(2);
        //msWait(200);
	#if GPS_MODE==GPS_NMEA
        // Set baudrate
        GPS_ConfigRxIRQ(ENABLE);
        gps_send_string("$PSRF100,1,115200,8,1,0*05\r\n",28); // Set NMEA, baudrate = 115200, 8 bits, 1 stop bit, no parity
        while (gps_tx_queue>0);
        GPS_SetBaudrate(115200);
        
	//gps_send_string("$PSRF103,00,00,00,01*24\r\n",25);	// Disable GGA
	gps_send_string("$PSRF103,03,00,10,01*26\r\n",25);		// Set GSV @10s interval
	
	while (gps_tx_queue>0);
	gps_send_string("$PSRF103,04,00,00,01*20\r\n",25);		// Disable RMC
	while (gps_tx_queue>0);
	gps_send_string("$PSRF103,08,00,01,01*2D\r\n",25); //Enable ZDA	
	while (gps_tx_queue>0);
	
		/*#ifndef GPS_MODE_1
			// We are in mode 0, we need to set the correct parameters
			while (gps_tx_queue>0);
			gps_send_string("$PSRF100,1,57600,8,1,0*36\r\n",27); //Set Baudrate on the GPS
			sleep(200);
			//while ((UCA2STAT & UCBUSY)>0);
			while (gps_tx_queue>0);
			
			
			// Set new Baudrate on USCI A2
			UCA2CTL1 |= UCSWRST;		// **Put state machine in reset**
			UCA2BR0 = 19;				// 1.125 MHz @ 57600 (ref. p. 426 UserGuide)
			UCA2BR1 = 0;				// 1.125 MHz @ 57600 (ref. p. 426 UserGuide)
			UCA2MCTL |= UCBRS_7 + UCBRF_0;		// Modulation stage = 6 //TOCHECK: 7 ???
			UCA2CTL1 &= ~UCSWRST;       // **Initialize USCI state machine**
			
		#endif

		//UCA2IE |= UCRXIE;*/
	#endif

        #if GPS_MODE==GPS_SIRF
		//SIRF MODE
                // Set the GPS into SIRF Mode
                GPS_SendString("$PSRF100,0,115200,8,1,0*04\r\n",28);   // Set SIRF, baudrate = 115200, 8 bits, 1 stop bit, no parity
                //gps_send_string("$PSRF100,0,9600,8,1,0*0C\r\n",26);   // Set SIRF, baudrate = 9600, 8 bits, 1 stop bit, no parity
                //gps_send_string("$PSRF100,0,57600,8,1,0*37\r\n",27); // Set SIRF, baudrate = 57600, 8 bits, 1 stop bit, no parity
                while (gps_tx_queue>0);               
                GPS_ConfigRxIRQ(ENABLE); // Enable only
                GPS_SetBaudrate(115200);
                msWait(800);
                
                // Wait for a first message before continuing (indicating baudrate was correcly set)
                
                timeout = 0xffff;
                while (gps_rx_ready==false && (--timeout)>0);
                if (timeout==0)
                  return ERROR_COM;
		GPS_ProcessRX();
		gps_rx_ready=FALSE;

             		
		// Test communication: Get SIRF chip version
		/*bin[0]=SIRF_POLL_VERSION;
		bin[1]=0x00;
		gps_send_sirf((char*)&bin[0],0x84,2);
		
		while (gps_tx_queue>0);
		//while ((UCA2STAT & UCBUSY)>0);
		while (gps_rx_ready==FALSE);
		process_gps_rx();
		gps_rx_ready=FALSE;*/
		
		//Set SIRF parameters
		bin[0] = SIRF_MODE_CONTROL;
		bin[1] = 0;						// Not used
		bin[2] = 0;						// Not used
		bin[3] = GPS_DEGRAD_MODE;                               // Degraded Mode
		bin[4] = 0;						// Not used
		bin[5] = 0;						// Not used
		bin[6] = 0;						// Altitude
		bin[7] = 0;						// Altitude
		bin[8] = 0;						// Altitude Hold Mode
		bin[9] = 0;						// Altitude Hold Source
		bin[10] = 0;						// Not used
		bin[11] = GPS_DEGRAD_TIMEOUT;                           // Degraded Mode Timeout
		bin[12] = GPS_DEADREC_TIMEOUT;                          // Dead reckoning timeout
		bin[13] = GPS_TRACKSMOOTHING;                           // Track Smoothing
		
		GPS_SendSirf(&bin[0],14);
		while (gps_tx_queue>0);

		//Wait for acknowledgement message
                timeout = 0xFFFF;
                last_gps_cmd = SIRF_CMD_NONE;
                while (last_gps_cmd != SIRF_CMD_ACK){
                  while (gps_rx_ready==FALSE && (--timeout)>0);
                  if (timeout==0)
                    return ERROR_COM;
                  GPS_ProcessRX();
                  gps_rx_ready=FALSE;
                }
		
                //msWait(1000);
		//sleep(5000);
		
		if (GPS_SetMsgFrequency()!=0) //Set messages frequency
                  return ERROR_COM;
		
		
		// GPS Adaptative Trickle Power Mode
		if (wimu_config.power.adv_power_manage == true){
                    GPS_SetTricklePower(false, GPS_DUTY_CYCLE*10, GPS_ON_TIME);
                    //GPS_SetAcquisitionParams(GPS_MAX_OFF_TIME, GPS_MAX_SEARCH_TIME, 0, GPS_ADAPTIVE); // MOVED INTO GOT TIME SECTION
                }
				
		//GPS FORCE COLD START MODE
		/*if ((wimu_config.gps_opt & CONFIG_GPS_COLD)>0){
			bin[0]=SIRF_INIT_DATA_SRC;
			for (i=1; i<23; i++)
				bin[i]=0;
			bin[23] = 12; 	// Number of channels
			bin[24] = 0x44; // Clear all history (except almanac), RTC=bad
		
			gps_send_sirf(&bin[0],25);
			while (gps_tx_queue>0);
			//Wait for acknowledgement message
			while (gps_rx_ready==FALSE);
			process_gps_rx();
			gps_rx_ready=FALSE;
		}*/
		
		//Check SIRF parameters
		/*bin[0]=SIRF_POLL_VERSION;
		bin[1]=0;
		gps_send_sirf(&bin[0],2); //Poll Version
		while (gps_tx_queue>0);
				
		//Wait for reply
		while (gps_rx_ready==FALSE);*/
		
		//MUST SET A BREAKPOINT TO READ
		
		/*bin[0]=SIRF_POLL_NAV_PARAMS;
		bin[1]=0x00;
		gps_send_sirf(&bin[0],2); //Poll Navigation Parameters
		
		while (gps_tx_queue>0);
				
		//Wait for reply
		while (gps_rx_ready==FALSE);
		process_gps_rx();
		gps_rx_ready=FALSE;*/
		
	#endif
	
	

	
	return 0x00;
}
//------------------------------------------------------------------------------
// STOP_GPS
//------------------------------------------------------------------------------
// Stop function for the GPS module. 
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void GPS_Stop(void){
	//Disable GPS
        GPS_DisablePower();

        GPS_ConfigRxIRQ(DISABLE);
        GPS_ConfigTxIRQ(DISABLE);

	//P8DIR |= BIT2;		// Set P8.2 as Output
	//P8OUT &= ~(BIT2);		// Set P8.2 as Low
	
	//UCA2CTL1 |= UCSWRST;		// **Put state machine in reset**
	
}

#if GPS_MODE==GPS_SIRF

void GPS_Sleep(BOOL sleep){
	//Puts the GPS in a pseudo-sleep mode using SIRF commands
	//unsigned char bin[16];
	if (sleep==TRUE){
		//Set trickle power
                GPS_SetTricklePower(true, 1000, 200);
                GPS_SetAcquisitionParams(0xFFFF, 0, 0, false); //Set max offtime as maximum value possible, Set min search time as minimum value possible, Disable Adaptative Trickle Power
		gps_sleep=TRUE;
		
	}else{
		//Revert to default settings
                if (wimu_config.power.adv_power_manage == true){
                    GPS_SetTricklePower(false, GPS_DUTY_CYCLE*10, GPS_ON_TIME);
                    GPS_SetAcquisitionParams(GPS_MAX_OFF_TIME, GPS_MAX_SEARCH_TIME, 0, GPS_ADAPTIVE);
                }else{
                    GPS_SetTricklePower(false, 1000, 200);
                }

		gps_got_ffix = FALSE;
		gps_sleep=FALSE;
	}
}

//------------------------------------------------------------------------------
// GPS_CHECKSUM
//------------------------------------------------------------------------------
// Calculates the Checksum needed for the SIRF command
//------------------------------------------------------------------------------
// Parameters: 
// msg - a pointer to the start of the binary command to calculate. 
// len - the length of the command to send, excluding the header, CRC and end sequence
//
// Return value (Unsigned short):
// Checksum of the message
//------------------------------------------------------------------------------
unsigned short GPS_Checksum(unsigned char* msg, unsigned short len){
	unsigned short checksum=0;
	unsigned short i;
	
	for (i=0; i<len; i++){
		checksum+=msg[i];
	}
	
	return checksum;
	
}
//------------------------------------------------------------------------------
// GPS_SEND_SIRF
//------------------------------------------------------------------------------
// Add a binary string to the TX buffer and starts the transfer process to the GPS
//------------------------------------------------------------------------------
// Parameters: 
// msg - a pointer to the start of the binary command to transfer. This pointer
//       doesn't need to still be valid after the execution of this function, since
//       it will copy the string into a transmit buffer. 
// len - the length of the command to send, excluding the header, CRC and end sequence
// chk - the checksum of the message to append
//
// Return value (Unsigned Char):
// 0x00, if everything went ok
// 0x01, if string is too long
// 0x02, if transmit buffer are full
//------------------------------------------------------------------------------
Error_TypeDef GPS_SendSirf(unsigned char* msg, unsigned short len){
	unsigned short chk;
	//Check if length is <= TX buffer size
	if (len+8>GPS_TX_BUFFER){
		return ERROR_BUFFER;
	}
	
	//Check if buffers are full
	//TODO!
	
	//Header
	gps_tx[gps_tx_wr_ptr][0] = 0xA0;
	gps_tx[gps_tx_wr_ptr][1] = 0xA2;
	gps_tx[gps_tx_wr_ptr][2] = len>>8;
	gps_tx[gps_tx_wr_ptr][3] = (char)(len&0x00FF);
	
	//Copy the bytes into the actual transmit buffer
	memcpy(&gps_tx[gps_tx_wr_ptr][4], msg, len);
	
	//Footer
	chk = GPS_Checksum(msg,len);
	gps_tx[gps_tx_wr_ptr][len+4] = chk>>8;
	gps_tx[gps_tx_wr_ptr][len+5] = (char)(chk&0x00FF);
	gps_tx[gps_tx_wr_ptr][len+6] = 0xB0;
	gps_tx[gps_tx_wr_ptr][len+7] = 0xB3;
	
	//Set the message length
	gps_tx_len[gps_tx_wr_ptr]=len+8;
	
	//Increments buffer ptr
	gps_tx_wr_ptr++;
	if (gps_tx_wr_ptr >= GPS_TX_BUF_NUM){
		gps_tx_wr_ptr=0;
	}
	
	//Starts the transfer of the first byte
	if (gps_tx_queue>0)
		//Already processing... we just add another item
		gps_tx_queue++;
	else{
		gps_tx_queue++;
		USART_SendData(USART3, gps_tx[gps_tx_rd_ptr][0]);
		
	}
		
	
	return ERROR_NONE; //All is well!
}
#endif

//------------------------------------------------------------------------------
// GPS_SEND_STRING
//------------------------------------------------------------------------------
// Add a string to the TX buffer and starts the transfer process to the GPS
//------------------------------------------------------------------------------
// Parameters: 
// msg - a pointer to the start of the character string to transfer. This pointer
//       doesn't need to still be valid after the execution of this function, since
//       it will copy the string into a transmit buffer. 
// len - the length of the string to send
//
// Return value (Unsigned Char):
// 0x00, if everything went ok
// 0x01, if string is too long
// 0x02, if transmit buffer are full
//------------------------------------------------------------------------------
Error_TypeDef GPS_SendString(char* msg, unsigned short len){
	
	//Check if length is <= TX buffer size
	if (len>GPS_TX_BUFFER){
          return ERROR_BUFFER;
	}
	
	//Check if buffers are full
	//TODO!
	
	//Copy the bytes into the actual transmit buffer
	memcpy(&gps_tx[gps_tx_wr_ptr][0], msg, len);
	
	//Set the message length
	gps_tx_len[gps_tx_wr_ptr]=len;
	
	//Increments buffer ptr
	gps_tx_wr_ptr++;
	if (gps_tx_wr_ptr >= GPS_TX_BUF_NUM){
		gps_tx_wr_ptr=0;
	}
	
	//Starts the transfer of the first byte
	if (gps_tx_queue>0)
		//Already processing... we just add another item
		gps_tx_queue++;
	else{
		gps_tx_queue++;
		//UCA2TXBUF = gps_tx[gps_tx_rd_ptr][0];
                //Start transfer
                USART_SendData(USART3, gps_tx[gps_tx_rd_ptr][0]);
		
	}
		
	
	return ERROR_NONE; //All is well!
}

//------------------------------------------------------------------------------
// PROCESS_GPS_RX
//------------------------------------------------------------------------------
// Process the last received GPS NMEA data and execute appropriate tasks according
// to it. 
//------------------------------------------------------------------------------
// Parameters: 
// None - it will automatically use the actual RX read buffer as defined by
//        gps_rx_rd_ptr;
//
// Return value (Unsigned Char):
// 0x00, if command was processed
// 0x01, if command wasn't processed
//------------------------------------------------------------------------------
Error_TypeDef GPS_ProcessRX(void){
	unsigned char rval = ERROR_UNMANAGED;
	unsigned short t;
        //RTC_DateTypeDef RTC_DateStruct;
        //RTC_TimeTypeDef RTC_TimeStruct;
	//unsigned long last_ts;
	#if GPS_MODE==GPS_SIRF
		//unsigned char bin[64];
	#endif

	//gps_count=0; //Reset watchdog timer
	//gps_alive=TRUE;
	
	
#if GPS_MODE==GPS_NMEA
        gps_rx[gps_rx_rd_ptr][gps_rx_len[gps_rx_rd_ptr]]=0; 
        //printf("%lu: %s",timestamp, gps_rx[gps_rx_rd_ptr]);
	//ZDA
	////////////////
        

	if (strncmp((const char*)&gps_rx[gps_rx_rd_ptr][0],"$GPZDA",6)==0){
		
		//Set timestamp if not set
		//if (time_sync==FALSE){
		if (time_sync==TIME_SYNC_COUNT){
			
			//if (i_mod_status[MODULE_DATALOGGER]==MODULE_ONLINE){
				t=(gps_rx[gps_rx_rd_ptr][7]-48)*10+(gps_rx[gps_rx_rd_ptr][8]-48);
				//SetRTCHOUR(t);
                                RTC_TimeStruct.RTC_Hours = t;
				t=(gps_rx[gps_rx_rd_ptr][9]-48)*10+(gps_rx[gps_rx_rd_ptr][10]-48);
				//SetRTCMIN(t);
                                RTC_TimeStruct.RTC_Minutes = t;
				t=(gps_rx[gps_rx_rd_ptr][11]-48)*10+(gps_rx[gps_rx_rd_ptr][12]-48);
				//SetRTCSEC(t);
                                RTC_TimeStruct.RTC_Seconds = t;
				t=(gps_rx[gps_rx_rd_ptr][18]-48)*10+(gps_rx[gps_rx_rd_ptr][19]-48);
				//SetRTCDAY(t);
                                RTC_DateStruct.RTC_Date = t;
				t=(gps_rx[gps_rx_rd_ptr][21]-48)*10+(gps_rx[gps_rx_rd_ptr][22]-48);
				//SetRTCMON(t);
                                RTC_DateStruct.RTC_Month = t;
				t=(gps_rx[gps_rx_rd_ptr][24]-48)*1000+(gps_rx[gps_rx_rd_ptr][25]-48)*100
				 +(gps_rx[gps_rx_rd_ptr][26]-48)*10+(gps_rx[gps_rx_rd_ptr][27]-48);
				//SetRTCYEAR(t);
                                RTC_DateStruct.RTC_Year = t;
				//update_timestampRTC();		 
                                RTC_SetTime(RTC_Format_BIN, &RTC_TimeStruct);
                                RTC_SetDate(RTC_Format_BIN, &RTC_DateStruct);

			//}
			time_sync++;
			//TODO: resync at regular intervals???
			//time_sync=TRUE;
                       
		}else{
                  if (time_sync!=TIME_SYNC_COUNT+1)
			time_sync++;
		}
		
		rval=ERROR_NONE;
	}
#endif

#if GPS_MODE==GPS_SIRF
	//Sirf Binary data
	//TODO: check checksum
        last_gps_cmd = gps_rx[gps_rx_rd_ptr][4];
	switch(gps_rx[gps_rx_rd_ptr][4]){
		/*case SIRF_OK_TO_SEND:
			if (gps_rx[gps_rx_rd_ptr][5]==1 && i_mod_status[MODULE_GPS]==MODULE_ONLINE){ // OK to Send, so make sure config is ok
				gps_config();
			}
			rval=0x00;
			break;*/
		case SIRF_CMD_ACK:
			rval = ERROR_NONE;
			break;
		case SIRF_CMD_NACK:
			rval = ERROR_NONE;
			break;
		case SIRF_NAV_PARAMS:
			//TODO: update parameters in memory??
			rval = ERROR_NONE; 
			break;
		case SIRF_GEO_DATA:
			//if (time_sync==FALSE){
                        //led_toggle(LED_BLUE);
			t=gps_rx[gps_rx_rd_ptr][16] + (unsigned short)(gps_rx[gps_rx_rd_ptr][15]<<8);
			if (time_sync<TIME_SYNC_COUNT){
				 //if ((gps_rx[gps_rx_rd_ptr][7] & 0x07)>0){ // A fix was achieved
				if (t>2013 && t<3000){ // Year is different than default value
					time_sync++;
					if (time_sync>=TIME_SYNC_COUNT){
						//Prepare time structure for datalogger
						update_RTCtime(t,gps_rx[gps_rx_rd_ptr][17],gps_rx[gps_rx_rd_ptr][18],gps_rx[gps_rx_rd_ptr][19],gps_rx[gps_rx_rd_ptr][20],(gps_rx[gps_rx_rd_ptr][22] + (unsigned short)(gps_rx[gps_rx_rd_ptr][21]<<8))/1000, true);
						
						// Disable GPS if was on only for timestamp sync
                                                if (wimu_config.datetime.enable_gps_time > 0 && getModuleState(MODULE_GPS)==STATE_SPECIAL){
                                                    // GOTO hibernation mode
                                                    GPS_Hibernate();
                                                }else{
                                                   if (wimu_config.power.adv_power_manage == true){
                                                        GPS_SetAcquisitionParams(GPS_MAX_OFF_TIME, GPS_MAX_SEARCH_TIME, 0, GPS_ADAPTIVE);
                                                   }
                                                }
                                                // Log time sync in log.dat
						if (isModuleOnline(MODULE_DATALOGGER)){
							datalog_save_data((unsigned char*)"Time Synced\r\n",13, TRUE, MODULE_CPU,0);
                                                        msWait(50);
						}
					}
					//timestamp=mktime(&timing);
					//time_sync=TRUE;
					
				}
			}else{ //Time_Sync
				//Correct RTC drift
				gps_time_drift++;
				if (gps_time_drift>=TIME_DRIFT_COUNT){
					if (t>2013 && t<3000){ //Year is valid
						//last_ts=timestamp;
					 	update_RTCtime(t,gps_rx[gps_rx_rd_ptr][17],gps_rx[gps_rx_rd_ptr][18],gps_rx[gps_rx_rd_ptr][19],gps_rx[gps_rx_rd_ptr][20],(gps_rx[gps_rx_rd_ptr][22] + (unsigned short)(gps_rx[gps_rx_rd_ptr][21]<<8))/1000, true);
						
						/*if (i_mod_status[MODULE_DATALOGGER]==MODULE_ONLINE){
						
							sprintf(buf, "Drift: %d\r\n", timestamp-last_ts);
							datalog_save_data((unsigned char*)&buf[0],strlen(buf), TRUE, MODULE_CPU,0);
						}*/
						gps_time_drift=0;

                                                
					}
				}
			}
			
			//Fix analysis
			if ((gps_rx[gps_rx_rd_ptr][8] & 0x07)>0){
				gps_has_fix = TRUE;
				gps_nofix_count=0; //Reset fix counter
				if (gps_got_ffix == FALSE){
					//Check if we got a first fix since last restart or not
					gps_got_ffix = TRUE;

                                        //Set duty cycle and adaptative trickle power
                                        // MOVED INTO INIT SECTION
                                        /*if (wimu_config.power.power_manage == true){
                                            GPS_SetTricklePower(false, GPS_DUTY_CYCLE*10, GPS_ON_TIME);
                                        }*/
					
					//Enable adaptative trickle power, if selected
					/*if ((wimu_config.gps_opt & CONFIG_GPS_TRICKLE)>0){
						//Set trickle power
						bin[0]=SIRF_SET_TRICKLE_POWER;
						bin[1]=0; //Not using push-to-fix mode
						bin[2]=0;
						bin[3]=0x01;	//Duty Cycle set to 30% (recommended setting)
						bin[4]=0x2C;
						bin[5]=0x00;	//On-Time set to 300 ms
						bin[6]=0x00;
						bin[7]=0x01;
						bin[8]=0x2C;
					
						gps_send_sirf(&bin[0],9);
						while (gps_tx_queue>0);
						//Wait for acknowledgement message
						while (gps_rx_ready==FALSE);
						process_gps_rx();
						gps_rx_ready=FALSE;
						
						//Set adaptative trickle power
						bin[0]=SIRF_SET_LOWPOW_PARAMS;
						bin[1]=0; 		// Max OffTime @ 5 minutes //TODO: Set in Config
						bin[2]=0x04;	// 0x000493E0 = 300 000 ms = 5 minutes
						bin[3]=0x93;	
						bin[4]=0xE0;
						bin[5]=0x00;	// Max SearchTime @ 10 minutes 
						bin[6]=0x09;	// 0x000927C0 = 600 000 ms = 10 minutes
						bin[7]=0x27;
						bin[8]=0xC0;
						bin[9]=0;		//Push-to-fix period not needed
						bin[10]=0;
						bin[11]=0;
						bin[12]=0x3C;
						bin[13]=0x00;	//Enable Adaptative Trickle Power
						bin[14]=0x01;
					
						gps_send_sirf(&bin[0],15);
						while (gps_tx_queue>0);
						//Wait for acknowledgement message
						while (gps_rx_ready==FALSE);
						process_gps_rx();
						gps_rx_ready=FALSE;
						
					} //Enable Trickle*/
				} //Has first Fix
			}else{ //Has Fix
				gps_nofix_count++;
				if (gps_nofix_count>=GPS_NOFIX_COUNT_MAX){
					gps_nofix_count = GPS_NOFIX_COUNT_MAX;
					gps_has_fix = FALSE;
				}
			} 
			rval = ERROR_NONE;
			break;
		case SIRF_CLK_STATUS:
			rval = ERROR_NONE;
			break;
		default:
			rval=ERROR_UNMANAGED;
			break;
	}
#endif	
	
	if (++gps_rx_rd_ptr >= GPS_RX_BUF_NUM)	// At the end of the buffers?
		gps_rx_rd_ptr=0;
	
	gps_rx_queue--;
	

	return rval;
}


#if GPS_MODE==GPS_SIRF
Error_TypeDef GPS_SetMsgInterval(unsigned char msg_id, unsigned char interval){
  uint32_t timeout = 0x0fFFFF;
  unsigned char bin[10];
  bin[0]=SIRF_SETMSG_RATE;
  bin[1]=0;			// No polling yet
  bin[2]=msg_id;		// Message ID to set
  bin[3]=interval;		// Interval
  bin[4]=0;			// Not used
  bin[5]=0;			// Not used
  bin[6]=0;			// Not used
  bin[7]=0;			// Not used
                  
  GPS_SendSirf(&bin[0],8);
  while (gps_tx_queue>0);
  //Wait for acknowledgement message
  last_gps_cmd = SIRF_CMD_NONE;
  while (last_gps_cmd != SIRF_CMD_ACK){
    while (gps_rx_ready==FALSE && (--timeout)>0);
    if (timeout==0)
      return ERROR_COM;
    GPS_ProcessRX();
    gps_rx_ready=FALSE;
  }
  return ERROR_NONE;

}

Error_TypeDef GPS_SetTricklePower(bool pushToFix, short dutyCycle, int onTime){
  uint32_t timeout = 0x0fFFFF;
  unsigned char bin[9];
  bin[0]=SIRF_SET_TRICKLE_POWER;
  bin[1]=0;			
  if (pushToFix)                // Using Push-To-Fix mode
    bin[2]=1;		
  else
    bin[2]=0;
  
  bin[3] = (unsigned char)((dutyCycle & 0xFF00) >> 8);
  bin[4] = (unsigned char)(dutyCycle & 0x00FF);
  bin[5] = (unsigned char)((onTime & 0xFF000000) >> 24);
  bin[6] = (unsigned char)((onTime & 0x00FF0000) >> 16);
  bin[7] = (unsigned char)((onTime & 0x0000FF00) >> 8);
  bin[8] = (unsigned char)(onTime & 0x000000FF);
  
                  
  GPS_SendSirf(&bin[0], 9);
  while (gps_tx_queue>0);
  //Wait for acknowledgement message
  last_gps_cmd = SIRF_CMD_NONE;
  while (last_gps_cmd != SIRF_CMD_ACK){
    while (gps_rx_ready==FALSE && (--timeout)>0);
    if (timeout==0)
      return ERROR_COM;
    GPS_ProcessRX();
    gps_rx_ready=FALSE;
  }
  return ERROR_NONE;
}


Error_TypeDef GPS_SetAcquisitionParams(unsigned int maxOffTime, unsigned int maxSearchTime, unsigned int pushToFixPeriod, bool adaptiveTrickle){
  uint32_t timeout = 0x0fFFFF;
  unsigned char bin[15];
  bin[0]=SIRF_SET_LOWPOW_PARAMS;
 // Maximum time for sleep mode (msec)
  bin[1] = (unsigned char)((maxOffTime & 0xFF000000) >> 24);
  bin[2] = (unsigned char)((maxOffTime & 0x00FF0000) >> 16);
  bin[3] = (unsigned char)((maxOffTime & 0x0000FF00) >> 8);
  bin[4] = (unsigned char)(maxOffTime & 0x000000FF);  
  
  // Max. satellite search time (msec)
  bin[5] = (unsigned char)((maxSearchTime & 0xFF000000) >> 24);
  bin[6] = (unsigned char)((maxSearchTime & 0x00FF0000) >> 16);
  bin[7] = (unsigned char)((maxSearchTime & 0x0000FF00) >> 8);
  bin[8] = (unsigned char)(maxSearchTime & 0x000000FF);  

  // Push-to-Fix cycle period (sec)
  bin[9] = (unsigned char)((pushToFixPeriod & 0xFF000000) >> 24);
  bin[10] = (unsigned char)((pushToFixPeriod & 0x00FF0000) >> 16);
  bin[11] = (unsigned char)((pushToFixPeriod & 0x0000FF00) >> 8);
  bin[12] = (unsigned char)(pushToFixPeriod & 0x000000FF);  

  bin[13] = 0;
  if (adaptiveTrickle){
      bin[14] = 1;
  }else{
      bin[14] = 0;
  }
                  
  GPS_SendSirf(&bin[0], 15);
  while (gps_tx_queue>0);
  //Wait for acknowledgement message
  last_gps_cmd = SIRF_CMD_NONE;
  while (last_gps_cmd != SIRF_CMD_ACK){
    while (gps_rx_ready==FALSE && (--timeout)>0);
    if (timeout==0)
      return ERROR_COM;
    GPS_ProcessRX();
    gps_rx_ready=FALSE;
  }
  return ERROR_NONE;
}
//------------------------------------------------------------------------------
// GPS_SET_FILTERS
//------------------------------------------------------------------------------
// Set the right configuration of messages to send/receive on the GPS
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// 0 = all is fine
// 1+ = timeout
//------------------------------------------------------------------------------
Error_TypeDef GPS_SetMsgFrequency(){
    unsigned char rval = ERROR_NONE;
    
    // Disable Measured Navigation Data
    rval |= GPS_SetMsgInterval(SIRF_MNAV_DATA,0);
    
    // Disable CPU throughput
    rval |= GPS_SetMsgInterval(SIRF_CPU_THROUGHPUT,0);
                    
    // Disable Clock Status
    rval |= GPS_SetMsgInterval(SIRF_CLK_STATUS,0);
    
    // Disable Extended Ephemeris
    rval |= GPS_SetMsgInterval(SIRF_EXT_EPHEMERIS,0);

    // Disable Auxiliary init data
    rval |= GPS_SetMsgInterval(SIRF_NL_AUX_INIT_DATA,0);
    //msWait(200);
    // Disable SBAS parameters
    rval |= GPS_SetMsgInterval(SIRF_SBAS_PARAMETERS,0);
    //msWait(200);
    // Disable CW Interference report
    //rval |= GPS_SetMsgInterval(SIRF_CW_INTERFERENCE,0);
    //msWait(200);

    // Disable 50 BPS Data
    rval |= GPS_SetMsgInterval(SIRF_50BPS_DATA,0);
    //msWait(200);
    // Disable visible list
    rval |= GPS_SetMsgInterval(SIRF_VISIBLE_LIST,0);

    // Enable measured tracker data out
    //rval |= GPS_SetMsgInterval(SIRF_MTRACKER_DATA,1);
		
    return rval;
}
#endif

#if GPS_MODE==GPS_SIRF
void DMA1_Channel3_IRQHandler(void){
	//SIRF MODE
	//gps_rx[gps_rx_wr_ptr][gps_rx_index++]=USART_ReceiveData(USART3);

  uint8_t num_bytes = DMA_InitStructure.DMA_BufferSize;
  uint8_t new_byte = GPS_Rx_DMA[0];

  DMA_ClearITPendingBit(DMA1_IT_TC3);
  
  //Set DMA to trigger after next byte
  DMA_SetCurrDataCounter(DMA1_Channel3, 1);

  //Check for frame alignment
  if (gps_rx_index==0){
	if (new_byte != 0xA0){ // Not correctly aligned - wait for next
          return;
        }
  }

  // Copy data to main buffer
  memcpy(&gps_rx[gps_rx_wr_ptr][gps_rx_index], &GPS_Rx_DMA[0], num_bytes);

  // Update index
  gps_rx_index += num_bytes;
	
  if (gps_rx_index ==4 ){
      //Check and record message length
      //TODO: won't work with message payload longer than 255!! (not considering upper byte now)
      gps_rx_len[gps_rx_wr_ptr] = 8 + gps_rx[gps_rx_wr_ptr][3];

      //Prime DMA next message size
      DMA_SetCurrDataCounter(DMA1_Channel3, gps_rx_len[gps_rx_wr_ptr] - gps_rx_index);
  }
  
  if (gps_rx_index>=gps_rx_len[gps_rx_wr_ptr]){
    
      gps_rx_index=0;
      gps_rx_queue++;
      
      gps_rx_wr_ptr++;
      if (gps_rx_wr_ptr >= GPS_RX_BUF_NUM) // All buffers were used
        gps_rx_wr_ptr = 0;

      gps_rx_len[gps_rx_wr_ptr]=255;
      gps_rx_ready=TRUE;
  }
    
}
#endif
/*******************************************************************************
 * Function Name  : USART3_IRQHandler
 * Description    : This function handles USART3 interrupt request.
 * Input          : None
 * Output         : None
 * Return         : None
 *******************************************************************************/
void USART3_IRQHandler(void)
{
  // GPS Data Received
  /////////////////////
  
  /*if (USART_GetITStatus(USART3, USART_IT_ORE_RX) != RESET){ //RX Overrun
  }*/

  // If a RX overrun occur, we continue to proceed with GPS reception as normal
  //
  if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET || USART_GetITStatus(USART3, USART_IT_ORE_RX) != RESET)
  {
    USART_ClearFlag(USART3, USART_FLAG_RXNE);
    USART_ClearFlag(USART3, USART_FLAG_ORE);
    //printf("%c", USART_ReceiveData(USART3));
    #if GPS_MODE==GPS_NMEA
  	gps_rx[gps_rx_wr_ptr][gps_rx_index++]=USART_ReceiveData(USART3);
        //printf("%c", gps_rx[gps_rx_wr_ptr][gps_rx_index-1]);
  	
  	if (gps_rx_index>GPS_RX_BUFFER || gps_rx[gps_rx_wr_ptr][gps_rx_index-1]==0x0A){ //Line Feed
  		//Command complete or overflowed...
  		
  		gps_rx_len[gps_rx_wr_ptr] = gps_rx_index; 		
  		gps_rx_index=0;
  		gps_rx_queue++;
  		
  		gps_rx_wr_ptr++;
  		if (gps_rx_wr_ptr >= GPS_RX_BUF_NUM) // All buffers were used
  			gps_rx_wr_ptr = 0;
  		  		
  		gps_rx_ready=TRUE;
  	}
  	else{
  		//while (!(UCA3IFG&UCTXIFG));             // USCI_A0 TX buffer ready?
  		//UCA3TXBUF = UCA3RXBUF;                  // TX -> RXed character
  		
  		//usb_send_char(UCA3RXBUF);	
  	}
     #endif
     /*#if GPS_MODE==GPS_SIRF
	//SIRF MODE
	gps_rx[gps_rx_wr_ptr][gps_rx_index++]=USART_ReceiveData(USART3);
	//led_toggle(LED1);
	if (gps_rx_index==1){
		if (gps_rx[gps_rx_wr_ptr][0]!=0xA0){
			//Frame alignment isn't right - don't consider the data
			gps_rx_index=0;
		}
	}

        if (gps_rx_index==2){
		if (gps_rx[gps_rx_wr_ptr][1]!=0xA2){
			//Frame alignment isn't right - don't consider the data
                        if (gps_rx[gps_rx_wr_ptr][1]==0xA0){
                          gps_rx[gps_rx_wr_ptr][0]=0xA0;
                          gps_rx_index=1;
                        }else{
                          gps_rx_index=0;
                        }
		}
	}
	
	if (gps_rx_index==4){
		//Check and record message length
		//TODO: won't work with message payload longer than 255!! (not considering upper byte now)
		gps_rx_len[gps_rx_wr_ptr] = 8 + gps_rx[gps_rx_wr_ptr][3];
	}
	
	if (gps_rx_index>=gps_rx_len[gps_rx_wr_ptr]){
		
		gps_rx_index=0;
  		gps_rx_queue++;
  		
  		gps_rx_wr_ptr++;
  		if (gps_rx_wr_ptr >= GPS_RX_BUF_NUM) // All buffers were used
  			gps_rx_wr_ptr = 0;
  		gps_rx_len[gps_rx_wr_ptr]=255;
  		gps_rx_ready=TRUE;
	}
    #endif*/
  }
         // GPS Data Transmitted
        if(USART_GetITStatus(USART3, USART_IT_TC) != RESET)
        {
          USART_ClearFlag(USART3, USART_FLAG_TC);
          //Check for the next char to send
          if (gps_tx_queue>0){
                  gps_tx_index++;
                  if (gps_tx_index >= GPS_TX_BUFFER || gps_tx_index >= gps_tx_len[gps_tx_rd_ptr]){
                          //This sequence is over. 
                          gps_tx_queue--;
                          gps_tx_rd_ptr++;
                          gps_tx_index=0;
                          if (gps_tx_rd_ptr >= GPS_TX_BUF_NUM) // All buffers were used
                                  gps_tx_rd_ptr = 0;
                          if (gps_tx_queue>0){
                                  //Sends the next message
                                  //while (!(UCA3IFG&UCTXIFG));
                                  USART_SendData(USART3, gps_tx[gps_tx_rd_ptr][gps_tx_index]);
                          }
                    
                  }else{
                          //Sends the next char waiting!
                          //while (!(UCA3IFG&UCTXIFG));
                         USART_SendData(USART3, gps_tx[gps_tx_rd_ptr][gps_tx_index]);
                  }
          }
        }
  /*if(USART_GetITStatus(USART3, USART_IT_RXNE) != RESET)
  {
    USART_ClearFlag(USART3, USART_FLAG_RXNE);
    printf("%c", USART_ReceiveData(USART3));
  }*/
  
}


// GPS 1PPS interrupt
void EXTI3_IRQHandler(void)
{
	if(EXTI_GetITStatus(EXTI_Line3) != RESET)
  {
//    printf("1PPS\n");
    //GPIO_ToggleBits(GPIOC, GPIO_Pin_7);
    if (isModuleOnline(MODULE_GPS))
      if (wimu_config.ui.gps_fix_led==true)
        led_toggle(LED_GREEN, MEDIUM_PRIORITY);

    /* Clear interrupt pending bit */
    EXTI_ClearITPendingBit(EXTI_Line3);
  }
  
}


