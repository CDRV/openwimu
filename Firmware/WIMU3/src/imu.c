#include <stdio.h>

#include "imu.h"
#include "utils.h" 
#include "config.h"
#include "usb.h"
#include "flash.h"

#include "arm_math.h"

IMUFrame_Struct IMUFrame;
uint8_t IMUFrame_Status  = 0;

uint8_t IMUFrame_ReadyMask  = 0;
IMUCalib_Struct IMUCalib;

extern WIMU_SETTINGS wimu_settings; // For gains and offset values
extern WIMU_CONFIG  wimu_config;    // For accelero, gyro and magneto ranges
  
float gyroSum[3], gyroOffsets[3];

uint8_t acc_range;
float mag_range;
uint16_t gyro_range;

Madgwick_Struct madgwick_Struct;

void IMUInit(){
  uint8_t value;
  
  // Accelerometer range
  value = wimu_config.acc.range;  // Raw config register value
  acc_range = 1 << (value+1);                           // Accelerometer sensibility

  // Gyrometer range
  value = wimu_config.gyro.range; // Raw config register value
  gyro_range = (1 << value) * 250;                      // Gyrometer sensibility

  // Magnetometer range
  value = wimu_config.magneto.range; // Raw config register value
  switch(value){
    case 0:
      mag_range = 0.88;
    break;
    case 1:
      mag_range = 1.3;
    break;
    case 2:
      mag_range = 1.9;
    break;
    case 3:
      mag_range = 2.5;
    break;
    case 4:
      mag_range = 4.0;
    break;
    case 5:
      mag_range = 4.7;
    break;
    case 6:
      mag_range = 5.6;
    break;
    case 7:
      mag_range = 8.1;
    break;
    default:
      mag_range = 0;
    break;
  }

}

Madgwick_Struct MadgwickInit(float beta,int sampleFrequency,bool onlyImu,bool automaticGyroOffsets/*,float accOffsets[3],float gyroOffsets[3],float magOffsets[3],int16_t accGains[3],int16_t gyroGains[3],int16_t magGains[3]*/){
   
    Madgwick_Struct m;
    m.beta = beta;
    m.sampleFrequency = sampleFrequency;
    m.onlyImu = onlyImu;
    m.automaticGyroOffsets=automaticGyroOffsets;
    m.frameNum = 0;

    /*memcpy(m.accOffsets,accOffsets,3*4);
    memcpy(m.gyroOffsets,accOffsets,3*4);
    memcpy(m.magOffsets,accOffsets,3*4);
    memcpy(m.accGains,accGains,3*2);
    memcpy(m.gyroGains,gyroGains,3*2);
    memcpy(m.magGains,magGains,3*2);*/

    return m;
    
}


