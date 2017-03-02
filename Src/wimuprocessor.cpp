#include "wimuprocessor.h"

#include <QProgressDialog>
#include <QDir>
#include <QDebug>
#include <QCollator>
#include <QCoreApplication>
#include <QFileInfo>
#include <QElapsedTimer>

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/utime.h>
#include <time.h>

#include "wimufile.h"
#include "wimubinarystream.h"

WimuProcessor::WimuProcessor(QObject *parent) : QObject(parent)
{
    m_config = NULL;
    m_settings = NULL;
    m_cancel = false;
}

WimuProcessor::~WimuProcessor(){
    if (m_config)
        delete m_config;
    if (m_settings)
        delete m_settings;
}

bool WimuProcessor::preProcess(QString path){
    QDir folder(path);
    m_cancel = false;

    if (!folder.exists()){
        emit requestLogging(path + " est inexistant.",WIMU::LogError);
        return false;
    }

    // Remove "PreProcess" and "Processed" folders, if needed
    QDir todel;
    todel.setPath(path + "/PreProcess");
    todel.removeRecursively();
    todel.setPath(path + "/Processed");
    todel.removeRecursively();


    // Build list of folders to process
    QStringList folders = folder.entryList(QDir::AllDirs | QDir::NoDotAndDotDot);

    // Sort folder list
    sortFolderList(folders);

    // Remove folders containing "Process" into them (could be used for "backup" or to keep a trace of older processing)
    QStringList toremove;
    foreach (QString folder, folders){
        if (folder.contains("process",Qt::CaseInsensitive))
            toremove.append(folder);
    }

    foreach (QString folder, toremove){
        folders.removeAll(folder);
    }

    // Find settings to use
    if (m_settings){
        delete m_settings;
        m_settings = NULL;
    }

    for (int i=0; i<folders.count(); i++){
        WIMUSettings* new_set = new WIMUSettings();
        if (new_set->loadFromFile(path + "/" + folders.at(i)+ "/SETTINGS")){
            // OK, loaded!
            m_settings = new_set;
            break;
        }else{
            delete new_set;
        }
    }

    if (m_settings==NULL){
        emit requestLogging(path + ": Impossible de trouver un fichier de paramètres du module (SETTINGS)",WIMU::LogError);
        return false;
    }


    // Find config to use
    if (m_config){
        delete m_config;
        m_config = NULL;
    }

    for (int i=0; i<folders.count(); i++){
        WIMUConfig* new_conf = new WIMUConfig(m_settings->hw_id);
        if (new_conf->loadFromFile(path + "/" + folders.at(i) + "/CONFIG.WCF")){
            m_config = new_conf;
            break;
        }else{
            delete new_conf;
        }
    }

    if (m_config==NULL){
        emit requestLogging(path + ": Impossible de trouver un fichier de configuration du module (CONFIG.WCF)",WIMU::LogError);
        return false;
    }

    // Correct timestamps on a data folder basis
    for (int i=0; i<folders.count(); i++){
        // Estimate total number of files to process
        quint32 file_count = getFilesNumInFolder(path + "/" + folders.at(i),"???_*.DAT");

        // Update progress dialog accordingly
        emit requestProgressInit("Pré-traitement - " + path + "/" + folders.at(i), 0, file_count);

        correctTimestamp(path + "/" + folders.at(i));
        if (m_cancel)
            return false;
    }

    // Combine files and correct timestamp on a dataset folder basis
    emit requestLogging("Combinaison et nettoyage final des données...",WIMU::LogInfo);
    emit requestProgressInit("Combinaison et nettoyage final des données",0,6);
    combineDataSet(path, folders);
    if (m_cancel)
        return false;

    return true;
}

void WimuProcessor::sortFolderList(QStringList &folders){
    QCollator collator;
    collator.setNumericMode(true);
    collator.setIgnorePunctuation(true);
    collator.setCaseSensitivity(Qt::CaseInsensitive);
    std::sort(folders.begin(),
              folders.end(),
              [&collator](const QString &file1, const QString &file2)
                 {
                     return collator.compare(file1, file2) < 0;
                 });
}



