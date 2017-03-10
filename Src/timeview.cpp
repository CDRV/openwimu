#include "timeview.h"

#include <QDebug>

TimeView::TimeView(QWidget *parent) :
    QGraphicsView(parent)
{

}

void TimeView::mouseReleaseEvent (QMouseEvent* event){
    emit timeClicked(event->pos().x());
}
