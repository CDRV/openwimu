#include "wimuprocessor.h"

#include <QProgressDialog>
#include <QDir>
#include <QDebug>
#include <QCollator>
#include <QCoreApplication>
#include <QFileInfo>

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/utime.h>
#include <time.h>

#include "wimufile.h"

WimuProcessor::WimuProcessor(QObject *parent) : QObject(parent)
{
    m_config = NULL;
    m_settings = NULL;

}

WimuProcessor::~WimuProcessor(){
    if (m_config)
        delete m_config;
    if (m_settings)
        delete m_settings;
}

bool WimuProcessor::preProcess(QString path){
    QProgressDialog prog;
    QDir folder(path);

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

    // Setup progress dialog
    prog.setLabelText("Pré-traitement des données");
    prog.setCancelButtonText("Annuler");
    prog.setMinimum(0);
    prog.setMaximum(folders.count());
    //prog.setParent((QWidget*)this->parent());
    prog.setWindowModality(Qt::WindowModal);
    prog.setMinimumDuration(0);

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
        correctTimestamp(path + "/" + folders.at(i));
        prog.setValue(i);
        if (prog.wasCanceled())
            break;
        QCoreApplication::processEvents();
    }

    // Combine files and correct timestamp on a dataset folder basis
    combineDataSet(path, folders);

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

        //TODO: Find a good source if no acc data either...
    }

    // Sort file list
    sortFolderList(files);

    foreach (data_file,files){
        WIMUFile file(path + "/" + data_file, time_src, *m_settings, *m_config);

        if (!file.openFile()){
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



        file.closeFile();
    }

    /////////////////////////////////////////////////////////////
    // Step 2. Identify the first valid timestamp, if any
    /////////////////////////////////////////////////////////////
    //quint64 timestamp;
    int valid_ts_index = -1;

    /*
    }*/
    if (isTimestampValid(time_vector.last())){
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

    /////////////////////////////////////////////////////////////
    // Step 4. Create days mapping
    /////////////////////////////////////////////////////////////
    QList<quint32> dates;

    if (new_time_vector.count()>0){
        quint32 next_day = previousMidnight(adjustTimeForTimeZone(new_time_vector.at(0)));
        dates.append(next_day); // Current day
        next_day += 86400;
        while (next_day < new_time_vector.last()){
            next_day += 86400;
            dates.append(next_day);
        }
        /*if (!dates.contains(next_day))
            dates.append(next_day); // adds the final day*/
    }

    /////////////////////////////////////////////////////////////
    // Step 5. Build sensor list from prefixes
    /////////////////////////////////////////////////////////////
    QStringList file_prefixes = getSensorList(folder.path());

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

        }
    }

    /////////////////////////////////////////////////////////////
    // Step 7. Correct all sensors timestamps and split by day
    /////////////////////////////////////////////////////////////
    folder.setPath(path);

    // Process data by sensor prefixes

    foreach (sensor, file_prefixes){
        if (sensor=="GPS") // Ignore GPS for now...
            continue;

        // Start day = always first date
        quint8 current_day = 0;

        // Create list of files for that sensor
        QDir sensor_files(folder.path());
        files = sensor_files.entryList(QStringList(sensor+"_*.DAT"),QDir::Files);
        sortFolderList(files);

        // Browse each file
        foreach(data_file,files){
            emit requestLogging ("Traitement de: " + folder.path() + "/" + data_file, WIMU::LogDebug);
            // Read data
            WIMUFile current_file(folder.path() + "/" + data_file,WIMUFile::getModuleFromPrefix(sensor),*m_settings,*m_config);

            if (!current_file.openFile()){
                emit requestLogging("Impossible d'ouvrir le fichier: " + folder.path() + "/" + data_file + ". Ignoré.",WIMU::LogError);
                continue;
            }

            QByteArray data = current_file.readSample();

            QList<quint32> timestamps;
            qint64 last_pos = 0;

            while (!data.isEmpty()){
                //////////////////////////////////////
                // Correct sample timestamp, if needed
                quint64 timestamp = current_file.getSampleTime(&data);

                if (!isTimestampValid(timestamp)){
                    if (time_vector.contains(timestamp)){
                        timestamp = new_time_vector.at(time_vector.indexOf(timestamp));
                    }else{
                        // Check for closest value
                        bool found = false;
                        for (quint64 t=timestamp; t>time_vector.at(0); t--){
                            if (time_vector.contains(t)){
                                //emit requestLogging(data_file + ": Approximation du temps " + QString::number(timestamp) + " vers " + QString::number(t + 1),WIMU::LogWarning);
                                timestamp = new_time_vector.at(time_vector.indexOf(t)+1);
                                found = true;
                                break;
                            }
                        }
                        if (!found)
                            emit requestLogging(data_file + ": Correspondance temps non-corrigé->corrigé non-trouvé pour " + QString::number(timestamp)+". Échantillon ignoré.",WIMU::LogWarning);
                    }
                }

                // Ensure time is correct in regard to the DST and timezone
                timestamp = adjustTimeForTimeZone(timestamp);

                // Add to global write list
                timestamps.append(timestamp);

                // Check if timestamp is in the current date
                if (current_day+1 < dates.count()){
                    if (timestamp > dates.at(current_day+1)){
                        // Day change - write what we have so far...
                        if (!writeTimeFile(path + "/PreProcess",sensor, current_day, timestamps, dates.at(current_day)))
                            return;
                        if (!writeDataFile(path + "/PreProcess",sensor,current_day,current_file.getFilePtr(),last_pos,current_file.getCurrentPos(),dates.at(current_day)))
                            return;

                        // Clear variables
                        last_pos = current_file.getCurrentPos();
                        timestamps.clear();

                        // Find new day
                        for (int i=current_day+1; i<dates.count(); i++){
                            if (timestamp < dates.at(i)){
                                current_day = i;
                                break;
                            }
                        }
                    }
                }

                data = current_file.readSample();
                QCoreApplication::processEvents();
            } // While data

            // Write what we have so far
            if (!writeTimeFile(path + "/PreProcess",sensor, current_day, timestamps, dates.at(current_day)))
                return;
            if (!writeDataFile(path + "/PreProcess",sensor, current_day, current_file.getFilePtr(),last_pos,current_file.getCurrentPos(),dates.at(current_day)))
                return;

            // Clear variables
            last_pos = 0;
            timestamps.clear();


            current_file.closeFile();
        } // for each data file


    }       
}

