#ifndef SENSORDISPLAY_H
#define SENSORDISPLAY_H

#include <QWidget>
#include <QtWebEngineWidgets>

#include "datagraph.h"
#include "wimuconfig.h"
#include "sensorbuffer.h"
#include "wimu.h"

namespace Ui {
class SensorDisplay;
}

class SensorDisplay : public QWidget
{
    Q_OBJECT

public:
    explicit SensorDisplay(WIMUConfig *config, QWidget *parent = 0);
    ~SensorDisplay();

    void addIMUFrame(WIMU::IMUFrame_Struct &frame);
    void addGPSNavData(WIMU::GPSNavData_Struct &nav);
    void addGPSTrackerData(WIMU::GPSTrackerData_Struct &track);

private:
    void initWIMU3d();


    Ui::SensorDisplay *ui;

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

private slots:
    void manageCheckBoxClicked();
};


#endif // SENSORDISPLAY_H
