#include "infor_acc_user.h"

QVector<infor_acc_user> accounts;

//QString filePath("accounts.txt");

void read_filedata() {
    QFile file("accounts.txt");
    if(file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        while (!in.atEnd()) {
            QString line = in.readLine();
            QStringList credentials = line.split(",");
            if (credentials.size() >= 5) {
                QString file_num_acc = credentials.at(0);
                QString file_name_acc = credentials.at(1);
                QString pass_acc = credentials.at(2);
                QString money_acc = credentials.at(3);
                QString file_date = credentials.at(4);

                int file_pass_acc = pass_acc.toInt();
                double file_money = money_acc.toDouble();

                accounts.push_back(infor_acc_user(file_name_acc, file_num_acc, file_date, file_pass_acc, file_money));
            }
        }
        file.close();
    } else {
        qWarning() << "Could not open the file!";
    }
}

void infor_acc_user::save_filedata()
{
    QFile file("accounts.txt");
    if (!file.open( QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Unable to open file" << file.errorString();
        return;
    }
    else{
        QTextStream out(&file);
        for (auto& acc : accounts) {
            out << acc.get_num_acc() << ","
                << acc.get_name_acc() << ","
                << acc.get_pin_user() << ","
                << QString::number(acc.get_money_user(), 'f', 2) << ","
                << acc.get_date_acc() << "\n";
        }
        file.close();
    }
}

void merge(QVector<infor_acc_user> &list_user, int l, int m, int r, int type)
{
    int n1 = m - l + 1;
    int n2 = r - m;

    QVector<infor_acc_user> L(n1);
    QVector<infor_acc_user> R(n2);

    for(int i=0; i<n1; ++i) L[i] = list_user[i+l];
    for(int j=0; j<n2; ++j) R[j] = list_user[m+1+j];

    int i=0;
    int j=0;
    int k=l;
    while(i<n1&&j<n2){
        if(type == 0){
            if(L[i].get_date_acc()<=R[j].get_date_acc()){
                list_user[k] = L[i];
                i++;
            }else{
                list_user[k] = R[j];
                j++;
            }
            k++;
        }
        if(type == 1){
            if(L[i].get_date_acc() >= R[j].get_date_acc()){
                list_user[k] = L[i];
                i++;
            }else{
                list_user[k] = R[j];
                j++;
            }
            k++;
        }
    }
    while(i<n1){
        list_user[k] = L[i];
        i++;
        k++;
    }
    while(j<n2){
        list_user[k] = R[j];
        j++;
        k++;
    }
}

void merge_sort(QVector<infor_acc_user> &list_user, int l, int r, int type)
{
    if(l<r){
        int m = l + (r-l)/2;
        merge_sort(list_user,l,m,type);
        merge_sort(list_user,m+1,r,type);
        merge(list_user,l,m,r,type);
    }
}
