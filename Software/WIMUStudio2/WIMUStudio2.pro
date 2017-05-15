TEMPLATE = subdirs

SUBDIRS = Libs/Qwt-6.1.3/qwt.pro \
          Src/WIMUStudioMain.pro

# build the project sequentially as listed in SUBDIRS !
 CONFIG += ordered

#WIMUStudioMain.depends = qwt
