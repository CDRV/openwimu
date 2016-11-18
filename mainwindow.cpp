#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QFileDialog>
#include <QProgressDialog>
#include <QStorageInfo>

#include "wimuprocessor.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    //Load application settings
    loadAppSettings();

    updateToolsDisplay();

    // Signals connection
    connectButtonSignals();
    connectFolderSignals();

    m_dlgWIMUConfig = NULL;
    m_wimuUSBDriver = NULL;
    m_wimuBLEDriver = NULL;
    m_centralWidget = NULL;
    m_sensorDisplay = NULL;
    m_wimuDateTime = QDateTime();
    m_timeSyncRequested = false;

    setWindowState(Qt::WindowMaximized);
    ui->grpProcess->setVisible(false); // Analysis hidden by default
    ui->stkControls->setCurrentWidget(ui->pgEmpty);
    ui->wdgCentral->setLayout(new QVBoxLayout());

    addToLog("Bienvenue dans le WIMU Studio 2! (Version 2.0.2)", WIMU::LogNormal);

    connect(&m_clock,SIGNAL(timeout()),this,SLOT(clockUpdate()));
    connect(&m_connectTimer,SIGNAL(timeout()),this,SLOT(usbConnect()));
    m_clock.setInterval(1000);
    m_clock.setSingleShot(false);
    m_clock.start();

    connect(ui->lstBLEDevices,SIGNAL(currentRowChanged(int)),this,SLOT(bleListCurrentChanged(int)));
}

MainWindow::~MainWindow()
{
    if (m_wimuUSBDriver){
        m_wimuUSBDriver->wimuDisconnect();
    }

    if (m_wimuBLEDriver){
        m_wimuBLEDriver->wimuDisconnect();
    }


    // Save settings
    m_appSettings->beginGroup("Recents");
    for (int i=0; i<ui->cmbPath->count(); i++){
        if (i>=5)
            break; // Escape if we have more than 5 items in the history
        m_appSettings->setValue("Folder" + QString::number(i+1), ui->cmbPath->itemText(i));
    }
    m_appSettings->endGroup();

    delete m_appSettings;

    delete ui;
}

void MainWindow::connectButtonSignals(){
    connect(ui->btnBLE,SIGNAL(clicked(bool)),this,SLOT(srcBLESelected()));
    connect(ui->btnDisk,SIGNAL(clicked(bool)),this,SLOT(srcFolderSelected()));
    connect(ui->btnUSB,SIGNAL(clicked(bool)),this,SLOT(srcUSBSelected()));
    connect(ui->btnWIMUConfig,SIGNAL(clicked(bool)),this,SLOT(wimuConfigRequested()));
    connect(ui->btnSettings,SIGNAL(clicked(bool)),this,SLOT(appSettingsRequested()));
    connect(ui->btnBLEConnect,SIGNAL(clicked(bool)),this,SLOT(btnBLEDeviceConnectClicked()));
    connect(ui->btnBLERecord,SIGNAL(clicked(bool)),this,SLOT(btnBLERecordClicked()));
    connect(ui->btnBrowse,SIGNAL(clicked(bool)),this,SLOT(btnBrowseClicked()));
}

void MainWindow::connectUSBSignals(){
    if (!m_wimuUSBDriver)
        return;

    connect(m_wimuUSBDriver,SIGNAL(comAboutToClose()),this,SLOT(usbAboutToClose()));
    connect(m_wimuUSBDriver,SIGNAL(comError(QSerialPort::SerialPortError)),this,SLOT(usbError(QSerialPort::SerialPortError)));
    connect(m_wimuUSBDriver,SIGNAL(cmdError(WIMUUSBDriver::WIMUCommandID)),this,SLOT(usbCmdError(WIMUUSBDriver::WIMUCommandID)));
    connect(m_wimuUSBDriver,SIGNAL(cmdOK(WIMUUSBDriver::WIMUCommandID)),this,SLOT(usbCmdOK(WIMUUSBDriver::WIMUCommandID)));
    connect(m_wimuUSBDriver,SIGNAL(cmdReply(QString,WIMUUSBDriver::WIMUCommandID)),this,SLOT(usbCmdReply(QString,WIMUUSBDriver::WIMUCommandID)));
    connect(m_wimuUSBDriver,SIGNAL(configReceived(WIMUConfig)),this,SLOT(usbConfigReceived(WIMUConfig)));
    connect(m_wimuUSBDriver,SIGNAL(settingsReceived(WIMUSettings)),this,SLOT(usbSettingsReceived(WIMUSettings)));
    connect(m_wimuUSBDriver,SIGNAL(timeReceived(QDateTime)),this,SLOT(usbTimeReceived(QDateTime)));
    connect(m_wimuUSBDriver,SIGNAL(binReceived(WIMUBinaryStream)),this,SLOT(usbBinDataReceived(WIMUBinaryStream)));
}

void MainWindow::connectUSBButtons(){
    ui->btnConnect->disconnect();
    ui->btnStream->disconnect();
    ui->btnSyncTime->disconnect();

    connect(ui->btnConnect,SIGNAL(clicked(bool)),this,SLOT(btnUSBConnectClicked()));
    connect(ui->btnSyncTime,SIGNAL(clicked(bool)),this,SLOT(btnUSBSyncTimeClicked()));
    connect(ui->btnStream,SIGNAL(clicked(bool)),this,SLOT(btnUSBStreamClicked()));
}

