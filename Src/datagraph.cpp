#include "datagraph.h"

#include "qwt_plot_grid.h"
#include "qwt_plot_marker.h"
#include "qwt_plot_canvas.h"
#include "qwt_legend.h"
#include "qwt_scale_widget.h"
#include "qwt_symbol.h"

#include <QMetaEnum>


DataGraph::DataGraph(quint8 axisNum, quint16 samplingRate, QStringList axis_titles, bool continuous)
{
    m_axisNum = axisNum;
    m_samplingRate = samplingRate;

    setStyleSheet("QWidget{background-color:rgb(0,0,0);color:white;}");

    // Initialize components
    QFont f = QFont("Arial",8);
    QwtText t = QwtText("secondes");
    t.setFont(f);
    setAxisTitle(QwtPlot::xBottom,t);
    setAxisScale( QwtPlot::xBottom, 0, 10);
    setAxisScale( QwtPlot::yLeft, 1, -1);

   // set up the grid
    QwtPlotGrid *grid = new QwtPlotGrid();
    grid->setPen( Qt::gray, 0.0, Qt::DotLine );
    grid->enableX( true );
    grid->enableXMin( true );
    grid->enableY( true );
    grid->enableYMin( false );
    grid->attach( this );

    // set up the origin axes
    QwtPlotMarker * d_origin = new QwtPlotMarker();
    d_origin->setLineStyle( QwtPlotMarker::Cross );
    d_origin->setValue( 0.0, 0.0 );
    d_origin->setLinePen( Qt::gray, 0.0, Qt::DashLine );
    d_origin->attach( this );

    // the curve need a canvas to be drawn over it
    QwtPlotCanvas * canvas = new QwtPlotCanvas(this);
    canvas->setCursor(Qt::ArrowCursor);
    canvas->setPalette(QPalette(QColor(0,0,0)));
    setCanvas(canvas);


    // this is for changing graphic aspect of axis scaling
    QwtScaleWidget *qwtsw = axisWidget(QwtPlot::xBottom);

    QPalette palette = qwtsw->palette();
    palette.setColor( QPalette::WindowText, Qt::gray);	// for ticks
    palette.setColor( QPalette::Text, Qt::gray);	                // for ticks' labels
    qwtsw->setPalette( palette );
    qwtsw->setFont(f);

    // we remove y aspect
    //m_plot->axisScaleDraw(QwtPlot::yLeft)->enableComponent(QwtScaleDraw::Labels,false);

    QwtLegend* legend = new QwtLegend(this);
    insertLegend(legend);

    this->canvas()->setCursor(QCursor(Qt::SplitHCursor));

    setSizePolicy(QSizePolicy::MinimumExpanding,QSizePolicy::Maximum);

    // Create curves
    for (int i=0; i<m_axisNum; i++){
        QColor c = QColor(Qt::GlobalColor(i+7));
        addCurve(axis_titles.at(i),c,true,continuous);

    }

    // Enable options
    //setAxisAutoScale(QwtPlot::yLeft);
}

void DataGraph::addCurve(QString title, QColor color, bool show_legend, bool continuous){
    SensorCurve* d_curve = new SensorCurve();
    d_curve->setTitle(title);

    if (!continuous)
        d_curve->setPen(color,2,Qt::NoPen);
    else
        d_curve->setPen(color,2,Qt::SolidLine);

    QwtSymbol* symbol = new QwtSymbol(QwtSymbol::Rect);
    symbol->setPen(color,2);
    d_curve->setSymbol(symbol);

    d_curve->setStyle( QwtPlotCurve::Lines );
    //d_curve->setRenderHint( QwtPlotItem::RenderAntialiased, true );

    d_curve->setPaintAttribute( QwtPlotCurve::ClipPolygons, false );
    d_curve->setBaseline(0);
    d_curve->setItemAttribute(QwtPlotItem::Legend,show_legend);
    //d_curve->setSamples(data);

    d_curve->attach(this);

    m_curves.append(d_curve);

}

void DataGraph::setData(int curve_id, SensorBuffer *data){
    if (curve_id < 0 || curve_id > m_curves.count()-1){
        return; // Invalid curve id
    }

    m_datas.insert(curve_id,data);
    m_curves.at(curve_id)->setData(m_datas.at(curve_id));
}

