#ifndef EVENTSBROWSER_H
#define EVENTSBROWSER_H

#include <QWidget>
#include <QTableWidgetItem>
#include "wimu.h"
#include "wimulog.h"

namespace Ui {
class EventsBrowser;
}

class EventsBrowser : public QWidget
{
    Q_OBJECT

public:
    explicit EventsBrowser(QWidget *parent = 0);
    ~EventsBrowser();

    void clearWIMULogs();
    void addWIMULog(WIMULog log);


private:
    Ui::EventsBrowser *ui;

    QList<WIMULog> m_logs;

private slots:
    void eventClicked(QTableWidgetItem* event);

signals:
    void selectTimeRequest(quint32 stime);
};

#endif // EVENTSBROWSER_H