void MainWindow::connectBLESignals(){
    if (!m_wimuBLEDriver)
        return;

    connect(m_wimuBLEDriver,SIGNAL(comStatusString(QString)),this,SLOT(bleMessage(QString)));
    connect(m_wimuBLEDriver,SIGNAL(bleDeviceDestroyed(BLEDeviceContext*)),this,SLOT(bleDeviceDestroyed(BLEDeviceContext*)));
    connect(m_wimuBLEDriver,SIGNAL(bleDeviceDiscovered(BLEDeviceContext*)),this,SLOT(bleDeviceDiscovered(BLEDeviceContext*)));
    connect(m_wimuBLEDriver,SIGNAL(bleDeviceConnected(BLEDeviceContext*)),this,SLOT(bleDeviceConnected(BLEDeviceContext*)));
    connect(m_wimuBLEDriver,SIGNAL(timeReceived(QDateTime)),this,SLOT(usbTimeReceived(QDateTime)));
    connect(m_wimuBLEDriver,SIGNAL(imuDataReceived(WIMU::IMUFrame_Struct)),this,SLOT(bleIMUDataReceived(WIMU::IMUFrame_Struct)));
    connect(m_wimuBLEDriver,SIGNAL(imuConfigReceived(WIMU::IMUConfig_Struct)),this, SLOT(bleIMUConfigReceived(WIMU::IMUConfig_Struct)));
    connect(m_wimuBLEDriver,SIGNAL(remControlReceived(WIMUBLEDriver::BLERemControl_Struct)),this,SLOT(bleRemControlReceived(WIMUBLEDriver::BLERemControl_Struct)));
    connect(m_wimuBLEDriver,SIGNAL(battLevelReceived(quint8)),this,SLOT(bleBattReceived(quint8)));
    connect(m_wimuBLEDriver,SIGNAL(gpsDataReceived(WIMU::GPSNavData_Struct)),this,SLOT(bleGPSReceived(WIMU::GPSNavData_Struct)));

    connect(ui->lstBLEDevices,SIGNAL(doubleClicked(QModelIndex)),this,SLOT(bleListDeviceDoubleClicked(QModelIndex)));

}

void MainWindow::connectBLEButtons(){
    ui->btnConnect->disconnect();
    ui->btnStream->disconnect();
    ui->btnSyncTime->disconnect();

    connect(ui->btnConnect,SIGNAL(clicked(bool)),this,SLOT(btnBLEConnectClicked()));
    connect(ui->btnSyncTime,SIGNAL(clicked(bool)),this,SLOT(btnBLESyncTimeClicked()));
    connect(ui->btnStream,SIGNAL(clicked(bool)),this,SLOT(btnBLEStreamClicked()));
}

void MainWindow::connectFolderButtons(){

}

void MainWindow::connectFolderSignals(){
    connect(ui->cmbPath,SIGNAL(currentTextChanged(QString)),this,SLOT(folderPathChanged(QString)));
}

void MainWindow::srcBLESelected(){
    if (ui->btnBLE->isChecked()){
        ui->btnDisk->setChecked(false);
        ui->btnUSB->setChecked(false);
        ui->grpBLE->setVisible(true);
        ui->grpBLE->setEnabled(false);
        ui->grpBLEDevices->setVisible(false);
        ui->stkControls->setCurrentWidget(ui->pgUSBBLE);
        ui->grpProcess->setVisible(false);
        connectBLEButtons();
    }else{
        ui->stkControls->setCurrentWidget(ui->pgEmpty);
    }
    updateToolsDisplay();
}

void MainWindow::srcUSBSelected(){
    if (ui->btnUSB->isChecked()){
        ui->btnDisk->setChecked(false);
        ui->btnBLE->setChecked(false);
        ui->grpBLE->setVisible(false);
        ui->grpBLEDevices->setVisible(false);
        ui->stkControls->setCurrentWidget(ui->pgUSBBLE);
        ui->grpProcess->setVisible(false);
        connectUSBButtons();
    }else{
        ui->stkControls->setCurrentWidget(ui->pgEmpty);
    }
    updateToolsDisplay();
}

void MainWindow::srcFolderSelected(){
    if (ui->btnDisk->isChecked()){
        ui->btnBLE->setChecked(false);
        ui->btnUSB->setChecked(false);
        ui->grpProcess->setVisible(true);
        ui->stkControls->setCurrentWidget(ui->pgDisk);
    }else{
        ui->stkControls->setCurrentWidget(ui->pgEmpty);
    }
    updateToolsDisplay();
    clearFolderLists();
}

void MainWindow::wimuConfigRequested(){
    if (m_dlgWIMUConfig)
        m_dlgWIMUConfig->deleteLater();

    m_dlgWIMUConfig = new WIMUConfigDialog(this);
    m_dlgWIMUConfig->exec();

    m_dlgWIMUConfig->deleteLater();
    m_dlgWIMUConfig = NULL;
}