void WimuProcessor::combineDataSet(QString path, QStringList &folders){
    // Combine datas from each preprocess folders

    int i;
    QStringList sensors;
    QString sensor;

    /////////////////////////////////////////////////////////////
    // Step 1. Create output folder
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

    /////////////////////////////////////////////////////////////
    // Step 2. Build date list
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

    //qDebug() << dates << data_starts << data_ends;

    ///////////////////////////////////////////////////////////////
    // Step 3. Identify invalid dataset dates and propose solutions
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
                        if (isTimestampValid(dates.at(j).toTime_t())){
                            prev_valid = j;
                            break;
                        }
                    }

                    // Find next valid folder
                    for (int j=i+1; j<dates.count(); j++){
                        if (isTimestampValid(dates.at(j).toTime_t())){
                            next_valid = j;
                            break;
                        }
                    }
                }else{ // Last date in the list
                    // Find previous valid folder
                    for (int j=i; j>=0; j--){
                        if (isTimestampValid(dates.at(j).toTime_t())){
                            prev_valid = j;
                            break;
                        }
                    }
                }
            }else{ // First folder in the list
                // Find next valid folder
                for (int j=i+1; j<dates.count(); j++){
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
                if (next_valid>=0){ // No next valid time - use previous valid
                    data_starts[i] = previousMidnight(data_ends[prev_valid]) + 86400; //dates.at(prev_valid).addDays(1).toTime_t();
                    data_ends[i] = data_starts.at(i) + current_len;
                    emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Ajout après journée précédente)",WIMU::LogWarning );
                }else{
                    if (prev_valid>=0){
                        data_starts[i] = previousMidnight(data_starts[next_valid]) -86400; //dates.at(next_valid).addDays(-1).toTime_t();
                        data_ends[i] = data_starts.at(i) + current_len;
                        emit requestLogging("Estimation de la date de " + path + "/" + folders.at(i) + " à " + QDateTime::fromTime_t(data_starts.at(i)).toString("dd-MM-yyyy") + " (Ajout avant journée suivante)",WIMU::LogWarning );
                    }else{
                        // No valid time at all!!
                        emit requestLogging("Impossible d'estimer la date de " + path + "/" + folders.at(i) + ": Aucune donnée valide.",WIMU::LogWarning );
                    }
                }
            }

            // Update date in list
            dates[i] = QDateTime(QDateTime::fromTime_t(data_starts[i]).date());
        }
    }

    ///////////////////////////////////////////////////////////////
    // Step 4. Reprocess invalid timestamps
    ///////////////////////////////////////////////////////////////
    quint8 index;
    foreach(index,corrected_indexes){
        // Build sensor list
        QStringList sensors2 = getSensorList(path + "/" + folders.at(index) + "/PreProcess");
        // For each sensor
        foreach (sensor, sensors2){
            // Get list of files
            QDir ppFolder(path + "/" + folders.at(index) + "/PreProcess");
            QStringList files = ppFolder.entryList(QStringList("TIME_" + sensor + "_*.DAT"),QDir::Files);

            // Read each file
            QList<quint32> ts;
            quint32 base_ts = data_starts[index];

            for (i=0; i<files.count(); i++){
                if (readTimeFile(ppFolder.path(),sensor,i,ts)){
                    // Refactor timestamp
                    for (int j=0; j<ts.count(); j++){
                        ts[j] = ts.at(j) + base_ts;
                    }
                    // Save new files
                    if (ts.count()>0)
                        writeTimeFile(ppFolder.path(),sensor,i,ts,previousMidnight(ts.first()),true);
                    else
                        setFileModificationTime(ppFolder.path() + "/" + files.at(i),previousMidnight(base_ts));

                    base_ts += 86400;

                }else{
                    emit requestLogging("Impossible d'ouvrir le fichier temps du capteur " + sensor + " dans " + ppFolder.path(),WIMU::LogError);
                    return;
                }
                ts.clear();
            }

            // Set modification time for all files
            files = ppFolder.entryList(QStringList(sensor + "_*.DAT"),QDir::Files);

            base_ts = data_starts[index];
            for (i=0; i<files.count(); i++){
                setFileModificationTime(ppFolder.path() + "/" + files.at(i),previousMidnight(base_ts));
                base_ts += 86400;
            }

        }//sensor
    }

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

                    if (readTimeFile(ppFolder.path(),sensor,j,ts)){
                        writeTimeFile(path + "/PreProcess",sensor,day_id,ts,previousMidnight(finfo.lastModified().toTime_t()));
                    }
                }

                // Data
                files = ppFolder.entryList(QStringList(sensor + "_*.DAT"),QDir::Files);
                sortFolderList(files);
                for (int j=0; j<files.count(); j++){
                    finfo.setFile(path + "/" + folders.at(i) + "/PreProcess/" + files.at(j));
                    last_mod = finfo.lastModified().date();
                    qint16 day_id = fileDateMapping.key(last_mod,-1);
                    QFile src_file(finfo.filePath());
                    writeDataFile(path + "/PreProcess",sensor,day_id,&src_file,0,0,previousMidnight(finfo.lastModified().toTime_t()));
                }
            }
        }
    }

    ///////////////////////////////////////////////////////////////
    // Step 6. Delete each PreProcess subfolders (now rendered useless)
    ///////////////////////////////////////////////////////////////
    for (i=0; i<folders.count(); i++){
        QDir ppFolder(path + "/" + folders.at(i) + "/PreProcess");
        ppFolder.removeRecursively();
    }

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

