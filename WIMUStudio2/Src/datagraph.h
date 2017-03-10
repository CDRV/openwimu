#ifndef DATAGRAPH_H
#define DATAGRAPH_H

#include "qwt_plot.h"
#include "qwt_plot_curve.h"

#include "sensorbuffer.h"
#include "sensorcurve.h"

class DataGraph : public QwtPlot
{
public:
    DataGraph(quint8 axisNum, quint16 samplingRate, QStringList axis_titles=QStringList(), bool continuous=true);
    void setData(int curve_id, SensorBuffer* data);
private:
    void addCurve(QString title, QColor color, bool show_legend, bool continuous);


    quint8      m_axisNum;
    quint16     m_samplingRate;

    QList<SensorCurve*>     m_curves;
    QList<SensorBuffer*>    m_datas;
};

#endif // DATAGRAPH_H
