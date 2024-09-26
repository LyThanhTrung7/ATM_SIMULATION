#include "menu_atm.h"
#include "infor_acc_user.h"
#include "history_transfer_user.h"

#include <QLocale>
#include <QString>
#include <QDateTime>


ATM::ATM(QObject *parent)
    : QObject{parent}
{}

QString ATM::infor() const
{
    return Infor;
}

void ATM::set_infor(const QString &new_infor)
{
    if (Infor == new_infor)
        return;
    Infor = new_infor;
    emit infor_changed();
}

QString ATM::note() const
{
    return Note;
}

void ATM::set_note(const QString &new_note)
{
    if (Note == new_note)
        return;
    Note = new_note;
    emit note_changed();
}

QString ATM::user_infor() const
{
    return User;
}

void ATM::set_user_infor(const QString &new_user)
{
    if (User == new_user)
        return;
    User = new_user;
    emit user_infor_changed();
}

QString ATM::note_transfer() const
{
    return Transfer;
}

void ATM::set_note_transfer(const QString &newnote)
{
    if(Transfer == newnote)
        return ;
    Transfer = newnote;
    emit note_transfer_changed();
}

QString ATM::send() const
{
    return Send;
}

void ATM::setSend(const QString &newsend)
{
    if(Send == newsend)
        return ;
    Send = newsend;
    emit sendChanged();
}


QStringList ATM::his() const
{
    return His;
}

void ATM::setHis(const QStringList &newhis)
{
    if (His != newhis) {
        His = newhis;
        emit hisChanged(); // Báo cho QML biết rằng dữ liệu đã thay đổi
    }
}

QStringList ATM::list() const
{
    return List;
}

void ATM::setList(const QStringList &newlist)
{
    if (List != newlist) {
        List = newlist;
        emit listChanged();
    }
}

QString ATM::add_user() const
{
    return add;
}

void ATM:: setAdd_user(const QString &newadd)
{
    if (add != newadd) {
        add = newadd;
        emit add_userChanged();
    }
}

QString num_user;
QString name_user;
double money_user;
int pin_user;
QString time_user;

void ATM::read_acc(QString const Num, int Pin)
{
    for (auto& acc : accounts) {
        if (acc.check_acc(Num, Pin)) {
            acc.infor_user(num_user,name_user,money_user,pin_user,time_user);
        }
    }
}

QString formatMoney(double amount) {

    QString moneyStr = QString::number(amount, 'f', 0);
    int length = moneyStr.length();

    for (int i = length - 3; i > 0; i -= 3) {
        moneyStr.insert(i, ',');
    }

    return moneyStr;
}

void ATM::cash_out(QString cashMoney)
{
    double cash_money = cashMoney.toDouble();
    qDebug()<<"cash: "<<cash_money;
    for(auto& acc: accounts){
        if(acc.check_acc(num_user,pin_user)){
            if(cash_money > money_user){
                set_infor("Insufficient balance!!");
            }
            else{
                money_user = acc.update_money(cash_money);
                acc.save_filedata();
                QString money_user_str = formatMoney(money_user);
                QString real_money = "Withdrawal successful: " + money_user_str + " VND";
                set_infor(real_money);
                QString time = get_current_time();
                history.push_back(history_transfer_user(num_user,time,"Cash money",cash_money));
                save_file_history();
                break;
            }
        }
    }
}

void ATM::change_pin(int pincode_old,int pincode1, int pincode2)
{
    for(auto& acc: accounts){
        if(acc.check_acc(num_user,pin_user)){
            if(pincode_old != pin_user){
                set_note("Old pin code is incorrect!!");
            }
            else{
                if(pincode1==pincode2){
                    acc.update_pincode(pincode1);
                    acc.save_filedata();
                    set_note("");
                    emit change_pin_success();

                }else{
                    set_note("Re-enter new incorrect password!!!");
                    emit change_pin_false();
                }
            }
            break;
        }
    }
}

void ATM::User_infor()
{
    for(auto& acc: accounts){
        if(acc.check_acc(num_user,pin_user)){
            QString money_user_str = formatMoney(money_user);
            QString infor_users ="- Name: "+name_user+"\n- Acc-Number: "+num_user+"\n- Money: "+ money_user_str+" VND"+"\n- Date: "+ time_user;
            set_user_infor(infor_users);
            break;
        }
    }
}

