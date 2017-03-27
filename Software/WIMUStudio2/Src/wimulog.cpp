#include "wimulog.h"

WIMULog::WIMULog(QObject *parent) : QObject(parent)
{

}

WIMULog::WIMULog(const WIMULog& copy, QObject *parent)
: QObject(parent)
{
    *this = copy;
}


WIMULog& WIMULog::operator = (const WIMULog& original){
    timestamp = original.timestamp;
    log_type = original.log_type;
    log = original.log;

    return *this;
}

bool WIMULog::operator <(WIMULog const& b) const{
    return timestamp < b.timestamp;
}
