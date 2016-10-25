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
    m_imuHandle = 0;
    m_quaHandle = 0;
    m_controlHandle = 0;
    m_configHandle = 0;
    m_timeHandle = 0;
    m_gpsHandle = 0;
    m_battHandle = 0;
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

    //m_context->deleteLater();
    m_context = NULL;

}

bool WIMUBLEDriver::wimuIsConnected(){
    return (m_context != NULL);
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

                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x76ac)    // Configuration
                        m_configHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;

				}
			}

            if (m_context->m_serviceList.at(i).m_uuid == 0x1805){ // Current Time Service
                // Get attributes handles
                for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x2a2b) // Current time value
                        m_timeHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;
                }
            }

            if (m_context->m_serviceList.at(i).m_uuid == 0x180f){ // Battery Service
                // Get attributes handles
                for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x2a19) // Current time value
                        m_battHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;
                }
            }

            if (m_context->m_serviceList.at(i).m_uuid == 0x1819){ // Location and Navigation Service
                // Get attributes handles
                for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                    if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x2a67) // Location and speed
                        m_gpsHandle = m_context->m_serviceList.at(i).m_attributeList.at(j).m_handle;
                }
            }

		}
        //emit newStatus(Status::bluetooth);

        wimuGetTime();          // Get Time
        wimuGetIMUConfig();     // Get Config
        wimuGetControlState();  // Get current control state
	}
}

void WIMUBLEDriver::wimuIMUStreaming(bool enable){
    if (m_quaHandle==0)
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
    if (m_imuHandle==0)
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

void WIMUBLEDriver::wimuGPSStreaming(bool enable){
    if (m_gpsHandle==0)
        return;

    for (int i=0; i<m_context->m_serviceList.count(); i++){
        if (m_context->m_serviceList.at(i).m_uuid == 0x1819){
            for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x2A67){ // Location and speed
                    for (int k=j+1; k<j+4; k++){
                        if (m_context->m_serviceList.at(i).m_attributeList.at(k).m_uuid==0x2902){
                            if (enable)
                                m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("01:00"));
                            else
                                m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("00:00"));
                            break;
                        }
                    }
                }
                /*if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x2A69){ // Position quality
                    for (int k=j+1; k<j+4; k++){
                        if (m_context->m_serviceList.at(i).m_attributeList.at(k).m_uuid==0x2902){
                            if (enable)
                                m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("01:00"));
                            else
                                m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("00:00"));
                            break;
                        }
                    }
                }*/
            }
        }
    }
}

