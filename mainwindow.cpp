#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    updateToolsDisplay();

    // Signals connection
    connectButtonSignals();

    m_dlgWIMUConfig = NULL;
    m_wimuUSBDriver = NULL;
    m_wimuBLEDriver = NULL;
    m_centralWidget = NULL;
    m_sensorDisplay = NULL;
    m_wimuDateTime = QDateTime();
    m_timeSyncRequested = false;

    setWindowState(Qt::WindowMaximized);
    ui->stkControls->setCurrentWidget(ui->pgEmpty);
    ui->wdgCentral->setLayout(new QVBoxLayout());

    addToLog("Bienvenue dans le WIMU Studio 2!", LogNormal);

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
    delete ui;
}

void MainWindow::connectButtonSignals(){
    connect(ui->btnBLE,SIGNAL(clicked(bool)),this,SLOT(srcBLESelected()));
    connect(ui->btnDisk,SIGNAL(clicked(bool)),this,SLOT(srcFolderSelected()));
    connect(ui->btnUSB,SIGNAL(clicked(bool)),this,SLOT(srcUSBSelected()));
    connect(ui->btnWIMUConfig,SIGNAL(clicked(bool)),this,SLOT(wimuConfigRequested()));
    connect(ui->btnSettings,SIGNAL(clicked(bool)),this,SLOT(appSettingsRequested()));
    connect(ui->btnBLEConnect,SIGNAL(clicked(bool)),this,SLOT(btnBLEDeviceConnectClicked()));

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

}

void MainWindow::connectBLEButtons(){
    ui->btnConnect->disconnect();
    ui->btnStream->disconnect();
    ui->btnSyncTime->disconnect();

    connect(ui->btnConnect,SIGNAL(clicked(bool)),this,SLOT(btnBLEConnectClicked()));
    connect(ui->btnSyncTime,SIGNAL(clicked(bool)),this,SLOT(btnBLESyncTimeClicked()));
    connect(ui->btnStream,SIGNAL(clicked(bool)),this,SLOT(btnBLEStreamClicked()));
}

void MainWindow::srcBLESelected(){
    if (ui->btnBLE->isChecked()){
        ui->btnDisk->setChecked(false);
        ui->btnUSB->setChecked(false);
        ui->grpBLE->setVisible(true);
        ui->grpBLE->setEnabled(false);
        ui->grpBLEDevices->setVisible(false);
        ui->stkControls->setCurrentWidget(ui->pgUSBBLE);
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
        ui->stkControls->setCurrentWidget(ui->pgDisk);
    }else{
        ui->stkControls->setCurrentWidget(ui->pgEmpty);
    }
    updateToolsDisplay();
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
    ui->txtPath->setVisible(ui->btnDisk->isChecked());
    ui->btnBrowse->setVisible(ui->btnDisk->isChecked());
    ui->grpSources->updateGeometry();
}

void MainWindow::addToLog(QString log, LogTypes lt){
    QString format;
    switch (lt){
    case LogNormal:
        format = "<span style='color:black'>";
        break;
    case LogWarning:
        format = "<span style='color:orange;font-style:italic'>";
        break;
    case LogError:
        format = "<span style='color:red;font-weight:bold'>";
        break;
    case LogDebug:
        format = "<span style='color:grey;font-style:italic'>";
        break;
    case LogInfo:
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
            addToLog("Aucun WIMU n'a été détecté. Vérifiez qu'il est bien branché et dans le bon mode.",LogError);
            ui->btnConnect->setChecked(false);
            m_wimuUSBDriver->deleteLater();
            m_wimuUSBDriver = NULL;
            return;
        }else{
            addToLog("Connexion en cours: " + m_wimuUSBDriver->comGetPortName(),LogDebug);
        }

        status = m_wimuUSBDriver->wimuConnect();

        if (status){
            addToLog("Connexion établie - " + m_wimuUSBDriver->comGetPortName(),LogInfo);
            ui->btnConnect->setText(tr("Déconnecter"));
        }else{
            addToLog("Impossible de se connecter: " + m_wimuUSBDriver->comGetErrorString(),LogError);
            ui->btnConnect->setChecked(false);
            return;
        }

        // Request config & settings
        m_wimuUSBDriver->wimuStream(false); // Stop streaming, if needed
        m_connectTimer.setInterval(200);
        m_connectTimer.setSingleShot(true);
        m_connectTimer.start();

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
            // No WIMU
            addToLog(m_wimuBLEDriver->comGetErrorString(),LogError);
            ui->btnConnect->setChecked(false);
            m_wimuBLEDriver->deleteLater();
            m_wimuBLEDriver = NULL;
            return;
        }else{
            addToLog("Connexion en cours: " + m_wimuBLEDriver->comGetPortName(),LogDebug);
        }

        status = m_wimuBLEDriver->bledConnect();

        if (status){
            addToLog("Connexion établie - " + m_wimuBLEDriver->comGetPortName(),LogInfo);
            ui->btnConnect->setText(tr("Déconnecter"));
        }else{
            addToLog("Impossible de se connecter: " + m_wimuBLEDriver->comGetErrorString(),LogError);
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
    }
}