void MainWindow::appSettingsRequested(){

}

void MainWindow::updateToolsDisplay(){
    ui->cmbPath->setVisible(ui->btnDisk->isChecked());
    ui->btnBrowse->setVisible(ui->btnDisk->isChecked());
    ui->grpSources->updateGeometry();
    ui->lblBLERecNum->setVisible(ui->btnBLERecord->isChecked());
}

void MainWindow::addToLog(QString log, WIMU::LogTypes lt){
    QString format;
    switch (lt){
    case WIMU::LogNormal:
        format = "<span style='color:black'>";
        break;
    case WIMU::LogWarning:
        format = "<span style='color:orange;font-style:italic'>";
        break;
    case WIMU::LogError:
        format = "<span style='color:red;font-weight:bold'>";
        break;
    case WIMU::LogDebug:
        format = "<span style='color:grey;font-style:italic'>";
        break;
    case WIMU::LogInfo:
        format = "<span style='color:blue'>";
        break;
    }

    ui->txtLog->append("<span style='color:grey'>" + QTime::currentTime().toString("hh:mm:ss.zzz") + " </span>" + format + log + "</span>");
    ui->txtLog->ensureCursorVisible();
}

void MainWindow::btnUSBConnectClicked(){
    bool status = false;

    if (ui->btnConnect->isChecked()){ // Was just checked, so trying to connect...
        if (m_wimuUSBDriver){
            m_wimuUSBDriver->deleteLater();
        }

        m_wimuUSBDriver = new WIMUUSBDriver();
        connectUSBSignals();
        status = m_wimuUSBDriver->wimuFindAndPrepare();

        if (!status){
            // No WIMU
            addToLog("Aucun WIMU n'a été détecté. Vérifiez qu'il est bien branché et dans le bon mode.",WIMU::LogError);
            ui->btnConnect->setChecked(false);
            m_wimuUSBDriver->deleteLater();
            m_wimuUSBDriver = NULL;
            return;
        }else{
            addToLog("Connexion en cours: " + m_wimuUSBDriver->comGetPortName(),WIMU::LogDebug);
        }

        status = m_wimuUSBDriver->wimuConnect();

        if (status){
            addToLog("Connexion établie - " + m_wimuUSBDriver->comGetPortName(),WIMU::LogInfo);
            ui->btnConnect->setText(tr("Déconnecter"));
        }else{
            addToLog("Impossible de se connecter: " + m_wimuUSBDriver->comGetErrorString(),WIMU::LogError);
            ui->btnConnect->setChecked(false);
            return;
        }

        // Request config & settings
        m_wimuUSBDriver->wimuStream(false); // Stop streaming, if needed
        m_connectTimer.setInterval(200);
        m_connectTimer.setSingleShot(true);
        m_connectTimer.start();

        // Disable buttons while no config
        ui->btnSyncTime->setEnabled(false);
        ui->btnStream->setEnabled(false);

    }else{ // Was unchecked, so disconnect
       m_wimuUSBDriver->wimuDisconnect();
       m_wimuUSBDriver->deleteLater();
       m_wimuUSBDriver = NULL;
    }
}

void MainWindow::btnUSBSyncTimeClicked(){
    /*if (m_wimuUSBDriver)
        m_wimuUSBDriver->wimuSyncTime();

    addToLog("Date et heure synchronisés avec le WIMU", LogNormal);*/
    m_timeSyncRequested = true; // Will be synched on next clock update
    //m_wimuUSBDriver->wimuGetTime();
}

void MainWindow::btnUSBStreamClicked(){

    if (ui->btnStream->isChecked()){
        if (m_centralWidget){
            ui->wdgCentral->layout()->removeWidget(m_centralWidget);
            m_centralWidget->deleteLater();
        }
        if (m_sensorDisplay)
            m_sensorDisplay->deleteLater();
        m_sensorDisplay = new SensorDisplay(&m_wimuConfig);

        m_centralWidget = m_sensorDisplay;
        ui->wdgCentral->layout()->addWidget(m_centralWidget);

        ui->btnSyncTime->setEnabled(false);
        m_wimuUSBDriver->wimuStream(true);
    }else{
        m_wimuUSBDriver->wimuStream(false);
        ui->btnSyncTime->setEnabled(true);
    }

}

