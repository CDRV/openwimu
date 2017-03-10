#include "timebrowser.h"
#include "ui_timebrowser.h"

#include <QDebug>
#include <QGraphicsTextItem>

TimeBrowser::TimeBrowser(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::TimeBrowser)
{
    ui->setupUi(this);

    m_scene.setSceneRect(0,0,ui->timeView->width(),ui->timeView->height());
    ui->timeView->setScene(&m_scene);

    m_timeBar = NULL;

    connect(ui->sldTime,SIGNAL(valueChanged(int)), this, SLOT(timeSliderValueChanged(int)));
    connect(ui->timeView, SIGNAL(timeClicked(int)), this, SLOT(timeViewClicked(int)));

    connect(ui->btnPlay,SIGNAL(clicked(bool)),this,SLOT(btnPlayClicked()));
    connect(&m_playTimer, SIGNAL(timeout()), this, SLOT(playTimerTimeout()));

    m_refreshing = false;

    m_currentTime = 0;
    m_playTimer.setInterval(1000);
    m_playTimer.setSingleShot(false);
}

TimeBrowser::~TimeBrowser()
{
    delete ui;
}

void TimeBrowser::clearWIMULogs(){
    m_logs.clear();
}

void TimeBrowser::addWIMULog(WIMULog log){
    int index = m_logs.count();

    // Insert logs into internal structure
    m_logs.insert(index,log);
}

void TimeBrowser::setBasePaths(QList<QString> &base_paths){
    m_basePaths.clear();
    m_dataStarts.clear();
    m_dataEnds.clear();

    m_basePaths = base_paths;

    QList<QString> processed_paths;

    // Load file limits from base_paths
    foreach(QString path, m_basePaths){
        if (!processed_paths.contains(path)){
            processed_paths.append(path);
            QFile time_file(path + "/TIMES.DAT");

            if (time_file.open(QIODevice::ReadOnly)){
                // Load start and end times from files
                QByteArray data;
                while (!time_file.atEnd()){
                    data = time_file.readLine();
                    QStringList datas = QString(data).replace("\n","").split(",");
                    if (datas.count()==3){
                        // data[0] = day number = unused here
                        m_dataStarts.append(datas.at(1).toUInt());
                        m_dataEnds.append(datas.at(2).toUInt());
                    }
                }

                time_file.close();
            }
        }
    }
}

