#include "sensordisplay.h"
#include "ui_sensordisplay.h"

#include <QPointF>
#include <QHBoxLayout>
#include <QStringList>

#include "wimufile.h"
#include "wimubinarystream.h"
#include "wimuprocessor.h"

//#include <Qt3DCore/qaspectengine.h>

SensorDisplay::SensorDisplay(WIMUConfig* config, WIMUSettings* settings, QWidget *parent) :
    QWidget(parent),
    ui(new Ui::SensorDisplay)
{
    ui->setupUi(this);

    // Top navigation bar (browser)
    m_timeBrowser = new TimeBrowser(this);

    ui->wdgBrowser->setLayout(new QHBoxLayout());
    ui->wdgBrowser->layout()->addWidget(m_timeBrowser);
    ui->wdgBrowser->setVisible(false); // Hide browser by default

    // Left navigation bar (event browser)
    m_eventBrowser = new EventsBrowser(this);

    ui->wdgEvents->setLayout(new QHBoxLayout());
    ui->wdgEvents->layout()->addWidget(m_eventBrowser);
    ui->wdgEvents->setVisible(false);

    // Connect navigation bars
    connect(m_eventBrowser,SIGNAL(selectTimeRequest(quint32)),m_timeBrowser,SLOT(selectTime(quint32)));
    connect(m_timeBrowser,SIGNAL(timeChanged(quint32)),this,SLOT(displayTimeWasChanged(quint32)));

    m_config = config;
    m_settings = settings;

    QStringList labels;
    labels.append("X");
    labels.append("Y");
    labels.append("Z");

    // Create Datagraphs
    ui->wdgPlotAcc->setLayout(new QHBoxLayout());
    m_graphAcc = new DataGraph(3,config->general.sampling_rate, labels);
    ui->wdgPlotAcc->layout()->addWidget(m_graphAcc);

    ui->wdgPlotGyro->setLayout(new QHBoxLayout());
    m_graphGyro = new DataGraph(3,config->general.sampling_rate, labels);
    ui->wdgPlotGyro->layout()->addWidget(m_graphGyro);

    ui->wdgPlotMag->setLayout(new QHBoxLayout());
    m_graphMag = new DataGraph(3,config->general.sampling_rate, labels);
    ui->wdgPlotMag->layout()->addWidget(m_graphMag);

    ui->wdgPlotIMU->setLayout(new QHBoxLayout());
    labels.clear();
    labels.append("Q0");
    labels.append("Q1");
    labels.append("Q2");
    labels.append("Q3");
    m_graphIMU = new DataGraph(4,config->general.sampling_rate, labels);
    ui->wdgPlotIMU->layout()->addWidget(m_graphIMU);

    // Set data buffers
    for (int i=0; i<3; i++){
        m_dataAcc.append(new SensorBuffer(config->general.sampling_rate,10,SensorBuffer::BUFFER_FIFO));
        m_graphAcc->setData(i,m_dataAcc[i]);

        m_dataGyro.append(new SensorBuffer(config->general.sampling_rate,10,SensorBuffer::BUFFER_FIFO));
        m_graphGyro->setData(i,m_dataGyro[i]);

        m_dataMag.append(new SensorBuffer(config->general.sampling_rate,10,SensorBuffer::BUFFER_FIFO));
        m_graphMag->setData(i,m_dataMag[i]);

        m_dataIMU.append(new SensorBuffer(config->general.sampling_rate,10,SensorBuffer::BUFFER_FIFO));
        m_graphIMU->setData(i,m_dataIMU[i]);
    }
    m_dataIMU.append(new SensorBuffer(config->general.sampling_rate,10,SensorBuffer::BUFFER_FIFO));
    m_graphIMU->setData(3,m_dataIMU[3]);

    // Connect signals
    connect(ui->chkAcc,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkGyro,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkMag,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkIMU,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkGPS,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));

    // Init GPS display
    m_webMap = NULL;
    m_webMap = new QWebEngineView(ui->wdgGPSMap);
    ui->wdgGPSMap->layout()->addWidget(m_webMap);

    //QString mapPath = QApplication::applicationDirPath() + "/map.html";
    QString mapPath = "qrc:/html/map.html";
    m_webMap->setUrl(QUrl(mapPath));