void MainWindow::btnBLEConnectClicked(){
    bool status = false;
    if (ui->btnConnect->isChecked()){ // Was just checked, so trying to connect...
        if (m_wimuBLEDriver){
            m_wimuBLEDriver->deleteLater();
        }

        m_wimuBLEDriver = new WIMUBLEDriver();
        connectBLESignals();
        status = m_wimuBLEDriver->bledFindAndPrepare();

        if (!status){
            // No BLED112
            addToLog(m_wimuBLEDriver->comGetErrorString(),WIMU::LogError);
            ui->btnConnect->setChecked(false);
            m_wimuBLEDriver->deleteLater();
            m_wimuBLEDriver = NULL;
            return;
        }else{
            addToLog("Connexion en cours: " + m_wimuBLEDriver->comGetPortName(),WIMU::LogDebug);
        }

        status = m_wimuBLEDriver->bledConnect();

        if (status){
            addToLog("Connexion établie - " + m_wimuBLEDriver->comGetPortName(),WIMU::LogInfo);
            ui->btnConnect->setText(tr("Déconnecter"));
        }else{
            addToLog("Impossible de se connecter: " + m_wimuBLEDriver->comGetErrorString(),WIMU::LogError);
            ui->btnConnect->setChecked(false);
            return;
        }

        ui->lstBLEDevices->clear();
        ui->lstBLEDevices->setEnabled(true);
        ui->btnBLEConnect->setEnabled(false);
        ui->grpBLEDevices->setVisible(true);
        ui->grpBLEDevices->setEnabled(true);

        ui->btnWIMUConfig->setEnabled(false);

        ui->btnBLE->setEnabled(false);
        ui->btnDisk->setEnabled(false);
        ui->btnUSB->setEnabled(false);

        ui->btnStream->setChecked(false);
        ui->btnStream->setEnabled(false);
        ui->btnSyncTime->setEnabled(false);

        ui->btnBLEConnect->setChecked(false);
        ui->btnBLEConnect->setText("Lier");

        // Request config & settings
        /*m_wimuUSBDriver->wimuStream(false); // Stop streaming, if needed
        m_connectTimer.setInterval(200);
        m_connectTimer.setSingleShot(true);
        m_connectTimer.start();*/

    }else{ // Was unchecked, so disconnect
       ui->grpBLEDevices->setVisible(false);
       m_wimuBLEDriver->bledDisconnect();
       m_wimuBLEDriver->deleteLater();
       m_wimuBLEDriver = NULL;

       ui->btnConnect->setText(tr("Connecter"));

       ui->btnWIMUConfig->setEnabled(true);

       ui->btnBLE->setEnabled(true);
       ui->btnDisk->setEnabled(true);
       ui->btnUSB->setEnabled(true);

       ui->btnStream->setChecked(false);
       ui->btnStream->setEnabled(false);
       ui->btnSyncTime->setEnabled(false);
       m_wimuDateTime = QDateTime();
    }
}

void MainWindow::btnBLESyncTimeClicked(){
    if (m_wimuBLEDriver){
        m_wimuBLEDriver->wimuSyncTime();
    }
}

void MainWindow::btnBLEStreamClicked(){
    // Start streaming data according to selected items
    if (ui->btnStream->isChecked()){
        if (m_centralWidget){
            ui->wdgCentral->layout()->removeWidget(m_centralWidget);
            m_centralWidget->deleteLater();
        }
        if (m_sensorDisplay)
            m_sensorDisplay->deleteLater();
        m_sensorDisplay = new SensorDisplay(&m_wimuConfig);

        m_centralWidget = m_sensorDisplay;
        ui->wdgCentral->layout()->addWidget(m_centralWidget);

        ui->btnSyncTime->setEnabled(false);

        m_wimuBLEDriver->wimuIMUStreaming(ui->chkBLEEnableIMU->isChecked());
        m_wimuBLEDriver->wimuRAWStreaming(ui->chkBLEEnableRaw->isChecked());
        m_wimuBLEDriver->wimuGPSStreaming(ui->chkBLEEnableGPS->isChecked());
        m_wimuBLEDriver->wimuBattStreaming(ui->chkBLEEnableBatt->isChecked());

    }else{
        m_wimuBLEDriver->wimuIMUStreaming(false);
        m_wimuBLEDriver->wimuRAWStreaming(false);
        m_wimuBLEDriver->wimuGPSStreaming(false);
        m_wimuBLEDriver->wimuBattStreaming(false);

        ui->btnSyncTime->setEnabled(true);
    }
}

void MainWindow::btnBLERecordClicked(){
    // Start/stop recording
    m_wimuBLEDriver->wimuRecord(ui->btnBLERecord->isChecked());

    if (ui->btnBLERecord->isChecked()){
        ui->btnBLERecord->setText("Arrêter Enregistrement");
    }else{
        ui->btnBLERecord->setText("Débuter Enregistrement");
    }

    ui->lblBLERecNum->setVisible(ui->btnBLERecord->isChecked());
    ui->btnStream->setEnabled(!ui->btnBLERecord->isChecked());
    ui->btnSyncTime->setEnabled(!ui->btnBLERecord->isChecked());

}

void MainWindow::usbAboutToClose(){
    addToLog("WIMU #" + QString::number(m_wimuSettings.id,16).toUpper() + " déconnecté",WIMU::LogInfo);

    ui->btnConnect->setChecked(false);
    ui->btnConnect->setText("Connecter");
    ui->btnSyncTime->setEnabled(false);
    ui->btnStream->setEnabled(false);
    ui->btnWIMUConfig->setEnabled(true);

    m_wimuConfig.setDefaults();
    m_wimuSettings.setDefaults();
    m_wimuDateTime = QDateTime();

    ui->btnBLE->setEnabled(true);
    ui->btnDisk->setEnabled(true);
    ui->btnUSB->setEnabled(true);
}

void MainWindow::usbError(QSerialPort::SerialPortError error){
    Q_UNUSED(error)

    addToLog("USB: " + m_wimuUSBDriver->comGetErrorString(),WIMU::LogError);

    m_wimuUSBDriver->wimuDisconnect();
    ui->btnSyncTime->setEnabled(false);

}

