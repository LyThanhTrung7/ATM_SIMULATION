#include "login.h"
#include "history_transfer_user.h"
#include "infor_acc_user.h"

Login::Login(QObject *parent)
    : QObject{parent}
{

}

void Login::login_user(const QString num, int pass)
{
    read_file_history();
    read_filedata();
    QString name_user;
    bool found = false;
    for (auto& acc : accounts) {
        if (acc.check_acc(num, pass)) {
            found = true;
            name_user = acc.name();
            set_status(name_user);
            emit login_success();
            break;
        }
    }
    if (!found) {
        set_status("Account/password isn't correct!!BY USER");
        emit login_fails();
    }
}

void Login::login_admin(const QString acc_num, const QString pass)
{
    read_file_history();
    read_filedata();
    if(acc_num=="250802"&&pass=="1234"){
        emit login_success_ad();
    }else{
        set_status("Account/password isn't correct!!BY ADMIN");
        emit login_fails_ad();
    }
}

QString Login::status() const
{
    return m_status;
}

void Login::set_status(const QString &newStatus)
{
    if (m_status == newStatus)
        return;
    m_status = newStatus;
    emit status_changed();
}
