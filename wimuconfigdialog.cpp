#include "wimuconfigdialog.h"
#include "ui_wimuconfigdialog.h"

#include <QDebug>
#include <QFileDialog>
#include <QMessageBox>
#include <QtSerialPort/QSerialPortInfo>

#include "wimu.h"

WIMUConfigDialog::WIMUConfigDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::WIMUConfigDialog)
{
    ui->setupUi(this);

    // Set correct component ID in list
    ui->lstComponents->item(0)->setData(Qt::UserRole,WIMU::MODULE_ACC);
    ui->lstComponents->item(1)->setData(Qt::UserRole,WIMU::MODULE_GYRO);
    ui->lstComponents->item(2)->setData(Qt::UserRole,WIMU::MODULE_MAGNETO);
    ui->lstComponents->item(3)->setData(Qt::UserRole,WIMU::MODULE_GPS);
    ui->lstComponents->item(4)->setData(Qt::UserRole,WIMU::MODULE_DATALOGGER);
    ui->lstComponents->item(5)->setData(Qt::UserRole,WIMU::MODULE_BLE);
    ui->lstComponents->item(6)->setData(Qt::UserRole,WIMU::MODULE_IMU);

    // Connect signals
    connectCheckBoxSignals();
    connectButtonsSignals();
    connectGeneralUISignals();
    connectWIMUSignals();

    // Set default states
    initUIState();
    WIMUConfig default_config;
    loadFromConfig(&default_config);

    // Start clock timer
    connect(&m_clock,SIGNAL(timeout()),this,SLOT(clockUpdate()));
    m_clock.setInterval(1000);
    m_clock.setSingleShot(false);
    m_clock.start();

    m_wimuDateTime = QDateTime();
}

