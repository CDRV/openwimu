//******************************************************************************
//  WIMUGPS - USB Module
//
//  Description: This is the interface to the USB modules. It contains the various
//				 functions used to interpret commands received on the USB module
//				 and send back appropriate data to the requests.
//
//  Author: Simon Brière, ing., M. Sc. A.
//  Initial Version: May 19, 2009
//
//  Modifications: 
//  July 30th, 2013 - Official conversion for STM32
//******************************************************************************

//#include "msp430x54x.h"
#include "config.h"
#include "usb.h"
#include "utils.h"

#include "datalogger.h"
#include "flash.h"
#include "power.h"
#include "imu.h"
#include "buttons.h"
//#include "bootload.h"
#include "gps.h"


#include "usb_lib.h"
#include "usb_pwr.h"
#include "MS__usb_desc.h"
#include "MS__usb_prop.h"
#include "VC__usb_prop.h"

#include <string.h> //for memset and string functions
#include <stdio.h>
#include <stdlib.h>

unsigned char usb_rx[USB_RX_BUF_NUM][USB_RX_BUFFER];
unsigned char usb_tx[USB_TX_BUF_NUM][USB_TX_BUFFER];

//unsigned short usb_rx_len[USB_RX_BUF_NUM];
//unsigned short usb_tx_len[USB_TX_BUF_NUM];

unsigned char usb_rx_rd_ptr; // Actual RX read index
unsigned char usb_rx_wr_ptr; // Actual RX write index
unsigned char usb_tx_rd_ptr; // Actual TX read index
unsigned char usb_tx_wr_ptr; // Actual TX write index

unsigned char usb_rx_index;  // Actual RX buffer index (write)
unsigned char usb_tx_index;	 // Actual TX buffer index (write)

unsigned char usb_rx_queue;	 // Actual number of unread elements in RX
unsigned char usb_tx_queue;  // Actual number of unsent elements in TX

unsigned short usb_tx_len[USB_TX_BUF_NUM];

bool usb_rx_ready; // Set to TRUE when RX data is ready to be processed

//Streaming settings
//unsigned char usb_stream_acc;
unsigned char usb_stream_gps;
//unsigned char usb_stream_gyro;
//unsigned char usb_stream_mag;
//unsigned char usb_stream_quaternion;
unsigned char usb_stream_power;
//unsigned char usb_stream_time;
 
//unsigned char usb_stream_sonars;
//unsigned char usb_stream_encoders;
//unsigned char usb_stream_fsr;
//unsigned char usb_stream_joystick;

unsigned char usb_stream_bin;
unsigned char usb_datalog;
unsigned char usb_streaming;

ModuleStates copy_enabled_i_devices;

ProgramMode usb_mode = UNDEFINED; 

extern PushButton_TypeDef PushButton1;
extern uint8_t Calib_Counter;

extern WIMU_SETTINGS wimu_settings; // For gains and offset values

//------------------------------------------------------------------------------
// INIT_USB
//------------------------------------------------------------------------------
// Initialization function for the USB module. Currently, USB module is on the
// USCI A3 port configured on UART Mode (see function for details) using CTS/RTS
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if initialization was successfully completed
// 0xYY, if initialization wasn't successfully completed where YY=error code
//------------------------------------------------------------------------------
Error_TypeDef USB_GlobalInit(void){

     Set_System();
     Set_USBClock();
      if(usb_mode == MASS_STORAGE)
      {
        MS_Init();
      }
      else
      {
        VC_Init();
      }
      
      USB_Interrupts_Config();
      USB_Init();
       
      // Variables initialization
      //////////////////////////
      usb_rx_rd_ptr = 0;
      usb_rx_wr_ptr = 0;
      usb_tx_rd_ptr = 0;
      usb_tx_wr_ptr = 0;
      usb_rx_index  = 0;
      usb_tx_index  = 0;
      
      usb_rx_queue  = 0;
      usb_tx_queue  = 0;
      
      USB_StopAllStreams();
      usb_datalog=		USB_STREAM_FAST;
      
      usb_rx_ready  = FALSE;
      usb_streaming = 0;
      
      memset(&usb_rx,0,USB_RX_BUFFER*USB_RX_BUF_NUM);
      memset(&usb_tx,0,USB_TX_BUFFER*USB_TX_BUF_NUM);
      //memset(&usb_rx_len,0,USB_RX_BUFFER*sizeof(short));
      memset(&usb_tx_len,0,USB_TX_BUF_NUM*sizeof(short));
      
      return ERROR_NONE;
}

