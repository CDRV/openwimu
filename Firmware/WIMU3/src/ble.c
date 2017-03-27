#include "Merged__hw_config.h" 
#include "ble.h"
#include "config.h"
#include "utils.h"
#include <string.h> //memcpy

#include "datalogger.h" // To get current recording directory

#include "buttons.h" // To simulate button presses
#include "RTC.h"
#include "gps.h"

unsigned char ble_rx[BLE_RX_BUF_NUM][BLE_RX_BUFFER];
unsigned char ble_tx[BLE_TX_BUF_NUM][BLE_TX_BUFFER];

unsigned char ble_rx_rd_ptr; // Actual RX read index
unsigned char ble_rx_wr_ptr; // Actual RX write index
unsigned char ble_tx_rd_ptr; // Actual TX read index
unsigned char ble_tx_wr_ptr; // Actual TX write index

volatile unsigned char ble_rx_index;
volatile unsigned char ble_tx_index;

volatile unsigned char ble_rx_queue;
volatile unsigned char ble_tx_queue;

uint16_t ble_tx_len[BLE_TX_BUF_NUM];
uint16_t ble_rx_len[BLE_RX_BUF_NUM];

bool ble_rx_ready;

extern unsigned long timestamp;

unsigned long total_rx_frames=0;
unsigned long total_tx_frames=0;

RemControl_Struct ble_control;

bool ble_update_time = false;

//BOOL test_mode=TRUE;

// Data frame structures
POWERFrame_Struct       POWERFrame;
DEVINFOFrame_Struct	DEVINFOFrame;

CurrentTime_Struct current_time;

/* Extern variables ----------------------------------------------------------*/
extern RTC_TimeTypeDef RTC_TimeStruct;
extern RTC_DateTypeDef RTC_DateStruct;

//------------------------------------------------------------------------------
// INIT_BLE
//------------------------------------------------------------------------------
// Initialization function for the BLE module. 
//------------------------------------------------------------------------------
// Parameters: 
// None
//
// Return value (Unsigned Char):
// 0x00, if initialization was successfully completed
// 0xYY, if initialization wasn't successfully completed where YY=error code
//------------------------------------------------------------------------------
unsigned char init_ble(void){
  GPIO_InitTypeDef GPIO_InitStructure;
  USART_InitTypeDef USART_InitStruct;
  
  /* Enabling USART clock */
  RCC_APB1PeriphClockCmd(RCC_APB1Periph_USART2, ENABLE);
  
  // Connecting TX and RX pins to the desired peripherals' Alternate Function
  GPIO_PinAFConfig(GPIOA, GPIO_PinSource2, GPIO_AF_USART2);
  GPIO_PinAFConfig(GPIOA, GPIO_PinSource3, GPIO_AF_USART2);
  
  /* Configure USART Tx as alternate function and selecting the type, pull-up/pull-down and output speed */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_40MHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOA, &GPIO_InitStructure);
  
  /* Configure USART Rx as alternate function and selecting the type and pull-up/pull-down */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_3;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOA, &GPIO_InitStructure);
  
  /* Initializing the USART (Baud Rate, Word Length , Stop Bit, Parity, Hardware
   flow control and Mode) */
  USART_InitStruct.USART_BaudRate = 230400;//115200;
  USART_InitStruct.USART_WordLength = USART_WordLength_8b;
  USART_InitStruct.USART_StopBits = USART_StopBits_1;
  USART_InitStruct.USART_Parity = USART_Parity_No;
  USART_InitStruct.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
  USART_InitStruct.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
  USART_Init(USART2, &USART_InitStruct);
    
  BLE_SetupPower();


  // Initialize device info frame
  DEVINFOFrame.serialNumber = wimu_settings.id;
  DEVINFOFrame.hardRevision = wimu_settings.hw_id;
  for(int i = 0;i<(LEN_VERSION_STRING -2);i++) {	  // without new line and carriage return (\n\r)
    DEVINFOFrame.firmSoftRevision[i] = *(VERSION_STRING + i);}


  return 0x00;
}

