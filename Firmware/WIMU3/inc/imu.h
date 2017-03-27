#ifndef _IMU_H_
#define _IMU_H_

#include "config.h"
#include "Merged__hw_config.h" 

// this is for arm_math
#define ARM_MATH_CM3
//------------------------
// Structure Define
//------------------------

//This struct allow the calculation of madgwick quaternion and allow the calibration, this struct is built once when calling madgwickInit function
typedef struct{
  float beta;
  int sampleFrequency;
  bool onlyImu;
  bool automaticGyroOffsets;
  
  int frameNum;

  // Gains and offsets are already defined globally in the WIMU_SETTINGS struct
  /*float accOffsets[3];
  float gyroOffsets[3];
  float magOffsets[3];

  int16_t accGains[3];
  int16_t gyroGains[3];
  int16_t magGains[3];*/

  // Calibrated values
  float acc_data[3]; 
  float gyro_data[3];
  float mag_data[3];

  float quaternion[4];
}Madgwick_Struct;


//This struct is for recording all the Imu data: acc, gyro, magneto and quaternion. the frame num allow the labeling of the frames
typedef struct{
  uint16_t frame_num;
  int16_t acc_data[3];
  int16_t gyro_data[3];
  int16_t mag_data[3];
  float quaternion[4];
}IMUFrame_Struct;

typedef struct{
  int16_t acc_min[3];
  int16_t acc_max[3];
  int16_t gyro_min[3];
  int16_t gyro_max[3];
  int16_t mag_min[3];
  int16_t mag_max[3];
  BOOL in_progress;
}IMUCalib_Struct;

extern IMUFrame_Struct IMUFrame;
extern uint8_t IMUFrame_Status;
extern uint8_t IMUFrame_ReadyMask;

extern IMUCalib_Struct IMUCalib;
extern Madgwick_Struct madgwick_Struct;

void IMUInit();

/*

To start using Madgwick algorithm and library calibration tool, setup a struct with MadgwickInit function
This will return a Madgwick struct with algo parameters, offsets and gains, and last calculated quaternion
This struct is to be passed to all the functions

beta is madgwick algo gain: with 10 000, we have good results
sample frequency of sensors data pulling
onlyIMU has to be true if no magnetometer
automaticGyroOffset will calculate automatic offset for gyro. the first 100 iterations will create a sum tp calculate the average value defining the offset. 
  If automaticGyroOffset is set to true, the  parameters gyroOffsets[3] will be erased
next parameters are easy to understand 
In our test we used the gains to apply axis changements for aligning the axes of the sensors
*/
Madgwick_Struct MadgwickInit(float beta,int sampleFrequency,bool onlyImu,bool automaticGyroOffset/*,float accOffsets[3],float gyroOffsets[3],float magOffsets[3],int16_t accGains[3],int16_t gyroGains[3],int16_t magGains[3]*/);



/*
This function allow calibration of ahrs data.
This will apply offsets and gains set in madgwick struct
*/
void calibrateIMUFrame(Madgwick_Struct * madStruct, IMUFrame_Struct * input);


/*
Calculation of the quaternion. The quaternion calculated is set in the twice struct Madgwick_Struct and IMUFrame_Struct
*/
void MadgwickProcess(Madgwick_Struct * madStruct);

//private function to calculate inverse square root of float
float invSqrt(float x);

void IMUCalibStructInit(IMUCalib_Struct* calib);
void IMUProcessRawCalibration(IMUCalib_Struct* calib, IMUFrame_Struct* last_reading);
void IMUStartCalibProcess();

float ConvertAccToG(int16_t value);
float ConvertMagToGauss(int16_t value);


#endif /*_IMU_H_*/
