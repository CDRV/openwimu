#include "wimu_ble_driver.h"

#include <QDataStream>

WIMUBLEDriver::WIMUBLEDriver(QObject *parent) : QObject(parent)
{
    connect(&m_driver,SIGNAL(displayMessage(QString)),this,SIGNAL(comStatusString(QString)));
    connect(&m_driver,SIGNAL(deviceDiscovered(BLEDeviceContext*)),this,SLOT(handleNewDeviceDiscovered(BLEDeviceContext*)));
    connect(&m_driver,SIGNAL(deviceDestroyed(BLEDeviceContext*)),this,SLOT(handleDeviceDestroyed(BLEDeviceContext*)));
    connect(&m_driver,SIGNAL(deviceReady(BLEDeviceContext*)),this,SLOT(handleDeviceReady(BLEDeviceContext*)));
    connect(&m_driver,SIGNAL(deviceConnected(BLEDeviceContext*)),this,SIGNAL(bleDeviceConnected(BLEDeviceContext*)));

    m_context=NULL;
    m_imuHandle=0;
    m_quaHandle=0;
    m_controlHandle=0;
    m_timeHandle=0;
    m_portName = "";
}

WIMUBLEDriver::~WIMUBLEDriver(){
    m_driver.closeConnections();
}

bool WIMUBLEDriver::bledFindAndPrepare(){
	// Check if we have a BlueGiga device connected
    //if (!g_BLED112DriverPtr){
		QList<QSerialPortInfo> list = QSerialPortInfo::availablePorts();
        m_portName = "";
		for(int i = 0;i<list.length();i++){
		   if(list.at(i).description().contains("Bluegiga", Qt::CaseInsensitive)){
			   if(list.at(i).isBusy()){
                   m_lastErrorStr = "Port COM " + list.at(i).portName() + " occupé.";
                   return false;
			   }
               m_portName = list.at(i).portName();
			   break;
		   }
		}
        if (m_portName.isEmpty()){
            m_lastErrorStr = "BlueGiga BLE112 non-trouvé. Vérifiez qu'il est bien connecté au système.";
            return false;
		}
        return true;
    //}
    //m_lastErrorStr = "BLE déjà préparé.";
    //return false;
}

bool WIMUBLEDriver::bledConnect(){
    // Try to connect to the device
    if (!m_driver.init(m_portName)){
        m_lastErrorStr = tr("Impossible d'ouvrir le port COM du BLE112");
        return false;
    }

    return true;
}


void WIMUBLEDriver::bledDisconnect(){
   if (!g_BLED112DriverPtr){
	   return;
   }
   m_driver.closeConnections();
   emit comAboutToClose();
}

bool WIMUBLEDriver::wimuConnect(QString id){

    m_context = m_driver.connectDevice(id);

    if (m_context){
        connect(m_context,SIGNAL(attributeValue(uint,uint,QByteArray)),this,SLOT(handleNewData(uint,uint,QByteArray)));
    }

    return m_context != NULL;
}

void WIMUBLEDriver::wimuDisconnect(){
    if (m_context){
        m_context->disconnect();
        m_driver.disconnectDevice(m_context);
    }


    /*m_context->deleteLater();*/

    m_context = NULL;
}

void WIMUBLEDriver::handleNewDeviceDiscovered(BLEDeviceContext *context){
   /*if (m_context){
	   m_context->disconnect();
   }*/

   emit bleDeviceDiscovered(context);

   //emit comStatusString("Connecté à: " + context->m_name);

   //emit displayString("Connected to " + context->m_name);
   //emit displayString("Getting ready... please wait!");

   /*m_context = context;

   connect(m_context,SIGNAL(attributeValue(uint,uint,QByteArray)),this,SLOT(handleNewData(uint,uint,QByteArray)));
   */

}

void WIMUBLEDriver::handleDeviceDestroyed(BLEDeviceContext *context){
    emit bleDeviceDestroyed(context);

	if (context==m_context)
		m_context=NULL;
}

void WIMUBLEDriver::handleDeviceReady(BLEDeviceContext *context){
	if (m_context==context){
		// Check if there's an "Actimetry" service
        //emit displayString("Ready to stream!");
		for (int i=0; i<m_context->m_serviceList.count(); i++){
            if (m_context->m_serviceList.at(i).m_uuid == 0x70ee){ // Actimetry service
                // Get attributes handles
				for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x7486)    // Raw Data
                        m_imuHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;

                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x759d)    // Orientation
                        m_quaHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;

                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x76ad)    // Control
                        m_controlHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;


				}
			}

            if (m_context->m_serviceList.at(i).m_uuid == 0x1805){ // Current Time Service
                // Get attributes handles
                for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x2a2b) // Current time value
                        m_timeHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;
                }
            }
		}
        //emit newStatus(Status::bluetooth);

        wimuGetTime(); // Get Time
	}
}

