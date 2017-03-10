#ifndef WIMUBLEDRIVER_H
#define WIMUBLEDRIVER_H
#include <QObject>
#include <QTimer>

#include "BlueGiga/BLED112Driver.h"
#include "BlueGiga/BLEDeviceContext.h"
#include <QSerialPortInfo>
#include "wimubinarystream.h"



class WIMUBLEDriver:public QObject
{
    Q_OBJECT

public:
    typedef struct
    {
      quint16  year;
      quint8   month;
      quint8   day;
      quint8   hours;
      quint8   minutes;
      quint8   seconds;
      quint8   day_of_week; // 0=Undefined, 1 = Monday, ...
      quint8   fractions256;
      quint8   adjust_reason; // See https://developer.bluetooth.org/gatt/characteristics/Pages/CharacteristicViewer.aspx?u=org.bluetooth.characteristic.current_time.xml
    } BLECurrentTime_Struct;

    typedef struct {
      quint8   status;
      quint16  rec_id;
    } BLERemControl_Struct;

    explicit WIMUBLEDriver(QObject *parent = 0);
    ~WIMUBLEDriver();

    bool bledFindAndPrepare();
    bool bledConnect();
    void bledDisconnect();

    bool wimuConnect(QString id);
    void wimuDisconnect();
    bool wimuIsConnected();

    QString comGetErrorString();
    QString comGetPortName();

    // Commands
    void wimuIMUStreaming(bool enable);
    void wimuRAWStreaming(bool enable);
    void wimuGPSStreaming(bool enable);
    void wimuBattStreaming(bool enable);

    void wimuRecord(bool start);

    void wimuGetTime();
    void wimuGetIMUConfig();
    void wimuSyncTime();
    void wimuGetControlState();



signals:
    /*void comAboutToClose();
    void comError(QSerialPort::SerialPortError error);

    void configReceived(WIMUConfig config);
    void settingsReceived(WIMUSettings settings);
    void timeReceived(QDateTime wimuTime);

    void cmdOK(WIMUUSBDriver::WIMUCommandID id);
    void cmdError(WIMUUSBDriver::WIMUCommandID id);
    void cmdReply(QString reply, WIMUUSBDriver::WIMUCommandID id);*/

    void imuDataReceived(WIMU::IMUFrame_Struct data);
    void imuConfigReceived(WIMU::IMUConfig_Struct config);
    void remControlReceived(WIMUBLEDriver::BLERemControl_Struct control);
    void battLevelReceived(quint8 batt_pc);
    void gpsDataReceived(WIMU::GPSNavData_Struct gps);

    void comStatusString(QString status);

    void timeReceived(QDateTime wimuTime);

    void bleDeviceDiscovered(BLEDeviceContext* context);
    void bleDeviceDestroyed(BLEDeviceContext* context);
    void bleDeviceConnected(BLEDeviceContext* context);

    void comAboutToClose();

private slots:
    void handleNewDeviceDiscovered(BLEDeviceContext* context);
    void handleDeviceDestroyed(BLEDeviceContext* context);
    void handleDeviceReady(BLEDeviceContext* context);
    void handleNewData(uint handle, uint type, QByteArray value);

private:
    QDateTime   unpackDateTime(QByteArray &data);
    WIMU::IMUConfig_Struct unpackIMUConfig(QByteArray &data);
    BLERemControl_Struct unpackRemoteControl(QByteArray &data);
    WIMU::GPSNavData_Struct unpackLocationSpeed(QByteArray &data);

    BLED112Driver       m_driver;
    BLEDeviceContext*   m_context;

    quint8              m_imuHandle;
    quint8              m_quaHandle;
    quint8              m_controlHandle;
    quint8              m_configHandle;
    quint8              m_timeHandle;
    quint8              m_gpsHandle;
    quint8              m_battHandle;

    QString             m_lastErrorStr;
    QString             m_portName;

};

#endif // WIMUUSBDRIVER_H
