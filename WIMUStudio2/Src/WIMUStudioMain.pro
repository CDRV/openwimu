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
#QT += testlib #Uncomment to have a debug console
#CONFIG += console

TARGET = WIMUStudio2
TEMPLATE = app
INCLUDEPATH += $$PWD/../Libs/Qwt-6.1.3/src

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
           wimu3dviewer.cpp \
           BlueGiga\BLED112Driver.cpp \
           BlueGiga\BLEDeviceContext.cpp \
           BlueGiga\callbacks.cpp \
           BlueGiga\cmd_def.c \
           wimu_ble_driver.cpp \
           datatreeitem.cpp \
           wimuprocessor.cpp \
           wimufile.cpp \
           timebrowser.cpp \
           eventsbrowser.cpp \
           timeview.cpp \
    wimulog.cpp \
    wimufirmwaredialog.cpp

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
            wimu3dviewer.h \
            BlueGiga\BLED112Driver.h \
            BlueGiga\BLEDeviceContext.h \
            BlueGiga\cmd_def.h \
            BlueGiga\apitypes.h \
            wimu_ble_driver.h \
            datatreeitem.h \
            wimuprocessor.h \
            wimufile.h \
            timebrowser.h \
            eventsbrowser.h \
            timeview.h \
    wimulog.h \
    wimufirmwaredialog.h

FORMS    += mainwindow.ui \
            wimuconfigdialog.ui \
            sensordisplay.ui \
            timebrowser.ui \
            eventsbrowser.ui \
    wimufirmwaredialog.ui

#include (C:\Qwt-6.1.3\features\qwt.prf)
CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../Libs/Qwt-6.1.3/lib -lqwtd
CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../Libs/Qwt-6.1.3/lib -lqwt
LIBS += -lglu32 -lopengl32

RC_ICONS = images/WIMU2.ico

#Copy required files

#HTML map
extra_libs.files = $$PWD/map.html
CONFIG(debug, debug|release): extra_libs.path = $$OUT_PWD/debug
CONFIG(release, debug|release): extra_libs.path = $$OUT_PWD/release

#Firmware updater
firmware.files = $$PWD/../Utils/STM32_DFULoader/Windows/* + $$PWD/../../Firmware/WIMU3/bin/*
CONFIG(debug, debug|release): firmware.path = $$OUT_PWD/debug/firmware
CONFIG(release, debug|release): firmware.path = $$OUT_PWD/release/firmware

INSTALLS += extra_libs \
            firmware

RESOURCES += \
    wimustudio2.qrc