#if 0
    QFileInfo mapInfo(mapPath);
    if (!mapInfo.exists()){
        qDebug() << "ERREUR: Gabarit de carte " + mapPath + " introuvable!";
    }else{
        m_webMap->setUrl(QUrl(mapPath));
    }
#endif

    ui->lblGPSStatus->setText("Aucune position.");
    ui->frameGPSPosition->setVisible(false);

    // Hide "useless" features (i.e. not enabled modules in the WIMU)
    if (!config->isModuleEnabled(WIMU::MODULE_ACC)){
        ui->chkAcc->setChecked(false);
        ui->chkAcc->setVisible(false);
    }
    if (!config->isModuleEnabled(WIMU::MODULE_GYRO)){
        ui->chkGyro->setChecked(false);
        ui->chkGyro->setVisible(false);
    }
    if (!config->isModuleEnabled(WIMU::MODULE_MAGNETO)){
        ui->chkMag->setChecked(false);
        ui->chkMag->setVisible(false);
    }
    if (!config->isModuleEnabled(WIMU::MODULE_IMU)){
        ui->chkIMU->setChecked(false);
        ui->chkIMU->setVisible(false);
    }
    if (!config->isModuleEnabled(WIMU::MODULE_GPS)){
        ui->chkGPS->setChecked(false);
        ui->chkGPS->setVisible(false);
    }

    if (settings->hw_id<3){
        ui->frameGeneral->setVisible(false);
    }

}

SensorDisplay::~SensorDisplay()
{
    delete m_graphAcc;
    delete m_graphGyro;
    delete m_graphMag;
    delete m_graphIMU;
    delete m_timeBrowser;
    delete m_eventBrowser;

    // Already deleted by the graphs!
    /*qDeleteAll(m_dataAcc);
    qDeleteAll(m_dataGyro);
    qDeleteAll(m_dataMag);
    qDeleteAll(m_dataIMU);*/

    delete ui;
}

