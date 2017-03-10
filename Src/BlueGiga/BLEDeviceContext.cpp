#include "BLEDeviceContext.h"
#include <QtEndian>


BLEDeviceContext::BLEDeviceContext(QByteArray mac, QString name, unsigned int address_type, unsigned int connectDelayMs)
    : QObject(NULL),
      m_state(DISCONNECTED),
      m_mac(mac),
      m_name(name),
      m_addressType(address_type),
      m_connectDelayMs(connectDelayMs)
{
    m_connection = 0;
    m_scanTime = QDateTime::currentDateTime();
    //qDebug() << "BlueGiga: Context started with device " << name << " [" << mac.toHex() <<"] delay: "<<m_connectDelayMs;
}

BLEDeviceContext::~BLEDeviceContext(){
    //ble_cmd_connection_disconnect(m_connection);
    //ble_cmd_system_reset(0);

}

void BLEDeviceContext::connectionStatusEvent(const ble_msg_connection_status_evt_t *msg)
{
    //Verify if the right mac address
    if (QByteArray((const char*)msg->address.addr,6) != m_mac)
        return;

    if(msg->flags & connection_connected)
    {
        //qDebug("--- Connected! bond: %d ",msg->bonding);
        m_state = CONNECTED;
        m_connection = msg->connection;
    }
    else
    {
        //qDebug("---- Disconnected");
        m_state = DISCONNECTED;
        m_connection = msg->connection;
    }
}

void BLEDeviceContext::connectionDisconnectedEvent(const ble_msg_connection_disconnected_evt_t *msg)
{
    m_state = DISCONNECTED;
    m_connection = msg->connection;
}

void BLEDeviceContext::groupFoundEvent(const ble_msg_attclient_group_found_evt_t *msg)
{
    //Verify if the message is for us
    if (m_state == SCANNING_SERVICES && msg->connection == m_connection)
    {
        quint16 uuid;
        uuid = qFromLittleEndian<quint16>(msg->uuid.data);
        //QByteArray((const char*)msg->uuid.data,msg->uuid.len);

        //qDebug() << "---- Service found " << QString("%1").arg(uuid,0,16);//QByteArray((const char*)msg->uuid.data,msg->uuid.len).toHex();

        BLEService service(msg->start,msg->end,msg->connection, uuid/*(const char*) msg->uuid.data,msg->uuid.len*/);

        m_serviceList.append(service);

        emit serviceFound(msg->start,msg->end, uuid/*QByteArray((const char*)msg->uuid.data,msg->uuid.len)*/);

    }
}

void BLEDeviceContext::informationFoundEvent(const ble_msg_attclient_find_information_found_evt_t *msg)
{
    if (m_state == SCANNING_DESCRIPTORS && msg->connection == m_connection)
    {
        quint16 uuid;
        uuid = qFromLittleEndian<quint16>(msg->uuid.data);

        //qDebug() << "Information found chrhandle: " << msg->chrhandle
        //         << " connection " << msg->connection
        //         << " uuid " << QString("%1").arg(uuid,0,16)/*QByteArray((const char*) msg->uuid.data,msg->uuid.len).toHex()*/;

        // Find handle in attributes, if present
        // Find correct service for that information
        for (int i=0; i<m_serviceList.count(); i++){

            if (msg->chrhandle<=m_serviceList.at(i).m_end && msg->chrhandle>=m_serviceList.at(i).m_start){
                // Service found - check if attribute is already present
                bool already_present = false;
                /*for (int j=0; j<m_serviceList.at(i).m_attributeList.count(); j++){
                    if (m_serviceList.at(i).m_attributeList.at(j).m_handle==msg->chrhandle){
                        already_present=true;
                        m_serviceList[i].m_attributeList[j].setUUID(uuid);
                        break;
                    }
                }*/
                if (!already_present){
                    // Find correct position

                    int index = m_serviceList.at(i).m_attributeList.count();

                    if (m_serviceList.at(i).m_attributeList.count()==1){
                        if (m_serviceList.at(i).m_attributeList.at(0).m_handle>msg->chrhandle){
                            index=0;
                        }
                    }

                    for (int j=0; j<m_serviceList.at(i).m_attributeList.count()-1; j++){
                        if (msg->chrhandle > m_serviceList.at(i).m_attributeList.at(j).m_handle &&
                            msg->chrhandle < m_serviceList.at(i).m_attributeList.at(j+1).m_handle){
                            index = j+1;
                            break;
                        }
                    }
                    BLEAttribute new_att(2,0,msg->chrhandle);
                    new_att.m_uuid = uuid;
                    m_serviceList[i].m_attributeList.insert(index,new_att);
                }
                break;
            }
        }

    }
}

