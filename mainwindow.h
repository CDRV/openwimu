#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "wimuconfigdialog.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    void updateToolsDisplay();

    Ui::MainWindow *ui;

    WIMUConfigDialog* m_dlgWIMUConfig;

private slots:
    void srcBLESelected();
    void srcUSBSelected();
    void srcFolderSelected();

    void wimuConfigRequested();
    void appSettingsRequested();
};

#endif // MAINWINDOW_H