unsigned char start_ble(){
  uint8_t i;

  // Reset pointers
  ble_rx_index=0;
  ble_tx_index=0;
  ble_rx_rd_ptr=0;
  ble_rx_wr_ptr=0;
  ble_tx_rd_ptr=0;
  ble_tx_wr_ptr=0;
  ble_rx_queue=0;
  ble_tx_queue=0;
  for (i=0; i<BLE_RX_BUF_NUM; i++)
    ble_rx_len[i]=0;
  
  for (i=0; i<BLE_TX_BUF_NUM; i++)
    ble_tx_len[i]=0;

  ble_rx_ready=FALSE;

  // Interrupts
  BLE_ConfigRxIRQ(ENABLE);
  BLE_ConfigTxIRQ(ENABLE);

  BLE_EnablePower();

  USART_Cmd(USART2, ENABLE);

  BLE_sendDevInfoData(&DEVINFOFrame);

  return 0;

}

void BLE_SetupPower(void)
{
  /* Enabling GPIO clock */
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA, ENABLE);

  GPIO_InitTypeDef GPIO_InitStructure;
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_400KHz;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_DOWN;
  GPIO_Init(GPIOA, &GPIO_InitStructure);

}

void BLE_EnablePower(void)
{
  GPIO_SetBits(GPIOA, GPIO_Pin_0);
  msWait(100);
}

void BLE_DisablePower(void)
{
  GPIO_ResetBits(GPIOA, GPIO_Pin_0);
}

void stop_ble(){
  BLE_ConfigRxIRQ(DISABLE);
  BLE_ConfigTxIRQ(DISABLE);
  BLE_DisablePower();

  USART_Cmd(USART2, DISABLE);

}

//------------------------------------------------------------------------------
// BLE_PROCESS_RX
//------------------------------------------------------------------------------
// Process the last received command from the BLE chip and execute appropriate 
// tasks according to it. 
//------------------------------------------------------------------------------
// Parameters: 
// None - it will automatically use the actual RX read buffer as defined by
//        ble_rx_rd_ptr;
//
// Return value (Unsigned Char):
// 0x00, if command was correct
// 0xYY, if command is unknown or malformed
//------------------------------------------------------------------------------
unsigned char BLE_process_rx(void){
  unsigned char rval = 1;

 /* if (ble_rx_len[ble_rx_rd_ptr]==0)
    return 0;*/

  // Unstuff data
  unsigned char unstuffed[BLE_RX_BUFFER];
  COBS_UnStuffData(&ble_rx[ble_rx_rd_ptr][0], ble_rx_len[ble_rx_rd_ptr], &unstuffed[0]);

  // Process message according to msg type
  switch (unstuffed[0]){
    case BLE_DEVINFO_DATA:
      // Device information requested
      BLE_sendDevInfoData(&DEVINFOFrame);

      // Also sends current module config
     // BLE_sendConfig(&wimu_config);

      rval = 0; // All is well
    break;
    case BLE_CONTROL_DATA:
      if (wimu_config.ble.enable_control==false) // No control allowed
        break;

      // Start/Stop recording
      if ((ble_control.status & BLE_CTRL_FLAG_REC) != (unstuffed[2] & BLE_CTRL_FLAG_REC)){
        ModeButton.RequestedAction = BTN_MARK;
        rval = 2;
      }

      //ble_control = unstuffed[2];
      memcpy(&ble_control, &unstuffed[2], sizeof(RemControl_Struct));

      // Overwrite current rec_id
      ble_control.rec_id = dos_rec_count+1;

      // Resend current rec_id if recording started
      if (rval==2){
        BLE_sendRemoteControlData(&ble_control);
      }
      
      rval = 0;
    break;
    case BLE_DATETIME_DATA:{
      // Set current time requested
      CurrentTime_Struct current;
      memcpy(&current, &unstuffed[2], sizeof(CurrentTime_Struct));

    
      update_RTCtime(current.exact_time.day_date_time.date_time.year,
                     current.exact_time.day_date_time.date_time.month+1,
                     current.exact_time.day_date_time.date_time.day,
                     current.exact_time.day_date_time.date_time.hours,
                     current.exact_time.day_date_time.date_time.minutes,
                     current.exact_time.day_date_time.date_time.seconds,
                     false);

    }break;
    default:
    break;
  }

  // Update reading pointers
  if (++ble_rx_rd_ptr >= BLE_RX_BUF_NUM)	// At the end of the buffers?
      ble_rx_rd_ptr=0;
	
  ble_rx_queue--;

  return rval;
}

