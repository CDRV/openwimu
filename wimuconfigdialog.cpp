#include "wimuconfigdialog.h"
#include "ui_wimuconfigdialog.h"

#include <QDebug>
#include <QFileDialog>
#include <QMessageBox>
#include <QtSerialPort/QSerialPortInfo>

WIMUConfigDialog::WIMUConfigDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::WIMUConfigDialog)
{
    ui->setupUi(this);

    // Set correct component ID in list
    ui->lstComponents->item(0)->setData(Qt::UserRole,WIMUConfig::MODULE_ACC);
    ui->lstComponents->item(1)->setData(Qt::UserRole,WIMUConfig::MODULE_GYRO);
    ui->lstComponents->item(2)->setData(Qt::UserRole,WIMUConfig::MODULE_MAGNETO);
    ui->lstComponents->item(3)->setData(Qt::UserRole,WIMUConfig::MODULE_GPS);
    ui->lstComponents->item(4)->setData(Qt::UserRole,WIMUConfig::MODULE_DATALOGGER);
    ui->lstComponents->item(5)->setData(Qt::UserRole,WIMUConfig::MODULE_BLE);
    ui->lstComponents->item(6)->setData(Qt::UserRole,WIMUConfig::MODULE_IMU);

    // Connect signals
    connectCheckBoxSignals();
    connectButtonsSignals();
    connectGeneralUISignals();

    // Set default states
    initUIState();
    m_serialPort = NULL;
    WIMUConfig default_config;
    loadFromConfig(&default_config);

    m_lastSerialCmd="";
    m_serialBuffer.clear();

    // Start clock timer
    connect(&m_clock,SIGNAL(timeout()),this,SLOT(clockUpdate()));
    m_clock.setInterval(1000);
    m_clock.setSingleShot(false);
    m_clock.start();

    m_wimuDateTime.setDate(QDate());
    m_wimuDateTime.setTime(QTime());

}

WIMUConfigDialog::~WIMUConfigDialog()
{
    if (m_serialPort){
        m_serialPort->close();
        m_serialPort->deleteLater();
    }

    delete ui;
}

void WIMUConfigDialog::configSectionChanged(int newIndex){
    for (int i=0; i<ui->boxOptions->count(); i++){
        if (i!=newIndex)
            ui->boxOptions->setItemIcon(i, QIcon(":/icons/images/branch_closed.png"));
        else
            ui->boxOptions->setItemIcon(i, QIcon(":/icons/images/branch_opened.png"));
    }
}

void WIMUConfigDialog::configGeneralClicked(QListWidgetItem* item){
    ui->wdgPanels->setCurrentIndex(ui->lstGeneral->row(item)+1);
}

void WIMUConfigDialog::configComponentClicked(QListWidgetItem* item){
    ui->wdgPanels->setCurrentIndex(ui->lstGeneral->count() + ui->lstComponents->row(item) + 1);
}

void WIMUConfigDialog::configToolsClicked(QListWidgetItem* item){
    ui->wdgPanels->setCurrentIndex(ui->lstGeneral->count() + ui->lstComponents->count() + ui->lstTools->row(item) + 1);
}

void WIMUConfigDialog::configComponentItemChanged(QListWidgetItem* item){
    // Disable signal for now
    disconnect(ui->lstComponents,SIGNAL(itemChanged(QListWidgetItem*)),0,0);

    if (item->checkState()!=Qt::Checked){
        // Disable item
        item->setIcon(getIconForComponent(item->data(Qt::UserRole).toInt(),false));
        item->setTextColor(Qt::darkGray);
    }else{
        // Enable item
        item->setIcon(getIconForComponent(item->data(Qt::UserRole).toInt(),true));
        item->setTextColor(Qt::black);
    }

    // Link associated checkbox
    QCheckBox* chk = getActiveChkBox(item->data(Qt::UserRole).toInt());
    if (chk){
        chk->setCheckState(item->checkState());
    }

    // Reconnect signal
    connect(ui->lstComponents,SIGNAL(itemChanged(QListWidgetItem*)),this,SLOT(configComponentItemChanged(QListWidgetItem*)));

}

QIcon WIMUConfigDialog::getIconForComponent(int index, bool enabled){
    QString icon_path = "";
    switch (index){
    case WIMUConfig::MODULE_ACC: // Accelero
        icon_path = ":/icons/images/accelero";
        break;
    case WIMUConfig::MODULE_GYRO: // Gyro
        icon_path = ":/icons/images/gyro";
        break;
    case WIMUConfig::MODULE_MAGNETO: // Magneto
        icon_path = ":/icons/images/magnet";
        break;
    case WIMUConfig::MODULE_GPS: // GPS
        icon_path = ":/icons/images/gps";
        break;
    case WIMUConfig::MODULE_DATALOGGER: // Logger
        icon_path = ":/icons/images/logging";
        break;
    case WIMUConfig::MODULE_BLE: // BLE
        icon_path = ":/icons/images/ble";
        break;
    case WIMUConfig::MODULE_IMU: // IMU
        icon_path = ":/icons/images/IMU";
        break;
    default:
        break;
    }

    if (icon_path.isEmpty())
        return QIcon();

    if (!enabled)
        icon_path += "_off";

    icon_path+=".png";

    return QIcon(icon_path);
}

