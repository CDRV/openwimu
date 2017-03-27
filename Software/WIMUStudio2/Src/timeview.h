#ifndef TIMEVIEW_H
#define TIMEVIEW_H

#include <QGraphicsView>
#include <QMouseEvent>

class TimeView : public QGraphicsView
{
    Q_OBJECT
public:
    explicit TimeView(QWidget *parent=0);

protected:
    void mouseReleaseEvent (QMouseEvent* event);
signals:
    void timeClicked(int x);
};

#endif // TIMEVIEW_H
