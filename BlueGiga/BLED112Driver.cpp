#include "BLED112Driver.h"
#include <QDebug>
#include <QSerialPort>
#include <QThread>

//TODO, CAN WE DO BETTER???
BLED112Driver *g_BLED112DriverPtr = NULL;


BLED112Driver::BLED112Driver(QObject *parent) : QObject(parent)
{

}

BLED112Driver::~BLED112Driver(){

}

void ble_serial_output(uint8 len1,uint8* data1,uint16 len2,uint8* data2)
{
    if (g_BLED112DriverPtr)
    {
        //Write to serial port
        g_BLED112DriverPtr->writeSerialData(len1,data1,len2,data2);
    }
}


bool BLED112Driver::init(const QString &port)
{
    m_serialPort.setPortName(port);
    m_serialPort.setBaudRate(230400);
    m_serialPort.setDataBits(QSerialPort::Data8);
    m_serialPort.setParity(QSerialPort::NoParity);
    m_serialPort.setStopBits(QSerialPort::OneStop);
    m_serialPort.setFlowControl(QSerialPort::NoFlowControl);

    if (!m_serialPort.open(QIODevice::ReadWrite))
    {
        //qDebug() << "Cannot open serial port : " << port;
        emit displayMessage("Cannot open serial port " + port);
        return false;
    }


    //qDebug() << "OK Serial port : " << port;
    emit displayMessage("Serial Port " + port + " opened");
    connect(&m_serialPort, SIGNAL(readyRead()),this,SLOT(readyReadSerial()));

    bglib_output=ble_serial_output;

    g_BLED112DriverPtr = this; //UGLY

    // Reset Device
    ble_cmd_system_reset(0);
    m_serialPort.waitForBytesWritten(-1);
    m_serialPort.close();

    while (!m_serialPort.open(QIODevice::ReadWrite)); // Wait for BLED to come back alive

    //stop previous operation
    ble_cmd_gap_end_procedure();

    //Set active scanning to capture name and interval @ 125ms
    ble_cmd_gap_set_scan_parameters(200,200,1);

    //Start scan
    m_lastScanDateTime = QDateTime::currentDateTime();
    ble_cmd_gap_discover(gap_discover_generic);


    m_timer = new QTimer(this);
    connect(m_timer,SIGNAL(timeout()),this,SLOT(timeout()));
    m_timer->start(100); //100ms timeout is fast enough
    return true;
}

void BLED112Driver::closeConnections(){


    for (int i=0; i<m_contextList.count(); i++){
        ble_cmd_connection_disconnect(m_contextList.at(i)->m_connection);
    }

    /*qDeleteAll(m_contextList);
    m_contextList.clear();*/



    if (m_serialPort.isOpen()){
        m_serialPort.waitForBytesWritten(-1);
        m_serialPort.close();
        while(m_serialPort.isOpen());
    }



}

void BLED112Driver::scanResponse(const ble_msg_gap_scan_response_evt_t *msg)
{

    QByteArray mac((const char*) msg->sender.addr, 6);
    QString name(QByteArray((const char*)msg->data.data,msg->data.len));
    name = name.right(name.length()-1); // Remove name length
    if (name.contains("WIMU3") && !name.contains("xxxx")){

        //Look for already existing device
        for (int i =0; i< m_contextList.size(); i++)
        {
            if (m_contextList[i]->m_mac == mac)
            {
                //qDebug("Already discovered...");
                return;
            }

        }

        //Debug
        //qDebug() << "---- New device detected mac: " << mac.toHex() << " name : " << name;
        //emit displayMessage("New WIMU detected: " + name);

        //Not found, append device
        BLEDeviceContext *context = new BLEDeviceContext(mac, name, msg->address_type);
        m_contextList.append(context);
        emit deviceDiscovered(context);

        //Stop scanning
        //ble_cmd_gap_end_procedure();
    }
}

void BLED112Driver::connectionStatusEvent(const ble_msg_connection_status_evt_t *msg)
{
    //Forward message to the right context
    for (int i = 0; i < m_contextList.size(); i++)
    {
        BLEDeviceContext *context = m_contextList[i];


        //Handle is probably not set yet
        //Let's find the right context with the mac...
        QByteArray mac((const char*) msg->address.addr, 6);


        if (mac == context->m_mac)
        {
            context->connectionStatusEvent(msg);

            if (context->m_state == BLEDeviceContext::CONNECTED)
            {
                emit deviceConnected(context);
                connect(context,SIGNAL(initCompleted(BLEDeviceContext*)),this,SIGNAL(deviceReady(BLEDeviceContext*)));
            }
            else if (context->m_state == BLEDeviceContext::DISCONNECTED)
            {
                qDebug() << context->m_name << " disconnected!";

                //Emit signal before deleting
                emit deviceDestroyed(context);
                m_contextList.removeAll(context);
                delete context;

                // Restart scan for another one (or the same one)
                ble_cmd_gap_end_procedure();
                ble_cmd_gap_discover(gap_discover_generic);

                //Exit for loop
                break;
            }
        }

    }
}

void BLED112Driver::connectionDisconnectedEvent(const ble_msg_connection_disconnected_evt_t *msg)
{
    //Forward message to the right context
    for (int i = 0; i < m_contextList.size(); i++)
    {
        BLEDeviceContext *context = m_contextList[i];

        if (msg->connection == context->m_connection)
        {
            //qDebug() << m_contextList.at(i)->m_name << " disconnected.";
            context->connectionDisconnectedEvent(msg);

            ble_cmd_gap_end_procedure();

            //Emit signal before deleting
            emit deviceDestroyed(context);
            m_contextList.removeAll(context);
            delete context;

            // Restart scan
            ble_cmd_gap_discover(gap_discover_generic);

            /*if (m_serialPort.isOpen())
                m_serialPort.close();

            m_serialPort.disconnect();

            g_BLED112DriverPtr = NULL;*/

            //Exit for loop
            break;
        }

    }
}