QCheckBox* WIMUConfigDialog::getActiveChkBox(int index){
    switch (index){
    case WIMUConfig::MODULE_ACC: // Accelero
        return ui->chkAcc;
        break;
    case WIMUConfig::MODULE_GYRO: // Gyro
        return ui->chkGyro;
        break;
    case WIMUConfig::MODULE_MAGNETO: // Magneto
        return ui->chkMag;
        break;
    case WIMUConfig::MODULE_GPS: // GPS
        return ui->chkGPS;
        break;
    case WIMUConfig::MODULE_DATALOGGER: // Logger
        return ui->chkLogger;
        break;
    case WIMUConfig::MODULE_BLE: // BLE
        return ui->chkBLE;
        break;
    case WIMUConfig::MODULE_IMU: // IMU
        return ui->chkIMU;
        break;
    default:
        break;
    }

    return NULL;
}

void WIMUConfigDialog::manageCheckBoxClicked(){
    // Find emitting widget
    QCheckBox* check = (QCheckBox*)sender();
    if (check){
        if (check->objectName()=="chkDateTimeGPS"){
            ui->lblDateTimeGPSWarning->setVisible(check->isChecked());
            ui->chkDateTimeAutoOffset->setVisible(check->isChecked());
            ui->lblDateTimeOffset->setVisible(!ui->chkDateTimeAutoOffset->isChecked() || !check->isChecked());
            ui->spinDateTimeOffset->setVisible(!ui->chkDateTimeAutoOffset->isChecked() || !check->isChecked());
        }
        if (check->objectName()=="chkDateTimeAutoOffset"){
            ui->lblDateTimeOffset->setVisible(!ui->chkDateTimeAutoOffset->isChecked());
            ui->spinDateTimeOffset->setVisible(!ui->chkDateTimeAutoOffset->isChecked());
        }
        if (check->objectName()=="chkUIBlinkLED"){
            ui->frameUIBlinkLED->setVisible(check->isChecked());
        }
        if (check->objectName()=="chkPowerPowerSaving"){
            ui->chkPowerAdvPowerSaving->setVisible(check->isChecked());
            ui->chkPowerActivityDetection->setVisible(check->isChecked() && ui->chkPowerAdvPowerSaving->isChecked());
        }
        if (check->objectName()=="chkPowerAdvPowerSaving"){
            ui->chkPowerActivityDetection->setVisible(check->isChecked());
        }

        // Enablers
        if (check->objectName()=="chkAcc"){
            ui->lstComponents->item(0)->setCheckState(check->checkState());
        }
        if (check->objectName()=="chkGyro"){
            ui->lstComponents->item(1)->setCheckState(check->checkState());
        }
        if (check->objectName()=="chkMag"){
            ui->lstComponents->item(2)->setCheckState(check->checkState());
        }
        if (check->objectName()=="chkGPS"){
            ui->lstComponents->item(3)->setCheckState(check->checkState());
        }
        if (check->objectName()=="chkLogger"){
            ui->lstComponents->item(4)->setCheckState(check->checkState());
        }
        if (check->objectName()=="chkBLE"){
            ui->lstComponents->item(5)->setCheckState(check->checkState());
        }
        if (check->objectName()=="chkIMU"){
            ui->lstComponents->item(6)->setCheckState(check->checkState());
        }
    }
}

void WIMUConfigDialog::connectCheckBoxSignals(){
    connect(ui->chkDateTimeGPS,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkDateTimeAutoOffset,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkUIBlinkLED, SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkPowerPowerSaving,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkPowerAdvPowerSaving,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));

    connect(ui->chkAcc,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkGyro,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkMag,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkGPS,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkLogger,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkBLE,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));
    connect(ui->chkIMU,SIGNAL(stateChanged(int)),this,SLOT(manageCheckBoxClicked()));

}

