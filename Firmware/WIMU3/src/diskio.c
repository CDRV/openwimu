/*-----------------------------------------------------------------------*/
/* Low level disk I/O module skeleton for FatFs     (C)ChaN, 2007        */
/*-----------------------------------------------------------------------*/
/* This is a stub disk I/O module that acts as front end of the existing */
/* disk I/O modules and attach it to FatFs module with common interface. */
/*-----------------------------------------------------------------------*/

#include "diskio.h"
#include "stm32l1xx.h"
#include "ffconf.h"
#include "stm32l152_eval_spi_sd.h"
#include "stm32l1xx_rtc.h"
#include "config.h"

/*-----------------------------------------------------------------------*/
/* Correspondence between physical drive number and physical drive.      */
/*-----------------------------------------------------------------------*/

#define ATA		0
#define MMC		1
#define USB		2
SD_CardInfo SDCardInfo2;

/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
	BYTE drv				/* Physical drive nmuber (0..) */
)
{
 SD_Error res = SD_RESPONSE_FAILURE;
 res =  SD_Init(); 
 return ((DSTATUS)res);
}



/*-----------------------------------------------------------------------*/
/* Return Disk Status                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
	BYTE drv		/* Physical drive nmuber (0) */
)
{
	if (drv) return STA_NOINIT;		/* Supports only single drive */
	return 0;
}


/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/

DRESULT disk_read (
	BYTE drv,		/* Physical drive nmuber (0..) */
	BYTE *buff,		/* Data buffer to store read data */
	DWORD sector,	        /* Sector address (LBA) */
	UINT count		/* Number of sectors to read (1..255) */
)
{   
    SD_Error err;
    err = SD_ReadBlock(buff, sector << 9, 512);

    if (err==SD_RESPONSE_NO_ERROR)
      return RES_OK;
    else{
      return RES_ERROR;
    }
}



/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/
/* The FatFs module will issue multiple sector transfer request
/  (count > 1) to the disk I/O layer. The disk function should process
/  the multiple sector transfer properly Do. not translate it into
/  multiple single sector transfers to the media, or the data read/write
/  performance may be drasticaly decreased. */

/*
RES_OK (0)
    The function succeeded.
RES_ERROR
    Any hard error occured during the write operation and could not recover it.
RES_WRPRT
    The medium is write protected.
RES_PARERR
    Invalid parameter.
RES_NOTRDY
    The device has not been initialized. */

#if _READONLY == 0
DRESULT disk_write (
	BYTE drv,	        /* Physical drive nmuber (0..) */
	const BYTE *buff,	/* Data to be written */
	DWORD sector,		/* Sector address (LBA) */
	UINT count		/* Number of sectors to write (1..255) */
)
{
    SD_Error err;
    err = SD_WriteBlock((BYTE *)buff, sector << 9,512);;

    if (err==SD_RESPONSE_NO_ERROR)
      return RES_OK;
    else{
      return RES_ERROR;
    }
}
#endif /* _READONLY */

/*-----------------------------------------------------------------------*/
/* Get current time                                                      */
/*-----------------------------------------------------------------------*/

DWORD get_fattime ()
{
    DWORD time=0;

    RTC_TimeTypeDef RTC_Time;
    RTC_DateTypeDef RTC_Date;
    unsigned int val=0;
  	
    RTC_GetTime(RTC_Format_BIN, &RTC_Time);
    RTC_GetDate(RTC_Format_BIN, &RTC_Date);
  
    // Generate time word
    val = RTC_Date.RTC_Year + 20; // - 1980;
    //if (val<0) val=0;
    time = (val & 0x007F) << 25;
      
    val = RTC_Date.RTC_Month+1;
    time += (val & 0x000F) << 21;
      
    val = RTC_Date.RTC_Date;
    time += (val & 0x001F) << 16;
      
    val = RTC_Time.RTC_Hours;
    time += (val & 0x001F) << 11;
      
    val = RTC_Time.RTC_Minutes;
    time += (val & 0x001F) << 5;
      
    val = RTC_Time.RTC_Seconds/2;
    time += (val & 0x001F);

    return time;
}

/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl (
	BYTE drv,		/* Physical drive nmuber (0..) */
	BYTE ctrl,		/* Control code */
	void *buff		/* Buffer to send/receive control data */
)
{
		DRESULT res = RES_OK;
		switch (ctrl) {
    
      case CTRL_SYNC :        // Only used when _MAX_SS is not 512 (Always 512 for SDHC)
        break;
        
		case GET_SECTOR_COUNT :	  // Get number of sectors on the disk (DWORD) (Only used by f_mkfs() that is not used in our case)
			*(DWORD*)buff = 1;
			res = RES_OK;
			break;

		case GET_SECTOR_SIZE :	  // Get R/W sector size (WORD) 
			*(WORD*)buff = 512;
			res = RES_OK;
			break;

		case GET_BLOCK_SIZE :	    // Get erase block size in unit of sector (DWORD) (Only used by f_mkfs() that is not used in our case)
			*(DWORD*)buff = 32;
			res = RES_OK;
		  }
	  
	return res;
}
