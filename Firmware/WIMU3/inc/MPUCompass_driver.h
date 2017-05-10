

/* Define to prevent recursive inclusion -------------------------------------*/

#ifndef MPUCOMPASS_DRIVER_H_
#define MPUCOMPASS_DRIVER_H_

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx_i2c.h"
#include "stm32l1xx_pwr.h"
#include "I2C_driver.h"
#include "stm32l1xx.h"
#include "utils.h"
#include <stdio.h>

#define MPU_FILTERGYRO  1 // Define to filter Acc/Gyro values on the MPU

/* Exported types ------------------------------------------------------------*/

// If we filter the Gyro, internal Fs of the MPU changes, hence those values
// REF: MPU Register Mapping Document, pp. 11-12-13
#ifndef MPU_FILTERGYRO
  typedef enum
  {
    MPUCOMPASS_50Hz = 159,//655,//1312,
    MPUCOMPASS_100Hz = 79,//328,
    MPUCOMPASS_200Hz = 39,//164
    MPUCOMPASS_500Hz = 15,
    MPUCOMPASS_1000Hz = 7
  } MPUCompassSamplingFreq_TypeDef;
#else
  typedef enum
  {
    MPUCOMPASS_50Hz = 19,
    MPUCOMPASS_100Hz = 9,
    MPUCOMPASS_200Hz = 4,
    MPUCOMPASS_500Hz = 1,
    MPUCOMPASS_1000Hz = 0
  } MPUCompassSamplingFreq_TypeDef;
#endif

typedef struct
{
  uint8_t I2CAddress;
  uint8_t RegisterAddress;
  uint8_t RegisterValue;
} I2C_WriteStruct_Typedef;

typedef struct
{
  uint8_t I2CAddress;
  uint8_t RegisterAddress;
  uint8_t * RegisterValue;
  uint8_t BurstLength;
} I2C_ReadStruct_Typedef;

typedef enum
{
  MPUCOMPASS_I2C_IDLE,
  MPUCOMPASS_I2C_READING,
  MPUCOMPASS_I2C_WRITING
} MPUCompass_I2CState_Typedef;

typedef enum
{
  MPUCOMPASS_I2CWR_START,
  MPUCOMPASS_I2CWR_ICADDR_1,
  MPUCOMPASS_I2CWR_ICADDR_2,
  MPUCOMPASS_I2CWR_REGADDR,
  MPUCOMPASS_I2CWR_REGVAL
} MPUCompass_I2CWrState_Typedef;

typedef enum
{
  MPUCOMPASS_I2CRD_START,
  MPUCOMPASS_I2CRD_ICADDR_1,
  MPUCOMPASS_I2CRD_ICADDR_2,
  MPUCOMPASS_I2CRD_REGADDR,
  MPUCOMPASS_I2CRD_RESTART,
  MPUCOMPASS_I2CRD_DATA
} MPUCompass_I2CRdState_Typedef;


/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/

/* Use this define to set the maximum delay timeout for the I2C read or write.
 Exeeding this timeout delay, the read/write functions will be aborted. The period
 of the delay will depend on the system operating frequency. The following value
 has been set for system running at 32 MHz. */
#define I2C_REG_ACCESS_TIMEOUT 2000


// LSE startup timeout delay (ms)
#define LSE_STARTUP_TIMEOUT 100


// STM32 Peripheral ID MACRO
#define I2C_MPUCOMPASS_PERIPHERAL_ID I2C1
#define I2C_EXTERNAL_PERIPHERAL_ID I2C2

// I2C address MACRO
#define I2C_MPU_ADDR 0xD0
#define I2C_COMPASS_WR_ADDR 0x3C
#define I2C_COMPASS_RD_ADDR 0x3D
#define I2C_EXTERNAL_ADDR 0x00

