#include "history_transfer_user.h"
#include <QString>

QVector<history_transfer_user> history;

void save_file_history()
{
    QFile file("history_transaction.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Unable to open file" << file.errorString();
        return;
    }

    QSet<QString> exis;
    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine();
        exis.insert(line.trimmed());
    }
    file.close();

    if (!file.open(QIODevice::Append | QIODevice::Text)) {
        qWarning() << "Unable to open file" << file.errorString();
        return;
    }

    QTextStream out(&file);
    for (const auto& his : history) {
        QString transaction = his.get_num_his() + ","
                              + his.acc_date + ","
                              + his.acc_type + ","
                              + QString::number(his.acc_money, 'f', 0);
        if (!exis.contains(transaction)) {
            out << transaction << "\n";
            exis.insert(transaction);
        }
    }
    file.close();
}

void read_file_history()
{
    QFile file("history_transaction.txt");
    if(file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        while (!in.atEnd()) {
            QString line = in.readLine();
            QStringList credentials = line.split(",");
            if (credentials.size() >= 4) {

                QString file_num_acc = credentials.at(0);
                QString file_date = credentials.at(1);
                QString type_file = credentials.at(2);
                QString money_acc = credentials.at(3);

                double file_money = money_acc.toDouble();

                history.push_back(history_transfer_user(file_num_acc, file_date, type_file, file_money));
            }
        }
        file.close();
    } else {
        qWarning() << "Could not open the file!";
    }
}


void merge(QVector<history_transfer_user> &his, int l, int m, int r, int type)
{
    int n1 = m - l + 1;
    int n2 = r - m;

    QVector<history_transfer_user> L(n1);
    QVector<history_transfer_user> R(n2);

    for(int i=0; i<n1; ++i) L[i] = his[i+l];
    for(int j=0; j<n2; ++j) R[j] = his[m+1+j];

    int i=0;
    int j=0;
    int k=l;
    while(i<n1&&j<n2){
        if(type == 0){
            if(L[i].acc_date<=R[j].acc_date){
                his[k] = L[i];
                i++;
            }else{
                his[k] = R[j];
                j++;
            }
            k++;
        }
        if(type == 1){
            if(L[i].acc_date >= R[j].acc_date){
                his[k] = L[i];
                i++;
            }else{
                his[k] = R[j];
                j++;
            }
            k++;
        }
        if(type == 2){
            int num_L = L[i].get_num_his().toInt();
            int num_R = R[j].get_num_his().toInt();
            if(num_L < num_R){
                his[k] = L[i];
                i++;
            }else{
                his[k] = R[j];
                j++;
            }
            k++;
        }
    }
    while(i<n1){
        his[k] = L[i];
        i++;
        k++;
    }
    while(j<n2){
        his[k] = R[j];
        j++;
        k++;
    }
}

void merge_sort(QVector<history_transfer_user> &his, int l, int r, int type)
{
    if(l<r){
        int m = l + (r-l)/2;
        merge_sort(his,l,m,type);
        merge_sort(his,m+1,r,type);
        merge(his,l,m,r,type);
    }
}