void WIMUConfigDialog::connectButtonsSignals(){
    connect(ui->btnDefault,SIGNAL(clicked(bool)),this,SLOT(buttonDefaultClicked()));
    connect(ui->btnSaveConfig,SIGNAL(clicked(bool)),this,SLOT(buttonSaveConfigClicked()));
    connect(ui->btnLoadConfig,SIGNAL(clicked(bool)),this,SLOT(buttonLoadConfigClicked()));
    connect(ui->btnConnect,SIGNAL(clicked(bool)),this,SLOT(buttonConnectClicked()));
    connect(ui->btnClearConsole,SIGNAL(clicked(bool)),this,SLOT(buttonConsoleEraseClicked()));
    connect(ui->btnConsoleSend,SIGNAL(clicked(bool)),this,SLOT(buttonConsoleSendClicked()));
    connect(ui->btnReadConfig,SIGNAL(clicked(bool)),this,SLOT(buttonReadConfigClicked()));
    connect(ui->btnSaveSettings,SIGNAL(clicked(bool)),this,SLOT(buttonWriteSettingsClicked()));
    connect(ui->btnWriteConfig,SIGNAL(clicked(bool)),this,SLOT(buttonWriteConfigClicked()));
    connect(ui->btnReset,SIGNAL(clicked(bool)),this,SLOT(buttonResetClicked()));
    connect(ui->btnSyncTime,SIGNAL(clicked(bool)),this,SLOT(buttonSyncTimeClicked()));
}

void WIMUConfigDialog::connectSerialPortSignals(){
    if (m_serialPort){
        connect(m_serialPort,SIGNAL(aboutToClose()),this,SLOT(serialPortAboutToClose()));
        connect(m_serialPort,SIGNAL(readyRead()), this, SLOT(serialPortDataReady()));
        connect(m_serialPort,SIGNAL(bytesWritten(qint64)),this,SLOT(serialPortBytesWritten(qint64)));
        connect(m_serialPort,SIGNAL(error(QSerialPort::SerialPortError)),this, SLOT(serialPortError(QSerialPort::SerialPortError)));
    }
}

void WIMUConfigDialog::connectGeneralUISignals(){
    // Config Sections navigator
    connect(ui->boxOptions,SIGNAL(currentChanged(int)),this,SLOT(configSectionChanged(int)));
    connect(ui->lstGeneral,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(configGeneralClicked(QListWidgetItem*)));
    connect(ui->lstComponents,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(configComponentClicked(QListWidgetItem*)));
    connect(ui->lstComponents,SIGNAL(itemChanged(QListWidgetItem*)),this,SLOT(configComponentItemChanged(QListWidgetItem*)));
    connect(ui->lstTools,SIGNAL(itemClicked(QListWidgetItem*)),this,SLOT(configToolsClicked(QListWidgetItem*)));

    // Console
    connect(ui->txtConsoleCmd,SIGNAL(returnPressed()),this,SLOT(buttonConsoleSendClicked()));
    //connect(ui->txtConsoleCmd,SIGNAL(textChanged(QString)),ui->txtConsoleCmd,SLOT(setFocus()));

}

void WIMUConfigDialog::buttonDefaultClicked(){
    //TODO: Message box to confirm

    WIMUConfig default_config;
    loadFromConfig(&default_config);
}

void WIMUConfigDialog::buttonSaveConfigClicked(){
    // Open file dialog
    QString filename = QFileDialog::getSaveFileName(this,
                                                    "Choisissez le fichier à sauvegarder",
                                                    QString(),
                                                    tr("Fichier de configuration (*.wcf)"));

    if (filename.isEmpty())
        return;

    WIMUConfig config;
    saveToConfig(&config);

    if (config.saveToFile(filename)){
        QMessageBox::information(this,"Confirmation","Fichier " + filename + " sauvegardé!");
    }else{
        QMessageBox::warning(this,"Erreur","Fichier " + filename + " NON sauvegardé");
    }

}

void WIMUConfigDialog::buttonLoadConfigClicked(){
    // Open file dialog
    QString filename = QFileDialog::getOpenFileName(this,
                                                    tr("Choisissez le fichier à ouvrir"),
                                                    QString(),
                                                    tr("Fichier de configuration (*.wcf)"));

    if (filename.isEmpty())
        return;

    WIMUConfig config;

    if (config.loadFromFile(filename)){
        loadFromConfig(&config);
        QMessageBox::information(this,"Confirmation","Fichier " + filename + " chargé!");
    }else{
        QMessageBox::warning(this,"Erreur","Fichier " + filename + " NON chargé");
    }
}

void WIMUConfigDialog::buttonConsoleEraseClicked(){
    ui->txtConsole->clear();
}

void WIMUConfigDialog::buttonConsoleSendClicked(){
    if (!ui->btnConsoleSend->isEnabled()) return;

    ui->btnConsoleSend->setFocus();
    if (!m_serialPort || ui->txtConsoleCmd->text().isEmpty())
        return; // No port = no sending!

    wimuSendCommand(ui->txtConsoleCmd->text());

    // Clear text zone
    ui->txtConsoleCmd->clear();

}

void WIMUConfigDialog::buttonReadConfigClicked(){
    if (m_serialPort)
        wimuSendCommand("getconf");
}