void WimuProcessor::correctTimestamp(QString path){

    /////////////////////////////////////////////////////////////
    // Step 1. Build sensor list from prefixes
    /////////////////////////////////////////////////////////////
    QDir    folder(path);
    QStringList file_prefixes = getSensorList(folder.path());
    file_prefixes.append("LOG"); // Add log file as sensors prefix

    /////////////////////////////////////////////////////////////
    // Step 2. Build a time mapping
    /////////////////////////////////////////////////////////////
    QList<quint32> time_vector;

    if (m_settings->hw_id != 3 && m_settings->hw_id != 2){
        emit requestLogging("Version matérielle du WIMU non-supportée: HW v." + QString::number(m_settings->hw_id),WIMU::LogError);
        return;
    }


    QString data_file;
    WIMU::Modules_ID time_src = WIMU::MODULE_POWER;
    bool    day_offset = false;

    // Build list of files to process
    QStringList files = folder.entryList(QStringList("POW_*.DAT"),QDir::Files);

    if (files.isEmpty()){
        // Fall back to other sensors...
        emit requestLogging("Aucun enregistrement de la pile dans " + path + ". Génération du vecteur temps à partir d'une autre source.",WIMU::LogWarning);
        // Acc
        files = folder.entryList(QStringList("ACC_*.DAT"),QDir::Files);
        time_src = WIMU::MODULE_ACC;

        if (files.isEmpty()){
            // Fall back to other sensors...
            //emit requestLogging("Aucun enregistrement d'accélération dans " + path + ". Génération du vecteur temps à partir d'une autre source.",WIMU::LogWarning);
            // Gyro
            files = folder.entryList(QStringList("GYR_*.DAT"),QDir::Files);
            time_src = WIMU::MODULE_GYRO;

            if (files.isEmpty()){
                // Fall back to other sensors...
                //emit requestLogging("Aucun enregistrement de gyromètres dans " + path + ". Génération du vecteur temps à partir d'une autre source.",WIMU::LogWarning);
                // Magneto
                files = folder.entryList(QStringList("MAG_*.DAT"),QDir::Files);
                time_src = WIMU::MODULE_MAGNETO;
                if (files.isEmpty()){
                    // No valid timestamp source... ignore folder!
                    emit requestLogging("Aucune donnée temporelle dans " + path + ". Dossier ignoré.",WIMU::LogError);
                    return;
                }
                else{
                    emit requestLogging("Utilisation des données temporelles du magnétomètre.",WIMU::LogWarning);
                }
            }else{
                emit requestLogging("Utilisation des données temporelles du gyromètre.",WIMU::LogWarning);
            }
        }else{
            emit requestLogging("Utilisation des données temporelles de l'accéléromètre.",WIMU::LogWarning);
        }
    }

    // Sort file list
    sortFolderList(files);

    // On some WIMUs, a strange thing happened as the GPS time was exactly one day ahead of the sensors time...
    // Try to detect that using files dates and last sample of that file - if they are offset by one day, we must apply the correction...
    if (file_prefixes.contains("GPS")){
        foreach (data_file, files){
            QFileInfo info(path + "/" + data_file);
            quint32 file_time = info.lastModified().toSecsSinceEpoch();
            if (isTimestampValid(file_time)){
                // This file is valid - load last sample
                WIMUFile file(path + "/" + data_file, time_src, *m_settings, *m_config);
                if (!file.load(true)){
                    emit requestLogging("Impossible d'ouvrir le fichier: " + data_file + ". Ignoré.",WIMU::LogError);
                    return;
                }

                quint32 sample_time = file.getEndTime();
                if ((file_time-sample_time) > 86400){
                    emit requestLogging("Correctif - Alignement temporel GPS/Capteurs appliqué",WIMU::LogInfo);
                    day_offset = true;
                }
                file.close();
                break;
            }
        }
    }

    foreach (data_file,files){
        WIMUFile file(path + "/" + data_file, time_src, *m_settings, *m_config);

        if (!file.load(true)){
            emit requestLogging("Impossible d'ouvrir le fichier: " + data_file + ". Ignoré.",WIMU::LogError);
            continue;
        }

        //start_times.insert(data_file,file.getStartTime());
        //end_times.insert(data_file,file.getEndTime());
        QList<quint32> times = file.getTimeVector();
        if (!times.empty()){
            time_vector.append(times);
        }else{
            emit requestLogging("Impossible de lire le fichier: " + data_file + ". Ignoré.",WIMU::LogError);
            continue;
        }

        file.close();
    }

    if (m_cancel)
        return;

    /////////////////////////////////////////////////////////////
    // Step 3. Identify the first valid timestamp, if any
    /////////////////////////////////////////////////////////////
    //quint64 timestamp;
    int valid_ts_index = -1;

    if (!time_vector.isEmpty() && isTimestampValid(time_vector.first())){
        valid_ts_index = 0;
    }else{
        //for (int i=time_vector.count()-1; i>=0; i--){
        for (int i=0; i<time_vector.count(); i++){
            if (isTimestampValid(time_vector.at(i))){
                valid_ts_index = i;
                break;
            }
        }
    }

    if (valid_ts_index==-1){
        emit requestLogging("Aucune heure valide trouvée dans " + path, WIMU::LogWarning);
        //return;
    }

    if (m_cancel)
        return;

    /////////////////////////////////////////////////////////////
    // Step 4. Build conversion matrix to apply to all timestamps
    /////////////////////////////////////////////////////////////
    int current_diff = 1;
    int prev_diff;

    QList<quint32> new_time_vector = time_vector;

    if (day_offset){
        for (int i=0; i<new_time_vector.count(); i++){
            new_time_vector[i]+=86400;
        }
    }

    for (int i=valid_ts_index-1; i>=0; i--){
        // Correct previous timestamps
        if (i-1>=0){
            prev_diff = qAbs((qint32)time_vector.at(i) - (qint32)time_vector.at(i-1)); // Get difference between previous samples
            if (prev_diff>=86400)
                prev_diff = 1;

        }

        new_time_vector[i] = new_time_vector.at(i+1) - current_diff;
        current_diff = prev_diff;
        QCoreApplication::processEvents();
    }

    if (m_cancel)
        return;

    /////////////////////////////////////////////////////////////
    // Step 5. Create days mapping
    /////////////////////////////////////////////////////////////
    QList<quint32> dates;
    QMap<qint16, QDate> fileDateMapping;

    if (new_time_vector.count()>0){
        quint32 next_day = previousMidnight(/*adjustTimeForTimeZone(*/new_time_vector.first()/*,false)*/);
        //dates.append(next_day); // Current day
        //next_day += 86400;
        quint32 last_day = previousMidnight(/*adjustTimeForTimeZone(*/new_time_vector.last()/*,false)*/);
       // qDebug() << new_time_vector.first() << new_time_vector.last();
        /*if (last_day != next_day)
            last_day += 86400;*/

        dates.append(next_day); // Always a first date
        fileDateMapping.insert(0, QDateTime::fromSecsSinceEpoch(next_day,Qt::UTC).date());

        for (quint32 i=next_day+86400; i<=last_day; i+= 86400){
            dates.append(i);
            fileDateMapping.insert(dates.count()-1, QDateTime::fromSecsSinceEpoch(i,Qt::UTC).date());
        }
        //qDebug() << dates;

        //qDebug() << new_time_vector.last();
        /*while (next_day < new_time_vector.last()){
            dates.append(next_day);
            next_day += 86400;
        }
        if (!dates.contains(next_day))
            dates.append(next_day); // adds the final day*/
    }

    if (m_cancel)
        return;

    file_prefixes.clear();
    file_prefixes.append("LOG");
    file_prefixes.append("POW");

    //////////////////////////////////////////////////////////////////////
    // Step 6. Create all empty files required for those days and sensors
    //////////////////////////////////////////////////////////////////////
    // Create PreProcess folder
    if (folder.exists(folder.path()+"/PreProcess")){
        // Remove it!
        folder.setPath(folder.path()+"/PreProcess");
        folder.removeRecursively();
        folder.setPath(path);
    }
    if (!folder.mkdir("PreProcess")){
        emit requestLogging("Impossible de créer le répertoire: " + path + "/PreProcess",WIMU::LogError);
        return;
    }

    // Debug output file
    /*QFile debugfile(path+"/PreProcess/debug.txt");
    if (debugfile.open(QIODevice::WriteOnly)){
        QTextStream stream(&debugfile);

        for (int i=0; i<time_vector.count(); i++){
            stream << time_vector.at(i) << " = " << new_time_vector.at(i) << "\n";
        }
        debugfile.close();
    }*/
    QString sensor;
    foreach (sensor, file_prefixes){
        for (int i=0; i<dates.count(); i++){
            // TIME file
            if (!writeTimeFile(path + "/PreProcess",sensor, i, QList<quint32>(), dates.at(i)))
                return;

            // DATA file
            if (!writeDataFile(path + "/PreProcess",sensor, i, NULL, 0,0, dates.at(i)))
                return;

            // GPS CSV files
            if (sensor=="GPS"){
                if (!writeGPSHeaderFile(path + "/PreProcess",i,dates.at(i)))
                    return;
            }

        }
    }

    if (m_cancel)
        return;

    /////////////////////////////////////////////////////////////
    // Step 7. Correct all sensors timestamps and split by day
    /////////////////////////////////////////////////////////////
    folder.setPath(path);

    quint32 count = 0;

    // Process data by sensor prefixes
    /*for (int i=0; i<time_vector.count(); i++)
        qDebug() << time_vector.at(i);*/

    foreach (sensor, file_prefixes){
        /*if (sensor=="GPS") // Ignore GPS for now...
            continue;*/

        // Start day = always first date
        qint8 current_day = 0;

        // Create list of files for that sensor
        QDir sensor_files(folder.path());
        if (sensor != "LOG"){
            files = sensor_files.entryList(QStringList(sensor+"_*.DAT"),QDir::Files);
            sortFolderList(files);
        }else
            files = sensor_files.entryList(QStringList(sensor+".DAT"),QDir::Files);

        //quint32 base_timestamp=0;
        //int last_ts_index = -1;
        quint32 last_ts = 0;
        quint32 last_gps_ts = 0;
        quint32 gps_count = 0; // Offset to add from start index
        int gps_index = 0; // Start index
        quint16 not_found_count=0;

        WIMUBinaryStream wimu_data;

        // Browse each file
        foreach(data_file,files){
            count++;
            emit requestLogging ("Traitement de: " + folder.path() + "/" + data_file, WIMU::LogDebug);
            // Read data
            WIMUFile current_file(folder.path() + "/" + data_file,WIMUFile::getModuleFromPrefix(sensor),*m_settings,*m_config);

            if (!current_file.load(true)){
                emit requestLogging("Impossible d'ouvrir le fichier: " + folder.path() + "/" + data_file + ". Ignoré.",WIMU::LogError);
                continue;
            }

            QByteArray data = current_file.readSample();

            QList<quint32> timestamps;
            qint64 last_pos = 0;
            QList<QByteArray> samples;
            //bool reorder_ts = false;

            while (!data.isEmpty()){

                //////////////////////////////////////
                // Correct sample timestamp, if needed
                quint32 timestamp = current_file.getSampleTime(&data);

                if (sensor=="GPS" && isTimestampValid(timestamp)){
                    // We must convert GPS timestamp to localtime...
                    /*QDateTime ltime = QDateTime::fromSecsSinceEpoch(timestamp,Qt::UTC);
                    qDebug() << timestamp << ltime << ltime.toLocalTime() << adjustTimeForTimeZone(timestamp,true);*/
                    timestamp = adjustTimeForTimeZone(timestamp,true);
                }

                /*if (sensor=="LOG"){
                    qDebug() << "LOG";
                }*/

                if (!isTimestampValid(timestamp) || (day_offset && sensor!="GPS")){
                    if (sensor=="GPS"){
                        // GPS doesn't start at "0" for timestamp... so we must offset it from the first value we have
                        /*if (timestamp==1233446386){ // New GPS reset
                            qDebug() << "GPS Reset";
                        }*/

                        if (timestamp != last_ts && gps_index+1 < time_vector.count() && timestamp!=0 && last_gps_ts != timestamp){
                            // Check if we have a larger "jump" in time than 1 second
                            int diff = (time_vector.at(gps_index+1) - time_vector.at(gps_index) - gps_count);
                            if (diff==2){
                                gps_count++;
                            }else{
                               /* if (diff>1)
                                    qDebug() << diff;*/
                                gps_count=0;
                                gps_index++;
                            }
                        }

                        last_gps_ts = timestamp;
                        timestamp = time_vector.at(gps_index) + gps_count;
                        last_ts = timestamp;
                        //qDebug() << timestamp;// << time_vector.at(0);
                    }

                    if (sensor=="LOG"){
                        // First log in the file sometimes has a value before timestamp... so check it out!
                        if (timestamp < time_vector.first()){
                            timestamp = time_vector.first();
                        }
                    }
                    if (time_vector.contains(timestamp)){
                        timestamp = new_time_vector.at(time_vector.indexOf(timestamp));
                        //last_ts_index = time_vector.indexOf(timestamp);
                    }else{
                        //if (sensor != "GPS"){
                        // Check for closest value
                            //bool found = false;
                            if (!time_vector.isEmpty() && timestamp>0){
                                auto const closest = std::upper_bound(time_vector.begin(),time_vector.end(),timestamp);
                                if (closest!=time_vector.end()){

                                    int index = time_vector.indexOf(*closest);
                                    // Find difference between closest uncorrected and closest corrected, and apply to the current timestamp
                                    if (index>0){
                                        int diff = new_time_vector.at(index) - time_vector.at(index);
                                        /*if (sensor=="LOG")
                                            emit requestLogging(data_file + ": Approximation du temps " + QString::number(timestamp) + "  vers " + QString::number(new_time_vector.at(index-1) +1)
                                                            + " [" + QString::number(time_vector.at(index-1)) + ", " + QString::number(time_vector.at(index)) + "] - [" + QString::number(new_time_vector.at(index-1)) + ", " + QString::number(new_time_vector.at(index)) + "]",WIMU::LogWarning);*/

                                        //timestamp = new_time_vector.at(index) - diff/2;
                                        /*if (sensor=="LOG")
                                            qDebug() << timestamp << diff << time_vector.at(index) << timestamp + diff << time_vector.at(index) + diff;*/

                                        if (isTimestampValid(timestamp + diff))
                                            timestamp += diff;
                                        else
                                            timestamp = time_vector.at(index) + diff; //+= diff; //new_time_vector.at(index) - diff; //- diff/2;


                                    }else{
                                        if (index>=0)
                                            timestamp = new_time_vector.at(index);
                                        else
                                            emit requestLogging(data_file + ": Correspondance temps non-corrigé->corrigé - début de série, non-corrigé pour: " + QString::number(timestamp)+".",WIMU::LogWarning);
                                    }

                                    /*timestamp = new_time_vector.at(time_vector.indexOf(*closest));
                                    last_ts_index = time_vector.indexOf(*closest);*/

                                }else{
                                   // qDebug() << timestamp << time_vector.last() << new_time_vector.last();
                                    if (!isTimestampValid(timestamp)){
                                        emit requestLogging(data_file + ": Correspondance temps non-corrigé->corrigé non-trouvé pour " + QString::number(timestamp)+". Échantillon non-corrigé.",WIMU::LogWarning);
                                    }else{
                                        //qDebug() << timestamp - time_vector.last();
                                        int t_diff = (int)timestamp - time_vector.last();
                                        timestamp = new_time_vector.last() + t_diff;
                                    }
                                }
                                //}
                            }

                    }
                }

                // Ensure time is correct in regard to the DST and timezone
                /*if (isTimestampValid(timestamp) && sensor!="GPS")
                    timestamp = adjustTimeForTimeZone(timestamp, false);*/

                // Check if timestamp is in the current date
                //if (current_day+1 < dates.count()){
                    if (timestamp > (dates.at(current_day)+86400) || timestamp < dates.at(current_day)){
                        qint8 last_day = current_day;
                        quint32 last_ts;
                        if (timestamps.count()>0)
                            last_ts = timestamps.last();
                        if (not_found_count==0){
                           /* if (reorder_ts){
                                reorder_ts = false;
                                correctBadTimestamps(timestamps);
                            }*/

                            // Write data so far
                            if (!writeTimeFile(path + "/PreProcess",sensor, current_day, timestamps, dates.at(current_day)))
                                return;

                            quint16 last_sample_size = data.size();

                            if (sensor=="LOG"){
                                last_sample_size+=2;
                            }

                            if (!writeDataFile(path + "/PreProcess",sensor, current_day, current_file.getFileName(), last_pos, current_file.getCurrentPos() - last_sample_size, dates.at(current_day)))
                                return;

                            // Clear variables
                            last_pos = current_file.getCurrentPos() - last_sample_size;
                            timestamps.clear();
                        }

                        // Get new day
                        current_day = fileDateMapping.key(QDateTime::fromSecsSinceEpoch(timestamp,Qt::UTC).date(),-1);

                        if (current_day<0){ // Not found.. this happens when we have "bad" timestamp, so try and correct it
                            not_found_count++;
                            if (timestamps.isEmpty()){
                                // Append last timestamp in order to have a "base"
                                timestamps.append(last_ts);
                            }

                            /*if (not_found_count>=120){
                                emit requestLogging("Erreur: données positionnées à un mauvais moment...",WIMU::LogWarning);
                                not_found_count=0;
                            }*/
                            current_day = last_day;

                        }else{
                            if (not_found_count>0){
                                // We are back on track... so correct timestamps and move on as this was indeed just a bad jump to the future
                                correctBadTimestamps(timestamps);
                                // Remove "first" timestamp, which was kept to correctly correct the timestamps
                                timestamps.takeFirst();
                                not_found_count = 0;
                            }
                        }
                    }
                //}

                // Add to global write list
                /*if (timestamps.count()>0 && timestamp < timestamps.last() && sensor!="GPS"){
                    // Catch out of order timestamp
                    reorder_ts = true;
                }else*/
                    timestamps.append(timestamp);


                // If GPS, saves samples for file writing...
                if (sensor=="GPS"){
                    samples.append(data);
                }
                data = current_file.readSample();
                QCoreApplication::processEvents();

            } // While data

            if (not_found_count>0){
                correctBadTimestamps(timestamps);
                // Remove "first" timestamp, which was kept to correctly correct the timestamps
                timestamps.takeFirst();
                not_found_count = 0;
            }
            // Write what we have so far
            if (!dates.isEmpty()){
               /* if (reorder_ts){
                    reorder_ts = false;
                    correctBadTimestamps(timestamps);

                }*/
                if (!writeTimeFile(path + "/PreProcess",sensor, current_day, timestamps, dates.at(current_day)))
                    return;
                if (!writeDataFile(path + "/PreProcess",sensor, current_day, current_file.getFileName(),last_pos,current_file.getCurrentPos(),dates.at(current_day)))
                    return;
            }

            if (sensor=="GPS"){
                QList<WIMU::GPSNavData_Struct> nav_data;
                foreach (data, samples){
                    wimu_data.fromBinaryFile(data,WIMU::MODULE_GPS);
                    if (wimu_data.getGPSMessageID()==41){
                        WIMU::GPSNavData_Struct nav = wimu_data.convertToGPSNavData();
                        if (nav.nav_type!=WIMU::GPSNAV_NOFIX){
                            if (nav.nav_datetime.isValid())
                                nav_data.append(nav);
                        }
                    }
                }
                if (!nav_data.isEmpty()){
                    writeGPSCSVFile(path + "/PreProcess",current_day,nav_data,dates.at(current_day));

                }
            }

            // Clear variables
            last_pos = 0;
            timestamps.clear();


            current_file.close();

            emit requestProgressUpdate(count,"");
            if (m_cancel)
                return;
            QCoreApplication::processEvents();

        } // for each data file


    }       
}

