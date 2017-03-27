#ifndef GPS_H_
#define GPS_H_
#include "config.h"
#include "utils.h"
#include "Merged__hw_config.h" 

//------------------------
// Constants Define
//------------------------

#define GPS_RX_BUFFER	256	// Maximum number of char that can be received (commands) - NMEA standard
#define GPS_TX_BUFFER	128	// Maximum number of char that can be sent in one packet - NMEA standard

#define GPS_TX_BUF_NUM	2	// Number of TX buffers (number of messages in the queue)
#define GPS_RX_BUF_NUM	4	// Number of RX buffers (number of commands waiting)

#define GPS_NOFIX_COUNT_MAX	60 // Number of seconds after which we consider a fix is lost

//#define GPS_DEAD_T		5	// Number of seconds we consider the GPS dead if no RX and we decide to
							// restart it. 

#define GPS_NMEA  0
#define GPS_SIRF  1

#define GPS_MODE  GPS_SIRF

//#define GPS_MODE_1			// Define to use 57600 bps and SM
//#ifdef WHEELCHAIR
	//#define GPS_MODE_1
//#else
//	#define GPS_MODE_2			// Define to use 57600 bps and SIRF Binary protocol to initialize
//#endif

/// SIRF COMMANDS ///
/////////////////////
typedef enum{
  SIRF_CMD_NONE = 0,
  SIRF_MNAV_DATA = 2,
  SIRF_MTRACKER_DATA = 4,
  SIRF_CLK_STATUS = 7,
  SIRF_50BPS_DATA = 8,
  SIRF_CPU_THROUGHPUT = 9,
  SIRF_CMD_ACK = 11,
  SIRF_CMD_NACK = 12,
  SIRF_VISIBLE_LIST = 13,
  SIRF_OK_TO_SEND = 18,
  SIRF_NAV_PARAMS = 19,
  SIRF_GEO_DATA = 41,
  SIRF_SBAS_PARAMETERS = 50,
  SIRF_EXT_EPHEMERIS = 56,
  SIRF_NL_AUX_INIT_DATA = 64,
  SIRF_CW_INTERFERENCE = 92,
  SIRF_INIT_DATA_SRC = 128,
  SIRF_POLL_VERSION = 132,
  SIRF_MODE_CONTROL = 136,
  SIRF_SET_TRICKLE_POWER = 151,
  SIRF_POLL_NAV_PARAMS = 152,
  SIRF_SETMSG_RATE = 166,
  SIRF_SET_LOWPOW_PARAMS = 167,
  SIRF_DEV_DATA = 255
} SIRF_Cmds;

//#define SIRF_POLL_NAV_PARAMS            0x98
//#define SIRF_POLL_VERSION		0x84
//#define SIRF_MODE_CONTROL		0x88
//#define SIRF_OK_TO_SEND			0x12
//#define SIRF_CMD_ACK			0x0B
//#define SIRF_CMD_NACK			0x0C
//#define SIRF_NAV_PARAMS			0x13
//#define SIRF_SETMSG_RATE		0xA6

//#define SIRF_MTRACKER_DATA		0x04
//#define SIRF_INIT_DATA_SRC		0x80
//#define SIRF_SET_TRICKLE_POWER          0x97
//#define SIRF_SET_LOWPOW_PARAMS          0xA7
//#define SIRF_DEV_DATA			0xFF

//#define SIRF_MNAV_DATA			2
//#define SIRF_CLK_STATUS			7
//#define SIRF_50BPS_DATA                 8
//#define SIRF_CPU_THROUGHPUT		9
//#define SIRF_VISIBLE_LIST		13
//#define SIRF_GEO_DATA			41
//#define SIRF_SBAS_PARAMETERS            50
//#define SIRF_EXT_EPHEMERIS		56
//#define SIRF_NL_AUX_INIT_DATA           64
//#define SIRF_CW_INTERFERENCE            92

