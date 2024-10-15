#ifndef ADMINUSER_H
#define ADMINUSER_H
#include "user.h"

class AdminUser:public User
{
public:
    AdminUser();
    bool checkUser(int acc_num, int pin) override;

    void readData(int acc_num, int pin) override;
    void updateData(int pin, double money) override;

    QString displayInfor() override;

    QString getName() override {return accName; }
    QString acction_Menu(int type,double data, int data2)override ;
    QString acction_Menu(int type,int data, int data2, const QString &data3)override;

    QVariantList  readHistory(int acc_num,int data) override;
    void updateHistory(int acc_num,const QString &acc_date,const QString &acc_type, double money) override;
};

#endif // ADMINUSER_H
