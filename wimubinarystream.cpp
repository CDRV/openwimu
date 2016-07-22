#include "wimubinarystream.h"

#include <QDataStream>
#include <QDebug>

WIMUBinaryStream::WIMUBinaryStream(QObject *parent) : QObject(parent)
{
    m_idModule = WIMU::MODULE_CPU;
    m_data.clear();
}

WIMUBinaryStream::WIMUBinaryStream(const WIMUBinaryStream &copy, QObject *parent) :
       QObject(parent)
{
    *this = copy;
}


quint16 WIMUBinaryStream::fromBinaryStream(QByteArray &stream){
    if (stream.count()<2)
        return 0;

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

WIMU::IMUFrame_Struct WIMUBinaryStream::convertToIMUFrame(){
    WIMU::IMUFrame_Struct frame;

    if (m_idModule!=WIMU::MODULE_IMU)
        return frame;


    QDataStream ds(m_data);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    ds >> frame.frame_num;
    for (int i=0; i<3; i++)
        ds >> frame.acc_data[i];
    for (int i=0; i<3; i++)
        ds >> frame.gyro_data[i];
    for (int i=0; i<3; i++)
        ds >> frame.mag_data[i];
    for (int i=0; i<4; i++)
        ds >> frame.quaternion[i];

    return frame;
}

WIMU::Modules_ID WIMUBinaryStream::getModuleID(){
    return m_idModule;
}

int WIMUBinaryStream::getGPSMessageID(){
    int rval = -1;

    if (m_idModule != WIMU::MODULE_GPS){
        return rval;
    }

    // Get GPS data payload
    QByteArray payload = getGPSMessagePayload();

    if (!payload.isEmpty()){
        return payload.at(0);
    }
    return rval;
}

QByteArray WIMUBinaryStream::getGPSMessagePayload(){
    if (m_idModule != WIMU::MODULE_GPS){
        return QByteArray();
    }

    QByteArray rval;

    // Find sync bytes
    qint8 start_pos=-1, end_pos=-1;
    for (int i=0; i<m_data.count()-1; i++){
        if ((quint8)m_data.at(i)==0xA0 && (quint8)m_data.at(i+1)==0xA2){
            // Found start sequence
            start_pos = i+2; // Ignore sync bytes
        }
        if ((quint8)m_data.at(i)==0xB0 && (quint8)m_data.at(i+1)==0xB3){
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
    nav.nav_datetime = QDateTime(QDate(year,month,day),QTime(hour,minutes,seconds));

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
