#ifndef WIMUCONFIGDIALOG_H
#define WIMUCONFIGDIALOG_H

#include <QDialog>
#include <QListWidgetItem>
#include <QCheckBox>
#include <QtSerialPort/QSerialPort>
#include <QTimer>
#include <QDateTime>

#include "wimuconfig.h"
#include "wimusettings.h"
#include "wimu_usb_driver.h"


namespace Ui {
class WIMUConfigDialog;
}

class WIMUConfigDialog : public QDialog
{
    Q_OBJECT

public:
    explicit WIMUConfigDialog(QWidget *parent = 0);
    ~WIMUConfigDialog();

private:
    Ui::WIMUConfigDialog    *ui;
    //USBReader*              m_serialPort;
    WIMUUSBDriver            m_wimuDriver;

    QIcon       getIconForComponent(int index, bool enabled);
    QCheckBox*  getActiveChkBox(int index);

    QTimer      m_clock;
    QDateTime   m_wimuDateTime;

    void initUIState();
    void connectCheckBoxSignals();
    void connectButtonsSignals();
    void connectWIMUSignals();
    void connectGeneralUISignals();

    void loadFromConfig(WIMUConfig* config);
    void saveToConfig(WIMUConfig* config);
    void loadFromSettings(WIMUSettings* settings);
    void saveToSettings(WIMUSettings* settings);

    void addToConsole(QString text, bool sent);
    void enableCommandArea(bool enable);

    void sendCommandToWIMU(QString cmd, WIMUUSBDriver::WIMUCommandID cmd_id, bool hidden = false);
    void sendDataToWIMU(QByteArray data, WIMUUSBDriver::WIMUCommandID cmd_id);

private slots:
    void configSectionChanged(int newIndex);
    void configGeneralClicked(QListWidgetItem* item);
    void configToolsClicked(QListWidgetItem* item);
    void configComponentClicked(QListWidgetItem* item);
    void configComponentItemChanged(QListWidgetItem* item);

    void manageCheckBoxClicked();

    void buttonDefaultClicked();
    void buttonSaveConfigClicked();
    void buttonLoadConfigClicked();
    void buttonConnectClicked();
    void buttonConsoleSendClicked();
    void buttonConsoleEraseClicked();
    void buttonReadConfigClicked();
    void buttonWriteSettingsClicked();
    void buttonWriteConfigClicked();
    void buttonResetClicked();
    void buttonSyncTimeClicked();

    void wimuPortAboutToClose();
    void wimuPortError(QSerialPort::SerialPortError error);
    void wimuConfigReceived(WIMUConfig config);
    void wimuSettingsReceived(WIMUSettings settings);
    void wimuTimeReceived(QDateTime module_time);
    void wimuCmdOK(WIMUUSBDriver::WIMUCommandID cmd);
    void wimuCmdError(WIMUUSBDriver::WIMUCommandID cmd);
    void wimuCmdReply(QString reply, WIMUUSBDriver::WIMUCommandID cmd);

    void clockUpdate();


};

#endif // WIMUCONFIGDIALOG_H
