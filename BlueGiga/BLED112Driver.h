

#ifndef BLED112DRIVER_H
#define BLED112DRIVER_H

#include "BLEDeviceContext.h"

/**
 * @brief The BLED112Driver class
 * @author Dominic Letourneau
 */
class BLED112Driver : public QObject
{
    friend void ble_serial_output(uint8 len1,uint8* data1,uint16 len2,uint8* data2);

    Q_OBJECT

public:

    explicit BLED112Driver(QObject *parent = 0);

    ~BLED112Driver();

    bool init(const QString &port);

    BLEDeviceContext *connectDevice(const QString &id);

    void disconnectDevice(const BLEDeviceContext* device);

    void closeConnections();

    void scanResponse(const struct ble_msg_gap_scan_response_evt_t *msg);

    void connectionStatusEvent(const struct ble_msg_connection_status_evt_t *msg);

    void connectionDisconnectedEvent(const struct ble_msg_connection_disconnected_evt_t *msg);

    void groupFoundEvent(const struct ble_msg_attclient_group_found_evt_t *msg);

    void procedureCompletedEvent(const struct ble_msg_attclient_procedure_completed_evt_t *msg);

    void attributeValueEvent(const struct ble_msg_attclient_attribute_value_evt_t *msg);

    void informationFoundEvent(const struct ble_msg_attclient_find_information_found_evt_t *msg);

signals:

    void deviceDiscovered(BLEDeviceContext *context);
    void deviceConnected(BLEDeviceContext *context);
    void deviceDestroyed(BLEDeviceContext *context);
    void deviceReady(BLEDeviceContext *context);

    void displayMessage(QString msg);

protected slots:

    void readyReadSerial();
    void timeout();

protected:

    void writeSerialData(uint8 len1,uint8* data1,uint16 len2,uint8* data2);
    QSerialPort m_serialPort;
    QTimer *m_timer;
    QList<BLEDeviceContext*> m_contextList;
    QDateTime m_lastScanDateTime;
};

//TODO, CAN WE DO BETTER???
extern BLED112Driver *g_BLED112DriverPtr;

#endif // BLED112DRIVER_H