void WIMUBLEDriver::wimuIMUStreaming(bool enable){
    if (m_imuHandle==0)
		return;
	for (int i=0; i<m_context->m_serviceList.count(); i++){
		if (m_context->m_serviceList.at(i).m_uuid == 0x70ee){
			for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
				if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x759d){
					for (int k=j+1; k<j+4; k++){
						if (m_context->m_serviceList.at(i).m_attributeList.at(k).m_uuid==0x2902){
							if (enable)
								m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("01:00"));
							else
								m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("00:00"));
							return;
						}
					}
				}
			}
		}
	}
}

void WIMUBLEDriver::wimuRAWStreaming(bool enable){
    if (m_quaHandle==0)
		return;

	for (int i=0; i<m_context->m_serviceList.count(); i++){
		if (m_context->m_serviceList.at(i).m_uuid == 0x70ee){
			for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
				if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x7486){
					for (int k=j+1; k<j+4; k++){
						if (m_context->m_serviceList.at(i).m_attributeList.at(k).m_uuid==0x2902){
							if (enable)
								m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("01:00"));
							else
								m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("00:00"));
							return;
						}
					}
				}
			}
		}
	}
}

void WIMUBLEDriver::wimuRecord(bool start){
    if (m_controlHandle==0)
		return;

	if (start)
        m_context->attributeWrite(m_controlHandle,QByteArray::fromHex("01"));
	else
        m_context->attributeWrite(m_controlHandle,QByteArray::fromHex("00"));

	/*
	for (int i=0; i<m_context->m_serviceList.count(); i++){
		if (m_context->m_serviceList.at(i).m_uuid == 0x70ee){
			for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
				if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x76ad){
					if (start)

						m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(0).m_handle,QByteArray::fromHex("01:00"));
					else
						m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(0).m_handle,QByteArray::fromHex("00:00"));
					return;
				}

			}
		}
	}*/

}

void WIMUBLEDriver::wimuSyncTime(){
    if (m_timeHandle ==0)
        return;

    if(!m_context)
        return;

    // Pack current time
    QByteArray data;
    QDateTime current = QDateTime::currentDateTime();
    QDataStream ds(&data, QIODevice::WriteOnly);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    ds << (quint16)current.date().year();
    ds << (quint8)current.date().month();
    ds << (quint8)current.date().day();
    ds << (quint8)current.time().hour();
    ds << (quint8)current.time().minute();
    ds << (quint8)current.time().second();
    ds << (quint8)current.date().dayOfWeek();
    ds << (quint8)0;
    ds << (quint8)1; // Manual update

    m_context->attributeWrite(m_timeHandle, data);

    wimuGetTime();

}

void WIMUBLEDriver::wimuGetTime(){
    if (m_timeHandle ==0)
        return;

    if(!m_context)
        return;

    m_context->attributeRead(m_timeHandle); // Answer will come soon...! (handleNewData)

}

QString WIMUBLEDriver::comGetErrorString(){
    return m_lastErrorStr;
}

QString WIMUBLEDriver::comGetPortName(){
    return m_portName;
}

void WIMUBLEDriver::handleNewData(uint handle, uint type, QByteArray value){
Q_UNUSED(type)
    //qDebug() << "Data from handle " << handle;

    if (handle==m_imuHandle || handle==m_quaHandle){
		// Parse IMU data
		/*IMUFrame frame(value);
		//frameList.clear();
		frameList.append(frame);

		emit newIMUFramesAvailable(&frameList);
		frameList.clear();*/
	}

    if (handle==m_timeHandle){
        QDateTime current_time = unpackDateTime(value);

        emit timeReceived(current_time);
    }

}

QDateTime WIMUBLEDriver::unpackDateTime(QByteArray& data){
    QDataStream ds(data);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    BLECurrentTime_Struct current_time;

    ds >> current_time.year;
    ds >> current_time.month;
    ds >> current_time.day;
    ds >> current_time.hours;
    ds >> current_time.minutes;
    ds >> current_time.seconds;
    ds >> current_time.day_of_week;
    ds >> current_time.fractions256;
    ds >> current_time.adjust_reason;

    QDateTime rval(QDate(current_time.year, current_time.month, current_time.day),
                   QTime(current_time.hours, current_time.minutes, current_time.seconds));

    return rval;
}