void WimuProcessor::combineDataSet(QString path, QStringList &folders){
    // Combine datas from each preprocess folders

    int i;
    QStringList sensors;
    QString sensor;


    /////////////////////////////////////////////////////////////
    // Step 1. Build date list
    /////////////////////////////////////////////////////////////
    QList<QDateTime>            dates;
    QList<quint32>              data_starts;    // Timestamp where data starts in that folder
    QList<quint32>              data_ends;      // Timestamp where data ends in that folder

    sortFolderList(folders);
    for (i=0; i<folders.count(); i++){
        QDir ppFolder(path + "/" + folders.at(i) + "/PreProcess");

        if (ppFolder.exists()){

            // Get sensor list
            QStringList s = getSensorList(path + "/" + folders.at(i) + "/PreProcess");
            QString sname;
            foreach (sname, s){
                if (!sensors.contains(sname))
                    sensors.append(sname);
            }

            // List files in that folder
            QStringList files = ppFolder.entryList(QStringList("TIME_POW_*.DAT"),QDir::Files);

            if (files.count()==0){
                // Try with acc data
                files = ppFolder.entryList(QStringList("TIME_ACC_*.DAT"),QDir::Files);
            }
            sortFolderList(files);

            if (files.count()>0){
                QFileInfo finfo(path + "/" + folders.at(i) + "/PreProcess/" + files.first());
               // qDebug() << QString (path + "/" + folders.at(i) + "/" + files.at(j)) << finfo.lastModified().date();
                //QDateTime last_mod = finfo.lastModified();
                //if (!dates.contains(last_mod) && last_mod.isValid()){
                    //dates.append(last_mod);
                //}
                // Read start time from that file
                QFile timefile(finfo.absoluteFilePath());

                if (!timefile.open(QIODevice::ReadOnly)){
                    emit requestLogging("Impossible d'ouvrir le fichier: " + timefile.fileName(),WIMU::LogError);
                    return;
                }
                QString ts = timefile.readLine();
                data_starts.append(ts.toULong());
                timefile.close();

                // Read end time from the last file in the folder
                timefile.setFileName(path + "/" + folders.at(i) + "/PreProcess/" + files.last());
                if (!timefile.open(QIODevice::ReadOnly)){
                    emit requestLogging("Impossible d'ouvrir le fichier: " + timefile.fileName(),WIMU::LogError);
                    return;
                }
                timefile.seek(timefile.size()-50);
                while (!timefile.atEnd()){
                    ts = timefile.readLine();
                }
                data_ends.append(ts.toULong());
                timefile.close();

                // Create dates for each date between start and end
                for (quint32 i=data_starts.last();i<data_ends.last(); i+=86400){
                    QDateTime data_date = QDateTime(QDateTime::fromSecsSinceEpoch(i,Qt::LocalTime).date());
                    //data_date = previousMidnight(data_date);
                    if (!dates.contains(data_date)){
                        //qDebug() << "Adding " << data_date;
                        dates.append(data_date);
                    }
                }
            }
        }
    }

    // Check if we have a least a valid date in the list (i.e. not one set in the 1970s)...
    bool hasValidDate = false;
    for (int i=0; i<dates.count(); i++){
        if (dates.at(i).date().year()>=2001){
            hasValidDate = true;
            break;
        }
    }

    if (!hasValidDate){
        emit requestLogging("Aucune date valide n'a été trouvée dans ces données.", WIMU::LogWarning);
        // Remove "1969" dates if present
        QList<quint16> to_remove;
        for (int i=0; i<dates.count(); i++){
            if (dates.at(i).date().year()<1970){
                to_remove.append(i);
            }
        }

        for (int i=0; i<to_remove.count(); i++){
            dates.removeAt(to_remove.at(i));
        }
        // "Upgrade" all dates to 2000 to prevent date errors
        for (int i=0; i<dates.count(); i++){
            dates[i] = dates.at(i).addYears(2000-dates.at(i).date().year());
        }
        //qDebug() << QDateTime::fromSecsSinceEpoch(946684800,Qt::LocalTime).toSecsSinceEpoch();
        for (int i=0; i<data_starts.count(); i++){
            data_starts[i] = data_starts[i] + 946684800; // 01-01-2000
        }
        for (int i=0; i<data_ends.count(); i++){
            data_ends[i] = data_ends[i] + 946684800; // 01-01-2000
        }
    }

    if (m_cancel)
        return;
    emit requestProgressUpdate(1,"");
    //qDebug() << dates << data_starts << data_ends;

    ///////////////////////////////////////////////////////////////
    // Step 2. Identify invalid dataset dates and propose solutions
    //////////////////////////////////////////////////////////////
    QList<quint8> corrected_indexes; // Contains index of folders that are corrected
    //QList<quint8> to_remove;
    for (i=0; i<data_starts.count(); i++){
        if (!isTimestampValid(data_starts.at(i))){
            corrected_indexes.append(i);
            // Try to "fix" days without timestamp at all
            int prev_valid = -1;
            int next_valid = -1;
            if (i>0){
                if (i+1<data_ends.count()){ // In the middle of the list
                    // Find previous valid folder
                    for (int j=i; j>=0; j--){
                        if (!corrected_indexes.contains(j))
                            if (isTimestampValid(data_ends.at(j))){
                                prev_valid = j;
                                break;
                            }
                    }

                    // Find next valid folder
                    for (int j=i+1; j<data_ends.count(); j++){
                        if (!corrected_indexes.contains(j))
                            if (isTimestampValid(data_ends.at(j))){
                                next_valid = j;
                                break;
                            }
                    }
                }else{ // Last folder in the list
                    // Find previous valid folder
                    for (int j=i; j>=0; j--){
                        if (!corrected_indexes.contains(j))
                            if (isTimestampValid(data_ends.at(j))){
                                prev_valid = j;
                                break;
                            }
                    }
                }
            }else{ // First folder in the list
                // Find next valid folder
                for (int j=i+1; j<data_ends.count(); j++){
                    if (!corrected_indexes.contains(j))
                        if (isTimestampValid(data_ends.at(j))){
                            next_valid = j;
                            break;
                    }
                }
            }

            ////////////////////////
            // Try to correct dates
            int current_len = data_ends.at(i) - data_starts.at(i);
            if (next_valid>=0 && prev_valid>=0){ // Both are valid
                // Difference (in days)
                int diff = (data_starts.at(next_valid) - data_ends.at(prev_valid)) / 86400;//dates.at(next_valid).date().day() - dates.at(prev_valid).date().day();

                if (diff==2){ // We only have a missing day - assume the data will fit there
                    data_starts[i] = previousMidnight(data_starts.at(next_valid)) - 86400;//dates.at(next_valid).addDays(-1).toTime_t();
                    data_ends[i] = data_starts.at(i) + current_len;
                    emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Insertion simple)",WIMU::LogWarning );
                }else{
                    int len1 = data_ends.at(prev_valid) - data_starts.at(prev_valid);
                    int len2 = data_ends.at(next_valid) - data_starts.at(next_valid);

                    if (diff==0){ // No missing day in between - try to fit the dataset in
                        int avail = 86400 - len1 - len2; // Available time in that day
                        data_starts[i] = data_ends[prev_valid] + (avail - current_len)/2;
                        data_ends[i] = data_starts[next_valid] - (avail - current_len)/2;
                        emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Insertion même journée)",WIMU::LogWarning );

                    }else{
                        if (diff==1){ // Only one day difference - try to fit with the smallest dataset
                            if (len1>len2){
                                data_starts[i] = data_starts[next_valid] -current_len - 5; // Suppose a 5 seconds delay from last time
                                data_ends[i] = data_starts.at(i) + current_len;
                                emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Insertion journée suivante)",WIMU::LogWarning );
                            }else{
                                data_starts[i] = data_ends[prev_valid] + 5;
                                data_ends[i] = data_starts.at(i) + current_len;
                                emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Insertion journée précédente)",WIMU::LogWarning );
                            }
                        }else{ // More than one day - put it right in the middle!
                            data_starts[i] = previousMidnight(data_ends.at(prev_valid)) + (diff/2)*86400;//dates.at(prev_valid).addDays(diff/2).toTime_t();
                            data_ends[i] = data_starts.at(i) + current_len;
                            emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Insertion au milieu du trou)",WIMU::LogWarning );
                        }

                    }
                }
            }else{
                if (next_valid>=0 && prev_valid>=0){ // No next valid time - use previous valid
                    data_starts[i] = previousMidnight(data_ends[prev_valid]) + 86400; //dates.at(prev_valid).addDays(1).toTime_t();
                    data_ends[i] = data_starts.at(i) + current_len;
                    emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Ajout après journée précédente)",WIMU::LogWarning );
                }else{
                    if (prev_valid>=0){
                        data_starts[i] = previousMidnight(data_starts[prev_valid]) -86400; //dates.at(next_valid).addDays(-1).toTime_t();
                        data_ends[i] = data_starts.at(i) + current_len;
                        emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Ajout avant journée suivante)",WIMU::LogWarning );
                    }else{
                        if (next_valid>=0){
                            data_starts[i] = previousMidnight(data_starts[next_valid]) - (next_valid-i) * 86400;
                            data_ends[i] = data_starts.at(i) + current_len;
                            emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_ends.at(i)).toString("dd-MM-yyyy") + " (Ajout au début des données)",WIMU::LogWarning );
                        }else{
                            // No valid time at all!!
                            emit requestLogging("Impossible d'estimer la date de " + path + "/" + folders.at(i) + ": Aucune donnée valide - ajout suite aux autres données.",WIMU::LogWarning );
                            if (i>0){
                                data_starts[i] = data_ends[i-1]+1;
                                data_ends[i] = data_starts.at(i) + current_len;
                            }
                        }
                    }
                }
            }

            // Update date in list, if needed...
            QDateTime new_date = QDateTime(QDateTime::fromSecsSinceEpoch(data_ends[i], Qt::UTC).date());
            /*qDebug() << dates;
            qDebug() << new_date;*/
            if (!dates.contains(new_date)){
                //dates[i] = new_date;
                //qDebug() << "Modified " << dates.at(i);
                dates.append(new_date);
            }/*else{
                if (i<dates.count())
                    dates[i] = new_date;
                else
                    dates.append(new_date);
                //to_remove.append(i); // Mark for removal
                //qDebug() << "Already there: " << new_date;
            }*/

            QCoreApplication::processEvents();
            if (m_cancel)
                return;
        }
    }

    emit requestProgressUpdate(2,"");

    ///////////////////////////////////////////////////////////////
    // Step 3. Reprocess invalid timestamps
    ///////////////////////////////////////////////////////////////
    quint8 index;
    foreach(index,corrected_indexes){
        // Build sensor list
        QStringList sensors2 = getSensorList(path + "/" + folders.at(index) + "/PreProcess");
        // For each sensor
        foreach (sensor, sensors2){
            /*if (sensor=="GPS") // Don't touch GPS time!
                continue;*/

            // Get list of files
            QDir ppFolder(path + "/" + folders.at(index) + "/PreProcess");
            QStringList files = ppFolder.entryList(QStringList("TIME_" + sensor + "_*.DAT"),QDir::Files);

            // Read each file
            QList<quint32> ts;
            quint32 base_ts = data_starts[index];
            QList<quint32> files_ts;

            for (i=0; i<files.count(); i++){
                if (readTimeFile(ppFolder.path(),sensor,i,ts)){
                    // Refactor timestamp
                    for (int j=0; j<ts.count(); j++){
                        ts[j] = ts.at(j) + base_ts;
                    }
                    // Save new files
                    quint32 file_ts;
                    if (ts.count()>0){
                        file_ts = previousMidnight(ts.first());
                        writeTimeFile(ppFolder.path(),sensor,i,ts,file_ts,true);
                    }else{
                        file_ts = previousMidnight(base_ts + i*86400);
                        setFileModificationTime(ppFolder.path() + "/" + files.at(i),file_ts);
                    }

                    files_ts.append(file_ts);

                }else{
                    emit requestLogging("Impossible d'ouvrir le fichier temps du capteur " + sensor + " dans " + ppFolder.path(),WIMU::LogError);
                    return;
                }

            }

            // Set modification time for all files
            files = ppFolder.entryList(QStringList(sensor + "_*.DAT"),QDir::Files);

            base_ts = data_starts[index];
            for (i=0; i<files.count(); i++){
                setFileModificationTime(ppFolder.path() + "/" + files.at(i), files_ts.at(i));
                //setFileModificationTime(ppFolder.path() + "/" + files.at(i), previousMidnight(base_ts));
                //base_ts += 86400;
            }

            // Set modification time for GPS files
            if (sensor == "GPS"){
                files = ppFolder.entryList(QStringList("GPS_*.CSV"),QDir::Files);
                base_ts = data_starts[index];
                for (i=0; i<files.count(); i++){
                    setFileModificationTime(ppFolder.path() + "/" + files.at(i), files_ts.at(i));
                }
            }

            ts.clear();

            if (m_cancel)
                return;
            QCoreApplication::processEvents();

        }//sensor
    }

    emit requestProgressUpdate(3,"");

    /////////////////////////////////////////////////////////////
    // Step 4. Create output folder
    /////////////////////////////////////////////////////////////
    QDir folder(path);

    // Create PreProcess folder
    if (folder.exists(folder.path()+"/PreProcess")){
        // Remove it!
        folder.setPath(folder.path()+"/PreProcess");
        folder.removeRecursively();
        folder.setPath(path);
    }
    if (!folder.mkdir("PreProcess")){
        emit requestLogging("Impossible de créer le répertoire: " + path + "/PreProcess",WIMU::LogError);
        return;
    }

    emit requestProgressUpdate(4,"");

    ///////////////////////////////////////////////////////////////
    // Step 5. Combine files and merge into same folder
    ///////////////////////////////////////////////////////////////

    // Create empty files for each dates and sensors
    QMap<qint16, QDate> fileDateMapping;
    quint8 count = 0;

    // Create ordered list of dates without any holes
    QList<QDateTime> dates2;
    for (i=0; i<dates.count(); i++){
        //qDebug() << dates.at(i);
        if (!dates2.contains(dates.at(i)) && isTimestampValid(dates.at(i).toSecsSinceEpoch())){
            dates2.append(dates.at(i));
        }
    }

    if (dates2.isEmpty()){
        // No valid timestamp - copy originals ones
        dates2 = dates;
    }

    // Sort date list in case dates are mixed up
    std::sort(dates2.begin(),dates2.end());
    //qDebug() << dates2;

    // Check if we need to insert dates to complete the series
    QList<QDateTime> dates3;
    dates3.append(dates2.first());
    for (i=1; i<dates2.count(); i++){
        for (int j=1; j<dates2.at(i-1).daysTo(dates2.at(i)); j++){
            dates3.append(dates2.at(i-1).addDays(j));
        }
        dates3.append(dates2.at(i));
    }

   //qDebug() << dates3;
    dates2=dates3;
    dates3.clear();

    for (i=0; i<dates2.count(); i++){
       /* if (to_remove.contains(i))
            continue;*/

        QDateTime current_date = dates2.at(i);//dates.first().addDays(i);
        if (!fileDateMapping.values().contains(current_date.date())){
            foreach(sensor,sensors){
                // TIME file
                if (!writeTimeFile(path + "/PreProcess",sensor, count, QList<quint32>(), previousMidnight(current_date.toTime_t())))
                    return;

                // DATA file
                if (!writeDataFile(path + "/PreProcess",sensor, count, NULL, 0,0, previousMidnight(current_date.toTime_t())))
                    return;

                // GPS CSV files
                if (sensor=="GPS"){
                    if (!writeGPSHeaderFile(path + "/PreProcess",count,previousMidnight(current_date.toTime_t())))
                        return;
                }


            }
            fileDateMapping.insert(count,current_date.date());
            count++;
        }
    }

    // Browse each folder and append to correct file
    for (i=0; i<folders.count(); i++){
        QDir ppFolder(path + "/" + folders.at(i) + "/PreProcess");


        if (ppFolder.exists()){
            QStringList sensors2 = getSensorList(ppFolder.absolutePath());

            foreach(sensor,sensors2){
                emit requestProgressUpdate(4,"Traitement - " + ppFolder.absolutePath() + "/" + sensor);
                // Time
                QStringList files = ppFolder.entryList(QStringList("TIME_" + sensor + "_*.DAT"),QDir::Files);
                sortFolderList(files);
                QFileInfo finfo;
                QDate last_mod;
                for (int j=0; j<files.count(); j++){
                    finfo.setFile(path + "/" + folders.at(i) + "/PreProcess/" + files.at(j));
                    last_mod = finfo.lastModified().date();

                    QList<quint32> ts;
                    qint16 day_id = fileDateMapping.key(last_mod,-1);

                    //qDebug() << finfo.filePath() << last_mod << day_id;
                    if (day_id>=0){
                        if (readTimeFile(ppFolder.path(),sensor,j,ts)){
                            writeTimeFile(path + "/PreProcess",sensor,day_id,ts,previousMidnight(finfo.lastModified().toTime_t()));
                        }
                    }else{
                        qDebug() << "*** Day not found??! " << last_mod;
                    }
                    QCoreApplication::processEvents();
                }

                // Data
                files = ppFolder.entryList(QStringList(sensor + "_*.DAT"),QDir::Files);
                sortFolderList(files);
                for (int j=0; j<files.count(); j++){
                    finfo.setFile(path + "/" + folders.at(i) + "/PreProcess/" + files.at(j));
                    last_mod = finfo.lastModified().date();
                    qint16 day_id = fileDateMapping.key(last_mod,-1);
                   // qDebug() << finfo.filePath() << last_mod << day_id;
                    //QFile src_file(finfo.filePath());
                    if (day_id>=0){
                        writeDataFile(path + "/PreProcess",sensor,day_id,finfo.filePath(),0,0,previousMidnight(finfo.lastModified().toTime_t()));
                    }
                }

                // GPS CSV
                if (sensor=="GPS"){
                    files = ppFolder.entryList(QStringList("GPS_*.CSV"),QDir::Files);
                    sortFolderList(files);
                    for (int j=0; j<files.count(); j++){
                        finfo.setFile(path + "/" + folders.at(i) + "/PreProcess/" + files.at(j));
                        last_mod = finfo.lastModified().date();
                        qint16 day_id = fileDateMapping.key(last_mod,-1);
                        if (day_id>=0){
                            copyFile(finfo.filePath(), path + "/PreProcess/GPS_" + QString::number(day_id) + ".CSV",previousMidnight(finfo.lastModified().toTime_t()));
                        }
                    }
                }

                if (m_cancel)
                    return;
                QCoreApplication::processEvents();
            }
        }
    }

    emit requestProgressUpdate(5,"");
    ///////////////////////////////////////////////////////////////
    // Step 6. Delete each PreProcess subfolders (now rendered useless)
    ///////////////////////////////////////////////////////////////
    for (i=0; i<folders.count(); i++){
        QDir ppFolder(path + "/" + folders.at(i) + "/PreProcess");
        ppFolder.removeRecursively();
    }

    ///////////////////////////////////////////////////////////////
    // Step 7. Output estimated days in file
    ///////////////////////////////////////////////////////////////
    if (corrected_indexes.count() > 0){
        // Convert corrected indexes from "folder" to "date"
        QList<quint8> corrected_days;
        for (int i=0; i<corrected_indexes.count(); i++){
            quint8 new_index = fileDateMapping.key(previousMidnight(QDateTime::fromSecsSinceEpoch(data_starts.at(corrected_indexes.at(i)))).date());
            //if (!corrected_days.contains(new_index))
                corrected_days.append(new_index);
        }


        QFile est_file(path + "/PreProcess/corrected.txt");
        if (!est_file.open(QIODevice::WriteOnly)){
            emit requestLogging("Impossible de créer le fichier avec les jours estimés",WIMU::LogError);
            return;
        }

        QTextStream stream(&est_file);
        for (int i=0; i<corrected_days.count(); i++){
            stream << QString::number(corrected_days.at(i)) << "\n";// << "," << data_starts[corrected_indexes.at(i)] << "," << data_ends[corrected_indexes.at(i)] << "\n";
        }
        est_file.close();


        for (int i=0; i<corrected_indexes.count(); i++){
            quint8 log_id = corrected_days.at(i);
            /*if (to_remove.contains(corrected_indexes.at(i))){
                // We are on a day that is already present somewhere... find correct log
                //qDebug() << dates.at(corrected_indexes.at(i));
                for (int j=0; j<dates.count(); j++){
                    //qDebug() << dates.at(j).date();
                    if (j!=corrected_indexes.at(i) && dates.at(j).date()==dates.at(corrected_indexes.at(i)).date()){
                        log_id = j;
                        break;
                    }
                }
            }*/


            QByteArray raw;
            QDataStream datastream(&raw, QIODevice::ReadWrite);
            datastream.setByteOrder(QDataStream::LittleEndian);
           /* if (!isTimestampValid(data_starts[corrected_indexes.at(i)]) || !isTimestampValid(data_ends[corrected_indexes.at(i)])){
                continue;
            }*/
            // Add entries into log for those days
            est_file.setFileName(path + "/PreProcess/LOG_" + QString::number(log_id) + ".DAT");
            if (!est_file.open(QIODevice::Append)){
                emit requestLogging("Impossible d'ajouter les jours estimés au journal",WIMU::LogError);
                return;
            }

            raw.clear();
            datastream << data_starts[corrected_indexes.at(i)];
            //qDebug() << data_starts;
            if (m_settings->version_major >2 && m_settings->version_minor >1){

                // WIMU v3 adds human readable timestamp
                datastream << QString("," + QString::number(data_starts[corrected_indexes.at(i)]) + ",").toUtf8();

                // Remove string length, as not in the log file format
                raw = raw.mid(0,5) + raw.right(raw.length()-9);
            }

            QString logtext = QString("WIMUStudio: Corrected StartTime\n");
            datastream << logtext.toUtf8();
            raw = raw.left(4) + raw.right(logtext.length());

            est_file.write(raw);
            raw.clear();
            QDataStream datastream2 (&raw, QIODevice::ReadWrite);
            datastream2.setByteOrder(QDataStream::LittleEndian);

            datastream2 << data_ends[corrected_indexes.at(i)];
            if (m_settings->version_major >2 && m_settings->version_minor >1){
                // WIMU v3 adds human readable timestamp
                datastream2 << QString("," + QString::number(data_ends[corrected_indexes.at(i)]) + ",").toUtf8();
                // Remove string length, as not in the log file format
                raw = raw.mid(0,5) + raw.right(raw.length()-9);
            }
            logtext = QString("WIMUStudio: Corrected EndTime\n");
            datastream2 << logtext.toUtf8();
            raw = raw.left(4) + raw.right(logtext.length());

            est_file.write(raw);
            est_file.close();

            // Ensure log file doesn't lose its original modified date
            setFileModificationTime(est_file.fileName(), QDateTime(fileDateMapping.value(log_id)).toSecsSinceEpoch());
        }

        // Remove dates marked for removal

        /*for (int i=0; i<to_remove.count(); i++){
            dates.removeAt(to_remove.at(i));
            data_starts.removeAt(to_remove.at(i));
            data_ends.removeAt(to_remove.at(i));
        }*/
    }



    ///////////////////////////////////////////////////////////////
    // Step 8. Merge all log files, if present
    ///////////////////////////////////////////////////////////////
    if (sensors.contains("LOG")){
        QDir ppFolder(path + "/PreProcess");
        QStringList files = ppFolder.entryList(QStringList("LOG_*.DAT"),QDir::Files);

        sortFolderList(files);
        for (i=0; i<files.count(); i++){
            writeDataFile(path + "/PreProcess","LOG",-1,path + "/PreProcess/" + files.at(i),0,-1,QDateTime::currentSecsSinceEpoch());
        }

        files = ppFolder.entryList(QStringList("TIME_LOG_*.DAT"),QDir::Files);
        sortFolderList(files);
        for (i=0; i<files.count(); i++){
            writeDataFile(path + "/PreProcess","TIME_LOG",-1,path + "/PreProcess/" + files.at(i),0,-1,QDateTime::currentSecsSinceEpoch());
        }
        //path + "/PreProcess"
    }

    ///////////////////////////////////////////////////////////////
    // Step 9. Find minimum and maximum time for each day
    ///////////////////////////////////////////////////////////////
    for (i=0; i<fileDateMapping.count(); i++){
        quint32 min_ts=std::numeric_limits<quint32>::max();
        quint32 max_ts=0;
        quint32 ts;
        QByteArray sample;
        foreach(sensor, sensors){

            QFile data_file(path + "/PreProcess/TIME_" + sensor + "_" + QString::number(i) + ".DAT");
            if (!data_file.open(QIODevice::ReadOnly)){
                emit requestLogging("Impossible de lire le fichier " + data_file.fileName(),WIMU::LogError);
                return;
            }

            if (data_file.size()>0){
                if (sensor!="LOG"){
                    // Read first line
                    sample = data_file.readLine();
                    sample = sample.left(sample.size()-1);
                    ts = sample.toUInt();
                    if (ts < min_ts)
                        min_ts = ts;
                    if (ts > max_ts)
                        max_ts = ts;

                    // Read last line
                    data_file.seek(data_file.size()-sample.size()-1); // Move to end
                    sample = data_file.readLine();
                    sample = sample.left(sample.size()-1);
                    ts = sample.toUInt();
                    if (ts < min_ts)
                        min_ts = ts;
                    if (ts > max_ts)
                        max_ts = ts;
                }else{
                    // Log files may not be in order because of correction... so need to read them all!
                    while(!data_file.atEnd()){
                        sample = data_file.readLine();
                        sample = sample.left(sample.size()-1);
                        ts = sample.toUInt();
                        if (ts < min_ts)
                            min_ts = ts;
                        if (ts > max_ts)
                            max_ts = ts;
                    }
                }
            }
            data_file.close();
        }

        // Save min and max for that day, based on all sensors logs
        if (min_ts == std::numeric_limits<quint32>::max())
            min_ts = 0;

        QFile out_file(path + "/PreProcess/TIMES.DAT");
        if (!out_file.open(QIODevice::Append)){
            emit requestLogging("Impossible d'ouvrir le fichier des temps par jour.",WIMU::LogError);
            return;
        }

        QTextStream out_stream(&out_file);
        out_stream << QString::number(i) << "," << QString::number(min_ts) << "," << QString::number(max_ts) << "\n";
        out_file.close();
    }

    emit requestProgressUpdate(6,"");
}