void BLED112Driver::groupFoundEvent(const ble_msg_attclient_group_found_evt_t *msg)
{
    //Forward message to the right context
    for (int i = 0; i < m_contextList.size(); i++)
    {
        if (m_contextList[i]->m_connection == msg->connection)
            m_contextList[i]->groupFoundEvent(msg);
    }
}

void BLED112Driver::procedureCompletedEvent(const ble_msg_attclient_procedure_completed_evt_t *msg)
{

    //Forward message to the right context
    for (int i = 0; i < m_contextList.size(); i++)
    {
        if (m_contextList[i]->m_connection == msg->connection)
            m_contextList[i]->procedureCompletedEvent(msg);
    }
}

void BLED112Driver::attributeValueEvent(const ble_msg_attclient_attribute_value_evt_t *msg)
{

    //Forward message to the right context
    for (int i = 0; i < m_contextList.size(); i++)
    {
        if (m_contextList[i]->m_connection == msg->connection)
            m_contextList[i]->attributeValueEvent(msg);
    }
}

void BLED112Driver::informationFoundEvent(const ble_msg_attclient_find_information_found_evt_t *msg)
{
    //Forward message to the right context
    for (int i = 0; i < m_contextList.size(); i++)
    {
        if (m_contextList[i]->m_connection == msg->connection)
            m_contextList[i]->informationFoundEvent(msg);
    }
}




void BLED112Driver::readyReadSerial()
{
    struct ble_header apihdr;
    const struct ble_msg *apimsg;

    //Make sure we read all messages
    while(m_serialPort.bytesAvailable() > 0)
    {
        //Read header
        if (m_serialPort.bytesAvailable() >= 4)
        {

            m_serialPort.read((char*) &apihdr,4);
            //qDebug("payload length : %i",apihdr.lolen);
        }
        else
        {
            qWarning("No data in serial port");
            return;
        }

        //Read payload
        QByteArray payload;
        if (apihdr.lolen > 0)
        {
            payload = m_serialPort.read(apihdr.lolen);
        }

        //Parse
        apimsg=ble_get_msg_hdr(apihdr);

        QByteArray header;
        header.append(apihdr.type_hilen);
        header.append(apihdr.lolen);
        header.append(apihdr.cls);
        header.append(apihdr.command);

        //qDebug() << "header: " << header.toHex() << " payload: "<< payload.toHex();

        if (apimsg)
        {
            //qDebug("Handling message");
            apimsg->handler(payload.constData());
        }
        else
        {
            qWarning("Parser error");
        }

    } //while bytes available
}

void BLED112Driver::timeout()
{
    QList<BLEDeviceContext*> toRemoveList;

    //State machine handling for each context...
    //Seems to work
    for (int i = 0; i < m_contextList.size(); i++)
    {
        m_contextList[i]->state_machine();

        if (m_contextList[i]->m_state == BLEDeviceContext::WAITING_CONNECTION)
        {

            //Destroy device if not connected for 30 seconds
            if (QDateTime::currentDateTime().toMSecsSinceEpoch()
                    - m_contextList[i]->lastScanTime().toMSecsSinceEpoch() > 30000)
            {
                toRemoveList.push_back(m_contextList[i]);
            }
        }
    }

    //Remove unwanted contexts
    for (int i =0; i < toRemoveList.size(); i++)
    {
        BLEDeviceContext *context = toRemoveList[i];
        //Emit signal before deleting
        emit deviceDestroyed(context);
        m_contextList.removeAll(context);
        delete context;
    }
    toRemoveList.clear();


    //If nothing to do...
    //Can we do better???
    if (QDateTime::currentDateTime().toMSecsSinceEpoch() - m_lastScanDateTime.toMSecsSinceEpoch() > 10000)
    {
        m_lastScanDateTime = QDateTime::currentDateTime();
        //Do not end procedure here, we might be doing something (scanning) in the contexts.
        //Do it only when there is no contexts.
        //Sometimes the discover will fail because we are already discovering. Does not matter...

        if (m_contextList.empty())
        {
            ble_cmd_gap_end_procedure();
            ble_cmd_gap_discover(gap_discover_generic);
        }

        //ble_cmd_gap_discover(gap_discover_generic);
    }
}

void BLED112Driver::writeSerialData(uint8 len1, uint8 *data1, uint16 len2, uint8 *data2)
{
    if (!m_serialPort.isOpen())
        return;

    qint64 bytes_written = 0;

    //header
    if (data1 != NULL && len1 > 0)
        bytes_written += m_serialPort.write((const char*)data1,len1);

    //data
    if (data2 != NULL && len2 > 0)
        bytes_written += m_serialPort.write((const char*) data2,len2);

    //qDebug() << "Wrote bytes :" << bytes_written;

    //m_serialPort.waitForBytesWritten(-1);
}

BLEDeviceContext* BLED112Driver::connectDevice(const QString &id){
    for (int i=0; i<m_contextList.count(); i++){
        if (m_contextList.at(i)->m_name.trimmed()==id){
            m_contextList.at(i)->connectDevice();
            return m_contextList[i];
        }
    }
    return NULL;
}

void BLED112Driver::disconnectDevice(const BLEDeviceContext* device){
    if (device){
        ble_cmd_connection_disconnect((quint8)device->m_connection);
    }
}
