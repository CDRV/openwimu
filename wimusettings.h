#ifndef WIMUSETTINGS_H
#define WIMUSETTINGS_H

#include <QObject>

class WIMUSettings : public QObject
{
    Q_OBJECT
public:
    explicit WIMUSettings(QObject *parent = 0);

    uint16_t id;			// Serial Number
    uint8_t hw_id; 			// Hardware revision ID
    uint8_t version_major;  // Version Number
    uint8_t version_minor;
    uint8_t version_rev;
    int16_t acc_gain[3];	// Accelerometers gain
    int16_t acc_offset[3];  // Accelerometers offset
    int16_t gyro_gain[3];   // Gyroscope gain
    int16_t gyro_offset[3]; // Gyroscope offset
    int16_t mag_gain[3];	// Magnetometers gain
    int16_t mag_offset[3];  // Magnetometers offset
    int crc;

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
