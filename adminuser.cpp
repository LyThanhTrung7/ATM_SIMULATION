#include "adminuser.h"
#include <QVariant>
#include <QLocale>
#include <QDateTime>

AdminUser::AdminUser() {

}
QVariantList listuser;
bool AdminUser::checkUser(int acc_num, int pin)
{
    QSqlQuery query;
    bool success = query.exec("SELECT ACC_NUM, ACC_NAME, ACC_PIN FROM admin");

    if (!success) {
        qDebug() << "Query failed: " << query.lastError().text();
    } else {
        qDebug() << "Query succeeded!";
    }
    while (query.next()) {
        accNum  = query.value(0).toInt();
        accName = query.value(1).toString();
        pinCode = query.value(2).toInt();
    }

    if(acc_num == accNum && pin == pinCode) return true;
    else return false;
}

void AdminUser::readData(int acc_num, int pin)
{
    QSqlQuery query;
    QString order;

    switch (pin) {
    case 1:
        order = "ACC_DATE DESC";
        break;
    case 2:
        order = "ACC_DATE ASC";
        break;
    case 3:
        order = "ACC_MONEY DESC";
        break;
    case 4:
        order = "ACC_MONEY ASC";
        break;
    }

    QString queryStr = "SELECT * FROM user ORDER BY " + order;
    query.prepare(queryStr);
    bool success = query.exec();
    if (!success) {
        qDebug() << "Query failed: " << query.lastError().text();
    } else {
        qDebug() << "Query succeeded!";
    }
    listuser.clear();
    while (query.next()) {
        QVariantMap roomData;
        roomData["ACC_NUM"] = query.value(0).toInt();
        roomData["ACC_NAME"] = query.value(1).toString();
        roomData["ACC_DATE"] = query.value(4).toString();

        double Money = query.value(3).toDouble();
        QLocale locale = QLocale::system();
        QString formattedMoney = locale.toString(Money, 'f', 2);
        roomData["ACC_MONEY"] = formattedMoney;
        listuser.append(roomData);
    }
}

void AdminUser::updateData(int pin, double money)
{

}

QString AdminUser::displayInfor()
{
    QString number = QString::number(accNum);
    QString infor_user = "Account Number: " + number +
                         "\nName: " + accName;
    return infor_user;
}

QString AdminUser::acction_Menu(int type, double data, int data2)
{
    QString status;
    switch(type){
    case 1:
    {
        QSqlQuery deleteQuery;
        deleteQuery.prepare("DELETE FROM user WHERE ACC_NUM = :acc_num AND ACC_PIN = :acc_pin");
        deleteQuery.bindValue(":acc_num", data);
        deleteQuery.bindValue(":acc_pin", data2);

        if (!deleteQuery.exec()) {
            qDebug() << "Error deleting account: " << deleteQuery.lastError().text();
        } else {
            int rowsAffected = deleteQuery.numRowsAffected();
            if (rowsAffected > 0) {
                status = "Account deleted successfully.";
            } else {
                QString number = QString::number(data);
                status = "No account found to delete with account: "+ number;
            }
        }
    }
    break;
    case 2:
    {
        QSqlQuery checkQuery;
        checkQuery.prepare("SELECT COUNT(*) FROM user WHERE ACC_NUM = :acc_num");
        checkQuery.bindValue(":acc_num", data);

        if (!checkQuery.exec()) {
            qDebug() << "Failed to execute check query:" << checkQuery.lastError().text();
            return "ERROR CHECKING ACCOUNT NUMBER";
        }

        checkQuery.next();
        int count = checkQuery.value(0).toInt();

        if (count > 0) {
            QSqlQuery readQuery;
            readQuery.prepare("SELECT ACC_NAME, ACC_MONEY, ACC_DATE FROM user WHERE ACC_NUM = :acc_num");
            readQuery.bindValue(":acc_num", data);

            if (!readQuery.exec()) {
                qDebug() << "Failed to execute read query:" << readQuery.lastError().text();
                return "ERROR READING ACCOUNT DATA";
            }

            if (readQuery.next()) {
                QString number = QString::number(data);
                QString acc_name = readQuery.value(0).toString();

                double acc_money = readQuery.value(1).toDouble();

                QLocale locale = QLocale::system();
                QString formattedMoney = locale.toString(acc_money, 'f', 2);

                QString acc_date = readQuery.value(2).toString();

                status = QString("Account: "+number+
                                 "\nName: "+acc_name+
                                 "\nMoney: "+formattedMoney+
                                 "\nDate: "+acc_date);
            } else {
                status = "ACCOUNT EXISTS, BUT COULD NOT RETRIEVE DETAILS.";
            }
            return status;
        }

    }
    break;
    case 3:
    {
        money+=data;
        QLocale locale = QLocale::system();
        QString formattedMoney = locale.toString(money, 'f', 2);
        status = "SEND MONEY SUCCESSFUL: "+ formattedMoney;
        updateData(0,money);

        QDateTime current = QDateTime::currentDateTime();
        QString currentDateTime = current.toString("yyyy-MM-dd HH:mm:ss");
        updateHistory(accNum, currentDateTime,"Send Money", data);
    }
    break;
    }
    return status;
}

