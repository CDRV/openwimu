#ifndef TIMEBROWSER_H
#define TIMEBROWSER_H

#include <QWidget>
#include <QGraphicsScene>
#include "timeview.h"
#include "wimu.h"
#include "wimulog.h"

namespace Ui {
class TimeBrowser;
}

class TimeBrowser : public QWidget
{
    Q_OBJECT

public:
    explicit TimeBrowser(QWidget *parent = 0);
    ~TimeBrowser();

    void clearWIMULogs();
    void addWIMULog(WIMULog log);
    void setBasePaths(QList<QString> &base_paths);

    void updateDisplay();

private:
    Ui::TimeBrowser *ui;

    QGraphicsScene m_scene;
    QGraphicsItem* m_timeBar;

    bool m_refreshing;

    QList<WIMULog>          m_logs;      // Compiled log of all displayed data
    QList<QString>          m_basePaths; // Base paths of data to display
    //QList<quint16>          m_ids;       // Days id of data to display

    QList<quint32>          m_dataStarts; // Start times of each data set (day)
    QList<quint32>          m_dataEnds;   // End times of each data set (day)

    void resizeEvent(QResizeEvent *event);

    WIMULog* findClosestPreviousLog(quint32 ts);
    WIMULog* findClosestNextLog(quint32 ts);

private slots:
    void timeSliderValueChanged(int value);
    void timeViewClicked(int pos);

public slots:
    void selectTime(quint32 timestamp);

signals:
    void timeChanged(quint32 timestamp);
};



#endif // TIMEBROWSER_H