// MPU register MACRO
#define MPU_REG__SELF_TEST_X	0x0D
#define MPU_REG__SELF_TEST_Y	0x0E
#define MPU_REG__SELF_TEST_Z	0x0F
#define MPU_REG__SELF_TEST_A	0x10
#define MPU_REG__SMPLRT_DIV	0x19
#define MPU_REG__CONFIG         0x1A
#define MPU_REG__GYRO_CONFIG	0x1B
#define MPU_REG__ACCEL_CONFIG	0x1C
#define MPU_REG__MOT_THR	0x1F
#define MPU_REG__FIFO_EN	0x23
#define MPU_REG__I2C_MST_CTRL	0x24
#define MPU_REG__I2C_SLV0_ADDR	0x25
#define MPU_REG__I2C_SLV0_REG	0x26
#define MPU_REG__I2C_SLV0_CTRL	0x27
#define MPU_REG__I2C_SLV1_ADDR	0x28
#define MPU_REG__I2C_SLV1_REG	0x29
#define MPU_REG__I2C_SLV1_CTRL	0x2A
#define MPU_REG__I2C_SLV2_ADDR	0x2B
#define MPU_REG__I2C_SLV2_REG	0x2C
#define MPU_REG__I2C_SLV2_CTRL	0x2D
#define MPU_REG__I2C_SLV3_ADDR	0x2E
#define MPU_REG__I2C_SLV3_REG	0x2F
#define MPU_REG__I2C_SLV3_CTRL	0x30
#define MPU_REG__I2C_SLV4_ADDR	0x31
#define MPU_REG__I2C_SLV4_REG	0x32
#define MPU_REG__I2C_SLV4_DO	0x33
#define MPU_REG__I2C_SLV4_CTRL	0x34
#define MPU_REG__I2C_SLV4_DI	0x35
#define MPU_REG__I2C_MST_STATUS	0x36
#define MPU_REG__INT_PIN_CFG	0x37
#define MPU_REG__INT_ENABLE	0x38
#define MPU_REG__INT_STATUS	0x3A
#define MPU_REG__ACCEL_XOUT_H	0x3B
#define MPU_REG__ACCEL_XOUT_L	0x3C
#define MPU_REG__ACCEL_YOUT_H	0x3D
#define MPU_REG__ACCEL_YOUT_L	0x3E
#define MPU_REG__ACCEL_ZOUT_H	0x3F
#define MPU_REG__ACCEL_ZOUT_L	0x40
#define MPU_REG__TEMP_OUT_H	0x41
#define MPU_REG__TEMP_OUT_L	0x42
#define MPU_REG__GYRO_XOUT_H	0x43
#define MPU_REG__GYRO_XOUT_L	0x44
#define MPU_REG__GYRO_YOUT_H	0x45
#define MPU_REG__GYRO_YOUT_L	0x46
#define MPU_REG__GYRO_ZOUT_H	0x47
#define MPU_REG__GYRO_ZOUT_L	0x48
#define MPU_REG__EXT_SENS_DATA_00	0x49
#define MPU_REG__EXT_SENS_DATA_01	0x4A
#define MPU_REG__EXT_SENS_DATA_02	0x4B
#define MPU_REG__EXT_SENS_DATA_03	0x4C
#define MPU_REG__EXT_SENS_DATA_04	0x4D
#define MPU_REG__EXT_SENS_DATA_05	0x4E
#define MPU_REG__EXT_SENS_DATA_06	0x4F
#define MPU_REG__EXT_SENS_DATA_07	0x50
#define MPU_REG__EXT_SENS_DATA_08	0x51
#define MPU_REG__EXT_SENS_DATA_09	0x52
#define MPU_REG__EXT_SENS_DATA_10	0x53
#define MPU_REG__EXT_SENS_DATA_11	0x54
#define MPU_REG__EXT_SENS_DATA_12	0x55
#define MPU_REG__EXT_SENS_DATA_13	0x56
#define MPU_REG__EXT_SENS_DATA_14	0x57
#define MPU_REG__EXT_SENS_DATA_15	0x58
#define MPU_REG__EXT_SENS_DATA_16	0x59
#define MPU_REG__EXT_SENS_DATA_17	0x5A
#define MPU_REG__EXT_SENS_DATA_18	0x5B
#define MPU_REG__EXT_SENS_DATA_19	0x5C
#define MPU_REG__EXT_SENS_DATA_20	0x5D
#define MPU_REG__EXT_SENS_DATA_21	0x5E
#define MPU_REG__EXT_SENS_DATA_22	0x5F
#define MPU_REG__EXT_SENS_DATA_23	0x60
#define MPU_REG__I2C_SLV0_DO	0x63
#define MPU_REG__I2C_SLV1_DO	0x64
#define MPU_REG__I2C_SLV2_DO 	0x65
#define MPU_REG__I2C_SLV3_DO 	0x66
#define MPU_REG__I2C_MST_DELAY_CTRL 	0x67
#define MPU_REG__SIGNAL_PATH_RESET 	0x68
#define MPU_REG__MOT_DETECT_CTRL 	0x69
#define MPU_REG__USER_CTRL 	0x6A
#define MPU_REG__PWR_MGMT_1 	0x6B
#define MPU_REG__PWR_MGMT_2 	0x6C
#define MPU_REG__FIFO_COUNTH 	0x72
#define MPU_REG__FIFO_COUNTL 	0x73
#define MPU_REG__FIFO_R_W 	0x74
#define MPU_REG__WHO_AM_I 	0x75

