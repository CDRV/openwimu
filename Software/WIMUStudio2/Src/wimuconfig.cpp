#include "wimuconfig.h"

#include <QFile>

WIMUConfig::WIMUConfig(WIMUSettings &settings, QObject *parent) :
    QObject(parent)
{
    qRegisterMetaType<WIMUConfig>("WIMUConfig");
    setDefaults();
    m_settings = settings;
}

WIMUConfig::WIMUConfig(QObject *parent) :
    QObject(parent)
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

    // Settings
    m_settings.setDefaults();
}

void WIMUConfig::enableModule(WIMU::Modules_ID module, bool enable){
    if (enable){
        enabled_modules |= (1 << (module-1));
    }else{
        enabled_modules &= ~(1 << (module-1));
    }
}

bool WIMUConfig::isModuleEnabled(WIMU::Modules_ID module){
    return (enabled_modules & (1 << (module-1)))>0;
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

bool WIMUConfig::loadFromFile(QString filename, WIMUSettings* currentSettings){
    QFile in_file;
    in_file.setFileName(filename);

    if (!in_file.open(QFile::ReadOnly)){
        return false;
    }

    QByteArray data = in_file.readAll();
    in_file.close();

    if (currentSettings)
        m_settings = *currentSettings;

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
    quint16 size=0;

    // sizeof doesn't seem to work with VC compiler... so ugly stuff here!

    //size += sizeof(enabled_modules);
    size += sizeof(quint16);
    //size += sizeof(datetime);
    size += sizeof(quint8) + sizeof(bool)*2;
    //size += sizeof(ui);
    size += sizeof(quint8) + sizeof(bool)*4;
    //size += sizeof(general);
    if (m_settings.version_major==3 && m_settings.version_minor<=3 && m_settings.version_rev<=3){
        // Sampling rate on those versions was on 8 bits
        size += sizeof(quint8) + sizeof(bool);
        size += 2; // Align data
    }else{
        size += sizeof(quint16) + sizeof(bool);//+3;
    }

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

    if (m_settings.hw_id==2)
        rval = (((float)value / 4095.f) *2 * range_val) - range_val;

    if (m_settings.hw_id==3)
        rval = ((float)value / 32767.f) * range_val;



    return rval;
}

float WIMUConfig::convertGyro2degs(qint16 &value){
    float rval;

    quint16 range_val = getGyroRangeValue();

    if (m_settings.hw_id==2)
        rval = (((float)value / 4095.f) *2 * range_val) - range_val;

    if (m_settings.hw_id==3)
        rval = ((float)value / 32767.f) * range_val;

    return rval;
}

float WIMUConfig::convertMag2gauss(qint16 &value){
    float rval;

    float range_val = getMagRangeValue();

    if (m_settings.hw_id==2)
        rval = (((float)value / 4095.f) *2 * range_val) - range_val;

    if (m_settings.hw_id==3)
        rval = ((float)value / 2048.f) * range_val;

    return rval;
}

float WIMUConfig::convertBatt2volt(quint16 &value){
    float rval=0.f;

    if (m_settings.hw_id==2)
        rval = ((float)value / 4095.f) * 2 * 2.5;

    // On hwId=3, conversion is done on board.

    return rval;
}

float WIMUConfig::convertTemp2deg(qint16 &value){
    Q_UNUSED(value)
    float rval=0.f;

    if (m_settings.hw_id==2){
       // TODO, if useful...
    }


    // On hwId=3, conversion is done on board.

    return rval;
}

quint8 WIMUConfig::getAccRangeValue(){
    quint8 rval=0;

    if (m_settings.hw_id==3)
        rval = (quint8)1 << (acc.range+1);

    if (m_settings.hw_id==2){
        if (acc.range==0)
            rval = 1; // Real value should be 1.5
        else{
            rval = acc.range*2;
        }
    }

    return rval;
}

quint16 WIMUConfig::getGyroRangeValue(){
    quint16 rval;

    if (m_settings.hw_id==3)
        rval = (((quint8)1 << (gyro.range))) * 250;

    if (m_settings.hw_id==2)
        rval = 500;
    return rval;
}

float WIMUConfig::getMagRangeValue(){
    float rval = 0.f;

    if (m_settings.hw_id==3){
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
    }

    if (m_settings.hw_id==2){
        switch (magneto.range){
        case 0:
            rval = 0.7f;
            break;
        case 1:
            rval = 1.0f;
            break;
        case 2:
            rval = 1.5f;
            break;
        case 3:
            rval = 2.0f;
            break;
        case 4:
            rval = 3.2f;
            break;
        case 5:
            rval = 3.8f;
            break;
        case 6:
            rval = 4.5f;
            break;
        case 7:
            rval = 6.5f;
            break;
        default:
            break;
        }
    }

    return rval;
}

quint8 WIMUConfig::getHwId(){
    return m_settings.hw_id;
}

QByteArray WIMUConfig::serialize(){
    QByteArray bytes;
    QDataStream ds(&bytes, QIODevice::WriteOnly);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    ds << enabled_modules;
    ds << (qint8)datetime.time_offset;
    ds << datetime.enable_gps_time;
    ds << datetime.enable_auto_offset;
    ds << ui.led_blink_time;
    ds << ui.write_led;
    ds << ui.enable_marking;
    ds << ui.gps_fix_led;
    ds << ui.ble_activity_led;
    if (m_settings.version_major==3 && m_settings.version_minor<=3 && m_settings.version_rev<=3){
        // Sampling rate was on 8 bits...
        quint8 buf8 = general.sampling_rate;
        ds << buf8;
    }else{
        ds << general.sampling_rate;
    }

    ds << general.enable_watchdog;
    ds << logger.max_files_in_folder;
    ds << logger.split_by_day;
    ds << gps.interval;
    ds << gps.force_cold;
    ds << gps.enable_scan_when_charged;
    ds << power.power_manage;
    ds << power.enable_motion_detection;
    ds << power.adv_power_manage;
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
    quint8 buf8;

    if (m_settings.hw_id==2){
        quint16 buf16;
        ds >> enabled_modules;
        ds >> buf16;

        // CPU options
        ds >> buf8;
        general.enable_watchdog = (buf8 & 0x01)>0;
        if ( (buf8 & 0x02)>0)
            general.sampling_rate = 100;
        else
            general.sampling_rate = 50;
        ui.led_blink_time = ((buf8 & 0x7c) >> 2);

        // Log filetime
        ds >> buf8;

        // Log reset time
        ds >> buf8;

        // Logger options
        ds >> buf8;
        ui.write_led = (buf8 & 0x01)>0;
        ui.enable_marking = (buf8 & 0x02)>0;
        logger.split_by_day = (buf8 & 0x04)>0;
        qint16 offset = ((buf8 & 0x77) >> 3);
        //datetime.time_offset = (qint8)((buf8 & 0xF7) >> 3);//(((buf8 & 0xF8)) >> 3);
        if ((buf8 & 0x80)>0){
            // Negative time offset
            datetime.time_offset = -offset;
        }else{
            datetime.time_offset = offset;
        }

        // GPS dead time
        ds >> buf8;

        // GPS Degrad time
        ds >> buf8;

        // GPS Deadrec time
        ds >> buf8;

        // GPS options
        ds >> buf8;
        gps.force_cold = (buf8 & 0x08)>0;

        // Power options
        ds >> buf8;

        // Zigbee options
        ds >> buf8;

        // Acc range
        ds >> acc.range;

        // Gyro range
        ds >> buf8;

        // Mag range
        ds >> magneto.range;

        // Ignore the rest for now...!
    }

    if (m_settings.hw_id==3){
        ds >> enabled_modules;
        //ds >> datetime.time_offset;
        ds >> buf8;
        datetime.time_offset = (qint16) buf8;
        ds >> datetime.enable_gps_time;
        ds >> datetime.enable_auto_offset;
        ds >> ui.led_blink_time;
        ds >> ui.write_led;
        ds >> ui.enable_marking;
        ds >> ui.gps_fix_led;
        ds >> ui.ble_activity_led;
        if (m_settings.version_major==3 && m_settings.version_minor<=3 && m_settings.version_rev<=3){
            // Sampling rate was on 8 bits...
            ds >> buf8;
            general.sampling_rate = buf8;
        }else{
            ds >> general.sampling_rate;
        }
        ds >> general.enable_watchdog;
        ds >> logger.max_files_in_folder;
        ds >> logger.split_by_day;
        ds >> gps.interval;
        ds >> gps.force_cold;
        ds >> gps.enable_scan_when_charged;
        ds >> power.power_manage;
        ds >> power.enable_motion_detection;
        ds >> power.adv_power_manage;
        ds >> ble.enable_control;
        ds >> acc.range;
        ds >> gyro.range;
        ds >> magneto.range;
        ds >> imu.beta;

        ds >> imu.disable_magneto;
        ds >> imu.auto_calib_gyro;
        ds >> crc;
    }
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

    this->m_settings = original.m_settings;

    return *this;
}