QString AdminUser::acction_Menu(int type, int data, int data2, const QString &data3)
{
    QString status;
    if(type == 0){
        QDateTime current = QDateTime::currentDateTime();
        QString currentDateTime = current.toString("yyyy-MM-dd HH:mm:ss");

        QSqlQuery checkQuery;
        checkQuery.prepare("SELECT COUNT(*) FROM user WHERE ACC_NUM = :acc_num");
        checkQuery.bindValue(":acc_num", data);

        if (!checkQuery.exec()) {
            qDebug() << "Failed to execute check query:" << checkQuery.lastError().text();
            return "ERROR CHECKING ACCOUNT NUMBER";
        }

        checkQuery.next();
        int count = checkQuery.value(0).toInt();

        if (count > 0) {
            return "PLEASE USE A DIFFERENT NUMBER.";
        }

        QSqlQuery query;
        query.prepare("INSERT INTO user (ACC_NUM, ACC_NAME, ACC_PIN, ACC_DATE) "
                      "VALUES (:acc_num, :acc_name, :acc_pin, :acc_date)");
        query.bindValue(":acc_num", data);
        query.bindValue(":acc_name", data3);
        query.bindValue(":acc_pin", data2);
        query.bindValue(":acc_date", currentDateTime);

        if (!query.exec()) {
            qDebug() << "Failed to insert data into HISTORY:" << query.lastError().text();
        } else {
            qDebug() << "Data inserted successfully!";
        }
        status = "USER ADDED SUCCESSFULLY";
    }
    return status;
}

QVariantList AdminUser::readHistory(int acc_num,int data)
{
    QSqlQuery query;

    if(acc_num == 111) {
        readData(acc_num,data);
        return listuser;
    }else{

        QString order = (data == 1)?"DESC":"ASC";
        if(acc_num != 0){
            QString queryStr = "SELECT * FROM HISTORY WHERE ACC_NUM = :accNum ORDER BY ACC_DATE " + order;
            query.bindValue(":accNum", acc_num);
            query.prepare(queryStr);
        }else{
            QString queryStr = "SELECT * FROM HISTORY ORDER BY ACC_DATE " + order;
            query.prepare(queryStr);
        }
        bool success = query.exec();
        if (!success) {
            qDebug() << "Query failed: " << query.lastError().text();
            return QVariantList();
        } else {
            qDebug() << "Query succeeded!";
        }

        QVariantList his;
        while (query.next()) {
            QVariantMap roomData;

            roomData["ACC_NUM"] = query.value(0).toInt();
            roomData["ACC_DATE"] = query.value(1).toString();
            roomData["ACC_TYPE"] = query.value(2).toString();

            double Money = query.value(3).toDouble();
            QLocale locale = QLocale::system();
            QString formattedMoney = locale.toString(Money, 'f', 2);
            roomData["ACC_MONEY"] = formattedMoney;
            his.append(roomData);
        }
         return his;
    }

}

void AdminUser::updateHistory(int acc_num,const QString &acc_date,const QString& acc_type, double money)
{

}
