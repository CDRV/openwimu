#include "wimu_usb_driver.h"

#include <QDebug>

WIMUUSBDriver::WIMUUSBDriver(QObject *parent) : QObject(parent)
{
    m_serialPort = NULL;
    m_serialBuffer.clear();
    m_binStreaming = false;

    qRegisterMetaType<WIMUUSBDriver::WIMUCommandID>("WIMUUSBDriver::WIMUCommandID");

}

bool WIMUUSBDriver::wimuFindAndPrepare(){
    // Delete previous serial port
    if (m_serialPort){
        wimuDisconnect();
    }

    QList<QSerialPortInfo> serial_list = QSerialPortInfo::availablePorts();

    for (int i=0; i<serial_list.count(); i++){
        if (serial_list.at(i).description().contains("STMicroelectronics", Qt::CaseInsensitive) ||
            serial_list.at(i).description().contains("WIMU", Qt::CaseInsensitive)){
            // WIMU found
            m_serialPort = new QSerialPort(serial_list.at(i));
            break;
        }
    }

    if (m_serialPort==NULL){
        // No WIMU
        return false;
    }

    return true;
}

bool WIMUUSBDriver::wimuConnect(){
    bool rval = false;
    if (!m_serialPort)
        return false;

    m_serialPort->setBaudRate(230400);
    rval = m_serialPort->open(QSerialPort::ReadWrite);

    if (rval){
        connect(m_serialPort,SIGNAL(aboutToClose()),this,SIGNAL(comAboutToClose()));
        connect(m_serialPort,SIGNAL(readyRead()),this,SLOT(serialPortDataReady()));
        connect(m_serialPort,SIGNAL(error(QSerialPort::SerialPortError)),this,SIGNAL(comError(QSerialPort::SerialPortError)));
    }

    return rval;
}

void WIMUUSBDriver::wimuDisconnect(){
    if (m_serialPort){
        if (m_serialPort->isOpen())
            m_serialPort->close();
        m_serialPort->deleteLater();
        m_serialPort=NULL;
    }
    m_serialBuffer.clear();
    m_commands.clear();
    m_commands_ids.clear();
}

void WIMUUSBDriver::wimuSendCommand(QString cmd, WIMUCommandID cmd_id){
    if (!m_serialPort)
        return;

    if (m_binStreaming)
        return;

    // Clean the string
    QString tosend = cmd;

    // Remove all exit codes
    tosend = tosend.replace('\n',"");
    tosend = tosend.replace('\r',"");

    // Append return
    //tosend.append('\r');
    tosend.append('\n');

    // Enqueue command
    m_commands.enqueue(tosend.toUtf8());
    m_commands_ids.enqueue(cmd_id);

    if (m_commands.count()==1){
        // Send to serial port if no command currently sending
        m_serialPort->write(m_commands.head());
        m_serialPort->waitForBytesWritten(-1);
    }

}

void WIMUUSBDriver::wimuSendData(QByteArray data, WIMUCommandID cmd_id){
    if (!m_serialPort)
        return;

    if (m_binStreaming)
        return;

    // Enqueue command
    m_commands.enqueue(data);
    m_commands_ids.enqueue(cmd_id);

    if (m_commands.count()==1)
        // Send to serial port if no command currently sending
        m_serialPort->write(m_commands.head());

}

void WIMUUSBDriver::serialPortBinaryReady(){
    WIMUBinaryStream bin;
    quint16 count;

    while ((count=bin.fromBinaryStream(m_serialBuffer))>0){
    //if (bin.fromBinaryStream(m_serialBuffer)>0){
        emit binReceived(bin);
        m_serialBuffer.remove(0,count);
    }
}