bool WimuProcessor::writeTimeFile(QString path, QString sensor, quint8 day, const QList<quint32> &times, const quint32 &mod_ts, bool overwrite){
    // Write a time data file
    QFile time_file;

    time_file.setFileName(path + "/TIME_" + sensor + "_" + QString::number(day) + ".DAT");
    QIODevice::OpenMode flags = QIODevice::WriteOnly;
    if (!overwrite)
        flags |= QIODevice::Append;

    if (!time_file.open(flags)){
        emit requestLogging("Impossible de créer le fichier: " + time_file.fileName(),WIMU::LogError);
        return false;
    }

    QTextStream stream(&time_file);
    for (int i=0; i<times.count(); i++){
        stream << QString::number(times.at(i)) << "\n";
    }
    time_file.close();

    setFileModificationTime(time_file.fileName(), mod_ts);

    return true;
}

bool WimuProcessor::readTimeFile(QString path, QString sensor, quint8 day, QList<quint32> &times){
    // Read a time data file
    QFile time_file;

    time_file.setFileName(path + "/TIME_" + sensor + "_" + QString::number(day) + ".DAT");
    QIODevice::OpenMode flags = QIODevice::ReadOnly;

    if (!time_file.open(flags)){
        emit requestLogging("Impossible de créer le fichier: " + time_file.fileName(),WIMU::LogError);
        return false;
    }

    QString ts;
    while (!time_file.atEnd()){
        ts = time_file.readLine();
        times.append(ts.toULong());
    }
    time_file.close();
    return true;
}

bool WimuProcessor::writeDataFile(QString path, QString sensor, quint8 day, QFile* src, const qint64 start_pos, const qint64 end_pos, const quint32 &mod_ts){

    // Copy data from one file to another one
    QFile data_file;

    data_file.setFileName(path + "/" + sensor + "_" + QString::number(day) + ".DAT");
    if (!data_file.open(QIODevice::WriteOnly | QIODevice::Append)){
        emit requestLogging("Impossible de créer le fichier: " + data_file.fileName(),WIMU::LogError);
        return false;
    }

    // If a valid source file
    if (src){
        // Open source file, if needed
        if (!src->isOpen()){
            if (!(src->open(QIODevice::ReadOnly))){
                emit requestLogging("Impossible d'ouvrir le fichier: " + src->fileName(),WIMU::LogError);
                data_file.close();
                return false;
            }
        }

        // Move cursor to file start
        src->seek(start_pos);

        // If end_pos = 0, we must read to end of file

        // Read chunk into memory
        QByteArray data;
        if (end_pos==0)
            data = src->readAll();
        else
            data = src->read(end_pos-start_pos);

        if (!data.isEmpty()){
            data_file.write(data);
        }

    }
    data_file.close();

    setFileModificationTime(data_file.fileName(), mod_ts);

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