void SensorDisplay::addIMUFrame(WIMU::IMUFrame_Struct &frame){
    QPointF minMaxAcc(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());
    QPointF minMaxGyro(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());
    QPointF minMaxMag(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());
    QPointF minMaxIMU(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());

    // Copy all the information into the required buffers
    for (int i=0; i<3; i++){
        if (frame.acc_valid){
            m_dataAcc.at(i)->addSample(m_config->convertAcc2g(frame.acc_data[i]));
            minMaxAcc.setX(qMin((float)minMaxAcc.x(), m_dataAcc.at(i)->min()));
            minMaxAcc.setY(qMax((float)minMaxAcc.y(), m_dataAcc.at(i)->max()));
        }

        if (frame.gyro_valid){
            m_dataGyro.at(i)->addSample(m_config->convertGyro2degs(frame.gyro_data[i]));
            minMaxGyro.setX(qMin((float)minMaxGyro.x(), m_dataGyro.at(i)->min()));
            minMaxGyro.setY(qMax((float)minMaxGyro.y(), m_dataGyro.at(i)->max()));
        }

        if (frame.mag_valid){
            m_dataMag.at(i)->addSample(m_config->convertMag2gauss(frame.mag_data[i]));
            minMaxMag.setX(qMin((float)minMaxMag.x(), m_dataMag.at(i)->min()));
            minMaxMag.setY(qMax((float)minMaxMag.y(), m_dataMag.at(i)->max()));
        }

        if (frame.quat_valid){
            m_dataIMU.at(i)->addSample(frame.quaternion[i]);
            minMaxIMU.setX(qMin((float)minMaxIMU.x(), m_dataIMU.at(i)->min()));
            //minMaxIMU.setY(qMax((float)minMaxIMU.y(), m_dataIMU.at(i)->max()));
            minMaxIMU.setY(1);
            minMaxIMU.setX(-1);
        }
    }
    //qDebug() << m_dataAcc.last()->sample(0).y() << m_dataAcc.last()->sample(1).y() << m_dataAcc.last()->sample(2).y();
    if (frame.quat_valid){
        m_dataIMU.at(3)->addSample(frame.quaternion[3]);
        /*minMaxIMU.setX(qMin((float)minMaxIMU.x(), m_dataIMU.at(3)->min()));
        minMaxIMU.setY(qMax((float)minMaxIMU.y(), m_dataIMU.at(3)->max()));*/
        minMaxIMU.setY(1);
        minMaxIMU.setX(-1);
    }

    if (frame.acc_valid){
        m_graphAcc->setAxisScale (QwtPlot::yLeft, minMaxAcc.x(), minMaxAcc.y());
        m_graphAcc->replot();
    }

    if (frame.gyro_valid){
        m_graphGyro->setAxisScale(QwtPlot::yLeft, minMaxGyro.x(), minMaxGyro.y());
        m_graphGyro->replot();
    }

    if (frame.mag_valid){
        m_graphMag->setAxisScale(QwtPlot::yLeft, minMaxMag.x(), minMaxMag.y());
        m_graphMag->replot();
    }

    if (frame.quat_valid){
        m_graphIMU->setAxisScale(QwtPlot::yLeft, minMaxIMU.x(), minMaxIMU.y());
        m_graphIMU->replot();

        // 3D IMU
        ui->gl3D->setRotation(QQuaternion(frame.quaternion[0],
                                          frame.quaternion[1],
                                          frame.quaternion[2],
                                          frame.quaternion[3]));
    }

}

void SensorDisplay::addGPSNavData(WIMU::GPSNavData_Struct &nav){
    static bool led_on = true;
    // Alive LED
    if (led_on)
        ui->lblIconGPSAlive->setPixmap(QPixmap(":/icons/images/led_blue.png"));
    else
        ui->lblIconGPSAlive->setPixmap(QPixmap(":/icons/images/led_white.png"));

    led_on = !led_on;

    // Valid position
    ui->lblGPSStatus->setText("");
    if (!nav.nav_valid){
        ui->lblIconGPSStatus->setPixmap(QPixmap(":/icons/images/led_red.png"));
        ui->lblGPSStatus->setText("Aucune position.");
        ui->frameGPSPosition->setVisible(false);
    }else{
        if (nav.nav_type == WIMU::GPSNAV_4SV){
            ui->lblIconGPSStatus->setPixmap(QPixmap(":/icons/images/led_green.png"));
            ui->lblGPSStatus->setText("");
        }else{
            ui->lblIconGPSStatus->setPixmap(QPixmap(":/icons/images/led_yellow.png"));
            if (nav.nav_type == WIMU::GPSNAV_1SV || nav.nav_type== WIMU::GPSNAV_2SV || nav.nav_type == WIMU::GPSNAV_3SV){
                ui->lblGPSStatus->setText("Position non-optimale.");
            }
            if (nav.nav_type == WIMU::GPSNAV_2DLS || nav.nav_type==WIMU::GPSNAV_3DLS || nav.nav_type == WIMU::GPSNAV_DR){
                ui->lblGPSStatus->setText("Position estimée.");
            }
        }

        // Display position
        ui->frameGPSPosition->setVisible(true);
        ui->lblAltitudeValue->setText(QString::number(nav.altitude) + " m");
        ui->lblCourseValue->setText(QString::number(nav.orientation) + " deg");
        ui->lblLatitudeValue->setText((nav.latitude>=0 ? "N " : "S ") + QString::number(nav.latitude));
        ui->lblLongitudeValue->setText((nav.longitude>=0 ? "E " : "W ") + QString::number(nav.longitude));
        ui->lblPrecisionValue->setText(QString::number(nav.horizontal_precision) + " m");
        if (!nav.invalid_speed)
            ui->lblSpeedValue->setText(QString::number(nav.speed * 3.6) + " km/h");
        else
            ui->lblSpeedValue->setText("Invalide");
        // Update map
        if (m_webMap)
            m_webMap->page()->runJavaScript("setCurrentPosition(" + QString::number(nav.latitude) + ","+QString::number(nav.longitude) + ");");



    }
}