void WIMUConfigDialog::buttonWriteSettingsClicked(){
    // Pack data
    WIMUSettings settings;
    saveToSettings(&settings);

    QByteArray data = settings.serialize();
    data.insert(0,QString("setset"));
    data.append("\n\r");

    m_lastSerialCmd = "setset";

    wimuSendData(data);

}

void WIMUConfigDialog::buttonWriteConfigClicked(){
    // Pack data
    WIMUConfig config;
    saveToConfig(&config);

    QByteArray data = config.serialize();
    data.insert(0,QString("setconf"));
    data.append("\n\r");

    m_lastSerialCmd = "setconf";

    wimuSendData(data);

}

void WIMUConfigDialog::buttonResetClicked(){
    QMessageBox::StandardButton conf = QMessageBox::question(this,"Redémarrage?","Si le module est redémarré, la connexion avec celui-ci sera perdue.\nDésirez-vous vraiment poursuivre?");

    if (conf == QMessageBox::Yes){
        wimuSendCommand("reboot");

        m_serialPort->waitForBytesWritten(-1);
        buttonConnectClicked(); // Disconnect
    }
}

void WIMUConfigDialog::buttonSyncTimeClicked(){
    QDateTime local_date = QDateTime::currentDateTime();
    QString datestr = QString::number(QDateTime::currentDateTime().toTime_t()+local_date.offsetFromUtc());

    m_wimuDateTime = QDateTime();

    wimuSendCommand("timeset " + datestr);
}

void WIMUConfigDialog::addToConsole(QString text, bool sent){

    // Set color depending on if sent or not
    QString color = "lightgreen";

    if (sent)
        color = "cyan";

    text.replace("\n\r","");
    text = "<font color=" + color + ">" + text + "</font>";

    ui->txtConsole->append(text);
    ui->txtConsole->ensureCursorVisible();
}

void WIMUConfigDialog::initUIState(){
    ui->wdgPanels->setCurrentIndex(0);
    ui->boxOptions->setCurrentIndex(0);
    ui->frameConnected->setVisible(false);
    ui->lstTools->setVisible(false);
    ui->lblWIMUNotConnected->setVisible(true);

    // Date & Time
    ui->chkDateTimeGPS->setChecked(false);
    ui->lblDateTimeGPSWarning->setVisible(false);
    ui->chkDateTimeAutoOffset->setVisible(false);

    // User Interface
    ui->frameUIBlinkLED->setVisible(false);

    // Power Saving
    ui->chkPowerAdvPowerSaving->setVisible(false);
    ui->chkPowerActivityDetection->setVisible(false);

}