void BLE_sendIMUData(IMUFrame_Struct* imu_data/*int16_t *acc, int16_t *gyro, int16_t *mag*/){
  static uint16_t fnum=0;
  
  IMUFrame_Struct tosend;
  BLEFrame_Struct frame;

  //uint8_t i;
  
  //Copy IMU data to send into local buffer (in case of overwrite)
  memcpy(&tosend, imu_data, sizeof(IMUFrame_Struct));

  tosend.frame_num = fnum++;
  /*tosend.frame_num = 1;

  for (i=0;i<3; i++){
    tosend.acc_data[i] = 1*i;
    tosend.gyro_data[i] = 2*i;
    tosend.mag_data[i] = 3*i;
  }

  tosend.quaternion[0]=1;
  tosend.quaternion[1]=2;
  tosend.quaternion[2]=3;
  tosend.quaternion[3]=4;*/
  frame.data_type = BLE_IMU_DATA;
  frame.length = sizeof(IMUFrame_Struct);
  //frame.crc=0xffffffff;
  frame.data = (uint8_t*)&tosend;

  BLE_sendFrame(&frame);
}

void BLE_sendGPSData(unsigned char* gps_data, unsigned short length, uint8_t frame_type){
  uint32_t value32;
  uint16_t value16;
  uint8_t value8;

  if (frame_type == SIRF_GEO_DATA){
    //led_toggle(LED_GREEN,NO_PRIORITY);

    // Build and send GPS position update
    GPSFrame_struct GPSFrame;   
      
    // Time
    //////////////////
    GPSFrame.date_time.year = gps_data[SIRF_HEADER_LEN + SIRF_GEO_YEAR_POS_OFFSET+1] + (unsigned short)(gps_data[SIRF_HEADER_LEN + SIRF_GEO_YEAR_POS_OFFSET]<<8);
    GPSFrame.date_time.month = gps_data[SIRF_HEADER_LEN + SIRF_GEO_MONTH_POS_OFFSET];
    GPSFrame.date_time.day = gps_data[SIRF_HEADER_LEN + SIRF_GEO_DAY_POS_OFFSET];
    GPSFrame.date_time.hours = gps_data[SIRF_HEADER_LEN + SIRF_GEO_HOUR_POS_OFFSET];
    GPSFrame.date_time.minutes = gps_data[SIRF_HEADER_LEN + SIRF_GEO_MINUTE_POS_OFFSET];
    GPSFrame.date_time.seconds = (gps_data[SIRF_HEADER_LEN + SIRF_GEO_SECOND_POS_OFFSET+1] + (unsigned short)(gps_data[SIRF_HEADER_LEN + SIRF_GEO_SECOND_POS_OFFSET]<<8))/1000;

    // Position
    /////////////////
    value32 = gps_data[SIRF_HEADER_LEN + SIRF_GEO_LATITUDE_POS_OFFSET+3] +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_LATITUDE_POS_OFFSET+2]<<8) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_LATITUDE_POS_OFFSET+1]<<16) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_LATITUDE_POS_OFFSET]<<24);
    GPSFrame.loc_speed.latitude = value32;

    value32 = gps_data[SIRF_HEADER_LEN + SIRF_GEO_LONGITUDE_POS_OFFSET+3] +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_LONGITUDE_POS_OFFSET+2]<<8) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_LONGITUDE_POS_OFFSET+1]<<16) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_LONGITUDE_POS_OFFSET]<<24);
    GPSFrame.loc_speed.longitude = value32;

    // Elevation
    ////////////////
    GPSFrame.loc_speed.elevation[0] = gps_data[SIRF_HEADER_LEN + SIRF_GEO_ALTITUDE_POS_OFFSET+3];
    GPSFrame.loc_speed.elevation[1] = gps_data[SIRF_HEADER_LEN + SIRF_GEO_ALTITUDE_POS_OFFSET+2];
    GPSFrame.loc_speed.elevation[2] = gps_data[SIRF_HEADER_LEN + SIRF_GEO_ALTITUDE_POS_OFFSET+1];

    // Speed
    ////////////////
    GPSFrame.loc_speed.instantSpeed = gps_data[SIRF_HEADER_LEN + SIRF_GEO_SPEED_POS_OFFSET+1] + (unsigned short)(gps_data[SIRF_HEADER_LEN + SIRF_GEO_SPEED_POS_OFFSET]<<8);

    // Precisions
    ////////////////
    value32 = gps_data[SIRF_HEADER_LEN + SIRF_GEO_EHPE_POS_OFFSET+3] +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_EHPE_POS_OFFSET+2]<<8) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_EHPE_POS_OFFSET+1]<<16) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_EHPE_POS_OFFSET]<<24);
    GPSFrame.quality.ehpe = value32;

    value32 = gps_data[SIRF_HEADER_LEN + SIRF_GEO_EVPE_POS_OFFSET+3] +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_EVPE_POS_OFFSET+2]<<8) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_EVPE_POS_OFFSET+1]<<16) +
              ((uint32_t)gps_data[SIRF_HEADER_LEN + SIRF_GEO_EVPE_POS_OFFSET]<<24);
    GPSFrame.quality.evpe = value32;

    GPSFrame.quality.hdop = gps_data[SIRF_HEADER_LEN + SIRF_GEO_HDOP_POS_OFFSET];

    // GPS in fix
    ///////////////////
    GPSFrame.quality.beaconsInSolution = gps_data[SIRF_HEADER_LEN + SIRF_GEO_SATNUM_POS_OFFSET];

    // Adjust flags for available information
    /////////////////////////////////////////
    GPSFrame.quality.flags = 0x0079;
    GPSFrame.loc_speed.flags = 0x004d;

    // Position valid
    /////////////////
    value16 = gps_data[SIRF_HEADER_LEN + SIRF_GEO_NAVTYPE_POS_OFFSET + 1] + 
                    ((uint16_t)(gps_data[SIRF_HEADER_LEN + SIRF_GEO_NAVTYPE_POS_OFFSET]) << 8);

    value8 = (value16 & 0x0007);

    //GPSFrame.quality.flags &= GPS_POSITION_QUALITY_CLEAR_MASK;
    if (value8==0){
      // No navigation fix
      GPSFrame.quality.flags |= GPS_POSITION_QUALITY_INVALID_MASK;
      GPSFrame.loc_speed.flags |= GPS_POSITION_QUALITY_INVALID_MASK;
    }
    if (value8>0 && (value8<4 || value8 == 5 || value8 == 6)){
      GPSFrame.quality.flags |= GPS_POSITION_QUALITY_ESTIMATED_MASK;
      GPSFrame.loc_speed.flags |= GPS_POSITION_QUALITY_ESTIMATED_MASK;
    }
    if (value8==4){
      GPSFrame.quality.flags |= GPS_POSITION_QUALITY_OK_MASK;
      GPSFrame.loc_speed.flags |= GPS_POSITION_QUALITY_OK_MASK;
    }
    if (value8==7){
      GPSFrame.quality.flags |= GPS_POSITION_QUALITY_LASTKNOWN_MASK;
      GPSFrame.loc_speed.flags |= GPS_POSITION_QUALITY_LASTKNOWN_MASK;
    }

    BLEFrame_Struct frame;

    frame.data_type = BLE_GPS_DATA;
    frame.length = sizeof(GPSFrame);
   // frame.crc=0xffffffff;
    frame.data = (uint8_t*)&GPSFrame;

    BLE_sendFrame(&frame);
  }
  
}