bool WimuProcessor::isTimestampValid(const quint64 &ts){
    return (ts > 1262304000) && // After 01/01/2010
           (ts < (quint64)(QDateTime::currentMSecsSinceEpoch()/1000)); // Before "now"
}

void WimuProcessor::setFileModificationTime(const QString &filename, quint32 ts){
    struct _utimbuf ut;
    QDateTime filetime;
    qint64 file_ts;

    filetime = QDateTime::fromSecsSinceEpoch(ts,Qt::TimeZone);
    filetime = filetime.addSecs(-filetime.offsetFromUtc());
    file_ts = filetime.toSecsSinceEpoch();
    //qDebug() << "** Time = " << file_ts << filetime;
    //filetime = filetime.addSecs(-7200); //TODO: Understand why we need to do this....

    int diff = file_ts % 86400;
    if (diff !=0){
        // Try to round the time to nearest day
        if (diff >= 70000){
            file_ts += (86400 - diff);
        }else{
            file_ts -= diff;
        }
        file_ts -= filetime.offsetFromUtc();
    }

    //qDebug() << "** New Time = " << file_ts << QDateTime::fromSecsSinceEpoch(file_ts);

    ut.modtime = file_ts;
    ut.actime = file_ts;

    _utime( filename.toUtf8().data(), &ut );
}

