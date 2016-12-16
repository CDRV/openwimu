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

    bool            load();
    void            close();
    //QFile*          getFilePtr();

    quint64         getStartTime();
    quint64         getEndTime();
    QList<quint32>  getTimeVector();

    QByteArray      readSample();
    quint32         getSampleTime(QByteArray* data);
    QByteArray      getSampleData(QByteArray* data);

    qint64          getCurrentPos();
    QString         getFileName();

    static WIMU::Modules_ID getModuleFromPrefix(QString prefix);

private:

    quint16     getSampleSize();

    void        fillSamplesList(QByteArray &data);

    QString             m_filename;
    WIMU::Modules_ID    m_filetype;
    WIMUConfig          m_config;
    WIMUSettings        m_settings;

    //QFile               m_file;

    quint32             m_lastGPSTime;

    QBuffer             m_fileBuffer;
    QList<QByteArray>   m_samples;
    qint32              m_currentIndex;


signals:

public slots:
};

#endif // WIMUFILE_H