void BLEDeviceContext::connectDevice(){
    m_state = DISCOVERED;
}

void BLEDeviceContext::procedureCompletedEvent(const ble_msg_attclient_procedure_completed_evt_t *msg)
{

    if (msg->connection == m_connection)
    {

        if (m_state == SCANNING_SERVICES)
        {
            //qDebug("---- Services scan terminated.");

            //Scanning attributes all at once
            unsigned char uuid[2] = {0x03, 0x28};

            ble_cmd_attclient_read_by_type(msg->connection,0x0001,0xffff,2,uuid);

            m_state = SCANNING_ATTRIBUTES;

        }
        else if (m_state == SCANNING_ATTRIBUTES)
        {

            //qDebug("---- Attributes scan terminated.");

            ble_cmd_attclient_find_information(msg->connection,0x0001,0xffff);

            m_state = SCANNING_DESCRIPTORS;

        }
        else if (m_state == SCANNING_DESCRIPTORS)
        {
            //qDebug("---- Descriptors scan done");
            m_state = READY;
            emit initCompleted(this);


        }
        else if (m_state == WRITING)
        {
            //qDebug("---- Done writing");
            m_state = READY;
        }
    } //if connection
}

bool BLEDeviceContext::attributeWrite(unsigned int handle, const QByteArray &data)
{
    //TODO max list size ?
    //TODO Mutex?
    m_writeList.append(QPair<unsigned int, QByteArray>(handle,data));
    return true;
}

bool BLEDeviceContext::attributeRead(unsigned int handle){
    m_readList.append(handle);
    return true;
}

void BLEDeviceContext::attributeValueEvent(const ble_msg_attclient_attribute_value_evt_t *msg)
{
    if (msg->connection == m_connection)
    {

        //Verify that the message is for us!
        if (m_state == SCANNING_ATTRIBUTES)
        {
            //append attribute
            //to the right service
            for (int i = 0; i< m_serviceList.size(); i++)
            {
                if (msg->atthandle > m_serviceList[i].m_start && msg->atthandle < m_serviceList[i].m_end)
                {

                    /*quint16 uuid;
                    uuid = qFromLittleEndian<quint16>(msg->value.data);*/

                    //qDebug() << "---- Service " << QString("%1").arg(m_serviceList[i].m_uuid,0,16)//m_serviceList[i].m_uuid
                    //         << " Adding attribute type " << msg->type << " "
                    //         << " Atthandle " << msg->atthandle << " "
                    //         << /*QString("%1").arg(uuid,0,16);*/QByteArray((const char*) msg->value.data,msg->value.len);


                    //m_serviceList[i].m_attributeList.append(BLEAttribute(msg->type,
                    //                                                     QByteArray((const char*) msg->value.data,msg->value.len)/*uuid*/,msg->atthandle));

                    emit attributeValue(msg->type, msg->atthandle,/*uuid*/QByteArray((const char*) msg->value.data,msg->value.len));
                }
            }
        }
        else if (m_state == READY)
        {
            //qDebug() << "---- READY Attribute atthandle: " << msg->atthandle
            //         << " type " << msg->type
            //         << " value " << QByteArray((const char*) msg->value.data,msg->value.len).toHex();


            //New value returned
            emit attributeValue(msg->atthandle, msg->type, QByteArray((const char*) msg->value.data,msg->value.len));


        }
        else if (m_state == WRITING)
        {
            //New value returned
            emit attributeValue(msg->atthandle, msg->type, QByteArray((const char*) msg->value.data,msg->value.len));

            //Go back to ready state
            //Will be done by procedure complete
            //m_state = READY;
        }
    } //test connection
}

