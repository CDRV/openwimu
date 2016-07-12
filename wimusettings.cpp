#include "wimusettings.h"

#include <QDataStream>

WIMUSettings::WIMUSettings(QObject *parent) : QObject(parent)
{
    setDefaults();
}

void WIMUSettings::setDefaults(){
    id = 0;
    hw_id = 3;
    version_major = 0;
    version_minor = 0;
    version_rev = 0;
    for (int i=0; i<3; i++){
        acc_gain[i] = 1;
        acc_offset[i] = 0;
        gyro_gain[i] = 1;
        gyro_offset[i] = 0;
        mag_gain[i] = 1;
        mag_offset[i] = 0;
    }

    crc = 0xffffffff;
}

QString WIMUSettings::getFirmwareVersion(){
    QString version;

    version = QString::number(version_major) + "." +
              QString::number(version_minor) + " Rev. " +
              QString::number(version_rev);

    return version;
}

QByteArray WIMUSettings::serialize(){
    QByteArray bytes;
    QDataStream ds(&bytes, QIODevice::WriteOnly);
    ds.setByteOrder(QDataStream::LittleEndian);

    ds << id;
    ds << hw_id;
    ds << version_major;
    ds << version_minor;
    ds << version_rev;
    for (int i=0; i<3; i++)
        ds << acc_gain[i];
    for (int i=0; i<3; i++)
        ds << acc_offset[i];
    for (int i=0; i<3; i++)
        ds << gyro_gain[i];
    for (int i=0; i<3; i++)
        ds << gyro_offset[i];
    for (int i=0; i<3; i++)
        ds << mag_gain[i];
    for (int i=0; i<3; i++)
        ds << mag_offset[i];
    //ds << crc;
    ds << 0xffffffff; // For now...

    return bytes;
}

void WIMUSettings::unserialize(QByteArray* data){
    QDataStream ds(*data);
    ds.setByteOrder(QDataStream::LittleEndian);

    ds >> id;
    ds >> hw_id;
    ds >> version_major;
    ds >> version_minor;
    ds >> version_rev;

    for (int i=0; i<3; i++)
        ds >> acc_gain[i];
    for (int i=0; i<3; i++)
        ds >> acc_offset[i];
    for (int i=0; i<3; i++)
        ds >> gyro_gain[i];
    for (int i=0; i<3; i++)
        ds >> gyro_offset[i];
    for (int i=0; i<3; i++)
        ds >> mag_gain[i];
    for (int i=0; i<3; i++)
        ds >> mag_offset[i];
    ds >> crc;
}

quint16 WIMUSettings::size(){
    quint16 size=0;

    size += sizeof(id)+sizeof(hw_id);
    size += sizeof(version_major)*3;
    size += sizeof(acc_gain[0])*3*3;
    size += sizeof(acc_offset[0])*3*3;
    size += sizeof(crc);

    return size + 2; // We must align...
}

WIMUSettings& WIMUSettings::operator = (const WIMUSettings& original){
    this->id = original.id;
    this->hw_id = original.hw_id;
    version_major = original.version_major;
    version_minor = original.version_minor;
    version_rev = original.version_rev;
    for (int i=0; i<3; i++){
        acc_gain[i] = original.acc_gain[i];
        acc_offset[i] = original.acc_offset[i];
        gyro_gain[i] = original.gyro_gain[i];
        gyro_offset[i] = original.gyro_offset[i];
        mag_gain[i] = original.mag_gain[i];
        mag_offset[i] = original.mag_offset[i];
    }

    this->crc = original.crc;

    return *this;
}