void WIMUBLEDriver::wimuBattStreaming(bool enable){
    if (m_battHandle==0)
        return;

    for (int i=0; i<m_context->m_serviceList.count(); i++){
        if (m_context->m_serviceList.at(i).m_uuid == 0x180f){
            for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x2a19){ // Battery level
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

    // Set notification on control
    for (int i=0; i<m_context->m_serviceList.count(); i++){
        if (m_context->m_serviceList.at(i).m_uuid == 0x70ee){
            for (int j=0; j<m_context->m_serviceList.at(i).m_attributeList.count(); j++){
                if (m_context->m_serviceList.at(i).m_attributeList.at(j).m_uuid==0x76ad){
                    for (int k=j+1; k<j+4; k++){
                        if (m_context->m_serviceList.at(i).m_attributeList.at(k).m_uuid==0x2902){
                            if (start)
                                m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("01:00"));
                            else
                                m_context->attributeWrite(m_context->m_serviceList.at(i).m_attributeList.at(k).m_handle,QByteArray::fromHex("00:00"));
                            break;
                        }
                    }
                }
            }
        }
    }

    // Send control command
    // TODO: Adjust when other commands will be available
    if (start){
        m_context->attributeWrite(m_controlHandle,QByteArray::fromHex("01:00:00"));
    }else{
        m_context->attributeWrite(m_controlHandle,QByteArray::fromHex("00:00:00"));
    }



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

void WIMUBLEDriver::wimuGetIMUConfig(){
    if (m_configHandle ==0)
        return;

    if(!m_context)
        return;

    m_context->attributeRead(m_configHandle); // Answer will come soon...! (handleNewData)

}

void WIMUBLEDriver::wimuGetControlState(){
    if (m_controlHandle == 0)
        return;

    if (!m_context)
        return;

    m_context->attributeRead(m_controlHandle); // Answer will come soon!
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

        WIMU::IMUFrame_Struct data;
        data.frame_num=0;

        if (value.isEmpty()){
             qDebug() << "BLE IMU Data EMPTY";
            return;
        }

        if (handle == m_imuHandle){
            if (value.count() <20){
                qDebug() << "BLE IMU Missing data. Count = " << value.count();
               return;
            }

            //qDebug() << "BLE IMU Data";
            data.frame_num = (((qint16)(value.at(1) & 0xff)) << 8) | (value.at(0) & 0xff);

            // Sensor data
            for (int i=0; i<3; i++){
                data.acc_data[i] = (((qint16)(value.at((3+(i*2))) & 0xff)) << 8) | (value.at(2+(i*2)) & 0xff);
                data.gyro_data[i] = (((qint16)(value.at(9+(i*2)) & 0xff)) << 8)  | (value.at(8+(i*2)) & 0xff);
                data.mag_data[i] = (((qint16)(value.at(15+(i*2)) & 0xff)) << 8)  | (value.at(14+(i*2)) & 0xff);
            }
            //qDebug() << "Received: " << data.acc_data[0] << data.acc_data[1] << data.acc_data[2];
            data.acc_valid  = true;
            data.gyro_valid = true;
            data.mag_valid  = true;
            data.quat_valid = false;
        }

        if (handle == m_quaHandle){
            if (value.count() <16){
                qDebug() << "BLE QUA Missing data. Count = " << value.count();
               return;
            }

            //qDebug() << "BLE QUA Data";
            for (int i=0; i<4; i++){
                data.quaternion[i] = *reinterpret_cast<const float*>(value.mid(i*4,4).data());
            }
            data.acc_valid  = false;
            data.gyro_valid = false;
            data.mag_valid  = false;
            data.quat_valid = true;
        }
        emit imuDataReceived(data);
	}

    if (handle==m_timeHandle){
        QDateTime current_time = unpackDateTime(value);
        emit timeReceived(current_time);
    }

    if (handle==m_configHandle){
        WIMU::IMUConfig_Struct config = unpackIMUConfig(value);
        emit imuConfigReceived(config);
    }

    if (handle==m_controlHandle){
        BLERemControl_Struct control = unpackRemoteControl(value);
        emit remControlReceived(control);
    }

    if (handle==m_battHandle){
        quint8 batt_pc = (quint8)value.at(0);
        emit battLevelReceived(batt_pc);
    }

    if (handle==m_gpsHandle){
        WIMU::GPSNavData_Struct gps = unpackLocationSpeed(value);
        emit gpsDataReceived(gps);
    }

}

WIMU::IMUConfig_Struct WIMUBLEDriver::unpackIMUConfig(QByteArray &data){
    QDataStream ds(data);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    WIMU::IMUConfig_Struct config;

    ds >> config.enabled_modules;
    ds >> config.sampling_rate;
    ds >> config.acc_range;
    ds >> config.gyro_range;
    ds >> config.mag_range;

    return config;
}

WIMU::GPSNavData_Struct WIMUBLEDriver::unpackLocationSpeed(QByteArray &data){
    QDataStream ds(data);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    WIMU::GPSNavData_Struct gps;
    quint16 buf16;
    quint8  buf8;
    quint32 buf32;

    ds >> buf16; // Unused flags

    ds >> buf16; // Speed
    gps.speed = (float)buf16/100.f;

    ds << buf16; // Total distance, 16/24
    ds << buf8;  // Total distance, 24/24

    ds << buf32; // Latitude
    gps.latitude = (float)((qint32)buf32) / 10000000;

    ds << buf32; // Longitude
    gps.longitude = (float)((qint32)buf32) / 10000000;

    ds << buf16; // Elevation, 16/24
    ds << buf8;  // Elevation, 24/24

    gps.altitude = (float)((qint32)((((quint32)buf16) << 16) + (quint8)buf8))/100.f;

    ds << buf16; // Heading
    gps.orientation = (float)((qint16)buf16);

    gps.hdop = 0;
    gps.horizontal_precision = 0;
    gps.vertical_precision = 0;

    return gps;
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

WIMUBLEDriver::BLERemControl_Struct WIMUBLEDriver::unpackRemoteControl(QByteArray& data){
    QDataStream ds(data);
    ds.setByteOrder(QDataStream::LittleEndian);
    ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

    BLERemControl_Struct control;

    ds >> control.status;
    ds >> control.rec_id;

    // For an unknown reason (yet!), bytes aren't in the correct order - reorder.
    control.rec_id = ((control.rec_id & 0x00FF) << 8) + ((control.rec_id & 0xFF00) >> 8);

    return control;
}
