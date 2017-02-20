#ifndef SENSORDISPLAY_H
#define SENSORDISPLAY_H

#include <QWidget>
#include <QtWebEngineWidgets>

#include "datagraph.h"
#include "wimuconfig.h"
#include "wimusettings.h"
#include "sensorbuffer.h"
#include "wimu.h"
#include "timebrowser.h"
#include "eventsbrowser.h"

namespace Ui {
class SensorDisplay;
}

class SensorDisplay : public QWidget
{
    Q_OBJECT

public:
    explicit SensorDisplay(WIMUConfig *config, WIMUSettings *settings, QWidget *parent = 0);
    ~SensorDisplay();

    void addIMUFrame(WIMU::IMUFrame_Struct &frame);
    void addGPSNavData(WIMU::GPSNavData_Struct &nav);
    void addGPSTrackerData(WIMU::GPSTrackerData_Struct &track);
    void addPowerFrame(WIMU::PowerFrame_Struct &power);

    void showBrowser(bool show);
    void setDataFiles(QList<QString> &paths, QList<quint16> &ids);

private:
    Ui::SensorDisplay *ui;

    TimeBrowser*            m_timeBrowser;
    EventsBrowser*          m_eventBrowser;
    QList<QString>          m_dataPaths;
    QList<quint16>          m_dataIds;

    DataGraph*              m_graphAcc;
    QList<SensorBuffer*>    m_dataAcc;

    DataGraph*              m_graphGyro;
    QList<SensorBuffer*>    m_dataGyro;

    DataGraph*              m_graphMag;
    QList<SensorBuffer*>    m_dataMag;

    DataGraph*              m_graphIMU;
    QList<SensorBuffer*>    m_dataIMU;

    QWebEngineView*         m_webMap;

    WIMUConfig*             m_config;
    WIMUSettings*           m_settings;

private slots:
    void manageCheckBoxClicked();

    void displayTimeWasChanged(quint32 new_time);

signals:
    void requestLogging(QString text, WIMU::LogTypes log_type);
};


#endif // SENSORDISPLAY_H