// MPU register bit mask MACRO
#define MPU_REG__USER_CTRL__I2C_MST_EN__MASK 0x20

#define MPU_REG__INT_PIN_CFG__I2C_BYPASS_EN__MASK 0x02
#define MPU_REG__INT_PIN_CFG__INT_RD_CLEAR__MASK 0x10

#define MPU_REG__PWR_MGMT_1__SLEEP__MASK 0x40
#define MPU_REG__PWR_MGMT_1__TEMP_DIS__MASK 0x08
#define MPU_REG__PWR_MGMT_1__CLKSEL__MASK 0x07
#define MPU_REG__PWR_MGMT_1__CLKSEL__SHIFT 0

#define MPU_REG__GYRO_CONFIG__FS_SEL__SHIFT 3
#define MPU_REG__GYRO_CONFIG__FS_SEL__MASK 0x18

#define MPU_REG__ACCEL_CONFIG__AFS_SEL__SHIFT 3
#define MPU_REG__ACCEL_CONFIG__AFS_SEL__MASK 0x18

#define MPU_REG__INT_ENABLE__DATA_RDY_EN__MASK 0x01

// GYRO filtering values
#define MPU_DLPF_256HZ  0
#define MPU_DLPF_188HZ  1
#define MPU_DLPF_98HZ   2
#define MPU_DLPF_42HZ   3
#define MPU_DLPF_20HZ   4
#define MPU_DLPF_10HZ   5
#define MPU_DLPF_5HZ    6

// Compass register MACRO
#define COMPASS_REG__CONF_A 0x00
#define COMPASS_REG__CONF_B 0x01
#define COMPASS_REG__MODE 0x02
#define COMPASS_REG__DATA_X_MSB 0x03
#define COMPASS_REG__DATA_X_LSB 0x04
#define COMPASS_REG__DATA_Z_MSB 0x05
#define COMPASS_REG__DATA_Z_LSB 0x06
#define COMPASS_REG__DATA_Y_MSB 0x07
#define COMPASS_REG__DATA_Y_LSB 0x08
#define COMPASS_REG__STATUS 0x09
#define COMPASS_REG__ID_A 0x0A
#define COMPASS_REG__ID_B 0x0B
#define COMPASS_REG__ID_C 0x0C

//Configuration Register A
#define COMPASS_SAMPLE_AVG_1    0x0
#define COMPASS_SAMPLE_AVG_2    0x1
#define COMPASS_SAMPLE_AVG_4    0x2
#define COMPASS_SAMPLE_AVG_8    0x3

#define COMPASS_DATA_OUT_0_75   0x0
#define COMPASS_DATA_OUT_1_5    0x1
#define COMPASS_DATA_OUT_3      0x2
#define COMPASS_DATA_OUT_7_5    0x3
#define COMPASS_DATA_OUT_15     0x4
#define COMPASS_DATA_OUT_30     0x5
#define COMPASS_DATA_OUT_75     0x6

#define COMPASS_MEASURE_NORMAL  0x0
#define COMPASS_MEASURE_POSBIAS 0x1
#define COMPASS_MEASURE_NEGBIAS 0x2

// Configuration Register B
#define COMPASS_GAIN_0_88       0x0
#define COMPASS_GAIN_1_3        0x1
#define COMPASS_GAIN_1_9        0x2
#define COMPASS_GAIN_2_5        0x3
#define COMPASS_GAIN_4_0        0x4
#define COMPASS_GAIN_4_7        0x5
#define COMPASS_GAIN_5_6        0x6
#define COMPASS_GAIN_8_1        0x7

// Mode Register
#define COMPASS_MODE_CONTINUOUS 0x0
#define COMPASS_MODE_SINGLE     0x1
#define COMPASS_MODE_IDLE       0x2

