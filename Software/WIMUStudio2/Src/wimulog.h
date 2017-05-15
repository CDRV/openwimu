#ifndef WIMULOG_H
#define WIMULOG_H

#include <QObject>

class WIMULog : public QObject
{
    Q_OBJECT
public:
    // WIMU Log
    typedef enum{
        WIMULOG_UNKNOWN,
        WIMULOG_START,
        WIMULOG_TIMESYNC,
        WIMULOG_CHARGEON,
        WIMULOG_CHARGEOFF,
        WIMULOG_LOGRESET,
        WIMULOG_LOGCHANGE,
        WIMULOG_LOGERROR,
        WIMULOG_ON,
        WIMULOG_OFF,
        WIMULOG_LOWBAT,
        WIMULOG_RECOVERED,
        WIMULOG_USBMASS,
        WIMULOG_USBVCOM,
        WIMULOG_MARK,
        WIMULOG_CORRECTON,
        WIMULOG_CORRECTOFF,
        WIMULOG_DATAEND
    } WIMULogTypes;

    quint32         timestamp;
    WIMULogTypes    log_type;
    QString         log;

    explicit WIMULog(QObject *parent = 0);
    WIMULog(const WIMULog& copy, QObject *parent=0);

    WIMULog  &operator = (const WIMULog&);
    bool operator <(WIMULog const& b) const;

signals:

public slots:
};

#endif // WIMULOG_H
