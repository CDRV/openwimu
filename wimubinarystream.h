#ifndef WIMUBINARYSTREAM_H
#define WIMUBINARYSTREAM_H

#include <QObject>
#include "wimu.h"

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

    // GPS
    int getGPSMessageID();
    WIMU::GPSNavData_Struct convertToGPSNavData();
    WIMU::GPSTrackerData_Struct convertToGPSTrackerData();

    // POWER
    WIMU::PowerFrame_Struct convertToPowerFrame();

    WIMUBinaryStream  &operator = (const WIMUBinaryStream&);
signals:

public slots:

private:
    QByteArray getGPSMessagePayload();

    QByteArray          m_data;
    WIMU::Modules_ID    m_idModule;
};

#endif // WIMUBINARYSTREAM_H
