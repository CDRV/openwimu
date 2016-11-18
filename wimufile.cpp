#include "wimufile.h"
#include <QDebug>

WIMUFile::WIMUFile(QString filename, WIMU::Modules_ID file_type, WIMUSettings settings, WIMUConfig config, QObject *parent) :
    QObject(parent),
    m_filename(filename),
    m_filetype(file_type),
    m_config(config),
    m_settings(settings)
{

}

WIMUFile::~WIMUFile(){
    if (m_file.isOpen())
        m_file.close();
}

bool WIMUFile::openFile(){
    // Load data from file
    m_file.setFileName(m_filename);
    return m_file.open(QIODevice::ReadWrite);
}

void WIMUFile::closeFile(){
    m_file.close();
}

quint64 WIMUFile::getStartTime(){
    quint64 rval = 0;

    if (m_file.isOpen()){
        m_file.seek(0); // Move to beginning of file
        QByteArray data = readSample();
        rval = getSampleTime(&data);
    }
    return rval;
}

quint64 WIMUFile::getEndTime(){
    quint64 rval = 0;

    if (m_file.isOpen()){
        m_file.seek(m_file.size()-getSampleSize()); // Move to last sample in file
        QByteArray data = readSample();
        rval = getSampleTime(&data);
    }
    return rval;
}

QList<quint32> WIMUFile::getTimeVector(){
    QList<quint32> rval;

    if (m_file.isOpen()){
        m_file.seek(0);
        while (!m_file.atEnd()){
            QByteArray data = readSample();
            rval.append(getSampleTime(&data));
        }
    }

    return rval;
}

QByteArray WIMUFile::readSample(){
    QByteArray rval;

    // Read a sample from the current position in file
    quint16 size = getSampleSize();

    if (size>0){
        rval = m_file.read(size);
    }

    return rval;
}

quint16 WIMUFile::getSampleSize(){
    quint16 size = 0;

    // Get sample size including timestamp
    switch (m_filetype){
    case WIMU::MODULE_ACC:
    case WIMU::MODULE_GYRO:
    case WIMU::MODULE_MAGNETO:
        if (m_settings.hw_id==3){
            size = (4 + 50 * 3 * 2) * (m_config.general.sampling_rate/50);
        }
        if (m_settings.hw_id==2){
            size = (4 + m_config.general.sampling_rate * 3 * 2);
        }
        break;
    case WIMU::MODULE_GPS:
        // TODO
        break;
    case WIMU::MODULE_IMU:
        if (m_settings.hw_id==3){
            size = (4 + 50 * 4 * 4) * (m_config.general.sampling_rate/50);
        }
        break;
    case WIMU::MODULE_POWER:
        if (m_settings.hw_id==3){
            size = 4 + 3*2;
        }
        if (m_settings.hw_id==2){
            size = (4 + m_config.general.sampling_rate * 3 * 2);
        }
        break;
    default:
        break;
    }
    return size;
}



quint32 WIMUFile::getSampleTime(QByteArray *data){
    quint32 rval = 0;

    if (data->count()>4){
        rval = (((quint32)data->at(3)) << 24) & 0xff000000;
        rval |= (((quint32)data->at(2)) << 16) & 0x00ff0000;
        rval |= (((quint32)data->at(1)) << 8) & 0x0000ff00;
        rval |= ((quint32)data->at(0)) & 0x000000ff;
    }

    return rval;
}


QByteArray WIMUFile::getSampleData(QByteArray* data){
    if (data->count()>4){
        return data->mid(4);
    }

    return *data;
}

WIMU::Modules_ID WIMUFile::getModuleFromPrefix(QString prefix){
    if (prefix=="ACC")
        return WIMU::MODULE_ACC;

    if (prefix=="GYR")
        return WIMU::MODULE_GYRO;

    if (prefix=="MAG")
        return WIMU::MODULE_MAGNETO;

    if (prefix=="GPS")
        return WIMU::MODULE_GPS;

    if (prefix=="IMU")
        return WIMU::MODULE_IMU;

    if (prefix=="POW")
        return WIMU::MODULE_POWER;

    // Default value
    return WIMU::MODULE_CPU;

}

qint64 WIMUFile::getCurrentPos(){
    if (!m_file.isOpen())
        return -1;

    return m_file.pos();
}

QFile* WIMUFile::getFilePtr(){
    return &m_file;
}