quint32 WimuProcessor::adjustTimeForTimeZone(quint32 ts, bool ignore_wimu_offset){
    // Correctly adjust time according to timezone and DST

    // TODO: Use zone where data was collected instead of local zone
    qint32 wimu_offset = 0;

    if (!ignore_wimu_offset){
        wimu_offset = -m_config->datetime.time_offset*3600;
        if (m_settings->hw_id<=2){
            ts = ts + wimu_offset;
        }
    }

    return ts + QDateTime::fromSecsSinceEpoch(ts - wimu_offset,Qt::UTC).toLocalTime().offsetFromUtc();

}
/*
quint32 WimuProcessor::adjustTimeFromTimeZone(const quint32 &ts){
    // Correctly adjust time from timezone and ds

    // TODO: Use zone where data was collected instead of local zone
    qint32 wimu_offset = m_config->datetime.time_offset*3600;

    return ts + QDateTime::fromTime_t(ts - wimu_offset,Qt::UTC).toLocalTime().offsetFromUtc();

}*/

bool WimuProcessor::writeTimeFile(QString path, QString sensor, qint16 day, const QList<quint32> &times, const quint32 &mod_ts, bool overwrite){
    // Write a time data file
    QFile time_file;
    QIODevice::OpenMode flags;

    time_file.setFileName(path + "/TIME_" + sensor + "_" + QString::number(day) + ".DAT");

    // Check if we need to write at the start of the file or at the end (in order to keep correct timestamp order)
    /*bool writeFirst = false;
    flags = QIODevice::ReadOnly;
    if (time_file.open(flags)){
        QString firstLine = time_file.readLine();
        if (firstLine.toUInt() > times.first()){
            writeFirst = true;
        }
        time_file.close();
        if (writeFirst){
            // Make a backup copy of the file
            time_file.rename(path + "/TIME_" + sensor + "_" + QString::number(day) + ".BAK");
        }
    }*/



    flags = QIODevice::WriteOnly;
    if (!overwrite/* && !writeFirst*/)
        flags = QIODevice::Append;

    if (!time_file.open(flags)){
        emit requestLogging("Impossible de créer le fichier: " + time_file.fileName(),WIMU::LogError);
        return false;
    }

    QTextStream stream(&time_file);
    for (int i=0; i<times.count(); i++){
        stream << QString::number(times.at(i)) << "\n";
    }
    time_file.close();

    quint32 modif = mod_ts;
    if (!isTimestampValid(mod_ts))
         modif = adjustTimeForTimeZone(mod_ts, sensor=="GPS");

    /*if (writeFirst){
        // Append "old" data
        copyFile(path + "/TIME_" + sensor + "_" + QString::number(day) + ".BAK",
                 path + "/TIME_" + sensor + "_" + QString::number(day) + ".DAT",
                 modif);
    }*/


    setFileModificationTime(time_file.fileName(), modif);

    return true;
}