//------------------------------------------------------------------------------
// START_USB
//------------------------------------------------------------------------------
// Startup function for the USB module. 
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if startup was successfully completed
// 0xYY, if startup wasn't successfully completed and where YY=error code
//------------------------------------------------------------------------------
Error_TypeDef USB_Start(void){
	
	// Interrupt enable
	///////////////////
	//UCA3IFG |= UCTXIFG;	
	//UCA3IE |= UCRXIE + UCTXIE;
	
	return ERROR_NONE;
}

//------------------------------------------------------------------------------
// STOP_USB
//------------------------------------------------------------------------------
// Stop function for the USB module. 
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value:
// None
//------------------------------------------------------------------------------
void USB_Stop(void){
  PowerOff();
}

void USB_StopAllStreams(){
        /*usb_stream_acc = 	USB_STREAM_OFF;
	usb_stream_gyro = 	USB_STREAM_OFF;
	usb_stream_mag = 	USB_STREAM_OFF;*/
	usb_stream_gps = 	USB_STREAM_OFF;
        //usb_stream_quaternion = USB_STREAM_OFF;
 	usb_stream_power = 	USB_STREAM_OFF;
        //usb_stream_time=        USB_STREAM_OFF;
 		
	/*usb_stream_sonars = 	USB_STREAM_OFF;
	usb_stream_encoders = 	USB_STREAM_OFF;
	usb_stream_fsr = 	USB_STREAM_OFF;
	usb_stream_joystick = 	USB_STREAM_OFF;*/
	
	usb_stream_bin=		USB_STREAM_OFF;
}

