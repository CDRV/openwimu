#ifndef DATATREEITEM_H
#define DATATREEITEM_H

#include <QTreeWidgetItem>

class DataTreeItem : public QTreeWidgetItem
{

public:
    typedef enum{
      DATA_UNKNOWN=1000,
      DATA_PATIENT=1001,
      DATA_EXPERIMENT=1002,
      DATA_DATA = 1003
    } DataType;

    typedef enum{
      STATUS_INCOMPLETE,
      STATUS_INPROGRESS,
      STATUS_COMPLETE
    }DataStatus;

    DataTreeItem(QString name, DataType data_type, DataStatus data_status, QString path);

    DataType getDataType();
    DataStatus getStatus();
    QString getPath();
    quint16 getId();

    void setDataType(DataType data_type);
    void setStatus(DataStatus status);
    void setId(quint16 id);

private:
    void setDataIcon();

    DataStatus  m_status;
    DataType    m_type;

    QString     m_path;

    quint16     m_id;
};

#endif // DATATREEITEM_H
