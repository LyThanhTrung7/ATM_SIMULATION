#ifndef USER_H
#define USER_H
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariantList>

class User
{
public:
    virtual bool checkUser(int acc_num, int pin) = 0;
    virtual void readData(int acc_num, int pin) = 0;
    virtual void updateData(int pin, double money) = 0;

    virtual QString displayInfor() = 0;
    virtual QString getName() {return accName; }
    virtual QString acction_Menu(int type, double data, int data2) = 0;
    virtual QString acction_Menu(int type,int data, int data2, const QString &data3) = 0;
    virtual QVariantList readHistory(int acc_num,int data) = 0;
    virtual void updateHistory(int acc_num,const QString& acc_date,const QString& acc_type, double money) = 0;

    virtual ~User();
protected:
    int accNum;
    int pinCode;
    QString accName;
    double money;
    QString date;
};

#endif // USER_H
