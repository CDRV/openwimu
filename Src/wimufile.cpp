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
    m_currentIndex = 0;
}

WIMUFile::~WIMUFile(){
    /*if (m_file.isOpen())
        m_file.close();*/
    if (m_fileBuffer.isOpen())
        m_fileBuffer.close();
    m_samples.clear();

}

bool WIMUFile::load(bool ignore_timefile){
    QFile file;
    m_times.clear();

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

        // Check if we have a time file and, if so, load the times from it...
        if (!ignore_timefile){
            QString time_name ="";
            QStringList names = m_filename.replace("\\","/").split("/");
            if (!names.isEmpty()){
                time_name = "TIME_" + names.last();
                for (int i=names.count()-2; i>=0; i--){
                    time_name = names.at(i) + "\\" + time_name;
                }

                if (QFile::exists(time_name)){
                    // Load time data
                    QFile time_file(time_name);
                    if (time_file.open(QIODevice::ReadOnly)){
                        while (!time_file.atEnd()){
                            QString time = time_file.readLine();
                            m_times.append(time.toUInt());
                        }
                        time_file.close();
                    }
                }
            }

        }


        return true;
    }
    return false;
}

bool WIMUFile::load(quint32 start_filetime, quint32 ts, qint32 len){
    QFile file;
    m_times.clear();


    // Load data from file
    file.setFileName(m_filename);


    if (file.open(QIODevice::ReadOnly)){
        // Find correct position depending on sample size
        qint64 pos;

        if (m_filetype!=WIMU::MODULE_GPS){
            pos = (ts-start_filetime) * getSampleSize(); // Not true, since there might be a "jump" in the timestamps in the file

            QString time_name ="";
            QStringList names = m_filename.replace("\\","/").split("/");
            if (!names.isEmpty()){
                time_name = "TIME_" + names.last();
                for (int i=names.count()-2; i>=0; i--){
                    time_name = names.at(i) + "\\" + time_name;
                }

                if (QFile::exists(time_name)){
                    // Load time data
                    QFile time_file(time_name);

                    if (time_file.open(QIODevice::ReadOnly)){
                        quint32 count = qMax((int)((ts-start_filetime)-60)-1,0);
                        //TOFIX: will not work if timestamp does not contains 10 caracters
                        time_file.seek(count*11); // 11 = general size of text timestamp + \n
                        QString time = time_file.readLine();
                        while (time.toUInt() > ts){
                            // Move back 60 seconds
                            count -=60;
                            time_file.seek(count*11);

                            time = time_file.readLine();
                        }
                        while (!time_file.atEnd() && time.toUInt()<ts){
                            time = time_file.readLine();
                            count++;
                        }
                        time_file.close();
                        pos = count * getSampleSize(); // Count is now at the correct timestamp
                    }

                }
            }

            file.seek(pos);

            // Read samples from here, up to "len"
            m_fileBuffer.buffer().clear();
            for (int i=0; i<len; i++){
                if (!file.atEnd()){
                    QByteArray sample = file.read(getSampleSize());
                    m_fileBuffer.buffer().append(sample);
                }
            }

            file.close();
            m_fileBuffer.open(QIODevice::ReadOnly);
        }else{ // GPS file
            QString index_name ="";
            QStringList names = m_filename.replace("\\","/").split("/");
            if (!names.isEmpty()){
                index_name = "INDEX_" + names.last();
                for (int i=names.count()-2; i>=0; i--){
                    index_name = names.at(i) + "\\" + index_name;
                }
                if (QFile::exists(index_name)){
                    // Load time data
                    QFile index_file(index_name);
                    if (index_file.open(QIODevice::ReadOnly)){
                        quint32 count = qMax((int)((ts-start_filetime)-60)-1,0);
                        index_file.seek(count*12); // 12 = timestamp (4 bytes) + position (8 bytes)
                        QDataStream reader(&index_file);
                        reader.setByteOrder(QDataStream::LittleEndian);
                        quint32 current_ts;
                        quint32 last_ts;
                        qint64 last_pos;
                        qint64 current_pos;
                        reader >> current_ts >> current_pos;

                        while (current_ts > ts){
                            // Move back 60 seconds
                            count -=60;
                            index_file.seek(count*12);

                            reader >> current_ts >> current_pos;
                            last_pos = current_pos;
                            last_ts = current_ts;
                        }

                        while (!index_file.atEnd() && current_ts<ts){
                            last_pos = current_pos;
                            last_ts = current_ts;
                            reader >> current_ts >> current_pos;
                        }

                        pos = current_pos; // Count is now at the correct timestamp
                        m_fileBuffer.buffer().clear();
                        m_lastGPSTime = current_ts;

                        // Build list of sample positions to read
                        count =0;
                        QList<qint64> positions;
                        positions.append(current_pos);
                       // qDebug() << current_pos;
                        while ((qint32)count<len){
                            last_ts = current_ts;
                            reader >> current_ts >> current_pos;
                            positions.append(current_pos);
                            if (last_ts != current_ts)
                                count++;
                            if (file.atEnd() || last_ts ==0)
                                break;
                        }
                        index_file.close();

                        for (int i=0; i<positions.count()-1; i++){
                            file.seek(positions.at(i));
                            if (!file.atEnd() && (positions.at(i+1)-positions.at(i))>0){
                                QByteArray sample = file.read(positions.at(i+1)-positions.at(i));
                                m_fileBuffer.buffer().append(sample);
                            }
                        }


                        file.close();
                        m_fileBuffer.open(QIODevice::ReadOnly);
                        if (!positions.isEmpty())
                            fillSamplesList(m_fileBuffer.buffer(), positions.first());

                    }
                }else{
                    return false;
                }


            }else{
                return false;
            }
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

quint32 WIMUFile::getStartTime(){
    quint32 rval = 0;

    if (m_times.count()>0)
        return m_times.first();

    if (m_filetype!=WIMU::MODULE_GPS){
        if (m_fileBuffer.isOpen()){
            qint64 current_pos = m_fileBuffer.pos();
            m_fileBuffer.seek(0); // Move to beginning of file
            QByteArray data = readSample();
            rval = getSampleTime(&data);
            m_fileBuffer.seek(current_pos); // Move back to start position
        }
    }else{
        qDebug() << "GPS - getStartTime() not available yet!";
    }
    return rval;
}

quint32 WIMUFile::getEndTime(){
    quint32 rval = 0;

    if (m_times.count()>0)
        return m_times.last();

    if (m_filetype!=WIMU::MODULE_GPS){
        if (m_fileBuffer.isOpen()){
            qint64 current_pos = m_fileBuffer.pos();
            m_fileBuffer.seek(m_fileBuffer.size() - getSampleSize()); // Move to last sample in file
            QByteArray data = readSample();
            rval = getSampleTime(&data);
            m_fileBuffer.seek(current_pos); // Move back to current position
        }
    }else{
        qDebug() << "GPS - getEndTime() not available yet!";
    }
    return rval;
}

QList<quint32> WIMUFile::getTimeVector(){
    QList<quint32> rval;

    if (m_times.count()>0)
        return m_times;

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
            // In case we had a "\n" or "\r" in the timestamp, try to read again..
            while (rval.count()<4 && !m_fileBuffer.atEnd()){
                rval = rval.append(m_fileBuffer.readLine());
            }
            if (rval.count()>4){
                rval = rval.left(4) + rval.right(rval.length()-4).replace("\n","");
                rval = rval.left(4) + rval.right(rval.length()-4).replace("\r","");
            }else{
                rval.clear();
            }
        }
        m_currentIndex++; // Update current sample index
    }else{
        // Check if message is valid
        if (m_currentIndex < m_samples.count()){
            QByteArray * sample = &m_samples[m_currentIndex++];
            //qDebug() << m_samples;
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

    m_currentSample = rval;
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

// Warning: this function will always return uncorrected time...
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
                        m_lastGPSTime = nav.nav_datetime.toSecsSinceEpoch();
                }
            }
        }
        rval = m_lastGPSTime;
    }
    return rval;
}