void MainWindow::usbCmdError(WIMUUSBDriver::WIMUCommandID id){
    Q_UNUSED(id)
    if (id==WIMUUSBDriver::WimuCmdGetSet){
        // Retry!
        m_wimuUSBDriver->wimuGetSettings();
        return;
    }

    if (id==WIMUUSBDriver::WimuCmdGetConf){
        // Retry!
        m_wimuUSBDriver->wimuGetConfig();
        return;
    }

    addToLog("Réponse du WIMU: ERREUR",WIMU::LogError);
}

void MainWindow::usbCmdOK(WIMUUSBDriver::WIMUCommandID id){
    Q_UNUSED(id)
    addToLog("Réponse du WIMU: OK",WIMU::LogNormal);
}

void MainWindow::usbCmdReply(QString reply, WIMUUSBDriver::WIMUCommandID id){
    Q_UNUSED(id)
    addToLog("Réponse du WIMU: " + reply,WIMU::LogNormal);
}

void MainWindow::usbConfigReceived(WIMUConfig config){

    // Check if config is valid
    if (config.general.sampling_rate!= 50 &&
        config.general.sampling_rate!= 100 &&
        config.general.sampling_rate!= 200){
        m_wimuUSBDriver->wimuGetConfig();
        return;
    }
    m_wimuConfig = config;

    addToLog("Échantillonnage à " + QString::number(config.general.sampling_rate) + "Hz", WIMU::LogDebug);

    // Enable buttons
    ui->btnSyncTime->setEnabled(true);
    ui->btnStream->setEnabled(true);
}

void MainWindow::usbSettingsReceived(WIMUSettings settings){
    m_wimuSettings = settings;

    addToLog("WIMU #" + QString::number(settings.id,16).toUpper() +
             ", Hardware v" + QString::number(settings.hw_id) +
             ", Firmware v" + settings.getFirmwareVersion(), WIMU::LogDebug);
}

void MainWindow::usbTimeReceived(QDateTime module_time){
    m_wimuDateTime = module_time;
    clockUpdate();
}

void MainWindow::usbBinDataReceived(WIMUBinaryStream bin){
    switch(bin.getModuleID()){
    case WIMU::MODULE_IMU:{
        WIMU::IMUFrame_Struct frame = bin.convertToIMUFrame();
        //qDebug() << "Frame: " << frame.frame_num;
        if (m_sensorDisplay)
            m_sensorDisplay->addIMUFrame(frame);
    }
        break;
    case WIMU::MODULE_GPS:{
        // Get message id
        int gps_msg_id = bin.getGPSMessageID();

        switch (gps_msg_id){
            case 4:{
                WIMU::GPSTrackerData_Struct gps_track = bin.convertToGPSTrackerData();
                if (m_sensorDisplay)
                    m_sensorDisplay->addGPSTrackerData(gps_track);
            }break;
            case 41:{
                WIMU::GPSNavData_Struct gps_nav = bin.convertToGPSNavData();
                if (m_sensorDisplay)
                    m_sensorDisplay->addGPSNavData(gps_nav);
            }break;
            default:
                qDebug() << "GPS MSG ID" << gps_msg_id << "received.";
            break;
        }

    }
        break;
    case WIMU::MODULE_POWER:{
        WIMU::PowerFrame_Struct power = bin.convertToPowerFrame();
        if (m_sensorDisplay)
            m_sensorDisplay->addPowerFrame(power);
    }
        break;
    default:
        qDebug() << "Data from module: " << bin.getModuleID();
    }
}

void MainWindow::clockUpdate(){
    QDateTime localtime = QDateTime::currentDateTime();
    ui->lblUSBSysClock->setText("<b>Heure actuelle</b>:<br>" + localtime.toString("dd MMMM yyyy - hh:mm:ss"));

    if (m_timeSyncRequested){
        if (m_wimuUSBDriver)
            m_wimuUSBDriver->wimuSyncTime();

        addToLog("Date et heure synchronisés avec le WIMU", WIMU::LogNormal);
        m_timeSyncRequested = false;
        return;
    }

    if (!m_wimuDateTime.isValid()){
        ui->lblUSBWIMUTime->setText("<b>Heure module</b>:<br>Inconnue");
        return;
    }

    if (m_wimuUSBDriver && !ui->btnStream->isChecked()){
        m_wimuUSBDriver->wimuGetTime();
    }else{
        m_wimuDateTime = m_wimuDateTime.addSecs(1);
    }

    QString color = "black";

    quint8 offset = localtime.offsetFromUtc();

    if (m_wimuBLEDriver)
        offset=0;

    if (qAbs(m_wimuDateTime.secsTo(localtime) + offset)>2){
        color = "red";
    }

    ui->lblUSBWIMUTime->setText("<b>Heure module</b>:<br><font color=" + color +">" + m_wimuDateTime.toString("dd MMMM yyyy - hh:mm:ss") + "</font>");

}