void SensorDisplay::addGPSTrackerData(WIMU::GPSTrackerData_Struct &track){
    // Update progress bars

    for (int i=0; i<12; i++){
        QProgressBar* bar = ui->frameSatellites->findChild<QProgressBar*>(QString("progSat_" + QString::number(i+1)));
        if (bar){
            // Compute mean SNR
            QVector<quint8>* snr = &track.signal_ratios[i];

            quint32 mean_snr=0;
            for (int j=0; j<snr->count(); j++){
                mean_snr += snr->at(j);
            }
            mean_snr /= snr->count();
            mean_snr = ((float)mean_snr/45.f)*100;
            //qDebug() << "Sat " << track.sat_ids.at(i) << ", SIGNAL: " << mean_snr;
            bar->setValue(qMin((int)mean_snr,100));
            //bar->setFormat(QString::number(mean_snr));

            //Color according to state
            if (track.sat_states.at(i)>= 0x3F){ // Locked on
                bar->setStyleSheet("QProgressBar::chunk {"
                                   "background: rgb(0,255,0);"
                                   "border-bottom-right-radius: 3px;"
                                   "border-bottom-left-radius: 3px;"
                                   "border: 1px solid black;}");
            }else{
                if ( (track.sat_states.at(i) & 0x01)>0 || (track.sat_states.at(i) & 0x02)>0 ){
                    bar->setStyleSheet("QProgressBar::chunk {"
                                       "background: rgb(255,255,0);"
                                       "border-bottom-right-radius: 3px;"
                                       "border-bottom-left-radius: 3px;"
                                       "border: 1px solid black;}");
                }else{
                    bar->setStyleSheet("QProgressBar::chunk {"
                                       "background: rgb(255,0,0);"
                                       "border-bottom-right-radius: 3px;"
                                       "border-bottom-left-radius: 3px;"
                                       "border: 1px solid black;}");
                }
            }

        }

        QLabel* label = ui->frameSatellites->findChild<QLabel*>(QString("lblSat_" + QString::number(i+1)));
        if (label){
            label->setText(QString::number(track.sat_ids.at(i)));
        }
    }

}

void SensorDisplay::addPowerFrame(WIMU::PowerFrame_Struct &power){
    // Battery voltage
    QString battery_icon = ":/icons/images/battery";
    if (power.battery_pc == 100)
        battery_icon += "100";
    else if (power.battery_pc>=80)
        battery_icon += "80";
    else if (power.battery_pc>=60)
        battery_icon += "60";
    else if (power.battery_pc>=40)
        battery_icon += "40";
    else if (power.battery_pc>=20)
        battery_icon += "20";
    else
        battery_icon += "0";

    if (power.charging)
        battery_icon += "_charge";
    battery_icon += ".png";

    ui->imgBattery->setPixmap(QPixmap(battery_icon));
    if (power.battery > 0)
        ui->lblBattery->setText(QString::number(power.battery,'f',2)+" V");
    else
        ui->lblBattery->setText(QString::number(power.battery_pc) + "%");

    // Temperature
    if (power.temp>-100){
        ui->lblTemp->setText(QString::number(power.temp,'f',1) + " °C");
        ui->progTemp->setValue((quint16)power.temp);
    }else{
        ui->lblTemp->setVisible(false);
        ui->progTemp->setVisible(false);
    }

    // Status label
    QString status;
    switch (power.status){
    case WIMU::POWER_STATE_LOWBAT:
        status = "Pile faible";
        break;
    case WIMU::POWER_STATE_OFF:
        status = "Module éteint";
        break;
    case WIMU::POWER_STATE_ON:
        status = "Module en fonction";
        break;
    case WIMU::POWER_STATE_USB:
        status = "Branché sur USB";
        break;
    case WIMU::POWER_STATE_USB_COM:
        status = "Branché USB (Mode COM)";
        break;
    case WIMU::POWER_STATE_USB_MASS:
        status = "Branché USB (Mode Storage)";
        break;
    default:
        status = "";// "État inconnu.";
    }

    ui->lblStatus->setText(status);

}

