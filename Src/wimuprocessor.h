#ifndef WIMUPROCESSOR_H
#define WIMUPROCESSOR_H

#include <QObject>
#include <QFile>

#include "wimu.h"
#include "wimuconfig.h"
#include "wimusettings.h"

class WimuProcessor : public QObject
{
    Q_OBJECT
public:
    explicit WimuProcessor(QObject *parent = 0);
    ~WimuProcessor();

    bool preProcess(QString path);

    static void sortFolderList(QStringList &folders);
    static QStringList getSensorList(const QString& path);
private:
    bool m_cancel;

    void correctTimestamp(QString path);
    void combineDataSet(QString path, QStringList &folders);

    bool isTimestampValid(const quint64 &ts);
    quint32 adjustTimeForTimeZone(quint32 ts, bool ignore_wimu_offset);
    //quint32 adjustTimeFromTimeZone(const quint32 &ts);
    QDateTime previousMidnight(const QDateTime& time);
    quint32 previousMidnight(const quint32& time);

    void correctBadTimestamps(QList<quint32> &timestamps, QList<quint32> &bad_indexes);

    bool writeTimeFile(QString path, QString sensor, qint16 day, const QList<quint32> &times, const quint32 &mod_ts, bool overwrite=false);
    bool readTimeFile(QString path, QString sensor, qint16 day, QList<quint32> &times);
    bool writeDataFile(QString path, QString sensor, qint16 day, QString src_filename, const qint64 start_pos, const qint64 end_pos, const quint32 &mod_ts);
    bool writeGPSHeaderFile(QString path, qint16 day, const quint32 &mod_ts);
    bool writeGPSCSVFile(QString path, qint16 day, QList<WIMU::GPSNavData_Struct> &gps_data, const quint32 &mod_ts);
    bool copyFile(QString src, QString dst, const quint32 &mod_ts);
    void setFileModificationTime(const QString& filename, quint32 ts);

    quint32 getFilesNumInFolder(QString path, QString filter);

    WIMUConfig*      m_config;
    WIMUSettings*    m_settings;

signals:
    void requestLogging(QString text, WIMU::LogTypes log_type);
    void requestProgressUpdate(int val, QString label);
    void requestProgressInit(QString label, int min, int max);

public slots:
    void cancelRequested();
};

#endif // WIMUPROCESSOR_H
