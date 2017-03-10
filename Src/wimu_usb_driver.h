#ifndef WIMUUSBDRIVER_H
#define WIMUUSBDRIVER_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QQueue>
#include <QDateTime>

#include "wimuconfig.h"
#include "wimusettings.h"
#include "wimubinarystream.h"

class WIMUUSBDriver : public QObject
{
    Q_OBJECT
public:

    enum WIMUCommandID{
        WimuCmdNone,
        WimuCmdReboot,
        WimuCmdSetTime,
        WimuCmdGetTime,
        WimuCmdSetSet,
        WimuCmdGetSet,
        WimuCmdSetConf,
        WimuCmdGetConf,
        WimuCmdStream,
        WimuCmdOther
    };

    explicit WIMUUSBDriver(QObject *parent = 0);
    bool wimuFindAndPrepare();
    bool wimuConnect();
    void wimuDisconnect();

    void wimuSendCommand(QString cmd, WIMUCommandID cmd_id);
    void wimuSendData(QByteArray data, WIMUCommandID cmd_id);

    QString comGetErrorString();
    QString comGetPortName();

    // Commands
    void wimuReboot();
    void wimuSyncTime();

    void wimuGetTime();
    void wimuGetConfig();
    void wimuGetSettings();
    void wimuSetConfig(WIMUConfig* config);
    void wimuSetSettings(WIMUSettings* settings);

    void wimuStream(bool enable);

private:
    void serialPortBinaryReady();

    QSerialPort*            m_serialPort;
    QQueue<QByteArray>      m_commands;
    QQueue<WIMUCommandID>   m_commands_ids;

    QByteArray              m_serialBuffer;

    bool                    m_binStreaming;

private slots:
    void serialPortDataReady();

signals:
    void comAboutToClose();
    void comError(QSerialPort::SerialPortError error);

    void configReceived(WIMUConfig config);
    void settingsReceived(WIMUSettings settings);
    void timeReceived(QDateTime wimuTime);

    void cmdOK(WIMUUSBDriver::WIMUCommandID id);
    void cmdError(WIMUUSBDriver::WIMUCommandID id);
    void cmdReply(QString reply, WIMUUSBDriver::WIMUCommandID id);

    void binReceived(WIMUBinaryStream data);


};

#endif // USBREADER_H
