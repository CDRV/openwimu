#ifndef BLEDEVICECONTEXT_H
#define BLEDEVICECONTEXT_H

#include <QObject>
#include <QSerialPort>
#include <QTimer>
#include "apitypes.h"
#include "cmd_def.h"
#include <QUuid>
#include <QMap>
#include <QDebug>
#include <QDateTime>
#include <QList>
#include <QPair>

/**
 * @brief The BLEAttribute class
 * @author Dominic Letourneau
 */
class BLEAttribute
{
public:
    BLEAttribute(unsigned int type, QByteArray value, unsigned int atthandle);

    QByteArray m_value;
    unsigned   int m_handle;
    quint16    m_uuid;

    void setUUID(quint16 uuid);
};


/**
 * @brief The BLEService class
 * @author Dominic Letourneau
 */
class BLEService
{
public:

    BLEService(unsigned int start, unsigned int end, unsigned char connection, quint16 uuid/*const char* uuid, int uuid_length*/);

    bool operator==(const BLEService &service);

    bool addAttribute();

    unsigned int m_start;
    unsigned int m_end;
    unsigned char m_connection;
    quint16 m_uuid;
    QList<BLEAttribute> m_attributeList;


};

/**
 * @brief The BLEDeviceContext class
 * @author Dominic Letourneau
 */
class BLEDeviceContext : public QObject
{
    Q_OBJECT

public:

    typedef enum {DISCOVERED,
                  WAITING_CONNECTION,
                  CONNECTED,
                  SCANNING_SERVICES,
                  SCANNING_ATTRIBUTES,
                  SCANNING_DESCRIPTORS,
                  READY,
                  WRITING,
                  DISCONNECTED} ModuleState;

    explicit BLEDeviceContext(QByteArray mac, QString name, unsigned int address_type, unsigned int connectDelayMs = 0);

    ~BLEDeviceContext();

    void connectDevice();

    void connectionStatusEvent(const struct ble_msg_connection_status_evt_t *msg);

    void connectionDisconnectedEvent(const struct ble_msg_connection_disconnected_evt_t *msg);

    void groupFoundEvent(const struct ble_msg_attclient_group_found_evt_t *msg);

    void informationFoundEvent(const struct ble_msg_attclient_find_information_found_evt_t *msg);

    void procedureCompletedEvent(const struct ble_msg_attclient_procedure_completed_evt_t *msg);

    bool attributeWrite(unsigned int handle, const QByteArray &data);

    bool attributeRead(unsigned int handle);

    void attributeValueEvent(const struct ble_msg_attclient_attribute_value_evt_t *msg);

    bool state_machine();


    QDateTime lastScanTime();

signals:


    void serviceFound(unsigned int start, unsigned int end, quint16 uuid);
    void attributeFound(unsigned int type, unsigned int atthandle, quint16 uuid);
    void attributeValue(unsigned int handle,unsigned int type, QByteArray value);
    void ready();
    void initCompleted(BLEDeviceContext* context);

public:

    ModuleState m_state;
    unsigned int m_connection;
    QByteArray m_mac;
    QString m_name;
    unsigned int m_addressType;
    QList<BLEService> m_serviceList;
    QDateTime m_scanTime;
    QList<QPair<unsigned int, QByteArray> > m_writeList;
    QList<unsigned int> m_readList;
    unsigned int m_connectDelayMs;
};


#endif // BLEDEVICECONTEXT_H