#define SIRF_DEGRAD_NONE		0x04	//No degrad navigation mode allowed
#define SIRF_DEGRAD_2SVCD		0x03	//Allow 2 SV navigation, freeze clock drift
#define SIRF_DEGRAD_2SVD		0x02	//Allow 2 SV navigation, freeze direction
#define SIRF_DEGRAD_1SVCD		0x01	//Allow 1 SV navigation, freeze clock drift for 2 SV, then direc for 1 SV
#define SIRF_DEGRAD_1SVD		0x00	//Allow 1 SV navigation, freeze direction for 2 SV, then clock drift for 1 SV

#define SIRF_HEADER_LEN                 4
#define SIRF_FOOTER_LEN                 4

#define SIRF_GEO_NAVVALID_POS_OFFSET    1
#define SIRF_GEO_NAVTYPE_POS_OFFSET     3
#define SIRF_GEO_YEAR_POS_OFFSET        11
#define SIRF_GEO_MONTH_POS_OFFSET       13
#define SIRF_GEO_DAY_POS_OFFSET         14
#define SIRF_GEO_HOUR_POS_OFFSET        15
#define SIRF_GEO_MINUTE_POS_OFFSET      16
#define SIRF_GEO_SECOND_POS_OFFSET      17
#define SIRF_GEO_SATIDLIST_POS_OFFSET   19
#define SIRF_GEO_LATITUDE_POS_OFFSET    23
#define SIRF_GEO_LONGITUDE_POS_OFFSET   27
#define SIRF_GEO_ALTITUDE_POS_OFFSET    31
#define SIRF_GEO_SPEED_POS_OFFSET       40
#define SIRF_GEO_EHPE_POS_OFFSET        50
#define SIRF_GEO_EVPE_POS_OFFSET        54
#define SIRF_GEO_SATNUM_POS_OFFSET      84
#define SIRF_GEO_HDOP_POS_OFFSET        85


// SIRF PARAMETERS (IF USING MODE 2) //
///////////////////////////////////////
#define GPS_DEGRAD_MODE			SIRF_DEGRAD_2SVCD
#define GPS_DEGRAD_TIMEOUT		60					//Number of seconds in degraded mode max			
#define GPS_DEADREC_TIMEOUT		60					//Number of seconds in dead reckoning mode (0=disable)
#define GPS_TRACKSMOOTHING		1					//Set to 1 to enable Track Smoothing, 0 to disable

//#define GPS_COLD_START			// Define to force a GPS cold start

//------------------------
// Structure Define
//------------------------

//------------------------
// Functions Define
//------------------------
Error_TypeDef GPS_Init(void);
Error_TypeDef GPS_Start(void);
Error_TypeDef GPS_SendString(char* msg, unsigned short len);
#if GPS_MODE==GPS_SIRF
	unsigned char GPS_SendSirf(unsigned char* msg, unsigned short len);
	unsigned short GPS_Checksum(unsigned char* msg, unsigned short len);
        unsigned char GPS_SetMsgInterval(unsigned char msg_id, unsigned char interval);
	unsigned char GPS_SetMsgFrequency();
	void GPS_Sleep(BOOL sleep);
#endif
Error_TypeDef GPS_ProcessRX(void);
void GPS_Stop(void);

//------------------------
// Variable references
//------------------------
extern unsigned char gps_rx[GPS_RX_BUF_NUM][GPS_RX_BUFFER];
extern unsigned char gps_tx[GPS_TX_BUF_NUM][GPS_TX_BUFFER];

extern unsigned char gps_rx_rd_ptr; // Actual RX read index
extern unsigned char gps_rx_wr_ptr; // Actual RX write index
extern unsigned char gps_tx_rd_ptr; // Actual TX read index
extern unsigned char gps_tx_wr_ptr; // Actual TX write index

extern volatile unsigned char gps_rx_index;
extern volatile unsigned char gps_tx_index;

extern volatile unsigned char gps_rx_queue;
extern volatile unsigned char gps_tx_queue;

extern unsigned short gps_rx_len[GPS_RX_BUF_NUM];
extern unsigned short gps_tx_len[GPS_TX_BUF_NUM];

extern BOOL gps_rx_ready; // Set to TRUE when RX data is ready to be processed
extern BOOL gps_has_fix;
//extern BOOL gps_alive;
//extern unsigned char gps_count;

#endif /*GPS_H_*/
