#ifndef WIMUCONFIGDIALOG_H
#define WIMUCONFIGDIALOG_H

#include <QDialog>
#include <QListWidgetItem>
#include <QCheckBox>
#include <QtSerialPort/QSerialPort>
#include <QTimer>
#include <QDateTime>

#include "wimuconfig.h"
#include "wimusettings.h"


namespace Ui {
class WIMUConfigDialog;
}

class WIMUConfigDialog : public QDialog
{
    Q_OBJECT

public:
    explicit WIMUConfigDialog(QWidget *parent = 0);
    ~WIMUConfigDialog();

private:
    Ui::WIMUConfigDialog    *ui;
    QSerialPort*             m_serialPort;

    QIcon       getIconForComponent(int index, bool enabled);
    QCheckBox*  getActiveChkBox(int index);

    QString     m_lastSerialCmd;
    QByteArray  m_serialBuffer;

    QTimer      m_clock;
    QDateTime   m_wimuDateTime;

    void initUIState();
    void connectCheckBoxSignals();
    void connectButtonsSignals();
    void connectSerialPortSignals();
    void connectGeneralUISignals();

    void loadFromConfig(WIMUConfig* config);
    void saveToConfig(WIMUConfig* config);
    void loadFromSettings(WIMUSettings* settings);
    void saveToSettings(WIMUSettings* settings);

    void addToConsole(QString text, bool sent);

    void wimuSendCommand(QString cmd);
    void wimuSendData(QByteArray data);


private slots:
    void configSectionChanged(int newIndex);
    void configGeneralClicked(QListWidgetItem* item);
    void configToolsClicked(QListWidgetItem* item);
    void configComponentClicked(QListWidgetItem* item);
    void configComponentItemChanged(QListWidgetItem* item);

    void manageCheckBoxClicked();

    void buttonDefaultClicked();
    void buttonSaveConfigClicked();
    void buttonLoadConfigClicked();
    void buttonConnectClicked();
    void buttonConsoleSendClicked();
    void buttonConsoleEraseClicked();
    void buttonReadConfigClicked();
    void buttonWriteSettingsClicked();
    void buttonWriteConfigClicked();
    void buttonResetClicked();
    void buttonSyncTimeClicked();

    void serialPortAboutToClose();
    void serialPortDataReady();
    void serialPortBytesWritten(qint64 bytes);
    void serialPortError(QSerialPort::SerialPortError error);

    void clockUpdate();


};

#endif // WIMUCONFIGDIALOG_H
