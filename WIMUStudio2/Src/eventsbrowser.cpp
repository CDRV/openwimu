#include "eventsbrowser.h"
#include "ui_eventsbrowser.h"

EventsBrowser::EventsBrowser(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::EventsBrowser)
{
    ui->setupUi(this);

    ui->tblLogs->setColumnWidth(0,110);

    connect(ui->tblLogs,SIGNAL(itemClicked(QTableWidgetItem*)),this,SLOT(eventClicked(QTableWidgetItem*)));

}

EventsBrowser::~EventsBrowser()
{
    delete ui;
}


void EventsBrowser::clearWIMULogs(){
    ui->tblLogs->clearContents();
    m_logs.clear();
}

void EventsBrowser::addWIMULog(WIMULog log){
    int index = m_logs.count();
    QTableWidgetItem *item;

    ui->tblLogs->insertRow(ui->tblLogs->rowCount());

    // Check if log must be inserted somewhere specific (i.e. not at end of list)
    /*if (m_logs.count()>0){
        if (log.timestamp<m_logs.last().timestamp){
            // Find the correct place to insert
            for (int i=m_logs.count()-1; i>=0; i--){
                if (log.timestamp>m_logs.at(i).timestamp){
                    index=i+1;
                    break;
                }
            }

            if (log.timestamp<m_logs.first().timestamp){
                index = 0;
            }

            // Move table entries down
            for (int i=m_logs.count()-1;i>=index;i--){
                item = ui->tblLogs->takeItem(i,0);
                ui->tblLogs->setItem(i+1,0,item);
                item = ui->tblLogs->takeItem(i,1);
                ui->tblLogs->setItem(i+1,1,item);
            }
        }
    }*/

    // Insert logs into internal structure
    //m_logs.append(log);
    m_logs.insert(index,log);

    // Insert logs into table for display
    QDateTime logtime(QDateTime::fromSecsSinceEpoch(log.timestamp,Qt::UTC));

    item = new QTableWidgetItem(logtime.toString("dd-MM-yyyy hh:mm:ss"));

    ui->tblLogs->setItem(/*m_logs.count()-1*/index,0,item);
    item = new QTableWidgetItem(log.log);
    item->setToolTip(log.log);
    ui->tblLogs->setItem(/*m_logs.count()-1*/index,1,item);
}

void EventsBrowser::eventClicked(QTableWidgetItem *event){
    // Find log associated with current item

    if (event->row()<m_logs.count()){
        emit selectTimeRequest(m_logs.at(event->row()).timestamp);
    }
}
