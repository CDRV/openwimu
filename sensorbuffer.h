#ifndef SENSORBUFFER_H
#define SENSORBUFFER_H

#include <qwt_series_data.h>
#include <qvector.h>

class SensorBuffer:  public QObject, public QwtSeriesData <QPointF>
{

Q_OBJECT

public:
    enum BufferType{
        BUFFER_ROLLING,
        BUFFER_FIFO
    };

    // frequency of sensor, second bound is the length of bufferization in seconds
    SensorBuffer( int frequency, int _secondBound, BufferType buf_type = BUFFER_ROLLING);
    ~SensorBuffer();

    void addSample(QList<QVariant> data);
    void addSample(float data);

    size_t size()const;

    // Virtual
    // those two functions are called for ploting
    virtual QPointF sample( size_t i ) const;
    virtual QRectF boundingRect() const;

    // return a point with x min and y max value of the whole buffer
    QPointF getMinMax();

    float min();
    float max();

    void updateFrequency(int freq);

private:
    // this index indicated where to fill the data in the buffer when received from the sensor
    int startFillIndex;

    int frequency;
    int secondBound;

    BufferType  m_bufferType;

    float m_minValue;
    float m_maxValue;

    // the data stored
    QVector<float> values;

public slots:
    void empty();

    // update the number of second wed need to bufferize
    void updateSecondBound(double _secondBound);
};

#endif // SENSORBUFFER_H