//------------------------------------------------------------------------------
// PROCESS_USB_RX
//------------------------------------------------------------------------------
// Process the last received USB command and execute appropriate tasks according
// to it. 
//------------------------------------------------------------------------------
// Parameters: 
// None - it will automatically use the actual RX read buffer as defined by
//        usb_rx_rd_ptr;
//
// Return value (Unsigned Char):
// 0x00, if command was correct
// 0xYY, if command is unknown or malformed
//------------------------------------------------------------------------------
Error_TypeDef USB_ProcessRX(void){
	unsigned char rval = ERROR_UNMANAGED;
	char buf[64]; //char buffer
	uint32_t crc;
        uint32_t received_crc;
        uint64_t received_time;

        // If binary streaming, abort
        if (usb_stream_bin==USB_STREAM_FAST){
          usb_stream_bin = USB_STREAM_OFF;
          rval = ERROR_NONE;
        }

        // Check if first character is \n or \r. If so, we shift the received buffer as this
        // depends on the host sequence (\n, \n\r, \r, \r\n)
        if (usb_rx[usb_rx_rd_ptr][0]=='\n' || usb_rx[usb_rx_rd_ptr][0]=='\r'){
          memcpy(&usb_rx[usb_rx_rd_ptr][0],(void*)&usb_rx[usb_rx_rd_ptr][1],USB_RX_BUFFER-1);
          rval = ERROR_NONE; // Set in case this is the only good character in the stream         
        }

	//Status command
	////////////////
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"status",6)==0){
		
		USB_SendString("OK\n\r",4);
		//TODO: Send system status
		rval=ERROR_NONE;
	}
	
	//Version command
	/////////////////
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"version",7)==0){		
		USB_SendString(VERSION_STRING,31);		
		rval=ERROR_NONE;
	}
	
	//ACC command
	/////////////////
	
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"acc",3)==0){		
                //Display values of accelerometer channels
                /*if (usb_stream_acc != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_acc=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  X    Y    Z\n\r",15);	
                        usb_stream_acc=USB_STREAM_SLOW;
                }*/
                if (getModuleState(MODULE_ACC)!=STATE_DISABLED){
                  USB_SendString("Accelero ENABLED\n\r",18);
                }else{
                  USB_SendString("Accelero DISABLED\n\r",19);
                }
                rval=ERROR_NONE;
        }
		
        /*if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"facc",4)==0){		
                //Display values of accelerometer channels
                if (usb_stream_acc != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_acc=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  X    Y    Z\n\r",15);	
                        usb_stream_acc=USB_STREAM_FAST;
                }			
                rval=ERROR_NONE;
        }*/
	
	//GYRO command
	/////////////////
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"gyro",4)==0){		
                //Display values of gyro channels
                /*if (usb_stream_gyro != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_gyro=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  X    Y    Z\n\r",15);	
                        usb_stream_gyro=USB_STREAM_SLOW;
                }*/
                if (getModuleState(MODULE_GYRO)!=STATE_DISABLED){
                  USB_SendString("Gyro ENABLED\n\r",14);
                }else{
                  USB_SendString("Gyro DISABLED\n\r",15);
                }
                rval=ERROR_NONE;
        }
        
        /*if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"fgyro",5)==0){		
                //Display values of gyro channels
                if (usb_stream_gyro != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_gyro=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  X    Y    Z\n\r",15);	
                        usb_stream_gyro=USB_STREAM_FAST;
                }			
                rval=ERROR_NONE;
        }*/
	
	//MAGNETO command
	/////////////////
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"mag",3)==0){		
                //Display values of magneto channels
                /*if (usb_stream_mag != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_mag=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  X    Y    Z\n\r",15);	
                        usb_stream_mag=USB_STREAM_SLOW;
                }*/
                if (getModuleState(MODULE_MAGNETO)!=STATE_DISABLED){
                  USB_SendString("Magneto ENABLED\n\r",17);
                }else{
                  USB_SendString("Magneto DISABLED\n\r",18);
                }
                rval=ERROR_NONE;
        }
        
        /*if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"fmag",4)==0){		
                //Display values of magneto channels
                if (usb_stream_mag != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_mag=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  X    Y    Z\n\r",15);	
                        usb_stream_mag=USB_STREAM_FAST;
                }			
                rval=ERROR_NONE;
        }*/

	//IMU command
	/////////////////
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"imu",3)==0){		
                //Display values of gyro channels
                /*if (usb_stream_quaternion != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_quaternion=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  q0    q1    q2   q3\n\r",23);	
                        usb_stream_quaternion=USB_STREAM_FAST;
                }*/
                if (getModuleState(MODULE_IMU)!=STATE_DISABLED){
                  USB_SendString("IMU ENABLED\n\r",13);
                }else{
                  USB_SendString("IMU DISABLED\n\r",14);
                }
                rval=ERROR_NONE;
        }

        //BLE command
	/////////////////
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"ble",3)==0){		
                //Display values of gyro channels
                /*if (usb_stream_quaternion != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_quaternion=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("  q0    q1    q2   q3\n\r",23);	
                        usb_stream_quaternion=USB_STREAM_FAST;
                }*/
                if (getModuleState(MODULE_IMU)!=STATE_DISABLED){
                  USB_SendString("BLE ENABLED\n\r",13);
                }else{
                  USB_SendString("BLE DISABLED\n\r",14);
                }
                rval=ERROR_NONE;
        }

	//Power command
	/////////////////
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"power",5)==0){		
                //Display values of power channels
                if (usb_stream_power != USB_STREAM_OFF){
                        USB_SendString("*************\n\r",15);
                        usb_stream_power=USB_STREAM_OFF;
                        
                }else{
                        USB_SendString("            V    T\n\r",20);	
                        usb_stream_power=USB_STREAM_SLOW;
                }			
                rval=ERROR_NONE;
        }
	
	//GPS command
	/////////////////
	//if ((short)(enabled_i_devices & MODULE_GPS)>0){
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"gps",3)==0){		
        #if GPS_MODE==GPS_NMEA
          //Display values of accelerometer channels
          if (usb_stream_gps != USB_STREAM_OFF){
                  USB_SendString("*************\n\r",15);
                  usb_stream_gps=USB_STREAM_OFF;
              
          }else{
                  USB_SendString("GPS Values\n\r",17);	
                  usb_stream_gps=USB_STREAM_FAST;
          }			
          rval=ERROR_NONE;
        #else
          if (getModuleState(MODULE_GPS)!=STATE_DISABLED){
            USB_SendString("GPS ENABLED\n\r",13);
          }else{
            USB_SendString("GPS DISABLED\n\r",14);
          }
        #endif
          rval=ERROR_NONE;
        }
	
        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"bin",3)==0){		
            //Stream USB raw data
            if (usb_stream_bin == USB_STREAM_OFF){
                    /*if (isModuleOnline(MODULE_DATALOGGER))
                            stop_datalogger();*/
                    
                    usb_stream_bin=USB_STREAM_FAST;
            }			
            rval=ERROR_NONE;
        }

        /*if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"sbin",4)==0){
          if (usb_stream_bin != USB_STREAM_OFF){
              usb_stream_bin=USB_STREAM_OFF;
              if (getModuleState(MODULE_DATALOGGER)==STATE_OFFLINE)
                  start_datalogger();
          }
          rval=ERROR_NONE;
        }*/
		
        // Datalogger control
        /////////////////////
        /*if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"log",3)==0){		
                //Stop/Start datalogger
                if (usb_datalog != USB_STREAM_OFF){
                        copy_enabled_i_devices = getModuleState(MODULE_DATALOGGER);//enabled_i_devices; // Copy actual internal devices setup
                        //enabled_i_devices &= ~(MODULE_DATALOGGER); // Disable Datalogger if enabled
                        setModuleState(MODULE_DATALOGGER, STATE_TEMPOFF);
                        USB_SendString("LOG OFF\n\r",9);
                        usb_datalog = USB_STREAM_OFF;
                        
                }else{
                        //enabled_i_devices = copy_enabled_i_devices; // Restore previous internal config (to reactivate Datalogger)
                        setModuleState(MODULE_DATALOGGER, copy_enabled_i_devices);
                        USB_SendString("LOG ON\n\r",8);
                        usb_datalog = USB_STREAM_FAST;
                }			
                rval=ERROR_NONE;
        }*/
	
	// Log Mark
	///////////
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"mark",4)==0){
		// Save data in the LOG file
		if (usb_rx[usb_rx_rd_ptr][4] != ' '){ //Incorrect format
			rval=ERROR_FORMAT;
		}else{
			sprintf(buf, "%s\r\n",&usb_rx[usb_rx_rd_ptr][0]);
			if (isModuleOnline(MODULE_DATALOGGER))
				datalog_save_data((unsigned char*)&buf[4],strlen(buf)-4, TRUE, MODULE_CPU,0);
			rval = ERROR_NONE;
		}
	}
	
	// Module serial number (ID)
	/////////////////////
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"id",2)==0){
		//usb_send_string(ID_STRING,6);
		sprintf(buf, "%x\r\n",wimu_settings.id);
		USB_SendString(buf,strlen(buf));
		rval = ERROR_NONE;
	}
	
	// Flash writing interface
	////////////////////
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"getset",6)==0){
		//Reply with settings structure
		//wimu_settings.crc = crc_calc((unsigned short*)&wimu_settings, (sizeof(wimu_settings)-2)/2);
		//wimu_settings.crc = crc_calc((unsigned char*)&wimu_settings, (sizeof(wimu_settings)-2));
		
		USB_SendBinary((unsigned char*)&wimu_settings, sizeof(wimu_settings), MODULE_CPU);
		
		rval = ERROR_NONE;
	}
	
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"getconf",7)==0){
		//Reply with settings structure
		//wimu_settings.crc = crc_calc((unsigned short*)&wimu_settings, (sizeof(wimu_settings)-2)/2);
		//wimu_settings.crc = crc_calc((unsigned char*)&wimu_settings, (sizeof(wimu_settings)-2));
		
		USB_SendBinary((unsigned char*)&wimu_config, sizeof(wimu_config), MODULE_CPU);
		
		rval = ERROR_NONE;
	}
	
	
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"setset",6)==0){
		// Compute and check CRC value
		crc = crc_calc((unsigned char*)&usb_rx[usb_rx_rd_ptr][6], (sizeof(wimu_settings)-4));
		received_crc = (usb_rx[usb_rx_rd_ptr][sizeof(wimu_settings)]) +
                               (((uint32_t)usb_rx[usb_rx_rd_ptr][1+sizeof(wimu_settings)])<<8) +
                               (((uint32_t)usb_rx[usb_rx_rd_ptr][2+sizeof(wimu_settings)])<<16) +
                               (((uint32_t)usb_rx[usb_rx_rd_ptr][3+sizeof(wimu_settings)])<<24);
		// Check if CRC is valid
		if (crc == received_crc || received_crc==0xffffffff){
                    // Write received data into settings structure
                    // *** It is assumed that the incoming data is structured accordingly to WIMU_SETTINGS structure
                    //wimu_settings = *((WIMU_SETTINGS*)(&(usb_rx[usb_rx_rd_ptr][7])));
                    memcpy(&wimu_settings,&usb_rx[usb_rx_rd_ptr][6],sizeof(WIMU_SETTINGS));

                    // Recompute CRC if needed
                    if (received_crc==0xffffffff)
                      wimu_settings.crc = crc;
   
                    //CRC OK, save data
                    flash_write_settings(&wimu_settings);

                    // Overwrite software information
                    wimu_settings.version[0] = VERSION_MAJOR;
                    wimu_settings.version[1] = VERSION_MINOR;
                    wimu_settings.version[2] = VERSION_REV;
                                                            
                    //Send confirmation
                    USB_SendString("OK\n\r",4);
                    
                    rval = ERROR_NONE;
		}else{
                    //CRC not OK, send error message
                    rval = ERROR_CRC;
		}
		
		
	}
	
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"setconf",7)==0){
                rval = sizeof(wimu_config);
		// Compute and check CRC value
		//crc = crc_calc((unsigned char*)&usb_rx[usb_rx_rd_ptr][8], (sizeof(wimu_config)-4));
		
		// Check if CRC is valid
		//if (crc == (usb_rx[usb_rx_rd_ptr][6+sizeof(wimu_config)])+(((unsigned short)usb_rx[usb_rx_rd_ptr][7+sizeof(wimu_config)])<<8)){
                
                crc = crc_calc((unsigned char*)&usb_rx[usb_rx_rd_ptr][7], (sizeof(wimu_config)-4));
		received_crc = (usb_rx[usb_rx_rd_ptr][7+sizeof(wimu_config)-4]) +
                               (((uint32_t)usb_rx[usb_rx_rd_ptr][7+sizeof(wimu_config)-3])<<8) +
                               (((uint32_t)usb_rx[usb_rx_rd_ptr][7+sizeof(wimu_config)-2])<<16) +
                               (((uint32_t)usb_rx[usb_rx_rd_ptr][7+sizeof(wimu_config)-1])<<24);
		// Check if CRC is valid
		if (crc == received_crc || received_crc==0xffffffff){
					// Write received data into config structure
                      // *** It is assumed that the incoming data is structured accordingly to WIMU_CONFIG structure
                      //wimu_config = *((WIMU_CONFIG*)(&usb_rx[usb_rx_rd_ptr][7]));
                      memcpy(&wimu_config,&usb_rx[usb_rx_rd_ptr][7],sizeof(WIMU_CONFIG));

                      // Recompute CRC if needed
                      if (received_crc==0xffffffff)
                        wimu_config.crc = crc;
      
                      //CRC OK, save data
                      flash_write_config(&wimu_config);
                                                              
                      //TODO: Reboot??
                      
                      //Send confirmation
                      USB_SendString("OK\n\r",4);
                      
                      rval = ERROR_NONE;
		}else{
                      //CRC not OK, send error message
                      rval = ERROR_CRC;
		}
		
		
	}
	
	// Utilities
	////////////////////
	
	if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"reboot",6)==0){
            //Reboot the module
           NVIC_SystemReset();
	}

        // Time
        ///////////////////

        if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"timeset",7)==0){
            // Copy data to buffer
            for (crc = 8; crc < USB_RX_BUFFER; crc++){
              if (usb_rx[usb_rx_rd_ptr][crc]=='\n' || usb_rx[usb_rx_rd_ptr][crc]=='\r')
                break; // We found the end of the parameters
            }
            if (crc==USB_RX_BUFFER){
              rval = ERROR_FORMAT;
            }else{
              // Copy string to buffer
              memcpy(&buf[0], &usb_rx[usb_rx_rd_ptr][8], crc-7);
              // Convert to value
              received_time = atoll(&buf[0]) -  wimu_config.datetime.time_offset * 3600; // Time should be in local format - ignore time_offset
              update_RTCtimeFromTimestamp(received_time);

              
              //Send confirmation
              USB_SendString("OK\n\r",4);
            }

            //&usb_rx[usb_rx_rd_ptr][0]
            //
            rval=ERROR_NONE;
        }else{
          if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"time",4)==0){
            /*if (usb_stream_time != USB_STREAM_OFF){
              USB_SendString("*************\n\r",15);
              usb_stream_time=USB_STREAM_OFF;
                  
            }else{
              USB_SendString("System Time\n\r",13);	
              usb_stream_time=USB_STREAM_SLOW;
            }*/
            sprintf(buf, "%ld\n\r", timestamp);
            USB_SendString(buf,strlen(buf));
            rval=ERROR_NONE;
          }
        }

	
	//Sensors Calibration
	/*if (strncmp((const char*)&usb_rx[usb_rx_rd_ptr][0],"calib",5)==0){
          //ModeButton.RequestedAction = BTN_CALIB;
          rval = ERROR_NONE;
        }*/

	//Unknown command
	/////////////////
	if (rval != ERROR_NONE){
		//Command not found
		USB_SendString("ERROR\n\r",7);
	}	
	
	//Check if doing any streaming at all
	usb_streaming = /*usb_stream_acc +*/ usb_stream_gps + /*usb_stream_gyro + usb_stream_mag +*/ usb_stream_power + 
	                /*usb_stream_sonars + usb_stream_encoders + usb_stream_fsr + usb_stream_joystick +*/
			/*usb_stream_time +*/ usb_stream_bin; 
                                                                
	if (++usb_rx_rd_ptr >= USB_RX_BUF_NUM)	// At the end of the buffers?
		usb_rx_rd_ptr=0;
	
	usb_rx_queue--;
	
	return rval;
}

