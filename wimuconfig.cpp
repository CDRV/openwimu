#include "wimuconfig.h"

#include <QFile>

WIMUConfig::WIMUConfig(QObject *parent) : QObject(parent)
{
    setDefaults();
}

void WIMUConfig::setDefaults(){
    enabled_modules = 0;
    crc = 0;

    // Enabled Modules
    for (int i=0; i<MODULE_INTERNAL_NUM; i++){
        if (i== MODULE_GPS || i == MODULE_BLE){
            enableModule((Modules_ID)i,false);
        }else{
            enableModule((Modules_ID)i,true);
        }
    }

    // Set default values
    // Date & Time
    datetime.enable_auto_offset = false;
    datetime.enable_gps_time = false;
    datetime.time_offset = -5;

    // User Interface
    ui.ble_activity_led = false;
    ui.enable_marking = true;
    ui.gps_fix_led = true;
    ui.led_blink_time = 30;
    ui.write_led = false;

    // Power Saving
    power.power_manage = true;
    power.adv_power_manage = false;
    power.enable_motion_detection = false;

    // Options
    general.enable_watchdog = true;
    general.sampling_rate = 50;

    // Accelero
    acc.range = 2;

    // Gyro
    gyro.range = 0;

    // Magneto
    magneto.range = 4;

    // GPS
    gps.force_cold = false;
    gps.interval = 1;
    gps.enable_scan_when_charged = true;

    // Logger
    logger.split_by_day = true;
    logger.max_files_in_folder = 24;

    // BLE
    ble.enable_control = true;

    // IMU
    imu.auto_calib_gyro = true;
    imu.beta = 0.5;
    imu.disable_magneto = false;
}

void WIMUConfig::enableModule(Modules_ID module, bool enable){
    if (enable){
        enabled_modules |= (1 << module);
    }else{
        enabled_modules &= ~(1 << module);
    }
}

bool WIMUConfig::isModuleEnabled(Modules_ID module){
    return (enabled_modules & (1 << module))>0;
}

bool WIMUConfig::saveToFile(QString filename){
    QFile out_file;

    out_file.setFileName(filename);
    if (!out_file.open(QFile::WriteOnly)){
        return false; // Can't open file for writing!
    }

    QByteArray data = serialize();

    if (out_file.write(data) != data.count())
        return false;

    out_file.close();
    return true;

}

bool WIMUConfig::loadFromFile(QString filename){
    QFile in_file;
    in_file.setFileName(filename);

    if (!in_file.open(QFile::ReadOnly)){
        return false;
    }

    QByteArray data = in_file.readAll();
    in_file.close();

    unserialize(&data);

    return true;

}

quint16 WIMUConfig::size(){
    quint16 size=0;

    size += sizeof(enabled_modules);
    size += sizeof(datetime);
    size += sizeof(ui);
    size += sizeof(general);
    size += sizeof(logger);
    size += sizeof(gps);
    size += sizeof(power);
    size += sizeof(ble);
    size += sizeof(acc);
    size += sizeof(gyro);
    size += sizeof(magneto);
    size += sizeof(imu);
    size += sizeof(crc);

    return size;
}

QByteArray WIMUConfig::serialize(){
    QByteArray bytes;
    QDataStream ds(&bytes, QIODevice::WriteOnly);
    ds.setByteOrder(QDataStream::LittleEndian);

    ds << enabled_modules;
    ds << datetime.time_offset;
    ds << datetime.enable_gps_time;
    ds << datetime.enable_auto_offset;
    ds << ui.led_blink_time;
    ds << ui.write_led;
    ds << ui.enable_marking;
    ds << ui.gps_fix_led;
    ds << ui.ble_activity_led;
    ds << general.sampling_rate;
    ds << general.enable_watchdog;
    ds << logger.max_files_in_folder;
    ds << logger.split_by_day;
    ds << gps.interval;
    ds << gps.force_cold;
    ds << gps.enable_scan_when_charged;
    ds << power.power_manage;
    ds << power.adv_power_manage;
    ds << power.enable_motion_detection;
    ds << ble.enable_control;
    ds << acc.range;
    ds << gyro.range;
    ds << magneto.range;
    ds << imu.beta;
    ds << imu.disable_magneto;
    ds << imu.auto_calib_gyro;
    //ds << crc;
    ds << 0xffffffff; // For now...

    return bytes;
}

void WIMUConfig::unserialize(QByteArray* data){
    QDataStream ds(*data);
    ds.setByteOrder(QDataStream::LittleEndian);

    ds >> enabled_modules;
    ds >> datetime.time_offset;
    ds >> datetime.enable_gps_time;
    ds >> datetime.enable_auto_offset;
    ds >> ui.led_blink_time;
    ds >> ui.write_led;
    ds >> ui.enable_marking;
    ds >> ui.gps_fix_led;
    ds >> ui.ble_activity_led;
    ds >> general.sampling_rate;
    ds >> general.enable_watchdog;
    ds >> logger.max_files_in_folder;
    ds >> logger.split_by_day;
    ds >> gps.interval;
    ds >> gps.force_cold;
    ds >> gps.enable_scan_when_charged;
    ds >> power.power_manage;
    ds >> power.adv_power_manage;
    ds >> power.enable_motion_detection;
    ds >> ble.enable_control;
    ds >> acc.range;
    ds >> gyro.range;
    ds >> magneto.range;
    /*quint8 beta[4];
    //ds >> imu.beta;
    ds >> beta[0];
    ds >> beta[1];
    ds >> beta[2];
    ds >> beta[3];
    imu.beta = *((float*)&beta[0]);*/
    ds >> imu.beta;

    ds >> imu.disable_magneto;
    ds >> imu.auto_calib_gyro;
    ds >> crc;
}

WIMUConfig& WIMUConfig::operator = (const WIMUConfig& original){
    this->acc = original.acc;
    this->ble = original.ble;
    this->datetime = original.datetime;
    this->general = original.general;
    this->gps = original.gps;
    this->gyro = original.gyro;
    this->imu = original.imu;
    this->logger = original.logger;
    this->magneto = original.magneto;
    this->power = original.power;
    this->ui = original.ui;
    this->crc = original.crc;
    this->enabled_modules = original.enabled_modules;

    return *this;
}