void MadgwickProcess(Madgwick_Struct* madStruct){
 
  float beta = madStruct->beta;
  int sampleFreq = madStruct->sampleFrequency;
  float q0 = madStruct->quaternion[0];
  float q1 = madStruct->quaternion[1];
  float q2 = madStruct->quaternion[2];
  float q3 = madStruct->quaternion[3];

  // initialize quaternion data if first iteration
  if( q0==0){
    q0 = 1;
    q1 = 0;
    q2 = 0;
    q3 = 0;
  }

  float gx = -(madStruct->gyro_data[0])/1000;
  float gy = -(madStruct->gyro_data[1])/1000;
  float gz = (madStruct->gyro_data[2])/1000;
  float ax = -(madStruct->acc_data[0])/1000;
  float ay = -(madStruct->acc_data[1])/1000;
  float az = (madStruct->acc_data[2])/1000;
  float mx = (madStruct->mag_data[0])/1000;
  float my = (madStruct->mag_data[1])/1000;
  float mz = (madStruct->mag_data[2])/1000;
  

  float recipNorm;
  float s0, s1, s2, s3;
  float qDot1, qDot2, qDot3, qDot4;
  float hx, hy;
  float _2q0mx, _2q0my, _2q0mz, _2q1mx, _2bx, _2bz, _4bx, _4bz, _8bx, _8bz, _2q0, _2q1, _2q2, _2q3,/* _2q0q2, _2q2q3,*/ q0q0, q0q1, q0q2, q0q3, q1q1, q1q2, q1q3, q2q2, q2q3, q3q3;

  // Rate of change of quaternion from gyroscope
  qDot1 = 0.5 * (-q1 * gx - q2 * gy - q3 * gz);
  qDot2 = 0.5 * (q0 * gx + q2 * gz - q3 * gy);
  qDot3 = 0.5 * (q0 * gy - q1 * gz + q3 * gx);
  qDot4 = 0.5 * (q0 * gz + q1 * gy - q2 * gx);

// Compute feedback only if accelerometer measurement valid (avoids NaN in accelerometer normalisation)
  if(!((ax == 0) && (ay == 0) && (az == 0))) {
  
    // Normalize accelerometer measurement
    recipNorm = invSqrt(ax * ax + ay * ay + az * az);
    ax *= recipNorm;
    ay *= recipNorm;
    az *= recipNorm;   

   // Normalise magnetometer measurement
    recipNorm = invSqrt(mx * mx + my * my + mz * mz);
    mx *= recipNorm;
    my *= recipNorm;
    mz *= recipNorm;

    // Auxiliary variables to avoid repeated arithmetic
    _2q0mx = 2 * q0 * mx;
    _2q0my = 2 * q0 * my;
    _2q0mz = 2 * q0 * mz;
    _2q1mx = 2 * q1 * mx;
    _2q0 = 2 * q0;
    _2q1 = 2 * q1;
    _2q2 = 2 * q2;
    _2q3 = 2 * q3;
    //_2q0q2 = 2 * q0 * q2;
    //_2q2q3 = 2 * q2 * q3;
    q0q0 = q0 * q0;
    q0q1 = q0 * q1;
    q0q2 = q0 * q2;
    q0q3 = q0 * q3;
    q1q1 = q1 * q1;
    q1q2 = q1 * q2;
    q1q3 = q1 * q3;
    q2q2 = q2 * q2;
    q2q3 = q2 * q3;
    q3q3 = q3 * q3;
	
    // Reference direction of Earth's magnetic field
    hx = mx * q0q0 - _2q0my * q3 + _2q0mz * q2 + mx * q1q1 + _2q1 * my * q2 + _2q1 * mz * q3 - mx * q2q2 - mx * q3q3;
    hy = _2q0mx * q3 + my * q0q0 - _2q0mz * q1 + _2q1mx * q2 - my * q1q1 + my * q2q2 + _2q2 * mz * q3 - my * q3q3;

    arm_sqrt_f32(hx * hx + hy * hy,&_2bx);

    _2bz = -_2q0mx * q2 + _2q0my * q1 + mz * q0q0 + _2q1mx * q3 - mz * q1q1 + _2q2 * my * q3 - mz * q2q2 + mz * q3q3;
    _4bx = 2 * _2bx;
    _4bz = 2 * _2bz;
    _8bx = 2 * _4bx;
    _8bz = 2 * _4bz;

    // Gradient decent algorithm corrective step
    //s0 = -_2q2 * (2 * q1q3 - _2q0q2 - ax) + _2q1 * (2 * q0q1 + _2q2q3 - ay) - _2bz * q2 * (_2bx * (1/2 - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (-_2bx * q3 + _2bz * q1) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + _2bx * q2 * (_2bx * (q0q2 + q1q3) + _2bz * (1/2 - q1q1 - q2q2) - mz);
    //s1 = _2q3 * (2 * q1q3 - _2q0q2 - ax) + _2q0 * (2 * q0q1 + _2q2q3 - ay) - 4 * q1 * (1 - 2 * q1q1 - 2 * q2q2 - az) + _2bz * q3 * (_2bx * (0.5 - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (_2bx * q2 + _2bz * q0) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + (_2bx * q3 - _4bz * q1) * (_2bx * (q0q2 + q1q3) + _2bz * (1/2 - q1q1 - q2q2) - mz);
    //s2 = -_2q0 * (2 * q1q3 - _2q0q2 - ax) + _2q3 * (2 * q0q1 + _2q2q3 - ay) - 4 * q2 * (1 - 2 * q1q1 - 2 * q2q2 - az) + (-_4bx * q2 - _2bz * q0) * (_2bx * (1/2 - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (_2bx * q1 + _2bz * q3) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + (_2bx * q0 - _4bz * q2) * (_2bx * (q0q2 + q1q3) + _2bz * (1/2 - q1q1 - q2q2) - mz);
    //s3 = _2q1 * (2 * q1q3 - _2q0q2 - ax) + _2q2 * (2 * q0q1 + _2q2q3 - ay) + (-_4bx * q3 + _2bz * q1) * (_2bx * (1/2 - q2q2 - q3q3) + _2bz * (q1q3 - q0q2) - mx) + (-_2bx * q0 + _2bz * q2) * (_2bx * (q1q2 - q0q3) + _2bz * (q0q1 + q2q3) - my) + _2bx * q1 * (_2bx * (q0q2 + q1q3) + _2bz * (1/2 - q1q1 - q2q2) - mz);
    
    // Il semble y avoir une erreur pour la stabilité lorsque pointé vers le bas: http://stackoverflow.com/questions/25902186/madgwick-sensor-fusion-on-lsm9ds0
    s0= -_2q2*(2*(q1q3 - q0q2) - ax)    +   _2q1*(2*(q0q1 + q2q3) - ay)   +  -_4bz*q2*(_4bx*(0.5 - q2q2 - q3q3) + _4bz*(q1q3 - q0q2) - mx)   +   (-_4bx*q3+_4bz*q1)*(_4bx*(q1q2 - q0q3) + _4bz*(q0q1 + q2q3) - my)    +   _4bx*q2*(_4bx*(q0q2 + q1q3) + _4bz*(0.5 - q1q1 - q2q2) - mz);
    s1= _2q3*(2*(q1q3 - q0q2) - ax) +   _2q0*(2*(q0q1 + q2q3) - ay) +   -4*q1*(2*(0.5 - q1q1 - q2q2) - az)    +   _4bz*q3*(_4bx*(0.5 - q2q2 - q3q3) + _4bz*(q1q3 - q0q2) - mx)   + (_4bx*q2+_4bz*q0)*(_4bx*(q1q2 - q0q3) + _4bz*(q0q1 + q2q3) - my)   +   (_4bx*q3-_8bz*q1)*(_4bx*(q0q2 + q1q3) + _4bz*(0.5 - q1q1 - q2q2) - mz);             
    s2= -_2q0*(2*(q1q3 - q0q2) - ax)    +     _2q3*(2*(q0q1 + q2q3) - ay)   +   (-4*q2)*(2*(0.5 - q1q1 - q2q2) - az) +   (-_8bx*q2-_4bz*q0)*(_4bx*(0.5 - q2q2 - q3q3) + _4bz*(q1q3 - q0q2) - mx)+(_4bx*q1+_4bz*q3)*(_4bx*(q1q2 - q0q3) + _4bz*(q0q1 + q2q3) - my)+(_4bx*q0-_8bz*q2)*(_4bx*(q0q2 + q1q3) + _4bz*(0.5 - q1q1 - q2q2) - mz);
    s3= _2q1*(2*(q1q3 - q0q2) - ax) +   _2q2*(2*(q0q1 + q2q3) - ay)+(-_8bx*q3+_4bz*q1)*(_4bx*(0.5 - q2q2 - q3q3) + _4bz*(q1q3 - q0q2) - mx)+(-_4bx*q0+_4bz*q2)*(_4bx*(q1q2 - q0q3) + _4bz*(q0q1 + q2q3) - my)+(_4bx*q1)*(_4bx*(q0q2 + q1q3) + _4bz*(0.5 - q1q1 - q2q2) - mz);

    recipNorm = invSqrt(s0 * s0 + s1 * s1 + s2 * s2 + s3 * s3); // normalise step magnitude
    s0 *= recipNorm;
    s1 *= recipNorm;
    s2 *= recipNorm;
    s3 *= recipNorm;

    // Apply feedback step
    qDot1 -= beta * s0;
    qDot2 -= beta * s1;
    qDot3 -= beta * s2;
    qDot4 -= beta * s3;
  
  }//endif accelerometer data is good

  
  // floategrate rate of change of quaternion to yield quaternion
  q0 += qDot1 * (1.0f / sampleFreq);
  q1 += qDot2 * (1.0f / sampleFreq);
  q2 += qDot3 * (1.0f / sampleFreq);
  q3 += qDot4 * (1.0f / sampleFreq);

  // Normalise quaternion
  recipNorm = invSqrt(q0 * q0 + q1 * q1 + q2 * q2 + q3 * q3);
  q0 *= recipNorm;
  q1 *= recipNorm;
  q2 *= recipNorm;
  q3 *= recipNorm;

  madStruct->quaternion[0] = q0;
  madStruct->quaternion[1] = q1;
  madStruct->quaternion[2] = q2;
  madStruct->quaternion[3] = q3;

 /*madStruct->quaternion[0] = gx;
  madStruct->quaternion[1] = gy;
  madStruct->quaternion[2] = gz;
  madStruct->quaternion[3] = q3;*/

  
  return;

}

