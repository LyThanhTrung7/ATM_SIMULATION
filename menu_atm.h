#ifndef MENU_ATM_H
#define MENU_ATM_H

#include "history_transfer_user.h"
#include <QObject>
#include <QtQml>

class ATM : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString infor READ infor WRITE set_infor NOTIFY infor_changed FINAL)
    Q_PROPERTY(QString note READ note WRITE set_note NOTIFY note_changed FINAL)
    Q_PROPERTY(QString user_infor READ user_infor WRITE set_user_infor NOTIFY user_infor_changed FINAL)
    Q_PROPERTY(QString note_transfer READ note_transfer WRITE set_note_transfer NOTIFY note_transfer_changed FINAL)
    Q_PROPERTY(QString send READ send WRITE setSend NOTIFY sendChanged FINAL);
    Q_PROPERTY(QStringList his READ his WRITE setHis NOTIFY hisChanged FINAL);
    Q_PROPERTY(QStringList list READ list WRITE setList NOTIFY listChanged FINAL);;;

    Q_PROPERTY(QString add_user READ add_user WRITE setAdd_user NOTIFY add_userChanged FINAL)

public:
    explicit ATM(QObject *parent = nullptr);
    QString infor() const;
    void set_infor(const QString &new_infor);

    QString note() const;
    void set_note(const QString &new_note);

    QString user_infor()const;
    void set_user_infor(const QString &new_user);

    QString note_transfer() const;
    void set_note_transfer(const QString &newnote);

    QString send() const;
    void setSend(const QString &newsend);

    QStringList his() const;
    void setHis(const QStringList &newhis);

    QStringList list() const;
    void setList(const QStringList &newlist);

    QString add_user() const;
    void setAdd_user(const QString &newadd);

    Q_INVOKABLE void read_acc(QString const Num, int Pin);
    Q_INVOKABLE void cash_out(QString cashMoney);
    Q_INVOKABLE void change_pin(int pincode_old,int pincode1, int pincode2);
    Q_INVOKABLE void User_infor();
    Q_INVOKABLE void tranfer_money(QString const num_re, QString const money_re, QString const pin_trans);
    Q_INVOKABLE void send_money(double sendMoney);
    Q_INVOKABLE void user_his(int type);
    Q_INVOKABLE void user_list(int type);
    QString get_current_time();
    Q_INVOKABLE void add_new_user(QString const name,QString const num, const QString pin1, const QString pin2);
    Q_INVOKABLE void delete_user(QString const num,const QString pin);
    Q_INVOKABLE void search_user(QString const num);
    Q_INVOKABLE void admin_his(int type, QString num);

signals:
    void infor_changed();
    void note_changed();
    void user_infor_changed();
    void note_transfer_changed();
    void sendChanged();
    void hisChanged();
    void listChanged();
    void add_userChanged();

    void change_pin_success();
    void change_pin_false();

    void transfer_pin_success();
    void transfer_pin_false();

    void add_user_success();
    void add_user_false();

private:
    QString Infor;
    QString Note;
    QString User;
    QString Transfer;
    QString Send;
    QStringList His;
    QStringList List;
    QString add;
};
void merge_list(QVector<infor_acc_user> &list, int l, int m, int r, int type);
void merge_sort_list(QVector<infor_acc_user> &list, int l, int r, int type);
int binary_search(QVector<infor_acc_user> &list, int l, int r, QString num);
#endif // MENU_ATM_H
