#include "wimuconfig.h"

#include <QFile>

WIMUConfig::WIMUConfig(QObject *parent) : QObject(parent)
{
    qRegisterMetaType<WIMUConfig>("WIMUConfig");

    setDefaults();
}

WIMUConfig::WIMUConfig(const WIMUConfig &copy, QObject *parent) :
       QObject(parent)
{
    *this = copy;
}

void WIMUConfig::setDefaults(){
    enabled_modules = 0;
    crc = 0;

    // Enabled Modules
    for (int i=0; i<WIMU::MODULE_INTERNAL_NUM; i++){
        if (i== WIMU::MODULE_GPS || i == WIMU::MODULE_BLE){
            enableModule((WIMU::Modules_ID)i,false);
        }else{
            enableModule((WIMU::Modules_ID)i,true);
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

void WIMUConfig::enableModule(WIMU::Modules_ID module, bool enable){
    if (enable){
        enabled_modules |= (1 << module);
    }else{
        enabled_modules &= ~(1 << module);
    }
}

bool WIMUConfig::isModuleEnabled(WIMU::Modules_ID module){
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

void WIMUConfig::loadFromIMUConfig(WIMU::IMUConfig_Struct &config){
    enabled_modules = config.enabled_modules;
    general.sampling_rate = config.sampling_rate;
    acc.range = config.acc_range;
    gyro.range = config.gyro_range;
    magneto.range = config.mag_range;
}

quint16 WIMUConfig::size(){
    quint16 size=2;

    // sizeof doesn't seem to work with VC compiler... so ugly stuff here!

    //size += sizeof(enabled_modules);
    size += sizeof(quint16);
    //size += sizeof(datetime);
    size += sizeof(quint8) + sizeof(bool)*2;
    //size += sizeof(ui);
    size += sizeof(quint8) + sizeof(bool)*4;
    //size += sizeof(general);
    size += sizeof(quint8) + sizeof(bool);
    //size += sizeof(logger);
    size += sizeof(quint8) + sizeof(bool);
    //size += sizeof(gps);
    size += sizeof(quint8) + sizeof(bool)*2;
    //size += sizeof(power);
    size += sizeof(bool)*3;
    //size += sizeof(ble);
    size += sizeof(bool);
    //size += sizeof(acc);
    size += sizeof(quint8);
    //size += sizeof(gyro);
    size += sizeof(quint8);
    //size += sizeof(magneto);
    size += sizeof(quint8);
    //size += sizeof(imu);
    size += sizeof(float) + sizeof(bool)*2;
    //size += sizeof(crc);
    size+= sizeof(qint32);

    return size;
}

float WIMUConfig::convertAcc2g(qint16 &value){
    float rval;
    quint8 range_val = getAccRangeValue();

    // TODO: Adjust according to resolution on a different wimu version, if needed
    rval = ((float)value / 32767.f) * range_val;

    return rval;
}

float WIMUConfig::convertGyro2degs(qint16 &value){
    float rval;

    quint16 range_val = getGyroRangeValue();

    // TODO: Adjust according to resolution on a different wimu version, if needed
    rval = ((float)value / 32767.f) * range_val;

    return rval;
}

float WIMUConfig::convertMag2gauss(qint16 &value){
    float rval;

    float range_val = getMagRangeValue();

    // TODO: Adjust according to resolution on a different wimu version, if needed
    rval = ((float)value / 2048.f) * range_val;

    return rval;
}

quint8 WIMUConfig::getAccRangeValue(){
    quint8 rval = (quint8)1 << (acc.range+1);
    return rval;
}

quint16 WIMUConfig::getGyroRangeValue(){
    quint16 rval = (((quint8)1 << (gyro.range))) * 250;
    return rval;
}

float WIMUConfig::getMagRangeValue(){
    float rval = 0.f;

    switch (magneto.range){
    case 0:
        rval = 0.88f;
        break;
    case 1:
        rval = 1.3f;
        break;
    case 2:
        rval = 1.9f;
        break;
    case 3:
        rval = 2.5f;
        break;
    case 4:
        rval = 4.0f;
        break;
    case 5:
        rval = 4.7f;
        break;
    case 6:
        rval = 5.6f;
        break;
    case 7:
        rval = 8.1f;
        break;
    default:
        break;
    }

    return rval;
}

QByteArray WIMUConfig::serialize(){
    QByteArray bytes;
    QDataStream ds(&bytes, QIODevice::WriteOnly);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

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
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

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
