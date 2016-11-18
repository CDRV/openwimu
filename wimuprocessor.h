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

private:
    void sortFolderList(QStringList &folders);

    void correctTimestamp(QString path);
    void combineDataSet(QString path, QStringList &folders);

    bool isTimestampValid(const quint64 &ts);
    quint32 adjustTimeForTimeZone(const quint32 &ts);
    QDateTime previousMidnight(const QDateTime& time);
    quint32 previousMidnight(const quint32& time);

    bool writeTimeFile(QString path, QString sensor, quint8 day, const QList<quint32> &times, const quint32 &mod_ts, bool overwrite=false);
    bool readTimeFile(QString path, QString sensor, quint8 day, QList<quint32> &times);
    bool writeDataFile(QString path, QString sensor, quint8 day, QFile* src, const qint64 start_pos, const qint64 end_pos, const quint32 &mod_ts);

    void setFileModificationTime(const QString& filename, quint32 ts);

    QStringList getSensorList(const QString& path);

    WIMUConfig*      m_config;
    WIMUSettings*    m_settings;

signals:
    void requestLogging(QString text, WIMU::LogTypes log_type);

public slots:
};

#endif // WIMUPROCESSOR_H