void ATM::tranfer_money(const QString num_re, QString const money_re, QString const pin_trans) {
    double num_money = money_re.toDouble();
    int pin_code_trans = pin_trans.toInt();
    bool found_acc = false;
    for (auto& acc : accounts) {
        if (acc.check_acc(num_user, pin_code_trans)) {
            found_acc = true;
            if (num_money > acc.get_money_user()) {
                set_note_transfer("Insufficient balance!!!");
                emit transfer_pin_false();
                return;
            }

            bool found_recipient = false;
            for (auto& Acc : accounts) {
                if (num_re == Acc.get_num_acc()) {
                    Acc.deposit_money(num_money);
                    money_user = acc.update_money(num_money);
                    acc.save_filedata();

                    QString money_user_str = formatMoney(money_user);
                    QString real_money = "Transfer successful: " + money_user_str + " VND";
                    set_note_transfer(real_money);
                    found_recipient = true;
                    emit transfer_pin_success();

                    QString real_type = "Transfer";
                    QString time = get_current_time();
                    history.push_back(history_transfer_user(num_user,time,real_type,num_money));
                    save_file_history();
                    break;
                }
            }
            if (!found_recipient) {
                set_note_transfer("Incorrect recipient account!!");
                emit transfer_pin_false();
            }
            return;
        }
    }

    if (!found_acc) {
        set_note_transfer("Re-enter new incorrect password!!!");
        emit transfer_pin_false();
    }
}

void ATM::send_money(double sendMoney)
{
    for(auto& acc: accounts){
        if(acc.check_acc(num_user,pin_user)){
            // if(sendMoney > money_user){
            //     set_infor("Insufficient balance!!");
            // }
            money_user = acc.deposit_money(sendMoney);
            acc.save_filedata();
            QString money_user_str = formatMoney(money_user);
            QString real_money = "Send successful: " + money_user_str + " VND";
            setSend(real_money);

            QString time = get_current_time();
            history.push_back(history_transfer_user(num_user,time,"Send money",sendMoney));
            save_file_history();
            break;
        }
    }

}

void ATM::user_his(int tt)
{

    merge_sort(history, 0, history.size()-1, tt);

    QStringList historyList;
    for(int i=0; i<history.size();++i){
        if(num_user == history[i].get_num_his()){
            QString money_user = formatMoney(history[i].acc_money);
            QString his_user = +"Acc: "+history[i].get_num_his()
                               +" - Time: "+history[i].acc_date
                               +" - Type: "+history[i].acc_type
                               +" - Money: "+money_user+" VND";
            historyList.append(his_user);
        }
    }
    setHis(historyList);
}

bool isDataLoaded = false;

void ATM::user_list(int type)
{

    merge_sort_list(accounts, 0, accounts.size()-1, type);

    QStringList userList;
    for(int i=0; i<accounts.size();++i){
        QString money_user = formatMoney(accounts[i].acc_money);
        QString list_user = +"Acc: "+accounts[i].get_num_acc()
                            +" - Name: "+accounts[i].get_name_acc()
                            +" - Time: "+accounts[i].get_date_acc()
                            +" - Money: "+money_user+" VND";
        userList.append(list_user);
    }
    setList(userList);
}

QString ATM::get_current_time()
{
    QDateTime current = QDateTime::currentDateTime();
    return current.toString("yyyy-MM-dd HH:mm:ss");
}

void ATM::add_new_user(const QString name, const QString num, const QString pin1, const QString pin2)
{
    int pin_code1 = pin1.toInt();
    int pin_code2 = pin2.toInt();
    bool check = false;
    for(auto& acc: accounts){
        if(pin_code1 == pin_code2){
            for(auto& acc: accounts){
                if(num == acc.get_num_acc()){
                    setAdd_user("Account number already exists");
                    emit add_user_false();
                    check = true;
                }
            }
            if(check == false){
                QString date = get_current_time();
                accounts.push_back(infor_acc_user(name, num, date, pin_code1, 0));
                acc.save_filedata();
                setAdd_user("New user account added successfully");
                emit add_user_success();
                break;
            }
        }else{
            setAdd_user("Re-enter new incorrect pin!!!");
            emit add_user_false();
        }
    }
}