void WIMUConfigDialog::loadFromConfig(WIMUConfig* config){

    // Date & Time
    ui->chkDateTimeAutoOffset->setChecked(config->datetime.enable_auto_offset);
    ui->chkDateTimeGPS->setChecked(config->datetime.enable_gps_time);
    ui->spinDateTimeOffset->setValue(config->datetime.time_offset);
    ui->chkDateTimeAutoOffset->setVisible(config->datetime.enable_gps_time);
    ui->spinDateTimeOffset->setVisible(!config->datetime.enable_gps_time || !config->datetime.enable_auto_offset);

    // User Interface
    ui->chkUIBlinkLED->setChecked(config->ui.led_blink_time>0);
    ui->frameUIBlinkLED->setVisible(config->ui.led_blink_time>0);
    ui->spinUIBlinkLED->setValue(config->ui.led_blink_time);
    ui->chkUIBLELED->setChecked(config->ui.ble_activity_led);
    ui->chkUIGPSFixLED->setChecked(config->ui.gps_fix_led);
    ui->chkUIMark->setChecked(config->ui.enable_marking);
    ui->chkUIWriteLED->setChecked(config->ui.write_led);

    // Power Saving
    ui->chkPowerPowerSaving->setChecked(config->power.power_manage);
    ui->chkPowerAdvPowerSaving->setChecked(config->power.adv_power_manage);
    ui->chkPowerAdvPowerSaving->setVisible(config->power.power_manage);
    ui->chkPowerActivityDetection->setChecked(config->power.enable_motion_detection);
    ui->chkPowerActivityDetection->setVisible(config->power.adv_power_manage);

    // Options
    ui->chkOptionsWatchdog->setChecked(config->general.enable_watchdog);
    ui->cmbOptionsSampling->setCurrentIndex(-1);
    for (int i=0; i<ui->cmbOptionsSampling->count(); i++){
        if (ui->cmbOptionsSampling->itemText(i).toInt() == config->general.sampling_rate){
            ui->cmbOptionsSampling->setCurrentIndex(i);
            break;
        }
    }

    // Accelero
    ui->chkAcc->setChecked(config->isModuleEnabled(WIMUConfig::MODULE_ACC));
    if (config->isModuleEnabled(WIMUConfig::MODULE_ACC))
        ui->lstComponents->item(0)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(0)->setCheckState(Qt::Unchecked);
    ui->cmbAccRange->setCurrentIndex(config->acc.range);

    // Gyro
    ui->chkGyro->setChecked(config->isModuleEnabled(WIMUConfig::MODULE_GYRO));
        if (config->isModuleEnabled(WIMUConfig::MODULE_GYRO))
            ui->lstComponents->item(1)->setCheckState(Qt::Checked);
        else
            ui->lstComponents->item(1)->setCheckState(Qt::Unchecked);
    ui->cmbGyroRange->setCurrentIndex(config->gyro.range);

    // Magneto
    ui->chkMag->setChecked(config->isModuleEnabled(WIMUConfig::MODULE_MAGNETO));
    if (config->isModuleEnabled(WIMUConfig::MODULE_MAGNETO))
        ui->lstComponents->item(2)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(2)->setCheckState(Qt::Unchecked);
    ui->cmbMagRange->setCurrentIndex(config->magneto.range);

    // GPS
    ui->chkGPS->setChecked(config->isModuleEnabled(WIMUConfig::MODULE_GPS));
    if (config->isModuleEnabled(WIMUConfig::MODULE_GPS))
        ui->lstComponents->item(3)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(3)->setCheckState(Qt::Unchecked);
    ui->chkGPSColdStart->setChecked(config->gps.force_cold);
    ui->spinGPSSampling->setValue(config->gps.interval);
    ui->chkGPSAutoWake->setChecked(config->gps.enable_scan_when_charged);

    // Logger
    ui->chkLogger->setChecked(config->isModuleEnabled(WIMUConfig::MODULE_DATALOGGER));
    if (config->isModuleEnabled(WIMUConfig::MODULE_DATALOGGER))
        ui->lstComponents->item(4)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(4)->setCheckState(Qt::Unchecked);
    ui->chkLoggerSplit->setChecked(config->logger.split_by_day);
    ui->spinLoggerFileNum->setValue(config->logger.max_files_in_folder);

    // BLE
    ui->chkBLE->setChecked(config->isModuleEnabled(WIMUConfig::MODULE_BLE));
    if (config->isModuleEnabled(WIMUConfig::MODULE_BLE))
        ui->lstComponents->item(5)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(5)->setCheckState(Qt::Unchecked);
    ui->chkBLEControl->setChecked(config->ble.enable_control);

    // IMU
    ui->chkIMU->setChecked(config->isModuleEnabled(WIMUConfig::MODULE_IMU));
    if (config->isModuleEnabled(WIMUConfig::MODULE_IMU))
        ui->lstComponents->item(6)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(6)->setCheckState(Qt::Unchecked);
    ui->chkIMUAutoCalib->setChecked(config->imu.auto_calib_gyro);
    ui->chkIMUNoMag->setChecked(config->imu.disable_magneto);
    ui->txtIMUBeta->setText(QString::number(config->imu.beta));

}

void WIMUConfigDialog::loadFromSettings(WIMUSettings* settings){
    // Versions
    ui->lblHardwareValue->setText(QString::number(settings->hw_id));
    ui->lblFirmwareValue->setText(settings->getFirmwareVersion());

    // ID
    ui->txtID->setText(QString::number(settings->id,16));

    // Calibration
    for (int i=0; i<3; i++){
        ui->tblGains->item(0,i)->setText(QString::number(settings->acc_gain[i]));
        ui->tblGains->item(1,i)->setText(QString::number(settings->gyro_gain[i]));
        ui->tblGains->item(2,i)->setText(QString::number(settings->mag_gain[i]));

        ui->tblOffsets->item(0,i)->setText(QString::number(settings->acc_offset[i]));
        ui->tblOffsets->item(1,i)->setText(QString::number(settings->gyro_offset[i]));
        ui->tblOffsets->item(2,i)->setText(QString::number(settings->mag_offset[i]));
    }

}

void WIMUConfigDialog::saveToSettings(WIMUSettings* settings){
    // ID
    settings->id = ui->txtID->text().toInt(NULL,16);
    settings->hw_id = ui->lblHardwareValue->text().toInt();

    // Calibration
    for (int i=0; i<3; i++){
        settings->acc_gain[i] = ui->tblGains->item(0,i)->text().toInt();
        settings->gyro_gain[i] = ui->tblGains->item(1,i)->text().toInt();
        settings->mag_gain[i] = ui->tblGains->item(2,i)->text().toInt();

        settings->acc_offset[i] = ui->tblOffsets->item(0,i)->text().toInt();
        settings->gyro_offset[i] = ui->tblOffsets->item(1,i)->text().toInt();
        settings->mag_offset[i] = ui->tblOffsets->item(2,i)->text().toInt();

    }
}

