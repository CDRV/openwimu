#include "wimubinarystream.h"

#include <QDataStream>
#include <QDebug>

WIMUBinaryStream::WIMUBinaryStream(QObject *parent) : QObject(parent)
{
    m_idModule = WIMU::MODULE_CPU;
    m_data.clear();
    m_fromFile = false;
}

WIMUBinaryStream::WIMUBinaryStream(const WIMUBinaryStream &copy, QObject *parent) :
       QObject(parent)
{
    *this = copy;
}


quint16 WIMUBinaryStream::fromBinaryStream(QByteArray &stream){
    if (stream.count()<2)
        return 0;

     m_fromFile = false;

    // Find the sync bytes
    for (int i=0; i<stream.count()-1; i++){
        if ((quint8)stream.at(i)==SYNC_BYTE && (quint8)stream.at(i+1)==SYNC_BYTE){
            // Synched! Remove anything before that
            stream.remove(0,i);
            break;
        }
    }

    // Now ready to unpack everything
    if (stream.count()<5)
        return 0;

    // Module ID
    m_idModule = (WIMU::Modules_ID)stream.at(2);

    // Data length
    quint8 datalen = stream.at(3);

    // Copy data
    if (stream.count()<datalen+4)
        return 0; // Not enough data yet
    m_data = stream.mid(4,datalen);

    return datalen + 4;
}

quint16 WIMUBinaryStream::fromBinaryFile(QByteArray &stream, WIMU::Modules_ID module){
    m_idModule = module;

    m_data = stream;

    // TODO: Specific things for modules??

    m_fromFile = true;

    return stream.length();
}

WIMU::IMUFrame_Struct WIMUBinaryStream::convertToIMUFrame(){
    WIMU::IMUFrame_Struct frame;
    frame.frame_num=0;

    if (m_idModule!=WIMU::MODULE_IMU)
        return frame;

    QDataStream ds(m_data);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    if (!m_fromFile){
        ds >> frame.frame_num;
        for (int i=0; i<3; i++)
            ds >> frame.acc_data[i];
        for (int i=0; i<3; i++)
            ds >> frame.gyro_data[i];
        for (int i=0; i<3; i++)
            ds >> frame.mag_data[i];
    }
    for (int i=0; i<4; i++)
        ds >> frame.quaternion[i];

    frame.acc_valid = true;
    frame.gyro_valid = true;
    frame.mag_valid = true;
    frame.quat_valid = true;

    return frame;
}

QList<WIMU::IMUFrame_Struct> WIMUBinaryStream::convertToIMUFrames(WIMUConfig* config){

    QList<WIMU::IMUFrame_Struct> rval;

    if (m_fromFile){
        // Create all samples
        rval.reserve(config->general.sampling_rate);
        for (int i=0; i<config->general.sampling_rate; i++){
            WIMU::IMUFrame_Struct imu;
            imu.acc_valid=false;
            imu.gyro_valid=false;
            imu.mag_valid=false;
            imu.quat_valid = true;
            rval.append(imu);

        }

        QDataStream reader(m_data);
        reader.setByteOrder(QDataStream::LittleEndian);
        reader.setFloatingPointPrecision(QDataStream::SinglePrecision);
        float fvalue;
        for (int i=0; i<4; i++){ // 4 channels
            for (int j=0; j<config->general.sampling_rate; j++){ // All samples
                reader >> fvalue;
                rval[j].quaternion[i] = fvalue;
            }
        }

    }else{
        qDebug() << "convertToIMUFrames: Not a file - unexpected results expected!";
    }

    return rval;

}

