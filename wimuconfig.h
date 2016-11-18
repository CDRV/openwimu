#ifndef WIMUCONFIG_H
#define WIMUCONFIG_H

#include <QObject>
#include <QDataStream>

#include "wimu.h"

class WIMUConfig : public QObject
{
    Q_OBJECT

private:
    typedef struct {
      qint8     time_offset;
      bool      enable_gps_time;
      bool      enable_auto_offset;
    } WIMUConfig_DateTimeOptions;

    typedef struct {
      quint8   led_blink_time;
      bool      write_led;
      bool      enable_marking;
      bool      gps_fix_led;
      bool      ble_activity_led;
    } WIMUConfig_UIOptions;

    typedef struct {
      quint8   sampling_rate;
      bool      enable_watchdog;
    } WIMUConfig_GlobalOptions;

    typedef struct {
      quint8   max_files_in_folder;
      bool      split_by_day;
    } WIMUConfig_LoggerOptions;

    typedef struct {
      quint8 interval;
      bool    force_cold;
      bool    enable_scan_when_charged;
    } WIMUConfig_GPSOptions;

    typedef struct {
      bool      power_manage;
      bool      enable_motion_detection;
      bool      adv_power_manage;
    } WIMUConfig_PowerOptions;

    typedef struct {
      bool      enable_control;
    } WIMUConfig_BLEOptions;

    typedef struct {
      quint8   range;
    } WIMUConfig_AccOptions;

    typedef struct {
      quint8   range;
    } WIMUConfig_GyroOptions;

    typedef struct {
      quint8   range;
    } WIMUConfig_MagOptions;

    typedef struct {
      float     beta;
      bool      disable_magneto;
      bool      auto_calib_gyro;
    } WIMUConfig_IMUOptions;

    quint16     enabled_modules;   // Enabled modules

    qint32 crc;

public:
    explicit WIMUConfig(quint8 hw_id, QObject *parent = 0);
    explicit WIMUConfig(QObject *parent = 0);
    WIMUConfig(const WIMUConfig &copy, QObject *parent=0);


    void enableModule(WIMU::Modules_ID module, bool enable);
    bool isModuleEnabled(WIMU::Modules_ID module);
    void setDefaults();

    bool saveToFile(QString filename);
    bool loadFromFile(QString filename);

    void loadFromIMUConfig(WIMU::IMUConfig_Struct &config);

    QByteArray serialize();
    void unserialize(QByteArray *data);

    float convertAcc2g(qint16 &value);
    float convertGyro2degs(qint16 &value);
    float convertMag2gauss(qint16 &value);

    quint8 getAccRangeValue();
    quint16 getGyroRangeValue();
    float getMagRangeValue();

    static quint16 size();

    WIMUConfig  &operator = (const WIMUConfig&);

    // Parameters
    WIMUConfig_DateTimeOptions  datetime;          // Date & Time options
    WIMUConfig_UIOptions        ui;                // User Interface options
    WIMUConfig_GlobalOptions    general;           // Global options
    WIMUConfig_LoggerOptions    logger;            // Datalogger options
    WIMUConfig_GPSOptions       gps;               // GPS options
    WIMUConfig_PowerOptions     power;             // Power options
    WIMUConfig_BLEOptions       ble;               // BLE options
    WIMUConfig_AccOptions       acc;               // Accelero options
    WIMUConfig_GyroOptions      gyro;              // Gyro options
    WIMUConfig_MagOptions       magneto;           // Magneto options
    WIMUConfig_IMUOptions       imu;               // IMU options

    quint8  m_hwId;

signals:

public slots:
};

#endif // WIMUCONFIG_H
