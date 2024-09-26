#ifndef HISTORY_TRANSFER_USER_H
#define HISTORY_TRANSFER_USER_H

#include "infor_acc_user.h"
#include <QVector>
#include <QFile>
#include <QString>
#include <QDebug>
#include <QString>

class history_transfer_user
{
private:
    QString acc_his;
public:
    QString acc_date;
    QString acc_type;
    double acc_money;

    history_transfer_user()
        : acc_his(""), acc_date(""), acc_type(""), acc_money(0.0) {}

    history_transfer_user(const QString &acc, const QString &time, const QString &type, double money)
        : acc_his(acc), acc_date(time), acc_type(type), acc_money(money){}

     QString get_num_his() const { return acc_his; }

};
extern QVector<history_transfer_user> history;
void save_file_history();
void read_file_history();

void merge(QVector<history_transfer_user> &his, int l, int m, int r,int type);
extern void merge_sort(QVector<history_transfer_user> &his,int l, int r,int type) ;

#endif // HISTORY_TRANSFER_USER_H