void MainWindow::usbConnect(){
    m_wimuUSBDriver->wimuGetSettings();
    m_wimuUSBDriver->wimuGetConfig();
    m_wimuUSBDriver->wimuGetTime();

    /*ui->btnSyncTime->setEnabled(true);
    ui->btnStream->setEnabled(true);*/
    ui->btnStream->setChecked(false);
    ui->btnWIMUConfig->setEnabled(false);

    ui->btnBLE->setEnabled(false);
    ui->btnDisk->setEnabled(false);
    ui->btnUSB->setEnabled(false);
}

void MainWindow::bleAboutToClose(){
    addToLog("BLE déconnecté",WIMU::LogInfo);

    ui->btnConnect->setChecked(false);
    ui->btnConnect->setText("Connecter");
    ui->btnSyncTime->setEnabled(false);
    ui->btnStream->setEnabled(false);
    ui->btnWIMUConfig->setEnabled(true);

    m_wimuConfig.setDefaults();
    m_wimuSettings.setDefaults();
    m_wimuDateTime = QDateTime();

    ui->btnBLE->setEnabled(true);
    ui->btnDisk->setEnabled(true);
    ui->btnUSB->setEnabled(true);


}

void MainWindow::bleMessage(QString msg){
    addToLog("BLE: " + msg, WIMU::LogNormal);
}

void MainWindow::bleDeviceDiscovered(BLEDeviceContext* device){
    addToLog(device->m_name.trimmed() + " découvert", WIMU::LogDebug);
    ui->lstBLEDevices->addItem(device->m_name.trimmed());
    ui->lstBLEDevices->item(ui->lstBLEDevices->count()-1)->setIcon(QIcon(":/icons/images/wimu.png"));

}

void MainWindow::bleDeviceDestroyed(BLEDeviceContext* device){

    addToLog(device->m_name.trimmed() + " disparu", WIMU::LogDebug);

    // If we were connected to that device...
    if (ui->lstBLEDevices->currentItem()){
        if (ui->lstBLEDevices->currentItem()->text() == device->m_name.trimmed()){
            // Disconnect
            ui->btnBLEConnect->setChecked(false);
            btnBLEDeviceConnectClicked();
        }
    }

    for (int i=0; i<ui->lstBLEDevices->count(); i++){
        if (ui->lstBLEDevices->item(i)->text() == device->m_name.trimmed()){
            ui->lstBLEDevices->takeItem(i);
            break;
        }
    }

}

void MainWindow::bleDeviceConnected(BLEDeviceContext* device){
    Q_UNUSED(device)

}

void MainWindow::bleListCurrentChanged(int new_row){

    if (new_row!=-1)
        ui->btnBLEConnect->setEnabled(true);
    else
        ui->btnBLEConnect->setEnabled(false);
}

void MainWindow::btnBLEDeviceConnectClicked(){
    if (ui->lstBLEDevices->currentRow()==-1)
        return;

    if (!m_wimuBLEDriver)
        return;

    if (ui->btnBLEConnect->isChecked()){ // Was just checked, so trying to connect...
        if (!m_wimuBLEDriver->wimuConnect(ui->lstBLEDevices->currentItem()->text())){
            addToLog("Impossible de connecter " + ui->lstBLEDevices->currentItem()->text() + "!", WIMU::LogError);
        }else{
            ui->lstBLEDevices->setEnabled(false);
            ui->btnBLEConnect->setText("Délier");
            addToLog("Connexion établie avec " + ui->lstBLEDevices->currentItem()->text(), WIMU::LogInfo);

            //ui->btnSyncTime->setEnabled(true);
            //ui->btnStream->setEnabled(true);
            ui->grpBLE->setEnabled(true);

            // Query module time
            //m_wimuBLEDriver->wimuGetTime();
        }
    }else{
        // Disconnect
        if (m_wimuBLEDriver->wimuIsConnected()){
            m_wimuBLEDriver->wimuDisconnect();
            ui->lstBLEDevices->setEnabled(true);
            ui->btnBLEConnect->setText("Lier");
            addToLog("Connexion rompue avec " + ui->lstBLEDevices->currentItem()->text(), WIMU::LogInfo);
            ui->btnSyncTime->setEnabled(false);
            ui->btnStream->setEnabled(false);
            ui->grpBLE->setEnabled(false);

            ui->btnStream->setChecked(false);
            m_wimuDateTime = QDateTime();
        }
    }
}

void MainWindow::bleIMUDataReceived(WIMU::IMUFrame_Struct data){
    //qDebug() << "BLE IMU Data";
    if (m_sensorDisplay)
        m_sensorDisplay->addIMUFrame(data);
}

void MainWindow::bleIMUConfigReceived(WIMU::IMUConfig_Struct config){
    // Fill the corresponding field in the WIMU Config in order for the sensor display to work properly...

    // Config received - enable buttons
    ui->btnSyncTime->setEnabled(true);
    ui->btnStream->setEnabled(true);
    m_wimuConfig.loadFromIMUConfig(config);
}