bool WimuProcessor::readTimeFile(QString path, QString sensor, qint16 day, QList<quint32> &times){
    // Read a time data file
    QFile time_file;

    time_file.setFileName(path + "/TIME_" + sensor + "_" + QString::number(day) + ".DAT");
    QIODevice::OpenMode flags = QIODevice::ReadOnly;

    if (!time_file.open(flags)){
        emit requestLogging("Impossible d'ouvrir le fichier: " + time_file.fileName(),WIMU::LogError);
        return false;
    }

    QString ts;
    times.clear();
    while (!time_file.atEnd()){
        ts = time_file.readLine();
        times.append(ts.toULong());
    }
    time_file.close();
    return true;
}

bool WimuProcessor::writeDataFile(QString path, QString sensor, qint16 day, QString src_filename, const qint64 start_pos, const qint64 end_pos, const quint32 &mod_ts){

    // Copy data from one file to another one
    QFile data_file;
    QFile src(src_filename);

    if (day>=0){
        data_file.setFileName(path + "/" + sensor + "_" + QString::number(day) + ".DAT");
    }else{
        // No day
        data_file.setFileName(path + "/" + sensor + ".DAT");
    }
    if (!data_file.open(/*QIODevice::WriteOnly |*/ QIODevice::Append)){
        emit requestLogging("Impossible de créer le fichier: " + data_file.fileName(),WIMU::LogError);
        return false;
    }

    // If a valid source file
    if (!src_filename.isEmpty()){
        // Open source file

        if (!(src.open(QIODevice::ReadOnly))){
            emit requestLogging("Impossible d'ouvrir le fichier: " + src_filename,WIMU::LogError);
            data_file.close();
            return false;
        }


        // Move cursor to file start
        src.seek(start_pos);

        // If end_pos = 0, we must read to end of file

        // Read chunk into memory
        QByteArray data;
        if (end_pos<=0)
            data = src.readAll();
        else
            data = src.read(end_pos-start_pos);

        if (!data.isEmpty()){
            data_file.write(data);
        }
        src.close();

    }
    data_file.close();

    quint32 modif = mod_ts;
    if (!isTimestampValid(mod_ts))
         modif = adjustTimeForTimeZone(mod_ts, sensor=="GPS");

    setFileModificationTime(data_file.fileName(), modif);

    return true;
}