WIMU::PowerFrame_Struct WIMUBinaryStream::convertToPowerFrame(WIMUConfig *config){
    WIMU::PowerFrame_Struct power;
    quint16 status;
    power.battery = 0;
    WIMUConfig* current_config = config;

    if (m_idModule!=WIMU::MODULE_POWER)
        return power;

    if (!config){
        current_config = new WIMUConfig();
        current_config->setDefaults();
    }

    QDataStream ds(m_data);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    ds >> power.raw_temp;
    ds >> power.raw_battery;
    ds >> status;

    // WIMU2
    if (current_config->getHwId()==2){
        power.status = WIMU::POWER_STATE_UNKNOWN; // No power state in this version
        power.charging = false;

        // Compute battery voltage
       /* power.battery = current_config->convertBatt2volt(power.raw_battery);
        power.battery_pc = qMin((quint8)100, (quint8)((power.battery-3.3) / (3.7f-3.3f) * 100));*/
        power.battery = 0;
        power.battery_pc = 0;

        // Temperature is unused on this version...
        power.temp = -100;

    }
    // WIMU3
    if (current_config->getHwId()==3){
        power.status = ((WIMU::PowerStates)(status & 0x7F));
        power.charging = (status & 0x80) > 0;

        // Compute battery voltage
        power.battery = (float)power.raw_battery / 100.f; //(3.3f / 1024) * (float)power.raw_battery / 2;
        power.battery_pc = qMin((quint8)100, (quint8)((power.battery-3.3) / (3.7f-3.3f) * 100));

        // Compute temperature value
        power.temp = (float) power.raw_temp / 100.f; //((3.3f / 1024) * (float)power.raw_temp/2);
        //power.temp = power.temp / 1.61f - 273.15; // 1.61 = AVG Slope from data sheet
    }
    if (!config)
        delete current_config;
    return power;
}