//------------------------------------------------------------------------------
// USB_SEND_STRING
//------------------------------------------------------------------------------
// Add a string to the TX buffer and starts the transfer process
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
Error_TypeDef USB_SendString(char* msg, unsigned short len){
	
	//Check if length is <= TX buffer size
	if (len>USB_TX_BUFFER){
		return ERROR_BUFFER;
	}
	
	//Check if buffers are full
	 if (usb_tx_queue>USB_TX_BUF_NUM){
          // Wait for buffers to be free
          return ERROR_BUFFER;
        }
	
	//Copy the bytes into the actual transmit buffer
	memcpy(&usb_tx[usb_tx_wr_ptr][0], msg, len);
	
	//Set the message length
	usb_tx_len[usb_tx_wr_ptr]=len;
	
	//Increments buffer ptr
	usb_tx_wr_ptr++;
	if (usb_tx_wr_ptr >= USB_TX_BUF_NUM){
		usb_tx_wr_ptr=0;
	}
	
	// ***The SOF_Callback() (usb_endp.c) is call every 5 ms to start VC transfer
  
    usb_tx_queue++;

		
    return ERROR_NONE; //All is well!
}

//------------------------------------------------------------------------------
// USB_SEND_BINARY
//------------------------------------------------------------------------------
// Add binary data to the TX buffer and starts the transfer process
//------------------------------------------------------------------------------
// Parameters: 
// msg - a pointer to the start of data to transfer. This pointer
//       doesn't need to still be valid after the execution of this function, since
//       it will copy the string into a transmit buffer. 
// len - the length of the data to send
// module - the module sending the data (see constants definition in usb.h)
//
// Return value (Unsigned Char):
// 0x00, if everything went ok
// 0x01, if string is too long
// 0x02, if transmit buffer are full
//------------------------------------------------------------------------------
Error_TypeDef USB_SendBinary(unsigned char* msg, unsigned char len, unsigned char module){
	
	//Check if length is <= TX buffer size
	if (len+4>USB_TX_BUFFER){
		return ERROR_BUFFER;
	}
	
	//Check if buffers are full
        if (usb_tx_queue>USB_TX_BUF_NUM){
          //All buffers are full, stop streaming
          /*USB_StopAllStreams();
          usb_tx_queue=0;
          return ERROR_BUFFER;*/
          // Wait for buffers to be free
          while (usb_tx_queue>USB_TX_BUF_NUM && USB_IsConnected());

        }
	
	//Copy the bytes into the actual transmit buffer
	
	// Sync byte
	usb_tx[usb_tx_wr_ptr][0] = SYNC_BYTE;
	usb_tx[usb_tx_wr_ptr][1] = SYNC_BYTE;
	// Module
	usb_tx[usb_tx_wr_ptr][2] = module;
	// Length
	usb_tx[usb_tx_wr_ptr][3] = len;
	//Data
	memcpy(&usb_tx[usb_tx_wr_ptr][4], msg, len);
	
	//Set the message length
	usb_tx_len[usb_tx_wr_ptr]=len+4;
	
	//Increments buffer ptr
	usb_tx_wr_ptr++;
	if (usb_tx_wr_ptr >= USB_TX_BUF_NUM){
		usb_tx_wr_ptr=0;
	}
	
	// ***The SOF_Callback() (usb_endp.c) is call every 5 ms to start VC transfer

        usb_tx_queue++;
		
	return ERROR_NONE; //All is well!
}

