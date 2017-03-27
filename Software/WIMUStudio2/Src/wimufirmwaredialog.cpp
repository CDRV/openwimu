#include "wimufirmwaredialog.h"
#include "ui_wimufirmwaredialog.h"

#include <QDir>
#include <QStringList>
#include <QDebug>

WimuFirmwareDialog::WimuFirmwareDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::WimuFirmwareDialog)
{
    ui->setupUi(this);

    // Initial state
    ui->lblStatus->setStyleSheet("QLabel{color:black;}");
    ui->lblStatus->setText("Prêt à mettre à jour.");
    ui->lblStatusIcon->setPixmap(QPixmap(":/icons/images/led_green.png"));
    ui->lstFirmware->setEnabled(true);
    ui->btnSendFirmware->setEnabled(false); // Button disabled by default until firmwares are available
    ui->progUpdate->setVisible(false);
    ui->txtConsole->setVisible(false);

    // Fill list of available firmwares
    getAvailableFirmwares();

    // Connect signals
    connect(ui->btnSendFirmware,SIGNAL(clicked(bool)),this,SLOT(doFirmwareUpdate()));
    connect(ui->btnConsole,SIGNAL(clicked(bool)),this,SLOT(toggleConsole()));

    connect(&m_updateProcess,SIGNAL(readyReadStandardOutput()),this,SLOT(updateProcessReadyRead()));
    connect(&m_updateProcess,SIGNAL(readyReadStandardError()),this,SLOT(updateProcessReadyError()));
    connect(&m_updateProcess,SIGNAL(started()),this,SLOT(updateProcessStarted()));
    connect(&m_updateProcess,SIGNAL(finished(int)),this,SLOT(updateProcessTerminated()));
    connect(&m_updateProcess,SIGNAL(error(QProcess::ProcessError)),this,SLOT(updateProcessError(QProcess::ProcessError)));
}

WimuFirmwareDialog::~WimuFirmwareDialog()
{
    m_updateProcess.disconnect();

    if (m_updateProcess.state() != QProcess::NotRunning){
        m_updateProcess.kill();
    }
    delete ui;
    ui=NULL;
}


void WimuFirmwareDialog::getAvailableFirmwares(){
    QDir firmware_dir;
    firmware_dir.setPath(QApplication::applicationDirPath() + "/firmware");

    if (!firmware_dir.exists()){
        ui->lblStatus->setText("Erreur: Le répertoire des micrologiciels est inexistant.");
        ui->lblStatus->setStyleSheet("QLabel{color:red;}");
        ui->lblStatusIcon->setPixmap(QPixmap(":/images/led_red.png"));
        return;
    }

    QStringList files = firmware_dir.entryList(QStringList("*.dfu"),QDir::Files,QDir::Time);
    ui->lstFirmware->clear();
    for (int i=0; i<files.count(); i++){
        ui->lstFirmware->addItem(files.at(i));
    }

    if (ui->lstFirmware->count()>0){
        ui->lstFirmware->setCurrentRow(0);
        ui->btnSendFirmware->setEnabled(true);
    }



}

void WimuFirmwareDialog::doFirmwareUpdate(){
    if (ui->lstFirmware->currentRow()==-1)
        return; // No firmware selected

    ui->txtConsole->clear();

    QString firmware_file = QApplication::applicationDirPath() + "/firmware/" + ui->lstFirmware->currentItem()->text();
    QString updater_prog = QApplication::applicationDirPath() + "/firmware/DfuSeCommand.exe"; // TODO: Support other OS

    // Check for updater executable
    if (!QFile::exists(updater_prog)){
        ui->lblStatus->setText("Impossible de lancer l'utilitaire de mise à jour");
        ui->lblStatus->setStyleSheet("QLabel{color:red;}");
        ui->lblStatusIcon->setPixmap(QPixmap(":/icons/images/led_red.png"));
        return;
    }

    // Start QProcess
    m_updateProcess.setWorkingDirectory(QApplication::applicationDirPath() + "/firmware");
    m_updateProcess.setProgram(updater_prog);

    QStringList args;
    args.append("-c"); // Connect to device
    args.append("-d"); // Download file
    args.append("--v"); // Verify after download
    args.append("--fn"); // Filename
    args.append(firmware_file);

    m_updateProcess.setArguments(args);

    m_updateProcess.start();

}

