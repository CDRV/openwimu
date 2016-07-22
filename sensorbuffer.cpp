#include "sensorbuffer.h"
#include <QDebug>

SensorBuffer::SensorBuffer(int freq, int _secondBound, BufferType buf_type):
    startFillIndex(0),
    frequency(freq),
    secondBound(_secondBound)
{
    values.resize( freq*_secondBound );
    values.fill(std::numeric_limits<float>::max());
    m_minValue = std::numeric_limits<float>::max();
    m_maxValue = std::numeric_limits<float>::min();
    m_bufferType = buf_type;
}


void SensorBuffer::updateFrequency(int freq){
    if(frequency!=freq){
        frequency=freq;
        values.resize(freq*secondBound);
        values.fill(0.0);
        m_minValue = std::numeric_limits<float>::max();
        m_maxValue = std::numeric_limits<float>::min();
    }
}

QPointF SensorBuffer::getMinMax(){
   //int const * biggest = std::max_element(values.begin(),values.end());
   //const int * minest = std::min_element(values.begin(),values.end());

   float biggest = std::numeric_limits<float>::min();
   float lowest = std::numeric_limits<float>::max();
   // Manually have to browse items to remove invalid ones
   for (int i=0; i<values.count(); i++){
        if (values.at(i)!=std::numeric_limits<float>::max()){
            if (values.at(i)>biggest){
                biggest = values.at(i);
            }
            if (values.at(i)<lowest){
                lowest = values.at(i);
            }
        }
   }

   return QPointF(lowest,biggest);

}

void SensorBuffer::addSample(QList<QVariant> data){
    float old_value;

   for (int i = 0; i < data.size(); ++i) {

       m_minValue = qMin(m_minValue, data[i].toFloat());
       m_maxValue = qMax(m_maxValue, data[i].toFloat());

       if (m_bufferType==BUFFER_ROLLING){
           old_value = values[startFillIndex];
           values[startFillIndex]=data[i].toFloat();
           startFillIndex++;



           if (startFillIndex>=values.size())
           {
               startFillIndex=0;
           }
       }

       if (m_bufferType==BUFFER_FIFO){
           if (startFillIndex<values.size()){
            old_value = values[startFillIndex];
            values[startFillIndex++]=data[i].toFloat();
           }else{
               old_value = values.takeFirst();
               values.append(data[i].toFloat());
           }
       }

       if (old_value == m_minValue || old_value == m_maxValue){
           // Need to compute new min/max
           QPointF minMax = getMinMax();
           m_minValue = (float)minMax.x();
           m_maxValue = (float)minMax.y();
           old_value = qQNaN();
       }else{
           m_minValue = qMin(m_minValue, data[i].toFloat());
           m_maxValue = qMax(m_maxValue, data[i].toFloat());
       }
   }

}

void SensorBuffer::addSample(float data){
    float old_value;

    if (m_bufferType==BUFFER_ROLLING){
        old_value = values[startFillIndex];

        values[startFillIndex]=data;
        startFillIndex++;
        if (startFillIndex>=values.size())
        {
            startFillIndex=0;
        }
    }

    if (m_bufferType==BUFFER_FIFO){
        if (startFillIndex<values.size()){
            old_value = values[startFillIndex];
            values[startFillIndex++]=data;
        }else{
            old_value = values.takeFirst();
            values.append(data);
        }
    }

    if (old_value == m_minValue || old_value == m_maxValue){
        // Need to compute new min/max
        QPointF minMax = getMinMax();
        m_minValue = (float)minMax.x();
        m_maxValue = (float)minMax.y();
    }else{
        m_minValue = qMin(m_minValue, data);
        m_maxValue = qMax(m_maxValue, data);
    }


}

void SensorBuffer::empty(){

    startFillIndex = 0;

    //values.fill( 0.0 );
    values.fill(std::numeric_limits<float>::max());

    m_minValue = std::numeric_limits<float>::max();
    m_maxValue = std::numeric_limits<float>::min();
}

QPointF SensorBuffer::sample( size_t i ) const
{

    const double x = ((double)i*secondBound)/(double)values.size();

    int indexToReturn = 0;


    if (i>(quint32)values.size()){
       indexToReturn=(int)i-values.size();
    }else{
       indexToReturn = (int)i;
    }

    double y = values.data()[indexToReturn];

    if (y==std::numeric_limits<float>::max()){
        y = qQNaN();
    }

    return QPointF( x, y);
}

QRectF SensorBuffer::boundingRect() const
{
    float const* biggest = std::max_element(values.begin(),values.end());
    QPoint topLeft = QPoint(0,*biggest);

    const float * minest = std::min_element(values.begin(),values.end());
    QPoint bottomRight = QPoint(values.size(),*minest);

    return QRectF(topLeft,bottomRight);
}


void SensorBuffer::updateSecondBound(double _secondBound){

    secondBound = _secondBound;
    values.resize( secondBound * frequency );

     if(startFillIndex>=values.size())
         startFillIndex=0;

}

size_t SensorBuffer::size() const
{
    return values.size();
}


float SensorBuffer::min(){
    return m_minValue;
}

float SensorBuffer::max(){
    return m_maxValue;
}

SensorBuffer::~SensorBuffer()
{

}

