#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include <QDateTime>

#include "wimuconfigdialog.h"
#include "wimu_usb_driver.h"
#include "wimu_ble_driver.h"

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
    void connectUSBButtons();

    void connectBLESignals();
    void connectBLEButtons();

    Ui::MainWindow *ui;

    WIMUConfigDialog*   m_dlgWIMUConfig;
    WIMUUSBDriver*      m_wimuUSBDriver;
    WIMUBLEDriver*      m_wimuBLEDriver;

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

    // BLE
    void btnBLEConnectClicked();
    void btnBLESyncTimeClicked();
    void btnBLEStreamClicked();
    void bleMessage(QString msg);
    void bleAboutToClose();
    void bleDeviceDiscovered(BLEDeviceContext* device);
    void bleDeviceDestroyed(BLEDeviceContext* device);
    void bleDeviceConnected(BLEDeviceContext* device);
    void bleListCurrentChanged(int new_row);
    void btnBLEDeviceConnectClicked();




};

#endif // MAINWINDOW_H