void calibrateIMUFrame(Madgwick_Struct * madStruct, IMUFrame_Struct * input){

   uint8_t i;
   
   for (i=0; i<3; i++){
      madStruct->acc_data[i] =  (input->acc_data[i] - wimu_settings.acc_offset[i]) / ((float)wimu_settings.acc_gain[i]); 
      madStruct->gyro_data[i] = (input->gyro_data[i] - wimu_settings.gyro_offset[i]) / ((float)wimu_settings.gyro_gain[i]);
      madStruct->mag_data[i] =  (input->mag_data[i] - wimu_settings.mag_offset[i]) / ((float)wimu_settings.mag_gain[i]);
   } 
   madStruct->frameNum ++;
}

// Originally Madgwick use fast inverse square-root but this algo is only usable for floats.
// instead arm_math is used
float invSqrt(float x){
  
    float pOut;

    int result = arm_sqrt_f32(x,&pOut);
  
    if(result!=ARM_MATH_SUCCESS||pOut==0.0)
	return 0;
    
    return 1 / pOut;
}

void IMUCalibStructInit(IMUCalib_Struct* calib){
  // Set initial values
  uint8_t i;
  for (i=0; i<3; i++){
    calib->acc_min[i] = 32767;
    calib->mag_min[i] = 32767;
    calib->gyro_min[i] = 32767;
    
    calib->acc_max[i] = -32767;
    calib->gyro_max[i] = -32767;
    calib->mag_max[i] = -32767;
  }
  calib->in_progress = TRUE;
}