// Return corrected time, if available...
quint32 WIMUFile::getCurrentSampleTime(){
    if (m_times.count()>0 && m_currentIndex-1<m_times.count() && m_currentIndex-1>=0){
        return m_times.at(m_currentIndex-1);
    }

    // No corrected time vector - must return not corrected time
    return getSampleTime(&m_currentSample);

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
        /*qint64 pos=0;
        for (int i=m_currentIndex-1; i>=0; i--){
            pos += m_samples.at(i).count();
        }
        return pos;*/
        if (m_currentIndex>0)
            return m_samplesPos.at(m_currentIndex-1);
        else
            return 0;
    }
}

/*QFile* WIMUFile::getFilePtr(){
    return &m_file;
}*/

QString WIMUFile::getFileName(){
    return m_filename;
}

void WIMUFile::fillSamplesList(QByteArray& data, quint64 offset){
    // Fill the samples list from the ByteArray
    m_samples.clear();
    m_samplesPos.clear();
    if (m_filetype==WIMU::MODULE_GPS){
        QList<QByteArray> samples = data.split((char)0xB3);
        qint64 pos = 0;

        // Merge samples if needed
        QByteArray new_sample;
        for (int i=0; i<samples.count(); i++){
            QByteArray* sample = &samples[i];
            new_sample.append(*sample);
            new_sample.append((char)0xB3); // Was filtered when splitting
            if (new_sample.count()>=2){
                if ((quint8)new_sample.at(new_sample.count()-2)==0xB0 &&
                     (quint8)new_sample.at(new_sample.count()-1)==0xB3){
                    m_samples.append(new_sample);
                    m_samplesPos.append(pos+offset);
                    pos += new_sample.count();
                    new_sample.clear();
                }
            }
        }

        m_currentIndex = 0; // Reset sample index reader
    }else{
        qDebug() << "fillSamplesList - Not defined for that sensor type";
    }
}
