#include "wimufile.h"
#include <QDebug>
#include "wimubinarystream.h"


WIMUFile::WIMUFile(QString filename, WIMU::Modules_ID file_type, WIMUSettings settings, WIMUConfig config, QObject *parent) :
    QObject(parent),
    m_filename(filename),
    m_filetype(file_type),
    m_config(config),
    m_settings(settings)
{

    m_lastGPSTime = 0;
}

WIMUFile::~WIMUFile(){
    /*if (m_file.isOpen())
        m_file.close();*/
    if (m_fileBuffer.isOpen())
        m_fileBuffer.close();
    m_samples.clear();

}

bool WIMUFile::load(){
    QFile file;
    // Load data from file
    file.setFileName(m_filename);
    /*if (m_filetype!=WIMU::MODULE_GPS)
        return m_file.open(QIODevice::ReadWrite);*/

    // Use an internal buffer for improved speed - files are kept small, so should be OK for memory usage
    if (file.open(QIODevice::ReadOnly)){
        m_fileBuffer.buffer() = file.readAll();
        file.close();
        m_fileBuffer.open(QIODevice::ReadOnly);

        // Build samples list
        if (m_filetype==WIMU::MODULE_GPS){
            fillSamplesList(m_fileBuffer.buffer());
        }


        return true;
    }
    return false;
}

void WIMUFile::close(){
    //m_file.close();
    m_fileBuffer.buffer().clear();
    m_fileBuffer.close();
    m_samples.clear();
}

quint64 WIMUFile::getStartTime(){
    quint64 rval = 0;

    if (m_filetype!=WIMU::MODULE_GPS){
        if (m_fileBuffer.isOpen()){
            m_fileBuffer.seek(0); // Move to beginning of file
            QByteArray data = readSample();
            rval = getSampleTime(&data);
        }
    }else{
        qDebug() << "GPS - getStartTime() not available yet!";
    }
    return rval;
}

quint64 WIMUFile::getEndTime(){
    quint64 rval = 0;

    if (m_filetype!=WIMU::MODULE_GPS){
        if (m_fileBuffer.isOpen()){
            m_fileBuffer.seek(m_fileBuffer.size()-getSampleSize()); // Move to last sample in file
            QByteArray data = readSample();
            rval = getSampleTime(&data);
        }
    }else{
        qDebug() << "GPS - getEndTime() not available yet!";
    }
    return rval;
}

QList<quint32> WIMUFile::getTimeVector(){
    QList<quint32> rval;

    if (m_filetype!=WIMU::MODULE_GPS){
        if (m_fileBuffer.isOpen()){
            m_fileBuffer.seek(0);
            while (!m_fileBuffer.atEnd()){
                QByteArray data = readSample();
                rval.append(getSampleTime(&data));
            }
        }
    }else{
        //TODO... if needed!!
    }

    return rval;
}

QByteArray WIMUFile::readSample(){
    QByteArray rval;

    // Read a sample from the current position in file
    if (m_filetype!=WIMU::MODULE_GPS){
        if (m_filetype!=WIMU::MODULE_CPU){
            quint16 size = getSampleSize();

            if (size>0){
                rval = m_fileBuffer.read(size);
            }
        }else{
            // LOG File = read a whole line
            rval = m_fileBuffer.readLine();
        }
    }else{
        // Check if message is valid
        if (m_currentIndex < m_samples.count()){
            QByteArray * sample = &m_samples[m_currentIndex++];
            if ((quint8)sample->at(0)==0xA0 && (quint8)sample->at(1)==0xA2 &&
                (quint8)sample->at(sample->count()-2)==0xB0 && (quint8)sample->at(sample->count()-1)==0xB3){
                rval = *sample;
            }else{
                //qDebug() << "Invalid GPS message";
                //rval.clear(); // Invalid message
                rval = *sample; // In order not to end processing now...
            }
        }else{
            //qDebug() << "Attempting to read a sample out of bounds.";
        }

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
    case WIMU::MODULE_CPU:
        // LOG file - variable sample size
        break;
    default:
        break;
    }
    return size;
}



quint32 WIMUFile::getSampleTime(QByteArray *data){
    quint32 rval = 0;
    if (m_filetype!=WIMU::MODULE_GPS){
        if (data->count()>4){
            rval = (((quint32)data->at(3)) << 24) & 0xff000000;
            rval |= (((quint32)data->at(2)) << 16) & 0x00ff0000;
            rval |= (((quint32)data->at(1)) << 8) & 0x0000ff00;
            rval |= ((quint32)data->at(0)) & 0x000000ff;
        }
    }else{
        // Check if this is a frame containing time to update time, otherwise, return last valid one
        if (data->count()>5){
            if (data->at(4)==41 && data->count() >= 23){ // Geodetic Navigation Data
                WIMUBinaryStream stream;
                if (stream.fromBinaryFile(*data,WIMU::MODULE_GPS)>0){
                    WIMU::GPSNavData_Struct nav = stream.convertToGPSNavData();
                    if (nav.nav_datetime.isValid())
                        m_lastGPSTime = nav.nav_datetime.toMSecsSinceEpoch() / 1000;
                }

            }
        }
        rval = m_lastGPSTime;
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

    if (prefix=="LOG")
        return WIMU::MODULE_CPU;

    // Default value
    return WIMU::MODULE_CPU;

}

qint64 WIMUFile::getCurrentPos(){
    if (m_filetype!=WIMU::MODULE_GPS){
        if (!m_fileBuffer.isOpen())
            return -1;

        return m_fileBuffer.pos();
    }else{
        qint64 pos=0;
        for (int i=m_currentIndex-1; i>=0; i--){
            pos += m_samples.at(i).count();
        }
        return pos;
    }
}

/*QFile* WIMUFile::getFilePtr(){
    return &m_file;
}*/

QString WIMUFile::getFileName(){
    return m_filename;
}

void WIMUFile::fillSamplesList(QByteArray& data){
    // Fill the samples list from the ByteArray
    if (m_filetype==WIMU::MODULE_GPS){
        QList<QByteArray> samples = data.split((char)0xB3);
        // Merge samples if needed
        QByteArray new_sample;
        for (int i=0; i<samples.count(); i++){
            QByteArray* sample = &samples[i];
            new_sample.append(*sample);
            new_sample.append((char)0xB3); // Was filtered when splitting
            /*if (new_sample.count()>=2){
                if ((quint8)new_sample.at(0) != 0xA0 && (quint8)new_sample.at(1) != 0xA3){
                    // Resync GPS message
                    while(new_sample.count()>=2){
                        new_sample = new_sample.right(new_sample.count()-2);
                        if ((quint8)new_sample.at(0) == 0xA0 && (quint8)new_sample.at(1) == 0xA3){
                            break;
                        }
                    }
                    if ((quint8)new_sample.at(0) != 0xA0 && (quint8)new_sample.at(1) != 0xA3){
                        new_sample.clear();
                    }
                }
            }*/
            if (new_sample.count()>=2){

                if ((quint8)new_sample.at(new_sample.count()-2)==0xB0 &&
                     (quint8)new_sample.at(new_sample.count()-1)==0xB3){
                    m_samples.append(new_sample);
                    new_sample.clear();
                }
            }
        }

        m_currentIndex = 0; // Reset sample index reader
    }else{
        qDebug() << "fillSamplesList - Not defined for that sensor type";
    }
}
