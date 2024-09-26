#ifndef INFOR_ACC_USER_H
#define INFOR_ACC_USER_H
#include <QVector>
#include <QFile>
#include <QString>
#include <QDebug>
#include <QString>

class infor_acc_user
{
private:
    QString acc_name;
    QString acc_num;
    QString acc_date;
public:
    int acc_pin;
    double acc_money;

    infor_acc_user() : acc_num("0"), acc_pin(0), acc_name(""), acc_date(""), acc_money(0) {}
    infor_acc_user(QString const &name,  QString const &num, QString const &date,int pin,double money)
        : acc_num (num), acc_pin(pin),acc_date(date), acc_name(name), acc_money (money)
    {}
    QString name(){
        return acc_name;
    }
    QString get_num_acc() const { return acc_num; }
    QString get_name_acc() const { return acc_name; }
    int get_pin_user() const { return acc_pin; }
    double get_money_user() const { return acc_money; }
    QString get_date_acc() const { return acc_date; }

    void save_filedata();

    void infor_user(QString &Num,QString &Name, double &Money,int &Pin,QString &date){
        Num = acc_num;
        Name = acc_name;
        Money = acc_money;
        Pin = acc_pin;
        date = acc_date;
    }
    bool check_acc(QString const &num, int &pin) {
        return acc_num == num && acc_pin == pin;
    }
    double update_money(double &money_draw) {
        acc_money = acc_money - money_draw;
        return acc_money;
    }
    double deposit_money(double &money_deposit) {
        acc_money += money_deposit;
        return acc_money;
    }
    void update_pincode(int new_pin) {
        acc_pin = new_pin;
    }

};
extern QVector<infor_acc_user> accounts;
void read_filedata();
void merge(QVector<infor_acc_user> &list_user, int l, int m, int r, int type);
void merge_sort(QVector<infor_acc_user> &list_user, int l, int r, int type);
#endif // INFOR_ACC_USER_H