void MainWindow::btnBLESyncTimeClicked(){
    if (m_wimuBLEDriver){
        m_wimuBLEDriver->wimuSyncTime();
    }
}

void MainWindow::btnBLEStreamClicked(){

}

void MainWindow::usbAboutToClose(){
    addToLog("WIMU #" + QString::number(m_wimuSettings.id,16).toUpper() + " déconnecté",LogInfo);

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

    addToLog("USB: " + m_wimuUSBDriver->comGetErrorString(),LogError);
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

    addToLog("Réponse du WIMU: ERREUR",LogError);
}

void MainWindow::usbCmdOK(WIMUUSBDriver::WIMUCommandID id){
    Q_UNUSED(id)
    addToLog("Réponse du WIMU: OK",LogNormal);
}

void MainWindow::usbCmdReply(QString reply, WIMUUSBDriver::WIMUCommandID id){
    Q_UNUSED(id)
    addToLog("Réponse du WIMU: " + reply,LogNormal);
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

    addToLog("Échantillonnage à " + QString::number(config.general.sampling_rate) + "Hz",LogDebug);
}

void MainWindow::usbSettingsReceived(WIMUSettings settings){
    m_wimuSettings = settings;

    addToLog("WIMU #" + QString::number(settings.id,16).toUpper() +
             ", Hardware v" + QString::number(settings.hw_id) +
             ", Firmware v" + settings.getFirmwareVersion(), LogDebug);
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

        addToLog("Date et heure synchronisés avec le WIMU", LogNormal);
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

    if (qAbs(m_wimuDateTime.secsTo(localtime) +  localtime.offsetFromUtc())>2){
        color = "red";
    }

    ui->lblUSBWIMUTime->setText("<b>Heure module</b>:<br><font color=" + color +">" + m_wimuDateTime.toString("dd MMMM yyyy - hh:mm:ss") + "</font>");

}

void MainWindow::usbConnect(){
    m_wimuUSBDriver->wimuGetSettings();
    m_wimuUSBDriver->wimuGetConfig();
    m_wimuUSBDriver->wimuGetTime();

    ui->btnSyncTime->setEnabled(true);
    ui->btnStream->setEnabled(true);
    ui->btnStream->setChecked(false);
    ui->btnWIMUConfig->setEnabled(false);

    ui->btnBLE->setEnabled(false);
    ui->btnDisk->setEnabled(false);
    ui->btnUSB->setEnabled(false);
}

void MainWindow::bleAboutToClose(){
    addToLog("BLE déconnecté",LogInfo);

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
    addToLog("BLE: " + msg, LogNormal);
}

void MainWindow::bleDeviceDiscovered(BLEDeviceContext* device){
    addToLog(device->m_name.trimmed() + " découvert",LogDebug);
    ui->lstBLEDevices->addItem(device->m_name.trimmed());
    ui->lstBLEDevices->item(ui->lstBLEDevices->count()-1)->setIcon(QIcon(":/icons/images/wimu.png"));

}

void MainWindow::bleDeviceDestroyed(BLEDeviceContext* device){

    addToLog(device->m_name.trimmed() + " disparu",LogDebug);

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
            addToLog("Impossible de connecter " + ui->lstBLEDevices->currentItem()->text() + "!", LogError);
        }else{
            ui->lstBLEDevices->setEnabled(false);
            ui->btnBLEConnect->setText("Délier");
            addToLog("Connexion établie avec " + ui->lstBLEDevices->currentItem()->text(), LogInfo);

            ui->btnSyncTime->setEnabled(true);
            ui->btnStream->setEnabled(true);
            ui->grpBLE->setEnabled(true);

            // Query module time
            //m_wimuBLEDriver->wimuGetTime();
        }
    }else{
        // Disconnect
        m_wimuBLEDriver->wimuDisconnect();
        ui->lstBLEDevices->setEnabled(true);
        ui->btnBLEConnect->setText("Lier");
        addToLog("Connexion rompue avec " + ui->lstBLEDevices->currentItem()->text(), LogInfo);
        ui->btnSyncTime->setEnabled(false);
        ui->btnStream->setEnabled(false);
        ui->grpBLE->setEnabled(false);
    }
}
