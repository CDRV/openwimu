#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include <QDateTime>
#include <QSettings>

#include <QProgressDialog>

#include "datatreeitem.h"

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


    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    void updateToolsDisplay();

    void connectButtonSignals();

    void connectUSBSignals();
    void connectUSBButtons();

    void connectBLESignals();
    void connectBLEButtons();

    void connectFolderSignals();
    void connectFolderButtons();
    void clearFolderLists();
    DataTreeItem::DataType identifyFolderType(QFileInfo &folder);
    void loadFolders(QFileInfo &base_folder, DataTreeItem *base_item);
    void addItemToCorrectList(DataTreeItem* item);
    void loadData(QString new_path, bool force_preprocess);
    void updatePreprocessed();

    void loadAppSettings();

    Ui::MainWindow *ui;

    WIMUConfigDialog*       m_dlgWIMUConfig;
    WIMUUSBDriver*          m_wimuUSBDriver;
    WIMUBLEDriver*          m_wimuBLEDriver;

    WIMUConfig              m_wimuConfig;
    WIMUSettings            m_wimuSettings;

    QTimer                  m_clock;
    QTimer                  m_connectTimer;
    QDateTime               m_wimuDateTime;
    bool                    m_timeSyncRequested;

    QWidget*                m_centralWidget;
    SensorDisplay*          m_sensorDisplay;

    QSettings*              m_appSettings;

    QList<DataTreeItem*>    m_listExperiments;
    QList<DataTreeItem*>    m_listDatas;
    QList<DataTreeItem*>    m_listPatients;

    QProgressDialog*        m_progDialog;



private slots:
    void addToLog(QString log, WIMU::LogTypes lt);

    void srcBLESelected();
    void srcUSBSelected();
    void srcFolderSelected();

    void wimuConfigRequested();
    void appSettingsRequested();

    void clockUpdate();

    void usbConnect();

    void initProgDialog(QString label, int min, int max);
    void updateProgDialog(int value, QString label);

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
    void btnBLEDeviceConnectClicked();
    void btnBLERecordClicked();
    void bleMessage(QString msg);
    void bleAboutToClose();
    void bleDeviceDiscovered(BLEDeviceContext* device);
    void bleDeviceDestroyed(BLEDeviceContext* device);
    void bleDeviceConnected(BLEDeviceContext* device);
    void bleListCurrentChanged(int new_row);
    void bleIMUDataReceived(WIMU::IMUFrame_Struct data);
    void bleIMUConfigReceived(WIMU::IMUConfig_Struct config);
    void bleRemControlReceived(WIMUBLEDriver::BLERemControl_Struct control);
    void bleBattReceived(quint8 batt_pc);
    void bleGPSReceived(WIMU::GPSNavData_Struct gps);
    void bleListDeviceDoubleClicked(QModelIndex index);

    // Folders
    void btnBrowseClicked();
    void btnReloadClicked();
    void btnPreProcessClicked();
    void folderPathChanged(QString new_path);

};

#endif // MAINWINDOW_H