void ATM::delete_user(const QString num,const QString pin)
{
    int pincode = pin.toInt();
    auto dele = accounts.end();
    for (auto i = accounts.begin(); i != accounts.end(); ++i) {
        if(i->check_acc(num,pincode)){
            dele = i;
            break;
        }
    }
    if(dele!= accounts.end()){
        accounts.erase(dele);
        setAdd_user("Delete account successfully");
        dele->save_filedata();
        emit add_user_success();
    }else{
        setAdd_user("Not account!!!");
        emit add_user_false();
    }
}

void ATM::search_user(const QString num)
{
    int x = binary_search(accounts,0,accounts.size()-1,num);
    if(x == -1) set_user_infor("DON'T ACCOUNT!!!!!");
    else{
        QString money_user = formatMoney(accounts[x].get_money_user());
        QString infor_users ="User account found"
                              "\n- Name: "+accounts[x].get_name_acc()
                              +"\n- Acc-Number: "+accounts[x].get_num_acc()
                              +"\n- Money: " + money_user+ " VND"
                              +"\n- Date: "+ accounts[x].get_date_acc();
        set_user_infor(infor_users);
    }
}

void ATM::admin_his(int type, QString num)
{
    QStringList historyList;
    bool search = false;
    if(type < 3 && num == ""){
        merge_sort(history, 0, history.size()-1, type);
        for(int i=0; i<history.size();++i){
            QString money_user = formatMoney(history[i].acc_money);
            QString his_user = +"Acc: "+history[i].get_num_his()
                               +" - Time: "+history[i].acc_date
                               +" - Type: "+history[i].acc_type
                               +" - Money: "+money_user+" VND";
            historyList.append(his_user);
        }
    }else{
        merge_sort(history, 0, history.size()-1, type);
        for(int i=0; i<history.size();++i){
            if(num == history[i].get_num_his()){
                QString money_user = formatMoney(history[i].acc_money);
                QString his_user = +"Acc: "+history[i].get_num_his()
                                   +" - Time: "+history[i].acc_date
                                   +" - Type: "+history[i].acc_type
                                   +" - Money: "+money_user+" VND";
                historyList.append(his_user);
                search = true;
            }
        }
        if(!search) historyList.append("!!!!!There are no transactions for this user.!!!!!!");
    }
    setHis(historyList);
}

void merge_list(QVector<infor_acc_user> &list, int l, int m, int r, int type)
{
    int n1 = m - l +1 ;
    int n2 = r - m;
    QVector<infor_acc_user> L(n1);
    QVector<infor_acc_user> R(n2);

    for(int i=0; i<n1; i++) L[i] = list[i+l];
    for(int j=0; j<n2; j++) R[j] = list[m+1+j];

    int i =0;
    int j =0 ;
    int k = l;
    while(i<n1&&j<n2){
        if(type == 0){
            if(L[i].get_name_acc()<R[j].get_name_acc()){
                list[k] = L[i];
                i++;
            }else{
                list[k] = R[j];
                j++;
            }k++;
        }
        if(type == 1){
            if(L[i].get_date_acc()<R[j].get_date_acc()){
                list[k] = L[i];
                i++;
            }else{
                list[k] = R[j];
                j++;
            }k++;
        }
        if(type == 2){
            if(L[i].get_date_acc() > R[j].get_date_acc()){
                list[k] = L[i];
                i++;
            }else{
                list[k] = R[j];
                j++;
            }k++;
        }
        if(type == 3){
            if(L[i].get_num_acc() < R[j].get_num_acc()){
                list[k] = L[i];
                i++;
            }else{
                list[k] = R[j];
                j++;
            }k++;
        }
    }
    while(i<n1){
        list[k] = L[i];
        i++;
        k++;
    }
    while (j<n2) {
        list[k] = R[j];
        j++;
        k++;
    }
}

void merge_sort_list(QVector<infor_acc_user> &list, int l, int r, int type)
{
    if(l<r){
        int m = l+(r-l)/2;
        merge_sort_list(list,l,m,type);
        merge_sort_list(list,m+1,r,type);
        merge_list(list,l,m,r,type);
    }
}

int binary_search(QVector<infor_acc_user> &list, int l, int r, QString num)
{
    merge_sort_list(list,l,r,3);
    if(l<=r){
        int mid = l + (r-l)/2;
        if(list[mid].get_num_acc() == num ) return mid;
        else{
            if(list[mid].get_num_acc() > num ) return binary_search(list,l,mid-1,num);
            else return binary_search(list,mid+1,r,num);
        }
    }
    return -1;
}
