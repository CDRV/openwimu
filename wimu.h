#ifndef WIMU_H
#define WIMU_H

#include <QDateTime>

namespace WIMU{
    typedef enum{
      MODULE_CPU=0,
      MODULE_BLE=1,
      MODULE_GPS=2,
      MODULE_GYRO=3,
      MODULE_MAGNETO=4,
      MODULE_ACC=5,
      MODULE_DATALOGGER=6,
      MODULE_USB=7,
      MODULE_POWER=8,
      MODULE_IMU=9,
      MODULE_INTERNAL_NUM //Total number of internal modules
    } Modules_ID;

    // IMU
    typedef struct{
      quint16  frame_num;
      qint16   acc_data[3];
      qint16   gyro_data[3];
      qint16   mag_data[3];
      float    quaternion[4];
      bool     acc_valid;
      bool     gyro_valid;
      bool     mag_valid;
      bool     quat_valid;
    } IMUFrame_Struct;

    typedef struct {
      quint16   enabled_modules;
      quint8    sampling_rate;
      quint8    acc_range;
      quint8    gyro_range;
      quint8    mag_range;
    } IMUConfig_Struct;


    // GPS
    typedef enum{
        GPSNAV_NOFIX= 0,
        GPSNAV_1SV  = 1,
        GPSNAV_2SV  = 2,
        GPSNAV_3SV  = 3,
        GPSNAV_4SV  = 4,
        GPSNAV_2DLS = 5,
        GPSNAV_3DLS = 6,
        GPSNAV_DR   = 7
    } GPSNavType;


    typedef struct{
        bool                nav_valid;
        GPSNavType          nav_type;
        bool                trickle_power;
        bool                dop_limits;
        bool                dgps_corrected;
        bool                overdetermined;
        bool                invalid_speed;
        QDateTime           nav_datetime;
        quint32             nav_sat_ids;
        float               latitude;
        float               longitude;
        float               altitude;
        float               speed;
        float               orientation; // Degrees clock wise from true north
        float               climb_rate;
        float               horizontal_precision;
        float               vertical_precision;
        float               time_error;
        quint8              satellite_numbers;
        float               hdop;
    } GPSNavData_Struct;

    typedef struct{
        quint8                      nb_channels;
        QList<quint8>               sat_ids;
        QList< QVector <quint8> >   signal_ratios;
        QList<quint16>              sat_states;
    } GPSTrackerData_Struct;

    // POWER
    typedef enum{
        POWER_STATE_ON,
        POWER_STATE_LOWBAT,
        POWER_STATE_USB,
        POWER_STATE_USB_MASS,
        POWER_STATE_USB_COM,
        POWER_STATE_OFF
    }  PowerStates;

    typedef struct{
        quint16          raw_battery;
        quint16          raw_temp;
        PowerStates     status;
        bool            charging;
        float           temp;
        float           battery;
        quint8          battery_pc;
    } PowerFrame_Struct;

}

#endif // WIMU_H
