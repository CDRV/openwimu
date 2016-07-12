#ifndef WIMUCONFIG_H
#define WIMUCONFIG_H

#include <QObject>
#include <QDataStream>

class WIMUConfig : public QObject
{
    Q_OBJECT

private:
    typedef struct {
      int8_t    time_offset;
      bool      enable_gps_time;
      bool      enable_auto_offset;
    } WIMUConfig_DateTimeOptions;

    typedef struct {
      uint8_t   led_blink_time;
      bool      write_led;
      bool      enable_marking;
      bool      gps_fix_led;
      bool      ble_activity_led;
    } WIMUConfig_UIOptions;

    typedef struct {
      uint8_t   sampling_rate;
      bool      enable_watchdog;
    } WIMUConfig_GlobalOptions;

    typedef struct {
      uint8_t   max_files_in_folder;
      bool      split_by_day;
    } WIMUConfig_LoggerOptions;

    typedef struct {
      uint8_t interval;
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
      uint8_t   range;
    } WIMUConfig_AccOptions;

    typedef struct {
      uint8_t   range;
    } WIMUConfig_GyroOptions;

    typedef struct {
      uint8_t   range;
    } WIMUConfig_MagOptions;

    typedef struct {
      float     beta;
      bool      disable_magneto;
      bool      auto_calib_gyro;
    } WIMUConfig_IMUOptions;

    uint16_t                    enabled_modules;   // Enabled modules

    int32_t crc;

public:
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

    explicit WIMUConfig(QObject *parent = 0);

    void enableModule(Modules_ID module, bool enable);
    bool isModuleEnabled(Modules_ID module);
    void setDefaults();

    bool saveToFile(QString filename);
    bool loadFromFile(QString filename);

    QByteArray serialize();
    void unserialize(QByteArray *data);

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

signals:

public slots:
};

#endif // WIMUCONFIG_H