void WIMUConfigDialog::saveToConfig(WIMUConfig* config){

    /*if (config){
        config->deleteLater();
    }
    config = new WIMUConfig();*/

    // Date & Time
    config->datetime.enable_auto_offset = ui->chkDateTimeAutoOffset->isChecked();
    config->datetime.enable_gps_time = ui->chkDateTimeGPS->isChecked();
    config->datetime.time_offset = ui->spinDateTimeOffset->value();

    // User Interface
    if (!ui->chkUIBlinkLED->isChecked()){
        config->ui.led_blink_time=0;
    }else{
        config->ui.led_blink_time = ui->spinUIBlinkLED->value();
    }
    config->ui.ble_activity_led = ui->chkUIBLELED->isChecked();
    config->ui.gps_fix_led = ui->chkUIGPSFixLED->isChecked();
    config->ui.enable_marking = ui->chkUIMark->isChecked();
    config->ui.write_led = ui->chkUIWriteLED->isChecked();

    // Power Saving
    config->power.power_manage = ui->chkPowerPowerSaving->isChecked();
    config->power.adv_power_manage = config->power.adv_power_manage;
    config->power.enable_motion_detection = ui->chkPowerActivityDetection->isChecked();

    // Options
    config->general.enable_watchdog = ui->chkOptionsWatchdog->isChecked();
    config->general.sampling_rate = ui->cmbOptionsSampling->currentText().toInt();

    // Accelero
    config->enableModule(WIMUConfig::MODULE_ACC,ui->chkAcc->isChecked());
    config->acc.range = ui->cmbAccRange->currentIndex();

    // Gyro
    config->enableModule(WIMUConfig::MODULE_GYRO,ui->chkGyro->isChecked());
    config->gyro.range = ui->cmbGyroRange->currentIndex();

    // Magneto
    config->enableModule(WIMUConfig::MODULE_MAGNETO,ui->chkMag->isChecked());
    config->magneto.range = ui->cmbMagRange->currentIndex();

    // GPS
    config->enableModule(WIMUConfig::MODULE_GPS,ui->chkGPS->isChecked());
    config->gps.force_cold = ui->chkGPSColdStart->isChecked();
    config->gps.interval = ui->spinGPSSampling->value();
    config->gps.enable_scan_when_charged = ui->chkGPSAutoWake->isChecked();

    // Logger
    config->enableModule(WIMUConfig::MODULE_DATALOGGER,ui->chkLogger->isChecked());
    config->logger.split_by_day = ui->chkLoggerSplit->isChecked();
    config->logger.max_files_in_folder = ui->spinLoggerFileNum->value();

    // BLE
    config->enableModule(WIMUConfig::MODULE_BLE,ui->chkBLE->isChecked());
    config->ble.enable_control = ui->chkBLEControl->isChecked();

    // IMU
    config->enableModule(WIMUConfig::MODULE_IMU,ui->chkIMU->isChecked());
    config->imu.auto_calib_gyro = ui->chkIMUAutoCalib->isChecked();
    config->imu.disable_magneto = ui->chkIMUNoMag->isChecked();
    config->imu.beta = ui->txtIMUBeta->text().toFloat();

}

void WIMUConfigDialog::buttonConnectClicked(){

    // Delete previous serial port
    if (m_serialPort){
        if (m_serialPort->isOpen())
            m_serialPort->close();
        m_serialPort->deleteLater();
        m_serialPort=NULL;
    }

    m_serialBuffer.clear();

    if (ui->btnConnect->isChecked()){ // Was just checked, so trying to connect...
        QList<QSerialPortInfo> serial_list = QSerialPortInfo::availablePorts();

        for (int i=0; i<serial_list.count(); i++){
            if (serial_list.at(i).description().contains("STMicroelectronics", Qt::CaseInsensitive) ||
                serial_list.at(i).description().contains("WIMU", Qt::CaseInsensitive)){
                // WIMU found
                m_serialPort = new QSerialPort(serial_list.at(i));
                break;
            }
        }

        if (m_serialPort==NULL){
            // No WIMU
            ui->lblStatus->setText(tr("Aucun WIMU n'a été détecté. Vérifiez qu'il est bien branché et dans le bon mode."));
            ui->lblStatus->setStyleSheet("QLabel{color:red;}");
            ui->btnConnect->setChecked(false);
            return;
        }else{
            ui->lblStatus->setText(tr("Connexion en cours...") + m_serialPort->portName());
            ui->lblStatus->setStyleSheet("QLabel{color:black;}");
            m_serialPort->setBaudRate(115200);
        }

        if (m_serialPort->open(QSerialPort::ReadWrite)){
            ui->lblStatus->setText(tr("Connexion établie - ") + m_serialPort->portName());
            ui->lblStatus->setStyleSheet("QLabel{color:blue;}");
            ui->btnConnect->setText(tr("Déconnecter"));
        }else{
            ui->lblStatus->setText(tr("Impossible de se connecter: ") +  m_serialPort->errorString());
            ui->lblStatus->setStyleSheet("QLabel{color:red;}");
            ui->btnConnect->setChecked(false);
            return;
        }

        // Connect signals
        connectSerialPortSignals();

        // Show frame
        ui->frameConnected->setVisible(true);
        ui->lstTools->setVisible(true);
        ui->lblWIMUNotConnected->setVisible(false);

        // Request settings
        wimuSendCommand("getset");

    }else{ // Was unchecked, so disconnect
       // Handled in the about to close slot


    }
}