//------------------------------------------------------------------------------
// USB_SEND_CHAR
//------------------------------------------------------------------------------
// Add a char to the TX buffer and starts the transfer process
//------------------------------------------------------------------------------
// Parameters: 
// char, the character to send
//
// Return value (Unsigned Char):
// 0x00, if everything went ok
// 0x02, if transmit buffer are full
//------------------------------------------------------------------------------
Error_TypeDef USB_SendChar(char chr){

	//Check if buffers are full
        if (usb_tx_queue>USB_TX_BUF_NUM){
          // Wait for buffers to be free
          while (usb_tx_queue>USB_TX_BUF_NUM  && USB_IsConnected());
        }
	
	//Copy the bytes into the actual transmit buffer
	usb_tx[usb_tx_wr_ptr][0]=chr;
	
	//Set the message length
	usb_tx_len[usb_tx_wr_ptr]=1;
	
	//Increments buffer ptr
	usb_tx_wr_ptr++;
	if (usb_tx_wr_ptr >= USB_TX_BUF_NUM){
		usb_tx_wr_ptr=0;
	}
	
	// ***The SOF_Callback() (usb_endp.c) is call every 5 ms to start VC transfer
        usb_tx_queue++;
 
	return ERROR_NONE;
}

void USB_SetMode(ProgramMode mode){
  usb_mode = mode;
  
  PowerOff(); // Disable USB for now
  msWait(200);
  USB_GlobalInit();

}

