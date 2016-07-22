#ifndef WIMUSETTINGS_H
#define WIMUSETTINGS_H

#include <QObject>

class WIMUSettings : public QObject
{
    Q_OBJECT
public:
    explicit WIMUSettings(QObject *parent = 0);
    WIMUSettings(const WIMUSettings &copy, QObject *parent=0);

    quint16 id;			// Serial Number
    quint8 hw_id; 			// Hardware revision ID
    quint8 version_major;  // Version Number
    quint8 version_minor;
    quint8 version_rev;
    qint16 acc_gain[3];	// Accelerometers gain
    qint16 acc_offset[3];  // Accelerometers offset
    qint16 gyro_gain[3];   // Gyroscope gain
    qint16 gyro_offset[3]; // Gyroscope offset
    qint16 mag_gain[3];	// Magnetometers gain
    qint16 mag_offset[3];  // Magnetometers offset
    quint32 crc;

    void setDefaults();

    QString getFirmwareVersion();

    QByteArray serialize();
    void unserialize(QByteArray *data);

    static quint16 size();

    WIMUSettings  &operator = (const WIMUSettings&);
private:



signals:

public slots:
};

#endif // WIMUSETTINGS_H