void WIMUUSBDriver::serialPortDataReady(){
    m_serialBuffer.append(m_serialPort->readAll()); // Read all pending data
    //m_serialBuffer.append(m_serialPort->readLine());

    if (m_binStreaming)
        serialPortBinaryReady();

    if (m_commands.isEmpty()){
        // Data received but no command sent - don't know what to do with it!
        m_serialBuffer.clear();
        return;
    }

    if (m_serialBuffer.count() < m_commands.head().count()){
        return; // Wait for more
    }

    if (!m_commands.head().isEmpty()){
        // Module will echo back characters - ignore characters from the command
        // Remove those bytes from the list
        if (m_serialBuffer.left(m_commands.head().count())==m_commands.head()){
            m_serialBuffer.remove(0, m_commands.head().count());
            m_commands.head().clear();
        }


    }

    if (m_serialBuffer.isEmpty())
        return;

    // Remove pending "\n" or "\r"
    while ((m_serialBuffer.at(0) == '\n' || m_serialBuffer.at(0) == '\r')){
        m_serialBuffer.remove(0,1);
        if (m_serialBuffer.isEmpty())
            return;
    }

    // Process reply according to last command ID
    switch (m_commands_ids.head()){
    case WimuCmdGetConf:{
        // Check if we have received everything yet
        if (m_serialBuffer.count()<WIMUConfig::size())
            return;
        // Load data
        WIMUConfig config(3); // TODO: detect and use correct hardware version...

        while( !(m_serialBuffer.at(0) == char(0xEA) && m_serialBuffer.at(1) == char(0xEA)) &&
              m_serialBuffer.count()>=2){ // Sync on sync byte
            m_serialBuffer.remove(0,1);
        }
        // Remove 2 sync bytes
        m_serialBuffer.remove(0,2);

        // Check module ID byte and remove it
        m_serialBuffer.remove(0,1); // remove module ID

        // Check length
        if (m_serialBuffer.at(0) != WIMUConfig::size()){
            emit cmdError(m_commands_ids.head());
        }else{
            m_serialBuffer.remove(0,1); // remove length
            config.unserialize(&m_serialBuffer);

            // TODO: Checksum
            emit configReceived(config);
        }
    }
    break;
    case WimuCmdSetConf:
        // Check if we have received everything yet
        /*if (m_serialBuffer.count() < WIMUConfig::size() || !m_serialBuffer.endsWith('\r'))
            return;*/

       if (m_serialBuffer.contains("OK")){ // OK
           //qDebug() << "CONF OK";
           // All is well
           emit cmdOK(m_commands_ids.head());

       }else{
           if (m_serialBuffer.contains("ERROR")){
               // Error
               emit cmdError(m_commands_ids.head());
           }
           else{
               return;
           }
       }

        break;
    case WimuCmdGetTime:
         // Update module time
        if (m_serialBuffer.endsWith('\r')){
            QString datetime(m_serialBuffer);
            datetime = datetime.replace("\r","");
            datetime = datetime.replace("\n","");
            QDateTime moduleTime = QDateTime::fromTime_t(datetime.toULong(), Qt::UTC);
            emit timeReceived(moduleTime);
        }else
            return; // Wait for even more!
        break;
    case WimuCmdSetTime:
        if (m_serialBuffer.endsWith('\r')){
            if (m_serialBuffer.contains("OK")){ // OK
                // All is well
                emit cmdOK(m_commands_ids.head());

            }else{
                return; // Wait for more...
            }
        }
        break;
    case WimuCmdSetSet:
        //if (m_serialBuffer.count() > WIMUSettings::size()+6+4 && m_serialBuffer.endsWith('\r')){ // sizeof (setset) + \n\r\n\r

           if (m_serialBuffer.contains("OK")){ // OK
               // All is well
               emit cmdOK(m_commands_ids.head());
           }else{
               // Error
               emit cmdError(m_commands_ids.head());
           }
           //m_serialBuffer.clear();
       /*}else{
            return;
        }*/
        break;
    case WimuCmdGetSet:{
        // Check if we have received everything yet
        if (m_serialBuffer.count()<WIMUSettings::size())
            return;

        // Load data
        WIMUSettings settings;

        while( !(m_serialBuffer.at(0) == char(0xEA) && m_serialBuffer.at(1) == char(0xEA)) &&
              m_serialBuffer.count()>=2){ // Sync on sync byte
            m_serialBuffer.remove(0,1);
        }
        // Remove 2 sync bytes
        m_serialBuffer.remove(0,2);

        // Check module ID byte and remove it
        if (m_serialBuffer.at(0)!=0){
            emit cmdError(m_commands_ids.head());

        }else{
            m_serialBuffer.remove(0,1); // remove module ID

            // Check length
            if (m_serialBuffer.at(0) != WIMUSettings::size()){
                emit cmdError(m_commands_ids.head());
            }else{
                m_serialBuffer.remove(0,1); // remove length
                settings.unserialize(&m_serialBuffer);

                emit settingsReceived(settings);

            }
        }
    }
    break;
    case WimuCmdStream:
        m_binStreaming = true;
        break;
    default:
        // Generic reply
        if (!m_serialBuffer.isEmpty() && m_serialBuffer.count()>1)
            emit cmdReply(QString(m_serialBuffer),m_commands_ids.head());
        else
            return;
        break;
    }


    // Clean up!
    if (!m_serialBuffer.isEmpty()){
        m_commands.dequeue();
        m_commands_ids.dequeue();
        m_serialBuffer.clear();
    }

    if (m_commands.count()>0){
        m_serialPort->write(m_commands.head());
        //m_serialPort->waitForBytesWritten(-1);
    }


}

void WIMUUSBDriver::wimuReboot(){
    wimuSendCommand("reboot", WimuCmdReboot);

    if (m_serialPort)
        m_serialPort->waitForBytesWritten(-1);
}

void WIMUUSBDriver::wimuSyncTime(){
    QDateTime local_date = QDateTime::currentDateTime();
    QString datestr = QString::number(QDateTime::currentDateTime().toTime_t()+local_date.offsetFromUtc());

    wimuSendCommand("timeset " + datestr, WimuCmdSetTime);
}

void WIMUUSBDriver::wimuGetTime(){
    wimuSendCommand("time", WimuCmdGetTime);
}

void WIMUUSBDriver::wimuGetSettings(){
    wimuSendCommand("getset", WimuCmdGetSet);
}

void WIMUUSBDriver::wimuGetConfig(){
    wimuSendCommand("getconf", WimuCmdGetConf);
}

void WIMUUSBDriver::wimuStream(bool enable){

    // Check if we are still connected, if not, abort!
    if (!m_serialPort->isOpen()){
        wimuDisconnect();
        return;
    }

    if (enable){
        wimuSendCommand("bin", WimuCmdStream);

    }else{
        m_serialPort->write("\n"); // Stop the stream
        m_binStreaming = false;
        m_serialPort->waitForBytesWritten(-1);
    }
}

QString WIMUUSBDriver::comGetErrorString(){
    QString rval ="";

    if (m_serialPort)
        rval = m_serialPort->errorString();

    return rval;
}

QString WIMUUSBDriver::comGetPortName(){
    QString rval = "Inconnu";

    if (m_serialPort)
        rval = m_serialPort->portName();

    return rval;
}
