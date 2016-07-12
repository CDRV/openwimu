#-------------------------------------------------
#
# Project created by QtCreator 2016-06-20T10:10:57
#
#-------------------------------------------------

greaterThan(QT_MAJOR_VERSION, 4):

QT += core gui
QT += widgets
QT += serialport

TARGET = WIMUStudio2
TEMPLATE = app

SOURCES += main.cpp\
           mainwindow.cpp \
           wimuconfigdialog.cpp \
           wimuconfig.cpp \
    wimusettings.cpp

HEADERS  += mainwindow.h \
            wimuconfigdialog.h \
            wimuconfig.h \
    wimusettings.h

FORMS    += mainwindow.ui \
            wimuconfigdialog.ui

RC_ICONS = images/WIMU2.ico

RESOURCES += \
    wimustudio2.qrc