void BLE_sendPOWERData(POWERFrame_Struct* power_data){
  BLEFrame_Struct frame;

  frame.data_type = BLE_POWER_DATA;
  frame.length = sizeof(POWERFrame_Struct);
  //frame.crc=0xffffffff;
  frame.data = (uint8_t*)power_data;

  BLE_sendFrame(&frame);
}

void BLE_sendDevInfoData(DEVINFOFrame_Struct* devInfo_data){
  BLEFrame_Struct frame;

  frame.data_type = BLE_DEVINFO_DATA;
  frame.length = sizeof(DEVINFOFrame_Struct);
  //frame.crc=0xffffffff;
  frame.data = (uint8_t*)devInfo_data;

  BLE_sendFrame(&frame);

  // Always send the config at the same time!
  BLE_sendConfig(&wimu_config);
}

void BLE_sendConfig(WIMU_CONFIG* config_data){
  BLEFrame_Struct frame;
  IMUConfig_Struct configFrame;

  // Fill frame with informations
  configFrame.enabled_modules = config_data->enabled_modules;
  configFrame.sampling_rate = config_data->general.sampling_rate;
  configFrame.acc_range = config_data->acc.range;
  configFrame.gyro_range = config_data->gyro.range;
  configFrame.mag_range = config_data->magneto.range;
  
  frame.data_type = BLE_CONFIG_DATA;
  frame.length = sizeof(IMUConfig_Struct);
  
  //frame.crc=0xffffffff;
  frame.data = (uint8_t*)&configFrame;

  BLE_sendFrame(&frame);
}

