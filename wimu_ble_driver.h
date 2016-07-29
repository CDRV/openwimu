#ifndef WIMUBLEDRIVER_H
#define WIMUBLEDRIVER_H
#include <QObject>
#include <QTimer>

#include "BlueGiga/BLED112Driver.h"
#include "BlueGiga/BLEDeviceContext.h"
#include <QSerialPortInfo>




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

    explicit WIMUBLEDriver(QObject *parent = 0);
    ~WIMUBLEDriver();

    bool bledFindAndPrepare();
    bool bledConnect();
    void bledDisconnect();

    bool wimuConnect(QString id);
    void wimuDisconnect();

    QString comGetErrorString();
    QString comGetPortName();

    // Commands
    void wimuIMUStreaming(bool enable);
    void wimuRAWStreaming(bool enable);

    void wimuRecord(bool start);

    void wimuGetTime();
    void wimuSyncTime();



signals:
    /*void comAboutToClose();
    void comError(QSerialPort::SerialPortError error);

    void configReceived(WIMUConfig config);
    void settingsReceived(WIMUSettings settings);
    void timeReceived(QDateTime wimuTime);

    void cmdOK(WIMUUSBDriver::WIMUCommandID id);
    void cmdError(WIMUUSBDriver::WIMUCommandID id);
    void cmdReply(QString reply, WIMUUSBDriver::WIMUCommandID id);

    void binReceived(WIMUBinaryStream data);*/

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

    BLED112Driver       m_driver;
    BLEDeviceContext*   m_context;

    quint8              m_imuHandle;
    quint8              m_quaHandle;
    quint8              m_controlHandle;
    quint8              m_timeHandle;

    QString             m_lastErrorStr;
    QString             m_portName;

};

#endif // WIMUUSBDRIVER_H