WIMUConfigDialog::~WIMUConfigDialog()
{
    m_wimuDriver.wimuDisconnect();

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
    case WIMU::MODULE_ACC: // Accelero
        icon_path = ":/icons/images/accelero";
        break;
    case WIMU::MODULE_GYRO: // Gyro
        icon_path = ":/icons/images/gyro";
        break;
    case WIMU::MODULE_MAGNETO: // Magneto
        icon_path = ":/icons/images/magnet";
        break;
    case WIMU::MODULE_GPS: // GPS
        icon_path = ":/icons/images/gps";
        break;
    case WIMU::MODULE_DATALOGGER: // Logger
        icon_path = ":/icons/images/logging";
        break;
    case WIMU::MODULE_BLE: // BLE
        icon_path = ":/icons/images/ble";
        break;
    case WIMU::MODULE_IMU: // IMU
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
    case WIMU::MODULE_ACC: // Accelero
        return ui->chkAcc;
        break;
    case WIMU::MODULE_GYRO: // Gyro
        return ui->chkGyro;
        break;
    case WIMU::MODULE_MAGNETO: // Magneto
        return ui->chkMag;
        break;
    case WIMU::MODULE_GPS: // GPS
        return ui->chkGPS;
        break;
    case WIMU::MODULE_DATALOGGER: // Logger
        return ui->chkLogger;
        break;
    case WIMU::MODULE_BLE: // BLE
        return ui->chkBLE;
        break;
    case WIMU::MODULE_IMU: // IMU
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

void WIMUConfigDialog::connectWIMUSignals(){

    connect(&m_wimuDriver,SIGNAL(comAboutToClose()),this,SLOT(wimuPortAboutToClose()));
    connect(&m_wimuDriver,SIGNAL(comError(QSerialPort::SerialPortError)),this,SLOT(wimuPortError(QSerialPort::SerialPortError)));

    connect(&m_wimuDriver,SIGNAL(cmdError(WIMUUSBDriver::WIMUCommandID)),this,SLOT(wimuCmdError(WIMUUSBDriver::WIMUCommandID)), Qt::QueuedConnection);
    connect(&m_wimuDriver,SIGNAL(cmdOK(WIMUUSBDriver::WIMUCommandID)),this,SLOT(wimuCmdOK(WIMUUSBDriver::WIMUCommandID)), Qt::QueuedConnection);
    connect(&m_wimuDriver,SIGNAL(cmdReply(QString,WIMUUSBDriver::WIMUCommandID)),this,SLOT(wimuCmdReply(QString,WIMUUSBDriver::WIMUCommandID)), Qt::QueuedConnection);
    connect(&m_wimuDriver,SIGNAL(configReceived(WIMUConfig)),this,SLOT(wimuConfigReceived(WIMUConfig)), Qt::QueuedConnection);
    connect(&m_wimuDriver,SIGNAL(settingsReceived(WIMUSettings)),this,SLOT(wimuSettingsReceived(WIMUSettings)), Qt::QueuedConnection);
    connect(&m_wimuDriver,SIGNAL(timeReceived(QDateTime)),this,SLOT(wimuTimeReceived(QDateTime)), Qt::QueuedConnection);


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
    if (ui->txtConsoleCmd->text().isEmpty())
        return; // No cmd = no sending!

    sendCommandToWIMU(ui->txtConsoleCmd->text(), WIMUUSBDriver::WimuCmdOther);

    // Clear text zone
    ui->txtConsoleCmd->clear();

}

void WIMUConfigDialog::buttonReadConfigClicked(){
    sendCommandToWIMU("getconf", WIMUUSBDriver::WimuCmdGetConf);
}

void WIMUConfigDialog::buttonWriteSettingsClicked(){
    // Pack data
    WIMUSettings settings;
    saveToSettings(&settings);

    QByteArray data = settings.serialize();
    data.insert(0,QString("setset"));
    data.append("\n\r");

    sendDataToWIMU(data, WIMUUSBDriver::WimuCmdSetSet);

}

void WIMUConfigDialog::buttonWriteConfigClicked(){
    // Pack data
    WIMUConfig config;
    saveToConfig(&config);

    QByteArray data = config.serialize();
    data.insert(0,QString("setconf"));
    data.append("\n\r");

    sendDataToWIMU(data, WIMUUSBDriver::WimuCmdSetConf);

}

void WIMUConfigDialog::buttonResetClicked(){
    QMessageBox::StandardButton conf = QMessageBox::question(this,"Redémarrage?","Si le module est redémarré, la connexion avec celui-ci sera perdue.\nDésirez-vous vraiment poursuivre?");

    if (conf == QMessageBox::Yes){
        m_wimuDriver.wimuReboot();
        m_wimuDriver.wimuDisconnect(); // Disconnect
    }
}

void WIMUConfigDialog::buttonSyncTimeClicked(){
   m_wimuDateTime = QDateTime();

   m_wimuDriver.wimuSyncTime();
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
    ui->chkAcc->setChecked(config->isModuleEnabled(WIMU::MODULE_ACC));
    if (config->isModuleEnabled(WIMU::MODULE_ACC))
        ui->lstComponents->item(0)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(0)->setCheckState(Qt::Unchecked);
    ui->cmbAccRange->setCurrentIndex(config->acc.range);

    // Gyro
    ui->chkGyro->setChecked(config->isModuleEnabled(WIMU::MODULE_GYRO));
        if (config->isModuleEnabled(WIMU::MODULE_GYRO))
            ui->lstComponents->item(1)->setCheckState(Qt::Checked);
        else
            ui->lstComponents->item(1)->setCheckState(Qt::Unchecked);
    ui->cmbGyroRange->setCurrentIndex(config->gyro.range);

    // Magneto
    ui->chkMag->setChecked(config->isModuleEnabled(WIMU::MODULE_MAGNETO));
    if (config->isModuleEnabled(WIMU::MODULE_MAGNETO))
        ui->lstComponents->item(2)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(2)->setCheckState(Qt::Unchecked);
    ui->cmbMagRange->setCurrentIndex(config->magneto.range);

    // GPS
    ui->chkGPS->setChecked(config->isModuleEnabled(WIMU::MODULE_GPS));
    if (config->isModuleEnabled(WIMU::MODULE_GPS))
        ui->lstComponents->item(3)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(3)->setCheckState(Qt::Unchecked);
    ui->chkGPSColdStart->setChecked(config->gps.force_cold);
    ui->spinGPSSampling->setValue(config->gps.interval);
    ui->chkGPSAutoWake->setChecked(config->gps.enable_scan_when_charged);

    // Logger
    ui->chkLogger->setChecked(config->isModuleEnabled(WIMU::MODULE_DATALOGGER));
    if (config->isModuleEnabled(WIMU::MODULE_DATALOGGER))
        ui->lstComponents->item(4)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(4)->setCheckState(Qt::Unchecked);
    ui->chkLoggerSplit->setChecked(config->logger.split_by_day);
    ui->spinLoggerFileNum->setValue(config->logger.max_files_in_folder);

    // BLE
    ui->chkBLE->setChecked(config->isModuleEnabled(WIMU::MODULE_BLE));
    if (config->isModuleEnabled(WIMU::MODULE_BLE))
        ui->lstComponents->item(5)->setCheckState(Qt::Checked);
    else
        ui->lstComponents->item(5)->setCheckState(Qt::Unchecked);
    ui->chkBLEControl->setChecked(config->ble.enable_control);

    // IMU
    ui->chkIMU->setChecked(config->isModuleEnabled(WIMU::MODULE_IMU));
    if (config->isModuleEnabled(WIMU::MODULE_IMU))
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
    config->enableModule(WIMU::MODULE_ACC,ui->chkAcc->isChecked());
    config->acc.range = ui->cmbAccRange->currentIndex();

    // Gyro
    config->enableModule(WIMU::MODULE_GYRO,ui->chkGyro->isChecked());
    config->gyro.range = ui->cmbGyroRange->currentIndex();

    // Magneto
    config->enableModule(WIMU::MODULE_MAGNETO,ui->chkMag->isChecked());
    config->magneto.range = ui->cmbMagRange->currentIndex();

    // GPS
    config->enableModule(WIMU::MODULE_GPS,ui->chkGPS->isChecked());
    config->gps.force_cold = ui->chkGPSColdStart->isChecked();
    config->gps.interval = ui->spinGPSSampling->value();
    config->gps.enable_scan_when_charged = ui->chkGPSAutoWake->isChecked();

    // Logger
    config->enableModule(WIMU::MODULE_DATALOGGER,ui->chkLogger->isChecked());
    config->logger.split_by_day = ui->chkLoggerSplit->isChecked();
    config->logger.max_files_in_folder = ui->spinLoggerFileNum->value();

    // BLE
    config->enableModule(WIMU::MODULE_BLE,ui->chkBLE->isChecked());
    config->ble.enable_control = ui->chkBLEControl->isChecked();

    // IMU
    config->enableModule(WIMU::MODULE_IMU,ui->chkIMU->isChecked());
    config->imu.auto_calib_gyro = ui->chkIMUAutoCalib->isChecked();
    config->imu.disable_magneto = ui->chkIMUNoMag->isChecked();
    config->imu.beta = ui->txtIMUBeta->text().toFloat();

}

void WIMUConfigDialog::buttonConnectClicked(){

    bool status = false;

    if (ui->btnConnect->isChecked()){ // Was just checked, so trying to connect...
        status = m_wimuDriver.wimuFindAndPrepare();

        if (!status){
            // No WIMU
            ui->lblStatus->setText(tr("Aucun WIMU n'a été détecté. Vérifiez qu'il est bien branché et dans le bon mode."));
            ui->lblStatus->setStyleSheet("QLabel{color:red;}");
            ui->btnConnect->setChecked(false);
            return;
        }else{
            ui->lblStatus->setText(tr("Connexion en cours...") + m_wimuDriver.comGetPortName());
            ui->lblStatus->setStyleSheet("QLabel{color:black;}");
        }

        status = m_wimuDriver.wimuConnect();

        if (status){
            ui->lblStatus->setText(tr("Connexion établie - ") + m_wimuDriver.comGetPortName());
            ui->lblStatus->setStyleSheet("QLabel{color:blue;}");
            ui->btnConnect->setText(tr("Déconnecter"));

            int load = QMessageBox::question(this,"Chargement de la configuration?","Désirez-vous charger la configuration actuelle du module?",QMessageBox::Yes,QMessageBox::No);
            if (load == QMessageBox::Yes){
                buttonReadConfigClicked();
            }

        }else{
            ui->lblStatus->setText(tr("Impossible de se connecter: ") + m_wimuDriver.comGetErrorString());
            ui->lblStatus->setStyleSheet("QLabel{color:red;}");
            ui->btnConnect->setChecked(false);
            return;
        }

        // Show frame
        ui->frameConnected->setVisible(true);
        ui->lstTools->setVisible(true);
        ui->lblWIMUNotConnected->setVisible(false);

        // Request settings
        //wimuSendCommand("getset");
        sendCommandToWIMU("getset", WIMUUSBDriver::WimuCmdGetSet, true);

    }else{ // Was unchecked, so disconnect
       m_wimuDriver.wimuDisconnect();

    }
}

void WIMUConfigDialog::sendCommandToWIMU(QString cmd, WIMUUSBDriver::WIMUCommandID cmd_id, bool hidden){

    m_wimuDriver.wimuSendCommand(cmd, cmd_id);

    // Update Console Text
    if (!hidden)
        addToConsole(cmd, true);

    // Disable command area until reply is received
    enableCommandArea(false);
}

void WIMUConfigDialog::sendDataToWIMU(QByteArray data, WIMUUSBDriver::WIMUCommandID cmd_id){

    m_wimuDriver.wimuSendData(data, cmd_id);

}

void WIMUConfigDialog::wimuPortAboutToClose(){
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
    m_wimuDateTime = QDateTime();
}
/*
void WIMUConfigDialog::wimuPortDataReady(){

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
    }

}*/


void WIMUConfigDialog::wimuPortError(QSerialPort::SerialPortError error){
    Q_UNUSED(error)
    QMessageBox::warning(this,"Erreur COM", "Une erreur est survenue dans la communication: \n" + m_wimuDriver.comGetErrorString());
}

void WIMUConfigDialog::clockUpdate(){
    QDateTime localtime = QDateTime::currentDateTime();
    ui->lblCurrentDateTime->setText("<b>Heure actuelle</b>: " + localtime.toString("dd MMMM yyyy - hh:mm:ss"));

    if (!m_wimuDateTime.isValid()){
        ui->lblCurrentDateTimeWIMU->setText("<b>Heure du module</b>: Inconnue");
        m_wimuDriver.wimuGetTime();
        return;
    }

    m_wimuDateTime = m_wimuDateTime.addSecs(1);

    QString color = "black";

    if (qAbs(m_wimuDateTime.secsTo(localtime) +  localtime.offsetFromUtc())>1){
        color = "red";
    }

    ui->lblCurrentDateTimeWIMU->setText("<b>Heure du module</b>: <font color=" + color +">" + m_wimuDateTime.toString("dd MMMM yyyy - hh:mm:ss") + "</font>");
}

void WIMUConfigDialog::wimuConfigReceived(WIMUConfig config){
    loadFromConfig(&config);
    enableCommandArea(true);
}

void WIMUConfigDialog::wimuSettingsReceived(WIMUSettings settings){
    loadFromSettings(&settings);
    enableCommandArea(true);
}

void WIMUConfigDialog::wimuTimeReceived(QDateTime module_time){
    m_wimuDateTime = module_time;
    enableCommandArea(true);
}

void WIMUConfigDialog::wimuCmdOK(WIMUUSBDriver::WIMUCommandID cmd){
    //qDebug() << cmd << " = OK!";
    switch (cmd){
    case WIMUUSBDriver::WimuCmdSetConf:
        QMessageBox::information(this, "Configuration", "La configuration du module a bien été mise à jour.\nLe module doit être redémarré pour que celle-ci soit appliquée.");
        buttonResetClicked();
        break;
    case WIMUUSBDriver::WimuCmdSetSet:
        QMessageBox::information(this, "Paramètres", "Les paramètres du module ont bien été mis à jour.");
        break;
    default:
        addToConsole("OK",false);
        break;
    }

    enableCommandArea(true);
}

void WIMUConfigDialog::wimuCmdError(WIMUUSBDriver::WIMUCommandID cmd){
    //qDebug() << cmd << " = Error!";

    switch (cmd){
    case WIMUUSBDriver::WimuCmdSetConf:
        QMessageBox::warning(this, "Configuration", "La configuration du module n'a pas été mise à jour...");
        break;
    case WIMUUSBDriver::WimuCmdSetSet:
        QMessageBox::information(this, "Paramètres", "Les paramètres du module n'ont pas été mis à jour...");
        break;
    default:
        addToConsole("ERROR",false);
        break;
    }

    enableCommandArea(true);
}

void WIMUConfigDialog::wimuCmdReply(QString reply, WIMUUSBDriver::WIMUCommandID cmd){
    //qDebug() << cmd << " = " << reply;
    Q_UNUSED(cmd);

    addToConsole(reply,false);
    enableCommandArea(true);
}

void WIMUConfigDialog::enableCommandArea(bool enable){

    ui->btnConsoleSend->setEnabled(enable);
    ui->txtConsoleCmd->setEnabled(enable);
    if (enable)
        ui->txtConsoleCmd->setFocus();

}