void WimuFirmwareDialog::updateProcessReadyError(){
    QByteArray data = m_updateProcess.readAllStandardError();

    ui->txtConsole->append("<font color=red>" + QString(data) + "</font>");
    ui->txtConsole->ensureCursorVisible();
    QApplication::processEvents();

}

void WimuFirmwareDialog::updateProcessReadyRead(){
    //static quint32 last_length = 0;
    QByteArray data = m_updateProcess.readAllStandardOutput();
    QString output = QString(data);

   /* quint32 current_length = ui->txtConsole->toHtml().length();

    if (output.contains("\r") && !output.contains("\n")){
        ui->txtConsole->setText(ui->txtConsole->toHtml().left(ui->txtConsole->toHtml().length()-last_length));
    }*/

    ui->txtConsole->append(output);
    ui->txtConsole->ensureCursorVisible();

    //last_length = ui->txtConsole->toHtml().length() - current_length;

    // Manage specific cases...
    if (output.contains("0 Device(s) found")){
        m_updateProcess.kill();
        ui->lblStatus->setText("Aucun module à mettre à jour! Vérifiez qu'il est dans le bon mode.");
        ui->lblStatus->setStyleSheet("QLabel{color:red;}");
        ui->lblStatusIcon->setPixmap(QPixmap(":/icons/images/led_red.png"));
        //ui->btnSendFirmware->setEnabled(true);
        return;
    }

    if (output.contains("Phase (")){
        ui->lblStatus->setStyleSheet("QLabel{color:black;}");
        QString lblText = output;
        lblText = lblText.replace("Target 00: ","");

        QStringList values = lblText.split(QRegExp("[(]|[)]"));

        if (values.count()==3){
            ui->progUpdate->setValue(values.at(1).toUInt());
        }

        ui->lblStatus->setText(lblText);
        ui->progUpdate->setVisible(true);
        return;
    }

    if (output.contains("Verify successful !")){
        ui->lblStatus->setText("Processus de mise à jour terminée.");
        ui->lblStatus->setStyleSheet("QLabel{color:black;}");
        ui->lblStatusIcon->setPixmap(QPixmap(":/icons/images/led_green.png"));
        return;
    }

    ui->lblStatus->setText("Mise à jour en cours...");

}

void WimuFirmwareDialog::updateProcessStarted(){
    ui->btnSendFirmware->setEnabled(false);
    ui->lblStatus->setText("Mise à jour en cours...");
    ui->lblStatus->setStyleSheet("QLabel{color:black;}");
    ui->lblStatusIcon->setPixmap(QPixmap(":/icons/images/led_yellow.png"));
}

void WimuFirmwareDialog::updateProcessTerminated(){
    ui->btnSendFirmware->setEnabled(true);
    ui->progUpdate->setVisible(false);
    /*ui->lblStatus->setText("Processus de mise à jour terminée.");
    ui->lblStatus->setStyleSheet("QLabel{color:black;}");
    ui->lblStatusIcon->setPixmap(QPixmap(":/icons/images/led_green.png"));*/
}

void WimuFirmwareDialog::updateProcessError(QProcess::ProcessError err){
    Q_UNUSED(err)


    ui->btnSendFirmware->setEnabled(true);
    ui->txtConsole->append("<font color=red>***" + m_updateProcess.errorString() + "***</font>");
    ui->txtConsole->ensureCursorVisible();
}

void WimuFirmwareDialog::toggleConsole(){
    ui->txtConsole->setVisible(!ui->txtConsole->isVisible());
}