void WIMUConfigDialog::wimuSendCommand(QString cmd){
    if (!m_serialPort)
        return;

    // Clean the string
    QString tosend = cmd;

    // Remove all exit codes
    tosend = tosend.replace('\n',"");
    tosend = tosend.replace('\r',"");

    // Append return
    tosend.append('\n');
    tosend.append('\r');

    // Save last command
    m_lastSerialCmd = tosend;

    // Send to serial port
    m_serialPort->write(tosend.toUtf8());

    // Update Console Text
    addToConsole(tosend, true);

    // Disable command area until reply is received
    ui->btnConsoleSend->setEnabled(false);
    ui->txtConsoleCmd->setEnabled(false);

}

void WIMUConfigDialog::wimuSendData(QByteArray data){
    if (!m_serialPort)
        return;

    m_serialPort->write(data);

}

void WIMUConfigDialog::serialPortAboutToClose(){
    //qDebug() << "Serial Port about to close...";
    ui->btnConnect->setText(tr("Connecter"));
    ui->lblStatus->setText(tr("Aucune connexion établie"));
    ui->lblStatus->setStyleSheet("QLabel{color:black;}");
    ui->frameConnected->setVisible(false);
    ui->lstTools->setVisible(false);
    ui->lblWIMUNotConnected->setVisible(true);
    ui->txtConsole->clear();
    WIMUSettings settings;
    loadFromSettings(&settings);
    ui->wdgPanels->setCurrentWidget(ui->pgEmpty);
    m_wimuDateTime.setDate(QDate());
    m_wimuDateTime.setTime(QTime());
}

