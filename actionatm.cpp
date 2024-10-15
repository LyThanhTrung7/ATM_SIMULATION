#include "actionatm.h"

ActionATM::ActionATM(QObject *parent)
    : current_user(nullptr)
{

}

ActionATM::~ActionATM()
{
   delete current_user;
}


void ActionATM::Login(int type)
{
    delete current_user;
    if(type == 1) current_user = new RegularUser();
    else if(type == 2) current_user = new AdminUser();
}

bool ActionATM::checkUser(int acc_num, int pin)
{
    bool check = false;
    if(current_user){
        current_user->readData(acc_num, pin);
        check = current_user->checkUser(acc_num, pin);
    }
    if(check) {
        setLogin("Login cuccessful");
        setName(current_user->getName());
    }
    else{
        setLogin("Login fail!!!");
    }
    return check;
}

void ActionATM::readInfor()
{
    QString inforUser;
    if(current_user){
        inforUser = current_user->displayInfor();
        setInfor(inforUser);
    }
}

void ActionATM::acctionMenu(int type, double data, int data2)
{
    QString Status;
    Status = current_user->acction_Menu(type,data,data2);
    setStatus(Status);
}

void ActionATM::acctionMenu(int type, int data, int data2, const QString &data3)
{
    QString Status;
    Status = current_user->acction_Menu(type, data, data2, data3);
    setStatus(Status);
}

void ActionATM::readHistory(int acc_num,int data)
{
    QVariantList his;
    his = current_user->readHistory(acc_num,data);
    setHis(his);
}


QString ActionATM::login() const
{
    return m_login;
}

void ActionATM::setLogin(const QString &newLogin)
{
    if (m_login == newLogin)
        return;
    m_login = newLogin;
    emit loginChanged();
}

QString ActionATM::infor() const
{
    return m_infor;
}

void ActionATM::setInfor(const QString &newInfor)
{
    if (m_infor == newInfor)
        return;
    m_infor = newInfor;
    emit inforChanged();
}

void ActionATM::logout() {
    delete current_user;
    current_user = nullptr;
    setLogin("Logged out successfully");
}

QString ActionATM::name() const
{
    return m_name;
}

void ActionATM::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

QString ActionATM::status() const
{
    return m_status;
}

void ActionATM::setStatus(const QString &newStatus)
{
    if (m_status == newStatus)
        return;
    m_status = newStatus;
    emit statusChanged();
}

QVariantList ActionATM::his() const
{
    return m_his;
}

void ActionATM::setHis(const QVariantList &newHis)
{
    if (m_his == newHis)
        return;
    m_his = newHis;
    emit hisChanged();
}