void SensorDisplay::clearGPSDisplay(){
    ui->lblIconGPSAlive->setPixmap(QPixmap(":/icons/images/led_white.png"));

    ui->lblGPSStatus->setText("");
    ui->lblIconGPSStatus->setPixmap(QPixmap(":/icons/images/led_red.png"));
    ui->lblGPSStatus->setText("Aucune position.");
    //ui->frameGPSPosition->setVisible(false);

    for (int i=0; i<12; i++){
        QProgressBar* bar = ui->frameSatellites->findChild<QProgressBar*>(QString("progSat_" + QString::number(i+1)));
        if (bar){
            bar->setValue(0);
        }

        QLabel* label = ui->frameSatellites->findChild<QLabel*>(QString("lblSat_" + QString::number(i+1)));
        if (label){
            label->setText("");
        }
    }

    // Update map
   /* if (m_webMap)
        m_webMap->page()->runJavaScript("clearMap();");*/

}

void SensorDisplay::manageCheckBoxClicked(){
    // Find emitting widget
    QCheckBox* check = (QCheckBox*)sender();
    if (check){
        // Enablers
        if (check->objectName()=="chkAcc"){
            ui->wdgPlotAcc->setVisible(check->checkState());
        }
        if (check->objectName()=="chkGyro"){
            ui->wdgPlotGyro->setVisible(check->checkState());
        }
        if (check->objectName()=="chkMag"){
            ui->wdgPlotMag->setVisible(check->checkState());
        }
        if (check->objectName()=="chkGPS"){
            ui->frameGPSMain->setVisible(check->checkState());
            ui->frameSatellites->setVisible(check->checkState());
            ui->frameGPSPosition->setVisible(check->checkState());
        }

        if (check->objectName()=="chkIMU"){
            ui->wdgPlotIMU->setVisible(check->checkState());
            ui->frameIMU3D->setVisible(check->checkState());
        }
    }
}

void SensorDisplay::showBrowser(bool show){
    ui->wdgBrowser->setVisible(show);
    ui->wdgEvents->setVisible(show);
}

