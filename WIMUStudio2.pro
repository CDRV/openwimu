#-------------------------------------------------
#
# Project created by QtCreator 2016-06-20T10:10:57
#
#-------------------------------------------------

greaterThan(QT_MAJOR_VERSION, 4):

QT += core gui
QT += widgets
QT += serialport
QT += webenginewidgets

TARGET = WIMUStudio2
TEMPLATE = app

SOURCES += main.cpp\
           mainwindow.cpp \
           wimuconfigdialog.cpp \
           wimuconfig.cpp \
           wimusettings.cpp \
           wimu_usb_driver.cpp \
           sensordisplay.cpp \
           datagraph.cpp \
           sensorbuffer.cpp \
           sensorcurve.cpp \
           wimubinarystream.cpp \
            wimu3dviewer.cpp

HEADERS  += mainwindow.h \
            wimuconfigdialog.h \
            wimuconfig.h \
            wimusettings.h \
            wimu_usb_driver.h \
            sensordisplay.h \
            datagraph.h \
            sensorbuffer.h \
            sensorcurve.h \
            wimubinarystream.h \
            wimu.h \
            wimu3dviewer.h

FORMS    += mainwindow.ui \
            wimuconfigdialog.ui \
            sensordisplay.ui

include (C:\Qwt-6.1.3\features\qwt.prf)

LIBS += -lglu32 -lopengl32

RC_ICONS = images/WIMU2.ico

RESOURCES += \
    wimustudio2.qrc