void USBDetect_Config(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
  EXTI_InitTypeDef EXTI_InitStructure;
  NVIC_InitTypeDef NVIC_InitStructure;

/* Enable and set the EXTI interrupt priority */
  NVIC_InitStructure.NVIC_IRQChannel = EXTI15_10_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 2;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = DISABLE; // In case it was already enabled 
  NVIC_Init(&NVIC_InitStructure);

  // Enable GPIOx AHB Clocks
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, ENABLE);
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_SYSCFG, ENABLE);
	
  // Configure pins
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_13;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(GPIOC, &GPIO_InitStructure);

/* Connect EXTI Line to INT Pin */
  SYSCFG_EXTILineConfig(EXTI_PortSourceGPIOC, EXTI_PinSource13);
  
  /* Configure EXTI line */
  EXTI_InitStructure.EXTI_Line = EXTI_Line13;
  EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
  EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Rising_Falling;
  EXTI_InitStructure.EXTI_LineCmd = ENABLE;
  EXTI_Init(&EXTI_InitStructure);
  
  /* Enable and set the EXTI interrupt priority */
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);

}


/*uint8_t USBDetect_StateChanged(uint8_t * NewState)
{
  *NewState = GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_13);
  
  if(*NewState != USBDetect_CurrentState)
  {
    USBDetect_CurrentState = *NewState;
    return 1;
  }
  else
  {
    return 0;
  }
}*/