void TimeBrowser::updateDisplay(){
    m_refreshing = true;
    quint32 initial_ts=0;
    quint32 last_ts=1;
    m_scene.clear();

    // Set limits
    if (m_logs.count()>0){
       initial_ts = m_logs.first().timestamp;
       last_ts = m_logs.last().timestamp;
    }
    ui->sldTime->setMinimum(initial_ts);
    ui->sldTime->setMaximum(last_ts);
    ui->sldTime->setValue(initial_ts);

    // Browse logs for visual display
    //qDebug() << "View W=" << ui->timeView->width() << ", H=" << ui->timeView->height();
    QColor fill_color = Qt::black;
    int duration = 0;
    int pos = 0;

    for (int i=0; i<m_logs.count(); i++){
      switch (m_logs.at(i).log_type){
      case WIMULog::WIMULOG_START:
      case WIMULog::WIMULOG_TIMESYNC:
      case WIMULog::WIMULOG_LOGRESET:
      case WIMULog::WIMULOG_RECOVERED:
      case WIMULog::WIMULOG_LOGCHANGE:
      case WIMULog::WIMULOG_ON:
      case WIMULog::WIMULOG_CHARGEOFF:
      case WIMULog::WIMULOG_CORRECTON:
      case WIMULog::WIMULOG_CORRECTOFF:
      case WIMULog::WIMULOG_MARK:
          fill_color = ui->lblOK->palette().color(QPalette::Window);
          break;
      case WIMULog::WIMULOG_CHARGEON:
          fill_color = ui->lblCharge->palette().color(QPalette::Window);
          break;
      case WIMULog::WIMULOG_LOWBAT:
          fill_color = ui->lblLowBat->palette().color(QPalette::Window);
          break;
      case WIMULog::WIMULOG_OFF:
          fill_color = ui->lblOff->palette().color(QPalette::Window);
          break;
      case WIMULog::WIMULOG_LOGERROR:
          fill_color = ui->lblOK->palette().color(QPalette::Window);
          break;
      default:
          qDebug() << "UNKNOWN LOG: " << m_logs.at(i).log << " - " << m_logs.at(i).timestamp;
          fill_color = ui->lblNotOK->palette().color(QPalette::Window);
          break;
      }

      if (i+1 < m_logs.count()){
          duration = m_logs.at(i+1).timestamp - m_logs.at(i).timestamp;
      }else{
          duration = last_ts - m_logs.at(i).timestamp;
      }

      duration = ((float)duration / ((float)last_ts - initial_ts)) * ui->timeView->width();

      pos = (((float)m_logs.at(i).timestamp-initial_ts) / ((float)last_ts - initial_ts)) * ui->timeView->width();
      m_scene.addRect(pos,0,duration,ui->timeView->height(),QPen(fill_color),QBrush(fill_color));

    }

    for (int i=0; i<m_logs.count(); i++){
        // Overlay data, where needed
        switch (m_logs.at(i).log_type){
           case WIMULog::WIMULOG_CORRECTON:
                fill_color = ui->lblCorrected->palette().color(QPalette::Window);
                // Find end time
                for (int j=i+1; j<m_logs.count(); j++){
                    if (m_logs.at(j).log_type == WIMULog::WIMULOG_CORRECTOFF){
                        duration = m_logs.at(j).timestamp - m_logs.at(i).timestamp;
                        duration = ((float)duration / ((float)last_ts - initial_ts)) * ui->timeView->width();
                        pos = (((float)m_logs.at(i).timestamp-initial_ts) / ((float)last_ts - initial_ts)) * ui->timeView->width();
                        m_scene.addRect(pos,0,duration,15,QPen(fill_color),QBrush(fill_color));
                        m_scene.addRect(pos,ui->timeView->height()-5,duration,ui->timeView->height(),QPen(fill_color),QBrush(fill_color));
                        break;
                    }
                }
                break;
            default: break;

        }
    }

    // Check for missing data
    for (int i=0; i<m_dataEnds.count(); i++){
        WIMULog* prevLog = findClosestPreviousLog(m_dataEnds.at(i));
        if (prevLog){
            // Check what was the last type of log - some types are "OK" (charging, off, ...) and not a sign of missing data
            if (prevLog->log_type != WIMULog::WIMULOG_CHARGEON  &&
                prevLog->log_type != WIMULog::WIMULOG_LOWBAT    &&
                prevLog->log_type != WIMULog::WIMULOG_OFF       &&
                prevLog->log_type != WIMULog::WIMULOG_USBMASS   &&
                prevLog->log_type != WIMULog::WIMULOG_USBVCOM)
            {
                // We have some missing data...
                fill_color = ui->lblNotOK->palette().color(QPalette::Window);
                quint32 next_ts=0;
                quint16 count = 1;
                while (next_ts==0){

                    if (i+count < m_dataStarts.count()){
                        next_ts = m_dataStarts.at(i+count); // Use start of next day
                    }else{
                        WIMULog* nextLog = findClosestNextLog(m_dataEnds.at(i));
                        next_ts = nextLog->timestamp; // Use next log timestamp
                    }
                    count++;
                }

                duration = next_ts - m_dataEnds.at(i);
                duration = ((float)duration / ((float)last_ts - initial_ts)) * ui->timeView->width();
                pos = (((float)m_dataEnds.at(i)-initial_ts) / ((float)last_ts - initial_ts)) * ui->timeView->width();
                m_scene.addRect(pos,0,duration,ui->timeView->height(),QPen(fill_color),QBrush(fill_color));
            }
        }
    }

    for (int i=0; i<m_logs.count(); i++){
      // Add Marks on the data, where needed
      bool draw = true;
      switch (m_logs.at(i).log_type){
      case WIMULog::WIMULOG_TIMESYNC:
          fill_color = Qt::green;
          break;
      case WIMULog::WIMULOG_LOGERROR:
          fill_color = ui->lblNotOK->palette().color(QPalette::Window);
          break;
      case WIMULog::WIMULOG_MARK:
          fill_color = Qt::cyan;
          break;
      case WIMULog::WIMULOG_CORRECTON:
      case WIMULog::WIMULOG_CORRECTOFF:
          fill_color = ui->lblCorrected->palette().color(QPalette::Window);
          break;
      default:
          // Do nothing for most of the type
          draw = false;
          break;
      }

      if (draw){
        duration = (1.f / ((float)last_ts - initial_ts)) * ui->timeView->width();
        pos = (((float)m_logs.at(i).timestamp-initial_ts) / ((float)last_ts - initial_ts)) * ui->timeView->width();
        m_scene.addRect(pos,0,duration,ui->timeView->height(),QPen(fill_color),QBrush(fill_color));
        draw = false;
      }
    }

    // Display days on display
        // Date background rectangle
    m_scene.addRect(0,0,ui->timeView->width(),ui->timeView->height()/4,QPen(Qt::black),QBrush(Qt::black));

        // Date lines & values
    quint32 current_time = initial_ts - QDateTime::fromSecsSinceEpoch(initial_ts,Qt::UTC).toSecsSinceEpoch() % 86400; //(initial_ts % 86400); // Set on first day
    current_time -= QDateTime::fromSecsSinceEpoch(initial_ts,Qt::UTC).offsetFromUtc();

    while (current_time <= last_ts){
        pos = (((float)current_time-initial_ts) / ((float)last_ts - initial_ts)) * ui->timeView->width();
        if (pos <0)
            pos = 0;

        m_scene.addLine(pos,0,pos,ui->timeView->height(),QPen(Qt::white));
        QGraphicsTextItem *date_text = m_scene.addText(QDateTime::fromSecsSinceEpoch(current_time,Qt::UTC).date().toString("dd-MM-yyyy"));

        date_text->setPos(pos,-5);
        date_text->setDefaultTextColor(Qt::white);
        current_time += 86400;

    }

    // Add current time pointer
    m_timeBar = m_scene.addLine(0,0,0,ui->timeView->height(),QPen(Qt::yellow));

    if (!m_dataStarts.isEmpty()){
        m_currentTime = m_dataStarts.first();
        updateDisplayedTime();
    }
    m_refreshing = false;
}