void SensorDisplay::setDataFiles(QList<QString> &paths, QList<quint16> &ids){
    m_dataPaths = paths;
    m_dataIds = ids;

    if (m_timeBrowser){
        m_timeBrowser->clearWIMULogs();
        m_timeBrowser->setBasePaths(paths);
    }
    if (m_eventBrowser)
        m_eventBrowser->clearWIMULogs();

    // Load logs and times for those files
    QList<WIMULog> logs;
    int count = 0;
    m_dataStartTimes.clear();

    foreach(QString path, paths){
        quint16 id = ids.at(count++);
        //////// LOGS
        QString filename = path + "/LOG_" + QString::number(id) + ".DAT";
        //qDebug() << "Processing " << filename;
        if (QFile::exists(filename)){
            WIMUFile logfile(filename, WIMU::MODULE_CPU, *m_settings, *m_config);
            if (!logfile.load()){
                emit requestLogging("Impossible de charger le fichier " + filename,WIMU::LogError);
                return;
            }

            QByteArray logdata = logfile.readSample();
            while (!logdata.isEmpty()){
                WIMUBinaryStream bin;
                bin.fromBinaryFile(logdata,WIMU::MODULE_CPU);

                WIMULog log = bin.convertToWIMULog(m_settings->hw_id);
                log.timestamp = logfile.getCurrentSampleTime();

                logs.append(log);
                logdata = logfile.readSample();

            }
            logfile.close();
        }else{
            qDebug() << "Skipping " << filename << ": not present";
        }

        ///////// Time for that dataset
        filename = path + "/TIMES.DAT";
        if (QFile::exists(filename)){
            QFile timefile(filename);
            if (timefile.open(QIODevice::ReadOnly)){
                QByteArray data;
                while (!timefile.atEnd()){
                    data = timefile.readLine();
                    QStringList datas = QString(data).replace("\n","").split(",");
                    if (datas.count()==3){
                        if (datas.at(0).toUInt() == id){
                            m_dataStartTimes.append(datas.at(1).toUInt());
                        }
                    }
                }
                timefile.close();
            }
        }
    }

    // Order list of logs in case of mix-up
    std::sort(logs.begin(),logs.end());

    // Add logs to correct views
    foreach (WIMULog log, logs){
        if (m_timeBrowser){
            m_timeBrowser->addWIMULog(log);
        }
        if (m_eventBrowser){
            m_eventBrowser->addWIMULog(log);
        }
    }

    // Update visual display and browser
    if (m_timeBrowser)
        m_timeBrowser->updateDisplay();
}