void BLE_sendRemoteControlData(RemControl_Struct* remCon){
  BLEFrame_Struct frame; 
  
  frame.data_type = BLE_CONTROL_DATA;
  frame.length = sizeof(RemControl_Struct);
  
  //frame.crc=0xffffffff;
  frame.data = (uint8_t*)remCon;

  BLE_sendFrame(&frame);
}

void BLE_sendCurrentDateTime(){

 // led_toggle(LED_GREEN,NO_PRIORITY);

    /*RTC_GetTime(RTC_Format_BIN, &RTC_TimeStruct);
    RTC_GetDate(RTC_Format_BIN, &RTC_DateStruct);*/
    
    current_time.exact_time.day_date_time.date_time.seconds = RTC_TimeStruct.RTC_Seconds;
    current_time.exact_time.day_date_time.date_time.minutes = RTC_TimeStruct.RTC_Minutes;
    current_time.exact_time.day_date_time.date_time.hours = RTC_TimeStruct.RTC_Hours;
    current_time.exact_time.day_date_time.date_time.day = RTC_DateStruct.RTC_Date;
    current_time.exact_time.day_date_time.date_time.month = RTC_DateStruct.RTC_Month;
    current_time.exact_time.day_date_time.date_time.year = RTC_DateStruct.RTC_Year + 2000;

    current_time.exact_time.day_date_time.day_of_week = RTC_DateStruct.RTC_WeekDay;
    current_time.exact_time.fractions256 = 0; // No ms value... yet!

    current_time.adjust_reason = 0x02; // External time reference update

    BLEFrame_Struct frame;

    frame.data_type = BLE_DATETIME_DATA;
    frame.length = sizeof(CurrentTime_Struct);
    //frame.crc=0xffffffff;
    frame.data = (uint8_t*)&current_time;

    BLE_sendFrame(&frame);

    
}

