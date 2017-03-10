#ifndef WIMUFILE_H
#define WIMUFILE_H

#include <QObject>
#include <QFile>
#include <QBuffer>
#include "wimu.h"
#include "wimuconfig.h"
#include "wimusettings.h"

class WIMUFile : public QObject
{
    Q_OBJECT



public:
    explicit WIMUFile(QString filename, WIMU::Modules_ID file_type, WIMUSettings settings, WIMUConfig config, QObject *parent = 0);
    ~WIMUFile();

    bool            load(bool ignore_timefile=false);
    bool            load(quint32 start_filetime, quint32 ts, qint32 len);
    void            close();
    //QFile*          getFilePtr();

    quint32         getStartTime();
    quint32         getEndTime();
    QList<quint32>  getTimeVector();

    QByteArray      readSample();
    quint32         getSampleTime(QByteArray* data);
    QByteArray      getSampleData(QByteArray* data);
    quint32         getCurrentSampleTime();

    qint64          getCurrentPos();
    QString         getFileName();

    static WIMU::Modules_ID getModuleFromPrefix(QString prefix);

private:

    quint16     getSampleSize();

    void        fillSamplesList(QByteArray &data, quint64 offset=0);

    QString             m_filename;
    WIMU::Modules_ID    m_filetype;
    WIMUConfig          m_config;
    WIMUSettings        m_settings;

    //QFile               m_file;

    quint32             m_lastGPSTime;

    QBuffer             m_fileBuffer;
    QList<QByteArray>   m_samples;
    QList<qint64>       m_samplesPos;
    QList<quint32>      m_times;

    qint32              m_currentIndex;
    QByteArray          m_currentSample;

signals:

public slots:
};

#endif // WIMUFILE_H