bool BLEDeviceContext::state_machine()
{
    switch (m_state)
    {
    case DISCOVERED:
        //Wait few seconds before discovered...
        if (QDateTime::currentDateTime().toMSecsSinceEpoch() - m_scanTime.toMSecsSinceEpoch() > m_connectDelayMs)
        {
            //qDebug("---- Connecting");
            //address
            //addr_type
            //conn_interval_min = 1.25ms * val (6-3200)
            //conn_interval_max = 1.25ms * val (6-3200)
            //timeout = 10ms * val (10-3200)
            //latency = 0 = latency disabled
            //ble_cmd_gap_connect_direct(m_mac.constData(),m_addressType,0x003c,0x004c,0x0064,0x0000);
            ble_cmd_gap_connect_direct(m_mac.constData(),m_addressType,0x0009,0x0010,0x0064,0x0000);
            m_state = WAITING_CONNECTION;
        }
        break;

    case WAITING_CONNECTION:
        //TODO TIMEOUT IF CONNECT NEVER OCCURS?
        break;

    case CONNECTED:
        //Scan for services
    {

        uint8 uuid [2] = { 0x00, 0x28 }; //primary service
        ble_cmd_attclient_read_by_group_type(m_connection,0x0001,0xffff,2,uuid);
        m_state = SCANNING_SERVICES;


        //ble_cmd_attclient_find_information(m_connection,0x0001,0xffff);
        //m_state = SCANNING_SERVICES;
        m_scanTime = QDateTime::currentDateTime();
        //m_state = READY;
    }
        break;

    case SCANNING_SERVICES:
        //We are waiting for events...
        break;

    case SCANNING_ATTRIBUTES:
        //We are waiting for events...
        break;
    case SCANNING_DESCRIPTORS:
        //We are waiting for events...
        break;

    case READY:

        //Something to send???
        if (m_writeList.size() > 0)
        {

            //Get the command...
            QPair<unsigned int, QByteArray> command = m_writeList.takeFirst();

            //write the attribute
            ble_cmd_attclient_attribute_write(m_connection, command.first,
                                              command.second.size(), command.second.constData());
            m_state = WRITING;
        }
        else
        {
            if (m_readList.size() >0){

                unsigned int handle = m_readList.takeFirst();

                ble_cmd_attclient_read_by_handle(m_connection, handle);

            }else{
                //Ready for something...
                emit ready();
            }
        }


        break;

    case WRITING:
        //Waiting for event
        break;

    case DISCONNECTED:
        //qDebug("---- Disconnecting");
        break;

    default:
        //qDebug("Unhandled state");
        break;

    }

    return true;
}

QDateTime BLEDeviceContext::lastScanTime()
{
    return m_scanTime;
}

BLEAttribute::BLEAttribute(unsigned int type, QByteArray value, unsigned int atthandle)
    : m_value(value), m_handle(atthandle)
{
    Q_UNUSED(type)

}

void BLEAttribute::setUUID(quint16 uuid){
    m_uuid = uuid;
}

BLEService::BLEService(unsigned int start, unsigned int end, unsigned char connection, quint16 uuid)
    : m_start(start), m_end(end), m_connection(connection), m_uuid(uuid)
{

}

bool BLEService::operator==(const BLEService &service)
{
    if (m_start == service.m_start &&
            m_end == service.m_end &&
            m_connection == service.m_connection &&
            m_uuid == service.m_uuid)
    {
        return true;
    }

    return false;
}

bool BLEService::addAttribute()
{


    return true;
}