void BLE_sendFrame(BLEFrame_Struct* frame){
  // Check for overflow
  if (frame->length+4 > BLE_TX_BUFFER)
    return;

  if (wimu_config.ui.ble_activity_led==true)
      led(LED_BLUE,true,MEDIUM_PRIORITY);

  //Copy the bytes into the actual transmit buffer
  //ble_tx[ble_tx_wr_ptr][0] = SYNC_BYTE;
  ble_tx[ble_tx_wr_ptr][0] = frame->data_type;
  ble_tx[ble_tx_wr_ptr][1] = frame->length;
  memcpy(&ble_tx[ble_tx_wr_ptr][2], frame->data, frame->length);
  /*memcpy(&ble_tx[ble_tx_wr_ptr][2], &frame->length, 2);
  memcpy(&ble_tx[ble_tx_wr_ptr][4], frame->data, frame->length);*/
  uint16_t size = frame->length+2;
  uint8_t stuffed[BLE_TX_BUFFER];
  
  COBS_StuffData(&ble_tx[ble_tx_wr_ptr][0], size, &stuffed[0]);
  memcpy(&ble_tx[ble_tx_wr_ptr][0], stuffed, size+1);
  ble_tx[ble_tx_wr_ptr][size+1] = BLE_SYNC_BYTE;

  //Set the message length
  ble_tx_len[ble_tx_wr_ptr] = size+2;

  //Increment buffer ptr
  ble_tx_wr_ptr++;
  if (ble_tx_wr_ptr >= BLE_TX_BUF_NUM){
          ble_tx_wr_ptr=0;
  }

  //Start the transfer of the first byte, if not sending already
  //__disable_irq();
  ble_tx_queue++;
  if (ble_tx_queue>BLE_TX_BUF_NUM)
    ble_tx_queue = BLE_TX_BUF_NUM;

  if (ble_tx_queue==1){
    //Start transfer
    USART_SendData(USART2, ble_tx[ble_tx_rd_ptr][0]);
  }
  //__enable_irq();
  
  if (wimu_config.ui.ble_activity_led==false)
      led(LED_BLUE,false,MEDIUM_PRIORITY);
}

void BLE_ConfigRxIRQ(FunctionalState NewState)
{
  NVIC_InitTypeDef NVIC_InitStructure;
  
  USART_ClearFlag(USART2, USART_FLAG_RXNE);
  USART_ITConfig(USART2, USART_IT_RXNE, NewState);
  
  NVIC_InitStructure.NVIC_IRQChannel = USART2_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = NewState;
  NVIC_Init(&NVIC_InitStructure);

}
void BLE_ConfigTxIRQ(FunctionalState NewState)
{
  NVIC_InitTypeDef NVIC_InitStructure;
  
  USART_ClearFlag(USART2, USART_FLAG_TC);
  USART_ITConfig(USART2, USART_IT_TC, NewState);
  
  NVIC_InitStructure.NVIC_IRQChannel = USART2_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
  NVIC_InitStructure.NVIC_IRQChannelCmd = NewState;
  NVIC_Init(&NVIC_InitStructure);

}

#define COBS_FinishBlock(X) (*code_ptr = (X), code_ptr = dst++, code = 0x01)

