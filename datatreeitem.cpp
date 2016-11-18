#include "datatreeitem.h"

DataTreeItem::DataTreeItem(QString name, DataType data_type, DataStatus data_status, QString path)

{
    m_type = data_type;
    m_status = data_status;
    m_path = path;
    setText(0,name);

    setDataIcon();
}

void DataTreeItem::setDataIcon(){
    // Set correct icon
    QString prefix = ":/icons/images/";
    QString base = "";
    QString suffix = "";
    switch(m_type){
    case DATA_UNKNOWN:
        base = "folder";
        m_status = STATUS_INCOMPLETE; // Always incomplete when unknown!
        break;
    case DATA_EXPERIMENT:
        base = "experiment";
        break;
    case DATA_PATIENT:
        base = "patient";
        break;
    case DATA_DATA:
        base = "date";
        break;
    }

    switch(m_status){
    case STATUS_COMPLETE:
        suffix = "_green.png";
        break;
    case STATUS_INCOMPLETE:
        suffix = "_red.png";
        break;
    case STATUS_INPROGRESS:
        suffix = "_yellow.png";
        break;
    }

    setIcon(0,QIcon(prefix + base + suffix));

}

void DataTreeItem::setDataType(DataType data_type){
    m_type = data_type;
    setDataIcon();
}

void DataTreeItem::setStatus(DataStatus status){
    m_status = status;
    setDataIcon();
}

DataTreeItem::DataType DataTreeItem::getDataType(){
    return m_type;
}

DataTreeItem::DataStatus DataTreeItem::getStatus(){
    return m_status;
}

QString DataTreeItem::getPath(){
    return m_path;
}
