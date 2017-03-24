#ifndef WIMUFIRMWAREDIALOG_H
#define WIMUFIRMWAREDIALOG_H

#include <QDialog>
#include <QProcess>

namespace Ui {
class WimuFirmwareDialog;
}

class WimuFirmwareDialog : public QDialog
{
    Q_OBJECT

public:
    explicit WimuFirmwareDialog(QWidget *parent = 0);
    ~WimuFirmwareDialog();

private:
    bool wimuReadyToUpgrade();
    void getAvailableFirmwares();

    Ui::WimuFirmwareDialog  *ui;
    QProcess                m_updateProcess;

private slots:
    void doFirmwareUpdate();

    void updateProcessReadyRead();
    void updateProcessReadyError();
    void updateProcessStarted();
    void updateProcessTerminated();
    void updateProcessError(QProcess::ProcessError err);

    void toggleConsole();
};

#endif // WIMUFIRMWAREDIALOG_H
