#include "sensorcurve.h"

SensorCurve::SensorCurve()
{

}

/////////////////////////////////////////////////////////////////
void SensorCurve::drawLines(QPainter *p, const QwtScaleMap &xMap, const QwtScaleMap &yMap, const QRectF &canvasRect, int from, int to) const{
    QList<int> start_indexes;
    QList<int> end_indexes;

    for (int i=from; i<to; i++){
        if (!qIsNaN(data()->sample(i).y()) && start_indexes.isEmpty()){
            start_indexes.append(i);
            continue;
        }
        if (qIsNaN(data()->sample(i).y())&& i>0 && !qIsNaN(data()->sample(i-1).y())){
            end_indexes.append(i-1);
        }
        if (!qIsNaN(data()->sample(i).y()) && i>0 && qIsNaN(data()->sample(i-1).y())){
            start_indexes.append(i);
        }
    }

    if (start_indexes.length()-1 == end_indexes.length()){
        end_indexes.append((int)data()->size()-1);
    }

    for (int i=0; i<start_indexes.length(); i++){
        QwtPlotCurve::drawLines(p,xMap,yMap,canvasRect,start_indexes.at(i),end_indexes.at(i));
    }
}

void SensorCurve::drawSymbols(QPainter *p, const QwtSymbol& symbol, const QwtScaleMap &xMap, const QwtScaleMap &yMap, const QRectF &canvasRect, int from, int to) const{
    QList<int> start_indexes;
    QList<int> end_indexes;

    for (int i=from; i<to; i++){
        if (!qIsNaN(data()->sample(i).y()) && start_indexes.isEmpty()){
            start_indexes.append(i);
            continue;
        }
        if (qIsNaN(data()->sample(i).y())&& i>0 && !qIsNaN(data()->sample(i-1).y())){
            end_indexes.append(i-1);
        }
        if (!qIsNaN(data()->sample(i).y()) && i>0 && qIsNaN(data()->sample(i-1).y())){
            start_indexes.append(i);
        }
    }

    if (start_indexes.length()-1 == end_indexes.length()){
        end_indexes.append((int)data()->size()-1);
    }

    for (int i=0; i<start_indexes.length(); i++){
        QwtPlotCurve::drawSymbols(p,symbol,xMap,yMap,canvasRect,start_indexes.at(i),end_indexes.at(i));
    }
}