bool WimuProcessor::copyFile(QString src, QString dst, const quint32 &mod_ts){
    // Copy data from one file to another one
    QFile dst_file(dst);
    QFile src_file(src);

    if (!dst_file.open(/*QIODevice::WriteOnly |*/ QIODevice::Append)){
        emit requestLogging("Impossible de créer le fichier: " + dst_file.fileName(),WIMU::LogError);
        return false;
    }

    // Open source file
    if (!(src_file.open(QIODevice::ReadOnly))){
        emit requestLogging("Impossible d'ouvrir le fichier: " + src,WIMU::LogError);
        dst_file.close();
        return false;
    }

    // Skip first line
    QByteArray data = src_file.readLine();
    data = src_file.readAll();

    if (!data.isEmpty()){
        dst_file.write(data);
    }
    src_file.close();
    dst_file.close();

    quint32 modif = mod_ts;
    if (!isTimestampValid(mod_ts))
         modif = adjustTimeForTimeZone(mod_ts,true);

    setFileModificationTime(dst_file.fileName(), modif);

    return true;
}

bool WimuProcessor::writeGPSHeaderFile(QString path, qint16 day,const quint32 &mod_ts){
    QFile data_file;

    if (day>=0){
        data_file.setFileName(path + "/GPS_" + QString::number(day) + ".CSV");
    }else{
        // No day
        data_file.setFileName(path + "/GPS.CSV");
    }
    if (!data_file.open(QIODevice::WriteOnly)){
        emit requestLogging("Impossible de créer le fichier: " + data_file.fileName(),WIMU::LogError);
        return false;
    }

    QTextStream stream(&data_file);
    stream << "Date,Time,Latitude,Longitude,Altitude,Speed,Course,Precision,Fix,Datatype\n";

    data_file.close();

    quint32 modif = mod_ts;
    if (!isTimestampValid(mod_ts))
         modif = adjustTimeForTimeZone(mod_ts,true);

    setFileModificationTime(data_file.fileName(), modif);
    return true;
}

