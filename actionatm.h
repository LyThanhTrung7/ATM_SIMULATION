#ifndef ACTIONATM_H
#define ACTIONATM_H

#include <QObject>
#include <QQmlEngine>

#include "adminuser.h"
#include "regularuser.h"

class ActionATM: public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString login READ login WRITE setLogin NOTIFY loginChanged FINAL)
    Q_PROPERTY(QString infor READ infor WRITE setInfor NOTIFY inforChanged FINAL)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged FINAL)
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged FINAL)
    Q_PROPERTY(QVariantList his READ his WRITE setHis NOTIFY hisChanged FINAL)
public:
    explicit ActionATM(QObject *parent = nullptr);
    ~ActionATM();
    QString login() const;
    void setLogin(const QString &newLogin);

    QString infor() const;
    void setInfor(const QString &newInfor);

    QString name() const;
    void setName(const QString &newName);

    QString status() const;
    void setStatus(const QString &newStatus);

    QVariantList his() const;
    void setHis(const QVariantList &newHis);


public slots:
    void Login(int type);
    void logout();
    bool checkUser(int acc_num, int pin);
    void readInfor();
    void acctionMenu(int type, double data, int data2);
    void acctionMenu(int type, int data, int data2, const QString &data3);
    void readHistory(int acc_num,int data);

signals:
    void loginChanged();

    void inforChanged();

    void nameChanged();

    void statusChanged();

    void hisChanged();


private:
    User* current_user;
    QString m_login;
    QString m_infor;
    QString m_name;
    QString m_status;
    QVariantList m_his;
};

#endif // ACTIONATM_H