void COBS_StuffData(const unsigned char *ptr,
unsigned long length, unsigned char *dst)
{
  const unsigned char *end = ptr + length;
  unsigned char *code_ptr = dst++;
  unsigned char code = 0x01;

  while (ptr < end)
  {
    if (*ptr == 0)
      COBS_FinishBlock(code);
    else
    {
      *dst++ = *ptr;
      if (++code == 0xFF)
        COBS_FinishBlock(code);
    }
    ptr++;
  }

  COBS_FinishBlock(code);
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

/*******************************************************************************
 * Function Name  : USART2_IRQHandler
 * Description    : This function handles USART2 interrupt request.
 * Input          : None
 * Output         : None
 * Return         : None
 *******************************************************************************/
void USART2_IRQHandler(void)
{
  //uint8_t rx_byte;

  // Data Received
  if(USART_GetITStatus(USART2, USART_IT_RXNE) != RESET )
  { 

      ble_rx[ble_rx_wr_ptr][ble_rx_index]=USART_ReceiveData(USART2);
      // SYNC
      if (ble_rx[ble_rx_wr_ptr][ble_rx_index++]==BLE_SYNC_BYTE){
        // MSG is complete!
        ble_rx_len[ble_rx_wr_ptr] = ble_rx_index;
        ble_rx_index=0;
        ble_rx_queue++;
        total_rx_frames++;
        

        ble_rx_wr_ptr++;
        if (ble_rx_wr_ptr >= BLE_RX_BUF_NUM) // All buffers were used
          ble_rx_wr_ptr = 0;
                            
        ble_rx_ready=true;
      }

      // SYNC
      /*if (ble_rx_index==1){
        //1 byte received, and no length yet
        if (ble_rx[ble_rx_wr_ptr][0]!=SYNC_BYTE){
          //Not synced, reset the buffer.
          ble_rx_index=0;
          ble_rx_len[ble_rx_wr_ptr]=0;
        } 
//        led_toggle(LED_BLUE);
      }else{
        
        //DATA LENGTH
        if (ble_rx_index==4){
          //Set length
          ble_rx_len[ble_rx_wr_ptr] = ble_rx[ble_rx_wr_ptr][2] + (uint16_t)(ble_rx[ble_rx_wr_ptr][3]<<8) + 4;
        }
   
        if (ble_rx_index>BLE_RX_BUFFER || ble_rx_index==ble_rx_len[ble_rx_wr_ptr]){
                //Command completed or overflowed...
                ble_rx_index=0;
                ble_rx_queue++;
                total_rx_frames++;

                ble_rx_wr_ptr++;
                if (ble_rx_wr_ptr >= BLE_RX_BUF_NUM) // All buffers were used
                        ble_rx_wr_ptr = 0;
                            
                ble_rx_ready=TRUE;
        }
      }*/
    //rx_byte = USART_ReceiveData(USART2);
    //printf("%c", rx_byte);
    //USART_SendData(USART2, rx_byte);
    //test_mode=TRUE;
  }
  
   // Data Transmitted
  if(USART_GetITStatus(USART2, USART_IT_TC) != RESET)
  {
      USART_ClearFlag(USART2, USART_FLAG_TC);
      //Check for the next char to send
      if (ble_tx_queue>0){
          ble_tx_index++;
          if (ble_tx_index >= BLE_TX_BUFFER || ble_tx_index >= ble_tx_len[ble_tx_rd_ptr]){
                  //This sequence is over. 
                  if (ble_tx_queue>0){
                    //__disable_irq();
                    ble_tx_queue--;
                    //__enable_irq();
                  }
                  ble_tx_rd_ptr++;
                  ble_tx_index=0;
                  total_tx_frames++;
                  if (ble_tx_rd_ptr >= BLE_TX_BUF_NUM) // All buffers were used
                    ble_tx_rd_ptr = 0;
                  if (ble_tx_queue>0){
                    //Sends the next message
                    USART_SendData(USART2, ble_tx[ble_tx_rd_ptr][ble_tx_index]);
                  }/*else{
                    if (total_tx_frames%50==0)
                      led_toggle(LED_RED);
                  }*/
          }else{
                  //Sends the next char waiting!
                  //while (!(UCA3IFG&UCTXIFG));
                 USART_SendData(USART2, ble_tx[ble_tx_rd_ptr][ble_tx_index]);
          }
      }

  }

    
  
}