void SensorDisplay::displayTimeWasChanged(quint32 new_time){
    static bool updating = false;

    if (updating)
        return;

    if (m_dataStartTimes.isEmpty())
        return;

    //qDebug() << new_time;

    updating = true;
   // Get path and id to load
   quint16 id=0;
   QString path;
   QPointF minMaxAcc(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());
   QPointF minMaxGyro(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());
   QPointF minMaxMag(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());
   //QPointF minMaxIMU(std::numeric_limits<float>::max(), std::numeric_limits<float>::min());

   for (int i=1; i<m_dataStartTimes.count(); i++){
       if (m_dataStartTimes.at(i) > new_time && m_dataStartTimes.at(i-1) <= new_time ){
           id = i-1;
           break;
       }
   }
   path = m_dataPaths.at(id);

   // Build sensor list to load
   QStringList sensors = WimuProcessor::getSensorList(path);
   if (sensors.contains("LOG"))
       sensors.removeAll("LOG");

   // Clear current graph data
   for (int i=0; i<3; i++){
    m_dataAcc.at(i)->empty();
    m_dataGyro.at(i)->empty();
    m_dataMag.at(i)->empty();
    m_dataIMU.at(i)->empty();
   }
   m_dataIMU.at(3)->empty();

   // Load data from files
   foreach (QString sensor, sensors){
       WIMUFile datafile(path + "/" + sensor + "_" + QString::number(m_dataIds.at(id)) + ".DAT",
                     WIMUFile::getModuleFromPrefix(sensor), *m_settings, *m_config);

       // TODO: load a number of seconds equal to the max x of the graphs instead of the default 10
       quint16 len = 10;
       if (sensor=="GPS")
           len = 1; // Always one second for GPS

       if (datafile.load(m_dataStartTimes.at(id),new_time, len)){

           if (sensor!="GPS"){
               for (int sample=0; sample<len;sample++){
                   QByteArray data = datafile.readSample();
                   data = datafile.getSampleData(&data);

                   WIMUBinaryStream converter;
                   converter.fromBinaryFile(data,WIMUFile::getModuleFromPrefix(sensor));
                   //qDebug() << sensor;
                   if (sensor=="ACC"){
                       QList<QVector3D> acc = converter.convertToAccSensorData(m_config);
                       for (int i=0; i<3; i++){
                           for (int j=0; j<acc.count(); j++){
                               m_dataAcc.at(i)->addSample(acc[j][i]);
                               minMaxAcc.setX(qMin((float)minMaxAcc.x(), m_dataAcc.at(i)->min()));
                               minMaxAcc.setY(qMax((float)minMaxAcc.y(), m_dataAcc.at(i)->max()));
                           }
                       }
                   }

                   if (sensor=="GYR"){
                       QList<QVector3D> gyro = converter.convertToGyroSensorData(m_config);
                       for (int i=0; i<3; i++){
                           for (int j=0; j<gyro.count(); j++){
                               m_dataGyro.at(i)->addSample(gyro[j][i]);
                               minMaxGyro.setX(qMin((float)minMaxGyro.x(), m_dataGyro.at(i)->min()));
                               minMaxGyro.setY(qMax((float)minMaxGyro.y(), m_dataGyro.at(i)->max()));
                           }
                       }
                   }

                   if (sensor=="MAG"){
                       QList<QVector3D> mag = converter.convertToMagnetoSensorData(m_config);
                       for (int i=0; i<3; i++){
                           for (int j=0; j<mag.count(); j++){
                               m_dataMag.at(i)->addSample(mag[j][i]);
                               minMaxMag.setX(qMin((float)minMaxMag.x(), m_dataMag.at(i)->min()));
                               minMaxMag.setY(qMax((float)minMaxMag.y(), m_dataMag.at(i)->max()));
                           }
                       }
                   }

                   if (sensor=="POW"){
                       WIMU::PowerFrame_Struct power = converter.convertToPowerFrame(m_config);
                       addPowerFrame(power);
                   }
                   if (sensor=="IMU"){
                       QList<WIMU::IMUFrame_Struct> imu = converter.convertToIMUFrames(m_config);
                       for (int i=0; i<imu.count(); i++){

                           addIMUFrame(imu[i]);
                       }
                   }
               }
           }else{ // GPS Data
               //clearGPSDisplay();
               QByteArray data = datafile.readSample();
               WIMUBinaryStream converter;
               converter.fromBinaryFile(data,WIMUFile::getModuleFromPrefix(sensor));
               quint32 sample_time = datafile.getSampleTime(&data);
               quint32 current_time = sample_time;
               bool track_found = false;
               // Read all samples for that time
               while (!data.isEmpty()){
                   //qDebug() << data;
                   int msg_id = converter.getGPSMessageID();
                   //qDebug() << msg_id;
                    if (msg_id==41){
                        WIMU::GPSNavData_Struct nav = converter.convertToGPSNavData();
                        // Correct timestamp
                        //TODO
                        addGPSNavData(nav);
                    }
                    if (msg_id==4){
                        WIMU::GPSTrackerData_Struct track = converter.convertToGPSTrackerData();
                        addGPSTrackerData(track);
                        track_found = true;
                    }
                    data = datafile.readSample();
                    converter.fromBinaryFile(data,WIMUFile::getModuleFromPrefix(sensor));
                    current_time = datafile.getSampleTime(&data);
                    if (data.isEmpty() || data.isNull())
                        break;
               }

               if (!track_found){
                   clearGPSDisplay();
               }

           }
           datafile.close();
       }else{
           emit requestLogging("Erreur: impossible d'ouvrir le fichier " + datafile.getFileName(), WIMU::LogError);
       }

   }

   // Display data
   m_graphAcc->setAxisScale (QwtPlot::yLeft, minMaxAcc.x(), minMaxAcc.y());
   m_graphAcc->replot();

   m_graphGyro->setAxisScale (QwtPlot::yLeft, minMaxGyro.x(), minMaxGyro.y());
   m_graphGyro->replot();

   m_graphMag->setAxisScale (QwtPlot::yLeft, minMaxMag.x(), minMaxMag.y());
   m_graphMag->replot();

   updating = false;


}