void IMUProcessRawCalibration(IMUCalib_Struct* calib, IMUFrame_Struct* last_reading){
  // TODO: REVISE AS INITIAL CALIBRATION PROCEDURE WASN'T ADEQUATE
  // NOTE: last_reading isn't and shouldn't be calibrated here
  uint8_t i;
  //int32_t value;
  char buf[64];

  // Compute gains and offset values from raw min and max values

  // Accelerometer
   if (isModuleOnline(MODULE_ACC)){
    //value=-32767;
    for (i=0; i<3; i++){
      wimu_settings.acc_offset[i] = (calib->acc_min[i] + calib->acc_max[i]) / 2;
      sprintf(buf, "ACC # %d: MIN=%d, MAX=%d, OFFSET=%d\n\r", i,calib->acc_min[i], calib->acc_max[i],  wimu_settings.acc_offset[i]);
      USB_SendString(buf,strlen(buf));

      // Calibrate last reading with those offset
     // last_reading->acc_data[i] = last_reading->acc_data[i] - wimu_settings.acc_offset[i];

      // Get max acceleration
      //if (calib->acc_max[i]>value) value = calib->acc_max[i];
    }
    /*sprintf(buf, "REF=%d\n\r", value);
    usb_send_string(buf,strlen(buf));*/
    
    // Compute gains
    for (i=0; i<3; i++){
      // Based on "1g" value
      wimu_settings.acc_gain[i]  = (ConvertAccToG(calib->acc_max[i] - wimu_settings.acc_offset[i])) * 1000; 
      //wimu_settings.acc_gain[i] = ((float)calib->acc_max[i] / (float) value) * 1000;
      sprintf(buf, "ACC # %d: GAIN=%d\n\r", i,wimu_settings.acc_gain[i]);
      USB_SendString(buf,strlen(buf));
    }
    
  }

  ///////////////
  // Magnetometer
  if (isModuleOnline(MODULE_MAGNETO)){
    //value=-32767;
    for (i=0; i<3; i++){
      wimu_settings.mag_offset[i] = (calib->mag_min[i] + calib->mag_max[i]) / 2;
      sprintf(buf, "MAG # %d: MIN=%d, MAX=%d, OFFSET=%d\n\r", i,calib->mag_min[i], calib->mag_max[i],  wimu_settings.mag_offset[i]);
      USB_SendString(buf,strlen(buf));

      // Calibrate last reading with those offset
     // last_reading->mag_data[i] = last_reading->mag_data[i] - wimu_settings.mag_offset[i];

      // Compute max magnetic field
      //if (calib->mag_max[i]>value) value = calib->mag_max[i];
    }
    //sprintf(buf, "REF=%d\n\r", value);
    //usb_send_string(buf,strlen(buf));
    
    // Compute gains
    for (i=0; i<3; i++){

       // Earth Magnetic Field Calculator: http://geomag.bgs.ac.uk/data_service/models_compass/wmm_calc.html
       // Sherbrooke, 2016: 0.53653 Ga

       //TODO: Use value in config
       wimu_settings.mag_gain[i]  = (ConvertMagToGauss(calib->mag_max[i] - wimu_settings.mag_offset[i]) / 0.53653) * 1000;
      //wimu_settings.mag_gain[i] = ((float)calib->mag_max[i] / (float) value) * 1000;
      
      sprintf(buf, "MAG # %d: GAIN=%d\n\r", i,wimu_settings.mag_gain[i]);
      USB_SendString(buf,strlen(buf));
    }
    
  }

  // Save values in EEPROM
  wimu_settings.crc = crc_calc((unsigned char*)&wimu_settings, (sizeof(WIMU_SETTINGS)-4));
  flash_write_settings(&wimu_settings);

}

void IMUStartCalibProcess(){
      //Calib_Counter=30;
      USB_SendString("Sensors Calibration Started...\n\r",32);

      // Init calibration frame
      IMUCalibStructInit(&IMUCalib);
}

float ConvertAccToG(int16_t value){
  float acc_g = (float)value + 32767; // Remove negative offset
  acc_g = ((acc_g / 65536) * 2 * acc_range) - acc_range;
  return acc_g;
}

float ConvertMagToGauss(int16_t value){
  float gauss = (float)value + 2048; // Remove negative offset
  gauss = ((gauss / 4096) * 2 * mag_range) - mag_range;
  return gauss;
}