void MainWindow::bleRemControlReceived(WIMUBLEDriver::BLERemControl_Struct control){

    // Update the current record number label
    ui->lblBLERecNum->setText("Enregistrement #" + QString::number(control.rec_id));

    ui->lblBLERecNum->setVisible((control.status & 0x01)>0);

    // Ensure record button is in the correct state
    ui->btnBLERecord->setChecked((control.status & 0x01)>0);
    ui->btnStream->setEnabled(!ui->btnBLERecord->isChecked());
    ui->btnSyncTime->setEnabled(!ui->btnBLERecord->isChecked());
}

void MainWindow::bleBattReceived(quint8 batt_pc){
    //qDebug() << "BLE Batt Data";
    if (m_sensorDisplay){
        WIMU::PowerFrame_Struct power;
        power.battery_pc = batt_pc;
        power.battery = 0;
        power.charging = false; // Not yet available!
        power.temp = -100;      // Not yet available!
        power.status = WIMU::POWER_STATE_ON;    // Not yet available!
        m_sensorDisplay->addPowerFrame(power);
    }
}

void MainWindow::bleGPSReceived(WIMU::GPSNavData_Struct gps){
    //qDebug() << "BLE GPS Data";
    if (m_sensorDisplay){
        m_sensorDisplay->addGPSNavData(gps);
    }
}

void MainWindow::bleListDeviceDoubleClicked(QModelIndex index){
    Q_UNUSED(index)

    ui->btnBLEConnect->setChecked(true);
    // Link that device
    btnBLEDeviceConnectClicked();

}

void MainWindow::loadAppSettings(){
    m_appSettings = new QSettings(QSettings::IniFormat, QSettings::UserScope, "CDRV", "WIMU Studio 2");

    // Read recent folder paths (maximum last 5)
    m_appSettings->beginGroup("Recents");
    ui->cmbPath->insertItem(0,m_appSettings->value("Folder1","").toString());
    ui->cmbPath->insertItem(0,m_appSettings->value("Folder2","").toString());
    ui->cmbPath->insertItem(0,m_appSettings->value("Folder3","").toString());
    ui->cmbPath->insertItem(0,m_appSettings->value("Folder4","").toString());
    ui->cmbPath->insertItem(0,m_appSettings->value("Folder5","").toString());
    m_appSettings->endGroup();

    // Remove "empty" recent items
    for (int i=ui->cmbPath->count()-1; i>=0; i--){
        if (ui->cmbPath->itemText(i)=="")
            ui->cmbPath->removeItem(i);
    }
    ui->cmbPath->setCurrentIndex(-1); // Unselect everything


}

void MainWindow::btnBrowseClicked(){
    QFileDialog dialog(this);
    dialog.setFileMode(QFileDialog::Directory);
    dialog.setViewMode(QFileDialog::List);
    dialog.setOptions(QFileDialog::ShowDirsOnly | QFileDialog::DontUseNativeDialog
                      | QFileDialog::HideNameFilterDetails | QFileDialog::ReadOnly);

    dialog.setWindowTitle("Sélectionnez le répertoire de données");
    if (ui->cmbPath->currentText()!=""){
        dialog.setDirectory(ui->cmbPath->currentText());
    }else{
        if (ui->cmbPath->count()>0){
            dialog.setDirectory(ui->cmbPath->itemText(0));
        }
        else
            dialog.setDirectory(QCoreApplication::applicationDirPath());
    }

    if (dialog.exec()){
        if (dialog.selectedFiles().count()>0){
            ui->cmbPath->insertItem(0,dialog.selectedFiles().at(0));
            ui->cmbPath->setCurrentIndex(0);
        }
    }

}