void TimeBrowser::timeSliderValueChanged(int value){
    if (m_refreshing)
        return;
    m_refreshing = true;

    // Update date display
    //QDateTime current_date = QDateTime::fromSecsSinceEpoch(value,Qt::UTC);

    //ui->lblDateTime->setText(current_date.toString("dd-MM-yyyy hh:mm:ss"));
    updateDisplayedTime();

    // Update time bar position
    if (m_timeBar){
        int pos = ((float)(value-ui->sldTime->minimum())/(ui->sldTime->maximum()-ui->sldTime->minimum())) * ui->timeView->width();
        //qDebug() << ((float)(value-ui->sldTime->minimum())/(ui->sldTime->maximum()-ui->sldTime->minimum())) << pos << value << ui->sldTime->maximum();
        m_timeBar->setPos( pos,0);
    }

    m_currentTime = value;
    emit timeChanged((quint32)value);
    m_refreshing = false;
}

void TimeBrowser::resizeEvent(QResizeEvent *event){
    Q_UNUSED(event)
    updateDisplay();

}

void TimeBrowser::timeViewClicked(int pos){
    if (m_timeBar){
        m_timeBar->setPos(pos,0);
    }

    // Update slider value position
    ui->sldTime->disconnect(SIGNAL(valueChanged(int)));
    quint32 timestamp = ((float)pos / ui->timeView->width()) * (ui->sldTime->maximum()-ui->sldTime->minimum()) + ui->sldTime->minimum();
    selectTime(timestamp);
    connect(ui->sldTime,SIGNAL(valueChanged(int)), this, SLOT(timeSliderValueChanged(int)));

    emit timeChanged(timestamp);
}

void TimeBrowser::selectTime(quint32 timestamp){
    if (timestamp < (quint32)ui->sldTime->minimum())
        timestamp = ui->sldTime->minimum();
    if (timestamp > (quint32)ui->sldTime->maximum())
        timestamp = ui->sldTime->maximum();

    ui->sldTime->setValue(timestamp);
    m_currentTime = timestamp;
    updateDisplayedTime();
}

WIMULog* TimeBrowser::findClosestPreviousLog(quint32 ts){
    WIMULog* rval = NULL;

    // Browse logs and return closest one based on timestamp ts
    // TODO: improve algorithm
    for (int i=1; i<m_logs.count(); i++){
        if (m_logs.at(i).timestamp > ts && m_logs.at(i-1).timestamp <= ts){
            rval = &m_logs[i-1];
            break;
        }
    }
    return rval;
}

WIMULog* TimeBrowser::findClosestNextLog(quint32 ts){
    WIMULog* rval = NULL;

    // Browse logs and return closest one based on timestamp ts
    // TODO: improve algorithm
    for (int i=1; i<m_logs.count(); i++){
        if (m_logs.at(i).timestamp > ts && m_logs.at(i-1).timestamp <= ts){
            rval = &m_logs[i];
            break;
        }
    }


    return rval;
}

void TimeBrowser::btnPlayClicked(){
    static bool playing = false;

    if (playing){
        ui->btnPlay->setIcon(QIcon(":/icons/images/play.png"));
        m_playTimer.stop();
        playing = false;
    }else{
        ui->btnPlay->setIcon(QIcon(":/icons/images/stop.png"));
        m_playTimer.start();
        playing = true;
    }
}

void TimeBrowser::playTimerTimeout(){
    m_currentTime+=ui->spinSpeed->value();
    if (m_dataEnds.count()>0){
        if (m_currentTime > m_dataEnds.last()){
            btnPlayClicked(); // Stop playback
            return;
        }
    }

    selectTime(m_currentTime);
}

void TimeBrowser::updateDisplayedTime(){
    QDateTime current_time = QDateTime::fromSecsSinceEpoch(m_currentTime,Qt::UTC);

    ui->lcdDay->display(current_time.date().day());
    ui->lcdMonth->display(current_time.date().month());
    ui->lcdYear->display(current_time.date().year());
    ui->lcdHour->display(current_time.time().hour());
    ui->lcdMin->display(current_time.time().minute());
    ui->lcdSec->display(current_time.time().second());


}
