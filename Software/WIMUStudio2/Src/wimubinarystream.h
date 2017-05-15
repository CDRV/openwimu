#ifndef WIMUBINARYSTREAM_H
#define WIMUBINARYSTREAM_H

#include <QObject>
#include <QVector3D>
#include "wimu.h"
#include "wimulog.h"
#include "wimuconfig.h"

#define SYNC_BYTE 0xEA

class WIMUBinaryStream : public QObject
{
    Q_OBJECT
public:
    explicit WIMUBinaryStream(QObject *parent = 0);
    WIMUBinaryStream(const WIMUBinaryStream &copy, QObject *parent=0);

    WIMU::Modules_ID getModuleID();

    quint16 fromBinaryStream(QByteArray& stream);
    quint16 fromBinaryFile(QByteArray& stream, WIMU::Modules_ID module);

    // IMU
    WIMU::IMUFrame_Struct convertToIMUFrame();
    QList<WIMU::IMUFrame_Struct> convertToIMUFrames(WIMUConfig *config);

    // GPS
    quint8 getGPSMessageID();
    WIMU::GPSNavData_Struct convertToGPSNavData();
    WIMU::GPSTrackerData_Struct convertToGPSTrackerData();

    // POWER
    WIMU::PowerFrame_Struct convertToPowerFrame(WIMUConfig* config = NULL);

    // OTHER SENSORS
    QList<QVector3D> convertToAccSensorData(WIMUConfig* config);
    QList<QVector3D> convertToGyroSensorData(WIMUConfig* config);
    QList<QVector3D> convertToMagnetoSensorData(WIMUConfig* config);

    // LOG
    WIMULog convertToWIMULog(quint8 hw_id);

    WIMUBinaryStream  &operator = (const WIMUBinaryStream&);
signals:

public slots:

private:
    QByteArray getGPSMessagePayload();

    QByteArray          m_data;
    WIMU::Modules_ID    m_idModule;
    bool                m_fromFile;
};

#endif // WIMUBINARYSTREAM_H
