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
    //emit requestLogging("Combinaison et nettoyage final des données...",WIMU::LogInfo);
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
    // Step 1. Build a time mapping
    /////////////////////////////////////////////////////////////
    QList<quint32> time_vector;

    if (m_settings->hw_id != 3 && m_settings->hw_id != 2){
        emit requestLogging("Version matérielle du WIMU non-supportée: HW v." + QString::number(m_settings->hw_id),WIMU::LogError);
        return;
    }

    QDir    folder(path);
    QString data_file;
    WIMU::Modules_ID time_src = WIMU::MODULE_POWER;

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

    foreach (data_file,files){
        WIMUFile file(path + "/" + data_file, time_src, *m_settings, *m_config);

        if (!file.load()){
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
    // Step 2. Identify the first valid timestamp, if any
    /////////////////////////////////////////////////////////////
    //quint64 timestamp;
    int valid_ts_index = -1;

    if (!time_vector.isEmpty() && isTimestampValid(time_vector.last())){
        valid_ts_index = time_vector.count()-1;
    }else{
        for (int i=time_vector.count()-1; i>=0; i--){
        //for (int i=0; i<time_vector.count(); i++){
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
    // Step 3. Build conversion matrix to apply to all timestamps
    /////////////////////////////////////////////////////////////
    int current_diff = 1;
    int prev_diff;

    QList<quint32> new_time_vector = time_vector;
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
    // Step 4. Create days mapping
    /////////////////////////////////////////////////////////////
    QList<quint32> dates;

    if (new_time_vector.count()>0){
        quint32 next_day = previousMidnight(adjustTimeForTimeZone(new_time_vector.at(0)));
        //dates.append(next_day); // Current day
        //next_day += 86400;
        quint32 last_day = previousMidnight(adjustTimeForTimeZone(new_time_vector.last()));
       // qDebug() << new_time_vector.first() << new_time_vector.last();
        /*if (last_day != next_day)
            last_day += 86400;*/

        dates.append(next_day); // Always a first date

        for (quint32 i=next_day+86400; i<=last_day; i+= 86400){
            dates.append(i);
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

    /////////////////////////////////////////////////////////////
    // Step 5. Build sensor list from prefixes
    /////////////////////////////////////////////////////////////
    QStringList file_prefixes = getSensorList(folder.path());
    file_prefixes.append("LOG"); // Add log file as sensors prefix

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


    //folder.setPath(path + "/PreProcess");
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
        quint8 current_day = 0;

        // Create list of files for that sensor
        QDir sensor_files(folder.path());
        if (sensor != "LOG"){
            files = sensor_files.entryList(QStringList(sensor+"_*.DAT"),QDir::Files);
            sortFolderList(files);
        }else
            files = sensor_files.entryList(QStringList(sensor+".DAT"),QDir::Files);

        //quint32 base_timestamp=0;
        int last_ts_index = -1;
        quint32 last_ts = 0;
        quint32 last_gps_ts = 0;
        quint32 gps_count = 0; // Offset to add from start index
        int gps_index = 0; // Start index

        WIMUBinaryStream wimu_data;


        // Browse each file
        foreach(data_file,files){
            count++;
            emit requestLogging ("Traitement de: " + folder.path() + "/" + data_file, WIMU::LogDebug);
            // Read data
            WIMUFile current_file(folder.path() + "/" + data_file,WIMUFile::getModuleFromPrefix(sensor),*m_settings,*m_config);

            if (!current_file.load()){
                emit requestLogging("Impossible d'ouvrir le fichier: " + folder.path() + "/" + data_file + ". Ignoré.",WIMU::LogError);
                continue;
            }

            QByteArray data = current_file.readSample();

            QList<quint32> timestamps;
            qint64 last_pos = 0;
            QList<QByteArray> samples;


            while (!data.isEmpty()){
                //////////////////////////////////////
                // Correct sample timestamp, if needed
                quint64 timestamp = current_file.getSampleTime(&data);

                if (!isTimestampValid(timestamp)){
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
                        last_ts_index = time_vector.indexOf(timestamp);
                    }else{

                        //if (sensor != "GPS"){
                        // Check for closest value
                            bool found = false;
                            if (!time_vector.isEmpty() && timestamp>0){
                               // qDebug() << "Searching...";//time_vector.last() << time_vector.at(time_vector.count()-2);
                                if (timestamp<=time_vector.last() && timestamp>=time_vector.first()){
                                    for (quint64 t=timestamp; t>=/*time_vector.first()*/timestamp-10; t--){ // Only check 10 samples
                                        //qDebug() << ".";
                                        if (time_vector.contains(t)){
                                            //emit requestLogging(data_file + ": Approximation du temps " + QString::number(timestamp) + " vers " + QString::number(t + 1),WIMU::LogWarning);
                                            timestamp = new_time_vector.at(time_vector.indexOf(t))+1;
                                            last_ts_index = time_vector.indexOf(t);
                                            found = true;
                                            break;
                                        }
                                    }
                                }
                            }
                            if (!found){
                                last_ts_index = -1;
                                emit requestLogging(data_file + ": Correspondance temps non-corrigé->corrigé non-trouvé pour " + QString::number(timestamp)+". Échantillon ignoré.",WIMU::LogWarning);
                            }
                        /*}else{
                            // TODO!

                        }*/
                    }
                }

                // Ensure time is correct in regard to the DST and timezone
                timestamp = adjustTimeForTimeZone(timestamp);

                // Check if timestamp is in the current date
                //time.start();
                if (current_day+1 < dates.count()){
                    if (timestamp > (dates.at(current_day)+86400)/* && (sensor=="GPS" && isTimestampValid(timestamp))*/){

                        // Day change - write what we have so far...
                        if (!writeTimeFile(path + "/PreProcess",sensor, current_day, timestamps, dates.at(current_day)))
                            return;

                        if (!writeDataFile(path + "/PreProcess",sensor,current_day,current_file.getFileName(),last_pos,current_file.getCurrentPos(),dates.at(current_day)))
                            return;

                        // Find new day
                        bool found = false;
                        for (int i=current_day+1; i<dates.count(); i++){
                            if (timestamp < dates.at(i)+86400){
                                current_day = i;
                                found = true;
                                break;
                            }
                        }
                        if (!found){
                            qDebug() << "Impossible trouver prochain jour!!";
                        }
                        // Clear variables
                        last_pos = current_file.getCurrentPos();
                        timestamps.clear();
                    }
                }

                // Add to global write list
                timestamps.append(timestamp);

                // If GPS, saves samples for file writing...
                if (sensor=="GPS"){
                    samples.append(data);
                }
                data = current_file.readSample();
                QCoreApplication::processEvents();

            } // While data

            // Write what we have so far
            if (!dates.isEmpty()){
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
    QList<QDateTime>    dates;
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
                QDateTime last_mod = finfo.lastModified();
                //if (!dates.contains(last_mod) && last_mod.isValid()){
                    dates.append(last_mod);
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
                while (!timefile.atEnd()){
                    ts = timefile.readLine();
                }
                data_ends.append(ts.toULong());
                timefile.close();

            }
        }
    }

    if (m_cancel)
        return;
    emit requestProgressUpdate(1,"");
    //qDebug() << dates << data_starts << data_ends;

    ///////////////////////////////////////////////////////////////
    // Step 2. Identify invalid dataset dates and propose solutions
    //////////////////////////////////////////////////////////////
    QList<quint8> corrected_indexes;
    for (i=0; i<dates.count(); i++){
        if (!isTimestampValid(dates.at(i).toTime_t())){
            corrected_indexes.append(i);
            // Try to "fix" days without timestamp at all
            int prev_valid = -1;
            int next_valid = -1;
            if (i>0){
                if (i+1<dates.count()){ // In the middle of the list
                    // Find previous valid folder
                    for (int j=i; j>=0; j--){
                        if (!corrected_indexes.contains(j))
                            if (isTimestampValid(dates.at(j).toTime_t())){
                                prev_valid = j;
                                break;
                            }
                    }

                    // Find next valid folder
                    for (int j=i+1; j<dates.count(); j++){
                        if (!corrected_indexes.contains(j))
                            if (isTimestampValid(dates.at(j).toTime_t())){
                                next_valid = j;
                                break;
                            }
                    }
                }else{ // Last date in the list
                    // Find previous valid folder
                    for (int j=i; j>=0; j--){
                        if (!corrected_indexes.contains(j))
                            if (isTimestampValid(dates.at(j).toTime_t())){
                                prev_valid = j;
                                break;
                            }
                    }
                }
            }else{ // First folder in the list
                // Find next valid folder
                for (int j=i+1; j<dates.count(); j++){
                    if (!corrected_indexes.contains(j))
                        if (isTimestampValid(dates.at(j).toTime_t())){
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
                    emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Insertion simple)",WIMU::LogWarning );
                }else{
                    int len1 = data_ends.at(prev_valid) - data_starts.at(prev_valid);
                    int len2 = data_ends.at(next_valid) - data_starts.at(next_valid);

                    if (diff==0){ // No missing day in between - try to fit the dataset in
                        int avail = 86400 - len1 - len2; // Available time in that day
                        data_starts[i] = data_ends[prev_valid] + (avail - current_len)/2;
                        data_ends[i] = data_starts[next_valid] - (avail - current_len)/2;
                        emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Insertion même journée)",WIMU::LogWarning );

                    }else{
                        if (diff==1){ // Only one day difference - try to fit with the smallest dataset
                            if (len1>len2){
                                data_starts[i] = data_starts[next_valid] -current_len - 5; // Suppose a 5 seconds delay from last time
                                data_ends[i] = data_starts.at(i) + current_len;
                                emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Insertion journée suivante)",WIMU::LogWarning );
                            }else{
                                data_starts[i] = data_ends[prev_valid] + 5;
                                data_ends[i] = data_starts.at(i) + current_len;
                                emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Insertion journée précédente)",WIMU::LogWarning );
                            }
                        }else{ // More than one day - put it right in the middle!
                            data_starts[i] = previousMidnight(data_ends.at(prev_valid)) + (diff/2)*86400;//dates.at(prev_valid).addDays(diff/2).toTime_t();
                            data_ends[i] = data_starts.at(i) + current_len;
                            emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Insertion au milieu du trou)",WIMU::LogWarning );
                        }

                    }
                }
            }else{
                if (next_valid>=0 && prev_valid>=0){ // No next valid time - use previous valid
                    data_starts[i] = previousMidnight(data_ends[prev_valid]) + 86400; //dates.at(prev_valid).addDays(1).toTime_t();
                    data_ends[i] = data_starts.at(i) + current_len;
                    emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Ajout après journée précédente)",WIMU::LogWarning );
                }else{
                    if (prev_valid>=0){
                        data_starts[i] = previousMidnight(data_starts[next_valid]) -86400; //dates.at(next_valid).addDays(-1).toTime_t();
                        data_ends[i] = data_starts.at(i) + current_len;
                        emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Ajout avant journée suivante)",WIMU::LogWarning );
                    }else{
                        if (next_valid>=0){
                            data_starts[i] = previousMidnight(data_starts[next_valid]) - (next_valid-i) * 86400;
                            data_ends[i] = data_starts.at(i) + current_len;
                            emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Ajout au début des données)",WIMU::LogWarning );
                        }else{
                            // No valid time at all!!
                            emit requestLogging("Impossible d'estimer la date de " + path + "/" + folders.at(i) + ": Aucune donnée valide.",WIMU::LogWarning );
                        }
                    }
                }
            }

            // Update date in list
            dates[i] = QDateTime(QDateTime::fromTime_t(data_starts[i]).date());
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
    int date_diff = dates.last().date().day() - dates.first().date().day();
    QMap<qint16, QDate> fileDateMapping;
    for (i=0; i<=date_diff; i++){
        QDateTime current_date = dates.first().addDays(i);
        foreach(sensor,sensors){

            // TIME file
            if (!writeTimeFile(path + "/PreProcess",sensor, i, QList<quint32>(), previousMidnight(current_date.toTime_t())))
                return;

            // DATA file
            if (!writeDataFile(path + "/PreProcess",sensor, i, NULL, 0,0, previousMidnight(current_date.toTime_t())))
                return;

            // GPS CSV files
            if (sensor=="GPS"){
                if (!writeGPSHeaderFile(path + "/PreProcess",i,previousMidnight(current_date.toTime_t())))
                    return;
            }


        }
        fileDateMapping.insert(i,current_date.date());
    }

    // Browse each folder and append to correct file
    for (i=0; i<folders.count(); i++){
        QDir ppFolder(path + "/" + folders.at(i) + "/PreProcess");

        if (ppFolder.exists()){
            QStringList sensors2 = getSensorList(ppFolder.absolutePath());

            foreach(sensor,sensors2){
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
                files = ppFolder.entryList(QStringList("GPS_*.CSV"),QDir::Files);
                sortFolderList(files);
                for (int j=0; j<files.count(); j++){
                    finfo.setFile(path + "/" + folders.at(i) + "/PreProcess/" + files.at(j));
                    last_mod = finfo.lastModified().date();
                    qint16 day_id = fileDateMapping.key(last_mod,-1);
                    if (day_id>=0){
                        copyGPSCSVFile(finfo.filePath(), path + "/PreProcess/GPS_" + QString::number(day_id) + ".CSV",previousMidnight(finfo.lastModified().toTime_t()));
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
    // Step 7. Merge all log files, if present
    ///////////////////////////////////////////////////////////////
    if (sensors.contains("LOG")){
        QDir ppFolder(path + "/PreProcess");
        QStringList files = ppFolder.entryList(QStringList("LOG_*.DAT"),QDir::Files);
        for (i=0; i<files.count(); i++){
            writeDataFile(path + "/PreProcess","LOG",-1,path + "/PreProcess/" + files.at(i),0,-1,QDateTime::currentMSecsSinceEpoch()/1000);
        }
        //path + "/PreProcess"
    }

    ///////////////////////////////////////////////////////////////
    // Step 8. Output estimated days in file
    ///////////////////////////////////////////////////////////////
    if (corrected_indexes.count() > 0){
        QFile est_file(path + "/PreProcess/corrected.txt");
        if (!est_file.open(QIODevice::WriteOnly)){
            emit requestLogging("Impossible de créer le fichier avec les jours estimés",WIMU::LogError);
            return;
        }

        QTextStream stream(&est_file);
        for (int i=0; i<corrected_indexes.count(); i++){
            stream << QString::number(corrected_indexes.at(i)) << "\n";
        }
        est_file.close();
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

    filetime.setTimeSpec(Qt::TimeZone);
    filetime = QDateTime::fromTime_t(ts);
    filetime = filetime.addSecs(-QDateTime::currentDateTime().offsetFromUtc());
    filetime = filetime.addSecs(-7200); //TODO: Understand why we need to do this....


    ut.modtime = filetime.toTime_t();
    ut.actime = filetime.toTime_t();

    _utime( filename.toUtf8().data(), &ut );
}

quint32 WimuProcessor::adjustTimeForTimeZone(const quint32 &ts){
    // Correctly adjust time according to timezone and DST

    // TODO: Use zone where data was collected instead of local zone
    qint32 wimu_offset = m_config->datetime.time_offset*3600;

    return ts - QDateTime::fromTime_t(ts - wimu_offset,Qt::UTC).toLocalTime().offsetFromUtc();

}

quint32 WimuProcessor::adjustTimeFromTimeZone(const quint32 &ts){
    // Correctly adjust time from timezone and ds

    // TODO: Use zone where data was collected instead of local zone
    qint32 wimu_offset = m_config->datetime.time_offset*3600;

    return ts + QDateTime::fromTime_t(ts - wimu_offset,Qt::UTC).toLocalTime().offsetFromUtc();

}

bool WimuProcessor::writeTimeFile(QString path, QString sensor, qint16 day, const QList<quint32> &times, const quint32 &mod_ts, bool overwrite){
    // Write a time data file
    QFile time_file;

    time_file.setFileName(path + "/TIME_" + sensor + "_" + QString::number(day) + ".DAT");
    QIODevice::OpenMode flags = QIODevice::WriteOnly;
    if (!overwrite)
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
         modif = adjustTimeForTimeZone(mod_ts);

    setFileModificationTime(time_file.fileName(), modif);

    return true;
}

bool WimuProcessor::readTimeFile(QString path, QString sensor, qint16 day, QList<quint32> &times){
    // Read a time data file
    QFile time_file;

    time_file.setFileName(path + "/TIME_" + sensor + "_" + QString::number(day) + ".DAT");
    QIODevice::OpenMode flags = QIODevice::ReadOnly;

    if (!time_file.open(flags)){
        emit requestLogging("Impossible de créer le fichier: " + time_file.fileName(),WIMU::LogError);
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
         modif = adjustTimeForTimeZone(mod_ts);

    setFileModificationTime(data_file.fileName(), modif);

    return true;
}

bool WimuProcessor::copyGPSCSVFile(QString src, QString dst, const quint32 &mod_ts){
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
         modif = adjustTimeForTimeZone(mod_ts);

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
         modif = adjustTimeForTimeZone(mod_ts);

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
        // Date
        stream << gps.nav_datetime.date().toString("yyyy/MM/dd") << ",";
        // Time
        stream << gps.nav_datetime.time().toString("HH:mm:ss") << ",";
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

    data_file.close();
    quint32 modif = mod_ts;
    if (!isTimestampValid(mod_ts))
         modif = adjustTimeForTimeZone(mod_ts);

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