// Configuration Values
#define COMPASS_SAMPLE_AVG  COMPASS_SAMPLE_AVG_8
#define COMPASS_DATA_OUT    COMPASS_DATA_OUT_75
#define COMPASS_MEASURE     COMPASS_MEASURE_NORMAL

//#define COMPASS_GAIN        COMPASS_GAIN_8_1

#define COMPASS_MODE        COMPASS_MODE_CONTINUOUS

/*#define COMPASS_REG__CONG_A__MUST_CLR__SHIFT 7
#define COMPASS_REG__CONG_A__MUST_CLR__MASK 0x80

#define COMPASS_REG__CONG_A__SAMPLE_FOR_AVG__SHIFT 5
#define COMPASS_REG__CONG_A__SAMPLE_FOR_AVG__MASK 0x60

#define COMPASS_REG__CONG_A__OUTPUT_RATE__SHIFT 2
#define COMPASS_REG__CONG_A__OUTPUT_RATE__MASK 0x1C

#define COMPASS_REG__CONG_A__MEAS_CONF__SHIFT 0
#define COMPASS_REG__CONG_A__MEAS_CONF__MASK 0x00


#define COMPASS_REG__CONG_B__GAIN__SHIFT 5
#define COMPASS_REG__CONG_B__GAIN__MASK 0xE0

#define COMPASS_REG__CONG_B__MUST_CLR__SHIFT 0
#define COMPASS_REG__CONG_B__MUST_CLR__MASK 0x1F


#define COMPASS_REG__MODE__MUST_CLR__SHIFT 2
#define COMPASS_REG__MODE__MUST_CLR__MASK 0xFC

#define COMPASS_REG__MODE__OPERATE_MODE__SHIFT 0
#define COMPASS_REG__MODE__OPERATE_MODE__MASK 0x03*/

#define COMPASS_REG__MODE__STATUS__RDY__MASK 0x01


extern uint8_t MPU_SamplingFrequency;
extern uint8_t MPUCompass_SamplingFrequency;

extern volatile uint8_t MPU_BufRdPtr;
extern uint8_t MPU_BufWrPtr;
extern volatile uint8_t Compass_BufRdPtr;
extern uint8_t Compass_BufWrPtr;
extern uint8_t MPU_SampleNumber;
extern uint8_t Compass_SampleNumber;
//extern uint8_t MPU_DMA[16];

extern volatile bool MPU_BufferReady[2];
extern volatile bool Compass_BufferReady[2];
//extern volatile uint8_t Gyro_BufferReady[2];

extern volatile bool MPU_NewValue;
//extern volatile bool GyroNewValue;
extern volatile bool Mag_NewValue;


/* Exported functions ------------------------------------------------------- */
Error_TypeDef MPUCompass_MPUInit(void);
Error_TypeDef MPUCompass_MPUStart(void);

uint8_t MPUCompass_ConfigIO(void);
void MPUCompass_SetupPower(void);
uint8_t MPUCompass_EnablePower(void);
void MPUCompass_DisablePower(void);
uint8_t MPUCompass_MPUWakeup(void);
uint8_t MPUCompass_MPUSleep(void);
uint8_t MPUCompass_MPUSetFreq(MPUCompassSamplingFreq_TypeDef SamplingFreq);

void MPUCompass_MPUStop(void);
uint8_t MPUCompass_MPUIDValidation(void);
uint8_t MPUCompass_MPUConfigReg(uint8_t acc_range, uint8_t gyro_range);
//uint8_t MPUCompass_ReadMPUData(int16_t * AccelXYZData, int16_t * GyroXYZData);
uint8_t MPUCompass_StartReadMPUData();
uint8_t MPUCompass_CompassIDValidation(void);
uint8_t MPUCompass_CompassConfigReg(uint8_t mag_range);
uint8_t MPUCompass_CompassSetFreq(MPUCompassSamplingFreq_TypeDef SamplingFreq);
uint8_t MPUCompass_CompassInitiateSingleMeasure(void);
//uint8_t MPUCompass_ReadMegnetoData(int16_t * MagnetoXYZData);
uint8_t MPUCompass_StartReadMagnetoData();
void MPUCompass_CompassInitTimer(void);
void MPUCompass_CompassStart(void);
void MPUCompass_CompassStop(void);
uint8_t MPUCompass_CompassSync(void);
void MPUCompass_EnableInterrupt(bool enable);



#endif /*MPUCOMPASS_DRIVER_H_*/
