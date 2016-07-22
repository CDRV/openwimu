#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include <QDateTime>

#include "wimuconfigdialog.h"
#include "wimu_usb_driver.h"

#include "sensordisplay.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    enum LogTypes{
        LogNormal,
        LogWarning,
        LogError,
        LogInfo,
        LogDebug
    };

    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    void updateToolsDisplay();
    void addToLog(QString log, LogTypes lt);

    void connectButtonSignals();
    void connectUSBSignals();

    Ui::MainWindow *ui;

    WIMUConfigDialog*   m_dlgWIMUConfig;
    WIMUUSBDriver*      m_wimuUSBDriver;

    WIMUConfig          m_wimuConfig;
    WIMUSettings        m_wimuSettings;

    QTimer              m_clock;
    QTimer              m_connectTimer;
    QDateTime           m_wimuDateTime;
    bool                m_timeSyncRequested;

    QWidget*            m_centralWidget;
    SensorDisplay*      m_sensorDisplay;


private slots:
    void srcBLESelected();
    void srcUSBSelected();
    void srcFolderSelected();

    void wimuConfigRequested();
    void appSettingsRequested();

    void clockUpdate();

    void usbConnect();

    // USB
    void btnUSBConnectClicked();
    void btnUSBSyncTimeClicked();
    void btnUSBStreamClicked();
    void usbAboutToClose();
    void usbError(QSerialPort::SerialPortError error);
    void usbCmdError(WIMUUSBDriver::WIMUCommandID id);
    void usbCmdOK(WIMUUSBDriver::WIMUCommandID id);
    void usbCmdReply(QString reply, WIMUUSBDriver::WIMUCommandID id);
    void usbConfigReceived(WIMUConfig config);
    void usbSettingsReceived(WIMUSettings settings);
    void usbTimeReceived(QDateTime module_time);
    void usbBinDataReceived(WIMUBinaryStream bin);


};

#endif // MAINWINDOW_H