void MainWindow::folderPathChanged(QString new_path){
    //qDebug() << "PATH = " << new_path;
    clearFolderLists();

    QDir folder(new_path);

    if (!folder.exists())
        return;

    // Add to list
    if (ui->cmbPath->findText(new_path)==-1){
        ui->cmbPath->insertItem(0,new_path);
    }

    // Get count of all base folders to estimate time & show progress dialog
    folder.setFilter(QDir::AllDirs | QDir::NoDotAndDotDot);
    quint16 folder_count = folder.count();
    QProgressDialog prog("Chargement des données...","Annuler",0,folder_count*2,this);
    prog.setWindowModality(Qt::WindowModal);
    prog.setMinimumDuration(0);

    // Get initial state of all data
    quint16 count=0;
    QFileInfo subfolder;
    DataTreeItem* current_item;

    folder.setSorting(QDir::Name | QDir::IgnoreCase | QDir::LocaleAware);
    foreach (subfolder,folder.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot)){
        if (subfolder.fileName().toLower()=="preprocess" || subfolder.fileName().toLower()=="processed")
            continue;
        // Level 1 - try to ID if we have a patient, experiment or data
        current_item = new DataTreeItem(subfolder.fileName(),
                                        identifyFolderType(subfolder),
                                        DataTreeItem::STATUS_INCOMPLETE,
                                        subfolder.absoluteFilePath());
        ui->treeDisk->addTopLevelItem(current_item);

        addItemToCorrectList(current_item);
        // Level 2 - search into subfolders
        loadFolders(subfolder, current_item);

        count++;
        prog.setValue(count);
        if (prog.wasCanceled())
            break;
        QCoreApplication::processEvents();
    }

    // Now browse each item and try and determine if we need preprocessing or not
    count = 0;
    prog.setValue(0);
    prog.setMaximum(m_listExperiments.count());
    prog.setLabelText("Chargement des données déjà pré-traitées...");
    QList<QString> toPreprocess;
    foreach (current_item, m_listExperiments){
        QDir current_folder(current_item->getPath());
        current_folder.setSorting(QDir::Name | QDir::IgnoreCase | QDir::LocaleAware);
        if (current_folder.entryList(QDir::AllDirs).contains("PreProcess",Qt::CaseInsensitive)){
            current_item->setStatus(DataTreeItem::STATUS_COMPLETE);
        }else{
            // Flag for preprocessing
            toPreprocess.append(current_item->getPath());
        }

        // Check if parent and, if so, check if all of its child are completed (to update status)
        if (current_item->parent()){
            quint16 completed_count=0;
            quint16 inprogress_count=0;
            for (int i=0; i<current_item->parent()->childCount(); i++){
                if (((DataTreeItem*)current_item->parent()->child(0))->getStatus() == DataTreeItem::STATUS_COMPLETE){
                    completed_count++;
                }
                if (((DataTreeItem*)current_item->parent()->child(0))->getStatus() == DataTreeItem::STATUS_INPROGRESS){
                    inprogress_count++;
                }
            }

            if (inprogress_count>0){
                ((DataTreeItem*)(current_item->parent()))->setStatus(DataTreeItem::STATUS_INPROGRESS);
            }else{
                if (completed_count==current_item->parent()->childCount())
                    ((DataTreeItem*)(current_item->parent()))->setStatus(DataTreeItem::STATUS_COMPLETE);
            }
        }

        // Update progress
        count++;
        prog.setValue(count);
        if (prog.wasCanceled())
            break;
        QCoreApplication::processEvents();
    }


    if (!toPreprocess.isEmpty()){
        // We have some preprocessing to do!
        // Check if we are on a removable media before doing preprocessing
        QStorageInfo storage(new_path);
        if (QString(storage.fileSystemType())=="FAT"){
            int confirm = QMessageBox::question(this,"Pré-traitement des données","Les données semblent se trouver sur un disque externe.\n\nIl n'est pas recommandé de les pré-traiter directement sur ce disque.\nDésirez-vous tout de même poursuivre?",QMessageBox::Yes,QMessageBox::No);
            if (confirm==QMessageBox::No){
                // Clear list
                toPreprocess.clear();
            }
        }

        // Start preprocessing...
        QString current_path;
        WimuProcessor processor(this);
        connect(&processor, SIGNAL(requestLogging(QString,WIMU::LogTypes)),this,SLOT(addToLog(QString,WIMU::LogTypes)));
        foreach (current_path, toPreprocess){
            processor.preProcess(current_path);
        }
        processor.disconnect();
    }

}


DataTreeItem::DataType MainWindow::identifyFolderType(QFileInfo& folder){
    DataTreeItem::DataType data_type = DataTreeItem::DATA_UNKNOWN;
    if (!QDir(folder.filePath()).entryList(QStringList("FILE_ID"),QDir::AllEntries).empty()){
        data_type = DataTreeItem::DATA_EXPERIMENT;
    }else{
        // Check if it contains something else
        if (!QDir(folder.filePath()).entryList(QStringList("*.DAT"),QDir::AllEntries).empty()){
            data_type = DataTreeItem::DATA_DATA;
        }
    }
    return data_type;
}

void MainWindow::loadFolders(QFileInfo &base_folder, DataTreeItem* base_item){

    QCoreApplication::processEvents();

    QFileInfo subFolder;
    DataTreeItem* current_item;
    QDir current_folder((base_folder.filePath()));
    current_folder.setSorting(QDir::Name | QDir::IgnoreCase | QDir::LocaleAware);

    foreach (subFolder,current_folder.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot)){
        if (subFolder.fileName().toLower()=="preprocess" || subFolder.fileName().toLower()=="processed")
            continue;

        DataTreeItem::DataType data_type = identifyFolderType(subFolder);
        current_item = new DataTreeItem(subFolder.fileName(),
                                        data_type,
                                        DataTreeItem::STATUS_INCOMPLETE,
                                        subFolder.absoluteFilePath());
        base_item->addChild(current_item);
        addItemToCorrectList(current_item);

        // If we have an experiment, parent is a patient
        if (data_type==DataTreeItem::DATA_EXPERIMENT){
            base_item->setDataType(DataTreeItem::DATA_PATIENT);
        }

       // Next level
        loadFolders(subFolder,current_item);
    }
}

void MainWindow::clearFolderLists(){
    // Clear all data
    ui->treeDisk->clear();

    m_listDatas.clear();
    m_listExperiments.clear();
    m_listPatients.clear();
}

void MainWindow::addItemToCorrectList(DataTreeItem* item){
    switch (item->getDataType()){
    case DataTreeItem::DATA_DATA:
        m_listDatas.append(item);
        break;
    case DataTreeItem::DATA_EXPERIMENT:
        m_listExperiments.append(item);
        break;
    case DataTreeItem::DATA_PATIENT:
        m_listPatients.append(item);
        break;
    default:
        break;
    }
}
