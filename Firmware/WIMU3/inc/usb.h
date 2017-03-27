#ifndef USB_H_
#define USB_H_
#include "config.h"
#include "stm32l1xx.h"
#include "utils.h"

//------------------------
// Constants Define
//------------------------
#define USB_RX_BUFFER	128	// Maximum number of char that can be received (commands)
#define USB_TX_BUFFER	256	// Maximum number of char that can be sent in one packet

#define USB_TX_BUF_NUM	16	// Number of TX buffers (number of messages in the queue)
#define USB_RX_BUF_NUM	10	// Number of RX buffers (number of commands waiting)
										
#define USB_STREAM_OFF	0
#define USB_STREAM_FAST	1	
#define USB_STREAM_SLOW	2

/*#define USB_MODULE_ACC		0x00
#define USB_MODULE_GYRO		0x01
#define USB_MODULE_MAGNETO 	0x02
#define USB_MODULE_GPS		0x03
#define USB_MODULE_POWER	0x04
#define USB_MODULE_SONARS	0x05
#define USB_MODULE_ENC		0x06
#define USB_MODULE_FSR		0x07
#define USB_MODULE_JOY		0x08
#define USB_MODULE_IMU          0x09
#define USB_MODULE_QUATERNION          0x10*/

#define USB_STATE_CONNECTED     1 // Logic level when USB cable is connected
#define USB_STATE_DISCONNECTED  0 // Logic level when USB cable is disconnected

//------------------------
// Structure Define
//------------------------
typedef enum {VIRTUAL_COM, MASS_STORAGE, UNDEFINED} ProgramMode;

//------------------------
// Functions Define
//------------------------
Error_TypeDef USB_GlobalInit(void);
Error_TypeDef USB_Start(void);
void USB_Stop(void);
void USB_StopAllStreams(void);
Error_TypeDef USB_ProcessRX(void);
Error_TypeDef USB_SendString(char* msg, unsigned short len);
Error_TypeDef USB_SendBinary(unsigned char* msg, unsigned char len, unsigned char module);
Error_TypeDef USB_SendChar(char chr);

//void USB_ModeSelection(void);
void USB_SetMode(ProgramMode mode);

void USBDetect_Config(void);
//uint8_t USB_GetState();
bool USB_IsConnected();

//uint8_t USBDetect_StateChanged(uint8_t * NewState);

//------------------------
// Variable references
//------------------------
extern unsigned char usb_rx[USB_RX_BUF_NUM][USB_RX_BUFFER];
extern unsigned char usb_tx[USB_TX_BUF_NUM][USB_TX_BUFFER];

//extern unsigned short usb_rx_len[USB_RX_BUF_NUM];
//extern unsigned short usb_tx_len[USB_TX_BUF_NUM];

extern unsigned char usb_rx_rd_ptr; // Actual RX read index
extern unsigned char usb_rx_wr_ptr; // Actual RX write index
extern unsigned char usb_tx_rd_ptr; // Actual TX read index
extern unsigned char usb_tx_wr_ptr; // Actual TX write index

extern unsigned char usb_rx_index;
extern unsigned char usb_tx_index;

extern unsigned char usb_rx_queue;
extern unsigned char usb_tx_queue;

extern unsigned short usb_tx_len[USB_TX_BUF_NUM];

//extern unsigned char usb_stream_acc; //Stream ACC values on USB if =1 (fast) or =2 (slow)
extern unsigned char usb_stream_gps; //Stream GPS values on USB if =1
//extern unsigned char usb_stream_quaternion; //Stream Quaternion values on USB if =1
//extern unsigned char usb_stream_gyro; //Stream Gyro values on USB if =1 (fast) or =2 (slow)
//extern unsigned char usb_stream_mag;  //Stream Magneto values on USB if 1(fast) or 2 (slow)
extern unsigned char usb_stream_power;	//Stream power values on USB if =1 (fast) or =2 (slow)
//extern unsigned char usb_stream_time;

//extern unsigned char usb_stream_sonars;	//Stream Sonars values on USB if =1
//extern unsigned char usb_stream_encoders; //Stream Encoders value on USB if =1
//extern unsigned char usb_stream_fsr; //Stream FSR values on USB if =1
//extern unsigned char usb_stream_joystick; //Stream joystick values on USB if =1 (fast) or =2 (slow)

extern unsigned char usb_stream_bin; //Stream binary data on USB if =1 (fast)

extern unsigned char usb_streaming;	// >0 if any streaming is occuring, otherwise = 0

extern bool usb_rx_ready; // Set to TRUE when RX data is ready to be processed


extern ProgramMode usb_mode;
#endif /*USB_H_*/