WIMULog WIMUBinaryStream::convertToWIMULog(quint8 hw_id){

    WIMULog log;

    if (m_idModule != WIMU::MODULE_CPU)
        return log;

    if (m_data.count()<4)
        return log;

    // First 4 bytes = timestamp
    log.timestamp = (((quint32)m_data.at(3)) << 24) & 0xff000000;
    log.timestamp |= (((quint32)m_data.at(2)) << 16) & 0x00ff0000;
    log.timestamp |= (((quint32)m_data.at(1)) << 8) & 0x0000ff00;
    log.timestamp |= ((quint32)m_data.at(0)) & 0x000000ff;

    //qDebug() << "Log.timestamp " << log.timestamp;

    // Convert rest of data to string
    QString data(m_data.right(m_data.length()-4));

    if (hw_id<=2){
        // WIMU v2 or less don't have "text" timestamp
        log.log = data;
    }else{
        // WIMU v3 or more have "text" timestamp and comma separated values
        QStringList logs = data.split(",");
        if (logs.count() > 0){
            log.log = logs.last();
        }else{
            log.log = "???";
        }
    }

    // Identify the type of log depending on the log content (no other way right now...)
    log.log_type = WIMULog::WIMULOG_UNKNOWN;

    if (log.log.contains("started",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_START;

    if (log.log.contains("synced",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_TIMESYNC;

    if (log.log.contains("Charging Mode On",Qt::CaseInsensitive) || log.log.contains("USB Connected",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_CHARGEON;

    if (log.log.contains("Charging Mode Off",Qt::CaseInsensitive) || log.log.contains("USB Disconnected",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_CHARGEOFF;

    if (log.log.contains("Datalogger: Too many errors",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_LOGERROR;

    if (log.log.contains("Datalogger: Folder Change",Qt::CaseInsensitive) || log.log.contains("Datalogger: Reset",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_LOGCHANGE;

    if (log.log.contains("Datalogger: Reset",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_LOGRESET;

    if (log.log.contains("WIMUGPS ON",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_ON;

    if (log.log.contains("WIMUGPS OFF",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_OFF;

    if (log.log.contains("Low-Batt",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_LOWBAT;

    if (log.log.contains("Recovered",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_RECOVERED;

    if (log.log.contains("Mass Storage",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_USBMASS;

    if (log.log.contains("Virtual COM",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_USBVCOM;

    if (log.log.contains("Mark",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_MARK;

    if (log.log.contains("Corrected StartTime",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_CORRECTON;

    if (log.log.contains("Corrected EndTime",Qt::CaseInsensitive))
        log.log_type = WIMULog::WIMULOG_CORRECTOFF;

    return log;

}

WIMU::Modules_ID WIMUBinaryStream::getModuleID(){
    return m_idModule;
}

quint8 WIMUBinaryStream::getGPSMessageID(){
    int rval = -1;

    if (m_idModule != WIMU::MODULE_GPS){
        return rval;
    }

    // Get GPS data payload
    QByteArray payload = getGPSMessagePayload();

    if (!payload.isEmpty()){
        return (quint8)payload.at(0);
    }
    return rval;
}

QByteArray WIMUBinaryStream::getGPSMessagePayload(){
    if (m_idModule != WIMU::MODULE_GPS){
        return QByteArray();
    }

    QByteArray rval;

    // Find sync bytes
    qint16 start_pos=-1, end_pos=-1;
    for (int i=0; i<m_data.count()-1; i++){
        if ((quint8)m_data.at(i)==0xA0 && (quint8)m_data.at(i+1)==0xA2 && start_pos==-1){
            // Found start sequence
            start_pos = i+2; // Ignore sync bytes
        }
        if ((quint8)m_data.at(i)==0xB0 && (quint8)m_data.at(i+1)==0xB3  && end_pos==-1){
            // Found end sequence
            end_pos = i-2; // Remove checksum... for now!
        }
    }

    if (start_pos==-1 || end_pos==-1){
        // Incomplete frame...
        return rval;
    }

    // Get length

    quint16 len = (((quint16)m_data.at(start_pos))<<8) + (quint8)m_data.at(start_pos+1);
    // Check if length is ok with received length

    if (len <= ((quint16)end_pos-(quint16)start_pos)){
        rval = m_data.mid(start_pos+2,len);
    }else{
        return rval;
    }

    return rval;

}

WIMU::GPSNavData_Struct WIMUBinaryStream::convertToGPSNavData(){
    WIMU::GPSNavData_Struct nav;

    if (m_idModule != WIMU::MODULE_GPS){
        return nav;
    }

    // Get GPS data payload
    QByteArray payload = getGPSMessagePayload();

    if (payload.isEmpty())
        return nav;

    if (payload.at(0)!=41 || payload.count() != 91)
        return nav;

    // Ready!
    QDataStream ds(payload);
    //ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    quint8  num8;
    quint16 num16;
    quint32 num32;

    qint32  snum32;

    quint16 year;
    quint8  month;
    quint8  day;
    quint8  hour;
    quint8  minutes;
    quint16 seconds;

    ds >> num8; // Module ID

    ds >> num16; // Valid nav
    //nav.nav_valid = (num16<=1);

    ds >> num16; // Nav type
    nav.nav_type = (WIMU::GPSNavType)(num16 & 0x0007);
    nav.trickle_power = (num16 & 0x0008) > 0;
    nav.dop_limits = (num16 & 0x0020) > 0;
    nav.dgps_corrected = (num16 & 0x0040) > 0;
    nav.overdetermined = (num16 & 0x0100) > 0;
    nav.invalid_speed = (num16 & 0x1000) > 0;

    ds >> num16; // Week number
    ds >> num32; // Time of week in seconds
    ds >> year;
    ds >> month;
    ds >> day;
    ds >> hour;
    ds >> minutes;
    ds >> num16;
    seconds = num16 / 1000;
    nav.nav_datetime = QDateTime(QDate(year,month,day),QTime(hour,minutes,seconds),Qt::UTC);

    ds >> nav.nav_sat_ids; // Bit map of satellites in view used

    ds >> snum32; // Latitude
    nav.latitude = (float)snum32 / 1e7;

    ds >> snum32; // Longitude
    nav.longitude = (float)snum32 / 1e7;

    ds >> snum32; // Altitude from Ellipsoid

    ds >> snum32; // Altitude from MSL
    nav.altitude = (float)snum32 / 100;

    ds >> num8; // Map datum
    ds >> num16; // Speed
    nav.speed = (float)num16 / 100;

    ds >> num16; // Course
    nav.orientation = (float)num16 / 100;

    ds >> num16; // Magnetic variation
    ds >> num16; // Climb rate
    nav.climb_rate = (float)num16 / 100;

    ds >> num16; // Heading rate
    ds >> num32; // Horizontal error
    nav.horizontal_precision = (float)num32 / 100;
    ds >> num32; // Vertical error
    nav.vertical_precision = (float)num32 / 100;
    ds >> num32; // Time error
    nav.time_error = (float)num32 / 100;

    ds >> num32; // Speed error
    ds >> num32; // Clock bias
    ds >> num32; // Clock bias error
    ds >> num32; // Clock Drift
    ds >> num32; // Clock Drift error
    ds >> num32; // Distance
    ds >> num16; // Distance error
    ds >> num16; // Heading error
    ds >> nav.satellite_numbers;

    ds >> num8; // HDOP
    nav.hdop = (float)num8 / 5;

    nav.nav_valid = nav.nav_type != WIMU::GPSNAV_NOFIX;

    return nav;
}

WIMU::GPSTrackerData_Struct WIMUBinaryStream::convertToGPSTrackerData(){
    WIMU::GPSTrackerData_Struct track;

    if (m_idModule != WIMU::MODULE_GPS){
        return track;
    }

    // Get GPS data payload
    QByteArray payload = getGPSMessagePayload();

    if (payload.isEmpty())
        return track;

    if (payload.at(0)!=4)
        return track;

    // Ready!
    QDataStream ds(payload);
    //ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    quint8  num8;
    quint16 num16;
    quint32 num32;

    //qint32  snum32;

    ds >> num8;     // Module ID
    ds >> num16;    // GPS Week
    ds >> num32;    // GPS TOW
    ds >> track.nb_channels;

    for (int i=0; i<track.nb_channels; i++){
        ds >> num8; // Satellite ID
        track.sat_ids.append(num8);

        ds >> num8; // Azimuth
        ds >> num8; // Elevation
        ds >> num16; // State
        track.sat_states.append(num16);
        QVector<quint8> snr;
        for (int j=0; j<10; j++){ // Signal-noise ratio
            ds >> num8;
            snr.append(num8);
        }
        track.signal_ratios.append(snr);
    }

    return track;
}

WIMUBinaryStream& WIMUBinaryStream::operator = (const WIMUBinaryStream& original){
    m_idModule = original.m_idModule;
    m_data = original.m_data;

    return *this;
}

QList<QVector3D> WIMUBinaryStream::convertToAccSensorData(WIMUConfig* config){
    QList<QVector3D> rval;

    if (m_fromFile){
        // Create all samples
        for (int i=0; i<config->general.sampling_rate; i++){
            rval.append(QVector3D());
        }

        QDataStream reader(m_data);
        reader.setByteOrder(QDataStream::LittleEndian);
        qint16 value=0;
        float fvalue;
        for (int i=0; i<3; i++){ // 3 channels
            for (int j=0; j<config->general.sampling_rate; j++){ // All samples
                reader >> value;
                fvalue = config->convertAcc2g(value);
                rval[j][i] = fvalue;
            }
        }

    }else{

    }

    return rval;
}

QList<QVector3D> WIMUBinaryStream::convertToGyroSensorData(WIMUConfig* config){
    QList<QVector3D> rval;

    if (m_fromFile){
        // Create all samples
        for (int i=0; i<config->general.sampling_rate; i++){
            rval.append(QVector3D());
        }

        QDataStream reader(m_data);
        reader.setByteOrder(QDataStream::LittleEndian);
        qint16 value=0;
        float fvalue;
        for (int i=0; i<3; i++){ // 3 channels
            for (int j=0; j<config->general.sampling_rate; j++){ // All samples
                reader >> value;
                fvalue = config->convertGyro2degs(value);
                rval[j][i] = fvalue;
            }
        }

    }else{

    }

    return rval;
}

QList<QVector3D> WIMUBinaryStream::convertToMagnetoSensorData(WIMUConfig* config){
    QList<QVector3D> rval;

    if (m_fromFile){
        // Create all samples
        for (int i=0; i<config->general.sampling_rate; i++){
            rval.append(QVector3D());
        }

        QDataStream reader(m_data);
        reader.setByteOrder(QDataStream::LittleEndian);
        qint16 value=0;
        float fvalue;
        for (int i=0; i<3; i++){ // 3 channels
            for (int j=0; j<config->general.sampling_rate; j++){ // All samples
                reader >> value;
                fvalue = config->convertMag2gauss(value);
                rval[j][i] = fvalue;
            }
        }

    }else{

    }

    return rval;
}