bool WimuProcessor::writeGPSCSVFile(QString path, qint16 day, QList<WIMU::GPSNavData_Struct> &gps_data, const quint32 &mod_ts){
    QFile data_file;

    if (day>=0){
        data_file.setFileName(path + "/GPS_" + QString::number(day) + ".CSV");
    }else{
        // No day
        data_file.setFileName(path + "/GPS.CSV");
    }

    if (!data_file.open( QIODevice::Append)){
        emit requestLogging("Impossible de créer le fichier: " + data_file.fileName(),WIMU::LogError);
        return false;
    }

    QTextStream stream(&data_file);

    foreach(WIMU::GPSNavData_Struct gps, gps_data){
        if (gps.nav_datetime.isValid() && (gps.latitude != 0 && gps.longitude!=0)){
            // Date
            stream << gps.nav_datetime.toLocalTime().date().toString("yyyy/MM/dd") << ",";
            // Time
            stream << gps.nav_datetime.toLocalTime().time().toString("HH:mm:ss") << ",";
            // Latitude
            stream << QString::number(gps.latitude) << ",";
            // Longitude
            stream << QString::number(gps.longitude) << ",";
            // Altitude
            stream << QString::number(gps.altitude) << ",";
            //Speed
            stream << QString::number(gps.speed) << ",";
            // Course
            stream << QString::number(gps.orientation) << ",";
            // Precision
            stream << QString::number(gps.horizontal_precision) << ",";
            // Fix Type
            stream << QString::number(gps.nav_type) << ",";
            // Data type - always "1" with WIMU
            stream << "1\n";
        }
    }

    data_file.close();
    quint32 modif = mod_ts;
    if (!isTimestampValid(mod_ts))
         modif = adjustTimeForTimeZone(mod_ts,true);

    setFileModificationTime(data_file.fileName(), modif);
    return true;
}


QStringList WimuProcessor::getSensorList(const QString &path){
    QStringList file_prefixes;

    QDir folder(path);

    if (!folder.exists())
        return file_prefixes;

    QStringList files = folder.entryList(QStringList("???_*.DAT"),QDir::Files);

    // Sort file list
    sortFolderList(files);

    QString data_file;
    foreach (data_file,files){
        QStringList prefix = data_file.split("_");
        if (prefix.count()>0){
            if (!file_prefixes.contains(prefix.at(0))){
                file_prefixes.append(prefix.at(0));
            }
        }
    }

    return file_prefixes;

}

QDateTime WimuProcessor::previousMidnight(const QDateTime& time){
   return QDateTime::fromTime_t((time.toTime_t() / 86400) * 86400);
}

quint32 WimuProcessor::previousMidnight(const quint32 &time){
    return (time / 86400) * 86400;
}

quint32 WimuProcessor::getFilesNumInFolder(QString path, QString filter){
    quint32 count = 0;
    QDir base_dir(path);

    if (path.contains("Process",Qt::CaseInsensitive))
        return count;

    // Count direct files
    count += base_dir.entryList(QStringList(filter),QDir::Files).count();

    // Count files in each subfolders
    QStringList folders = base_dir.entryList(QDir::AllDirs | QDir::NoDotAndDotDot);
    for (int i=0; i<folders.count(); i++){
        count += getFilesNumInFolder(path + "/" + folders.at(i),filter);
    }

    return count;


}

void WimuProcessor::cancelRequested(){
    emit requestLogging("Opération annulée par l'utilisateur",WIMU::LogError);
    m_cancel = true;
}

void WimuProcessor::correctBadTimestamps(QList<quint32> &timestamps){
    emit requestLogging("Correction de données mal positionnées temporellement",WIMU::LogWarning);
    // Try to correct timestamps that have a "jump" in the future...
    for (int i=0; i<timestamps.count()-2; i++){
        if ((qint64)timestamps.at(i+1)-(qint64)timestamps.at(i)<0){
            // We have a descending timestamp value... find the moment it shifted
            int start_pos = -1;
            for (int j=qMax(i-120,0); j<qMin(timestamps.count()-1, i-1); j++){
                if ((timestamps.at(j+1) - timestamps.at(j))>10000){
                    // We found our start position... correct timestamps from there
                    start_pos = j+1;
                    break;

                }
            }
            if (start_pos >=0){

                QList<quint16> diff;
                for (int j=start_pos; j<qMin(timestamps.count(), i); j++){
                    diff.append(timestamps.at(j) - timestamps.at(j-1));
                }
                //timestamps[start_pos] = timestamps[start_pos-1] +1; // Correct first sample, suppose 1 seconds
                diff[0] = 1;
                for (int j=start_pos; j<qMin(timestamps.count(), i); j++){
                    timestamps[j] = timestamps[j-1] + diff.at(j-start_pos);
                }
            }else{
                // Check if we have another case of bad timestamp - a jump in the past, and then back in the future...
                start_pos = -1;
                for (int j=i+1; j<timestamps.count()-1; j++){
                    if ((timestamps.at(j+1) - timestamps.at(j))>2){
                        // We found our start position... correct timestamps from there
                        start_pos = j+1;
                        break;
                    }
                }
                if (start_pos>=0){

                   /* for (int j=i-10; j<start_pos+10; j++)
                        qDebug() << timestamps.at(j);*/

                    QList<quint16> diff;
                    for (int j=i+1; j<start_pos; j++){

                        diff.append(timestamps.at(j) - timestamps.at(j-1));
                    }
                    diff[0] = 1;
                    for (int j=0; j<diff.count(); j++){
                        timestamps[i+j+1] = timestamps[i+j] + diff.at(j);

                    }

                    /*for (int j=i-10; j<start_pos+10; j++)
                        qDebug() << timestamps.at(j);*/
                }
            }
        }
    }
}
