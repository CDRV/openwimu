#ifndef SENSORCURVE_H
#define SENSORCURVE_H

#include "qwt_plot_curve.h"


class SensorCurve : public QwtPlotCurve
{
public:
    SensorCurve();

    void drawLines(QPainter *p, const QwtScaleMap &xMap, const QwtScaleMap &yMap, const QRectF &canvasRect, int from, int to) const;
    void drawSymbols(QPainter *p, const QwtSymbol& symbol, const QwtScaleMap &xMap, const QwtScaleMap &yMap, const QRectF &canvasRect, int from, int to) const;
};

#endif // SENSORCURVE_H