uint8_t USB_GetState(){
  return GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_13);
}

bool USB_IsConnected(){
  return USB_GetState()==USB_STATE_CONNECTED;
}

void EXTI15_10_IRQHandler(void)
{
  //char buf[32];
  //PushButtonState_TypeDef btn_state;
  if(EXTI_GetITStatus(EXTI_Line13) != RESET)
  {
    if (USB_GetState()==USB_STATE_CONNECTED){
      //USB cable connected
      //if (Power_GetState()!=POWER_STATE_USB_ON && Power_GetState() !=POWER_STATE_OFF){
        //Power_SetState(POWER_STATE_USB);
      /*}else
        Power_StateDisplay();*/

       // Require a new time sync when connected
       time_sync = 0;
          
    }else{
      // Disconnected - exit USB mode
      //led(LED_BLUE,FALSE);
      usb_mode = MASS_STORAGE; // Reset mode

      /*if (Power_GetState() == POWER_STATE_USB || Power_GetState() == POWER_STATE_USB_ON || Power_GetState() == POWER_STATE_LOWBAT){
        if (Power_GetLastState()!=POWER_STATE_OFF)*/
          //Power_SetState(POWER_STATE_ON);
        /*else{
          Power_SetState(POWER_STATE_OFF);
        }
      }else{
        Power_StateDisplay();
      }      
      */
    }

    EXTI_ClearITPendingBit(EXTI_Line13);
  }
}