void WIMUConfigDialog::serialPortDataReady(){
    m_serialBuffer.append(m_serialPort->readAll());

    //////////////////
    // Special cases when expecting binary reply
    if (m_lastSerialCmd.left(7)=="getconf"){
        // Check if we have received everything yet
        if (m_serialBuffer.count()<WIMUConfig::size() + m_lastSerialCmd.count())
            return;

        // Load data
        WIMUConfig config;

        while( !(m_serialBuffer.at(0) == char(0xEA) && m_serialBuffer.at(1) == char(0xEA)) &&
              m_serialBuffer.count()>=2){ // Sync on sync byte
            m_serialBuffer.remove(0,1);
        }
        // Remove 2 sync bytes
        m_serialBuffer.remove(0,2);

        // Check module ID byte and remove it
        if (m_serialBuffer.at(0)!=0){
            QMessageBox::warning(this,"Erreur Lecture Config","La configuration reçue n'est pas bien formattée!");

        }else{
            m_serialBuffer.remove(0,1); // remove module ID

            // Check length
            if (m_serialBuffer.at(0) != WIMUConfig::size()){
                QMessageBox::warning(this,"Erreur Lecture Config","La configuration reçue n'a pas la bonne taille!");
            }else{
                m_serialBuffer.remove(0,1); // remove length
                config.unserialize(&m_serialBuffer);

                // TODO: Checksum
                loadFromConfig(&config);
            }
        }
    }

    if (m_lastSerialCmd.left(6)=="getset"){
        // Check if we have received everything yet
        if (m_serialBuffer.count()<WIMUSettings::size())
            return;

        // Load data
        WIMUSettings settings;

        while( !(m_serialBuffer.at(0) == char(0xEA) && m_serialBuffer.at(1) == char(0xEA)) &&
              m_serialBuffer.count()>=2){ // Sync on sync byte
            m_serialBuffer.remove(0,1);
        }
        // Remove 2 sync bytes
        m_serialBuffer.remove(0,2);

        // Check module ID byte and remove it
        if (m_serialBuffer.at(0)!=0){
            QMessageBox::warning(this,"Erreur Lecture Paramètres","La configuration reçue n'est pas bien formattée!");

        }else{
            m_serialBuffer.remove(0,1); // remove module ID

            // Check length
            if (m_serialBuffer.at(0) != WIMUSettings::size()){
                QMessageBox::warning(this,"Erreur Lecture Paramètres","La configuration reçue n'a pas la bonne taille!");
            }else{
                m_serialBuffer.remove(0,1); // remove length
                settings.unserialize(&m_serialBuffer);

                // TODO: Checksum
                loadFromSettings(&settings);

            }
        }

    }
    if (m_lastSerialCmd=="setset"){
         if (m_serialBuffer.count() > WIMUSettings::size()+6+4 && m_serialBuffer.endsWith('\r')){ // sizeof (setset) + \n\r\n\r
            // Remove last 2 characters (\n\r)
            m_serialBuffer.remove(m_serialBuffer.count()-2,2);

            if (m_serialBuffer.at(m_serialBuffer.count()-1)=='K'){ // OK
                // All is well
                QMessageBox::information(this,"Mise à jour Paramètres","Les paramètres ont bien été mis à jour!");
            }else{
                // Error
                QMessageBox::warning(this,"Mise à jour Paramètres","Les paramètres n'ont pas pu être mis à jour...");
            }
            m_serialBuffer.clear();
        }else{
             return;
         }
    }

    if (m_lastSerialCmd=="setconf"){
         if (m_serialBuffer.count() > WIMUConfig::size()+7+4/* && m_serialBuffer.endsWith('\r') && m_serialBuffer.at(m_serialBuffer.count()-2)=='\n'*/){ // sizeof (setset) + \n\r\n\r
            // Remove last 2 characters (\n\r)
            //m_serialBuffer.remove(m_serialBuffer.count()-2,2);

            if (m_serialBuffer.contains("OK")){ // OK
                // All is well
                QMessageBox::information(this,"Mise à jour Configuration","La configuration a bien été mise à jour!\nLe module doit être redémarré pour que celle-ci prenne effet...");

                m_serialBuffer.clear();
                buttonResetClicked();
            }else{
                if (m_serialBuffer.contains("ERROR")){
                    // Error
                    QMessageBox::warning(this,"Mise à jour Configuration","La configuration n'a pas pu être mise à jour...");
                    m_serialBuffer.clear();
                }
                else{
                    return;
                }
            }
         }else{
             return;
         }
    }


    if (m_lastSerialCmd.left(6)=="time\n\r"){

        if (m_serialBuffer.count() < m_lastSerialCmd.count()){
            return; // Wait for more
        }

        // Update module time
        if (m_serialBuffer.count()> m_lastSerialCmd.count() && m_serialBuffer.endsWith('\r')){
            m_serialBuffer.remove(0, m_lastSerialCmd.count());
            m_serialBuffer.remove(m_serialBuffer.count()-2,2);

            QString datetime(m_serialBuffer);
            m_wimuDateTime = QDateTime::fromTime_t(datetime.toULong(), Qt::UTC);
        }else
            return; // Wait for even more!
    }else{
        ////////////////
        if (!m_lastSerialCmd.isEmpty()){
            // Module will echo back characters - ignore characters from the command
            if (m_serialBuffer.count() < m_lastSerialCmd.count()){
                // Wait for more...
                return;
            }
            // Remove those bytes from the list
            m_serialBuffer.remove(0, m_lastSerialCmd.count());
        }
    }


    QString s_data(m_serialBuffer);
    s_data.replace('\n',"");
    s_data.replace('\r',"");


    if (!s_data.isEmpty() && m_lastSerialCmd.left(6)!="getset")
        addToConsole(s_data, false);

    // Enable command area
    if (!m_lastSerialCmd.isEmpty()){
        ui->btnConsoleSend->setEnabled(true);
        ui->txtConsoleCmd->setEnabled(true);
        ui->txtConsoleCmd->setFocus();
        m_lastSerialCmd.clear();
    }
    m_serialBuffer.clear();
}

void WIMUConfigDialog::serialPortBytesWritten(qint64 bytes){
    Q_UNUSED(bytes)
}

void WIMUConfigDialog::serialPortError(QSerialPort::SerialPortError error){
    Q_UNUSED(error)
    QMessageBox::warning(this,"Erreur COM", "Une erreur est survenue dans la communication: \n" + m_serialPort->errorString());
}

void WIMUConfigDialog::clockUpdate(){
    QDateTime localtime = QDateTime::currentDateTime();
    ui->lblCurrentDateTime->setText("<b>Heure actuelle</b>: " + localtime.toString("dd MMMM yyyy - hh:mm:ss"));

    if (!m_wimuDateTime.isValid()){
        if (m_serialPort){
            // Query for time
            if (m_lastSerialCmd.isEmpty() && m_serialBuffer.isEmpty())
                wimuSendCommand("time");
        }else{
            ui->lblCurrentDateTimeWIMU->setText("<b>Heure du module<b>: Inconnue");
        }
        return;

    }

    m_wimuDateTime = m_wimuDateTime.addSecs(1);

    QString color = "black";

    if (qAbs(m_wimuDateTime.secsTo(localtime) +  localtime.offsetFromUtc())>1){
        color = "red";
    }

    ui->lblCurrentDateTimeWIMU->setText("<b>Heure du module</b>: <font color=" + color +">" + m_wimuDateTime.toString("dd MMMM yyyy - hh:mm:ss") + "</font>");
}
