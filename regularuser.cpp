#include "regularuser.h"
#include <QVariant>
#include <QLocale>
#include <QDateTime>
RegularUser::RegularUser() {

}

bool RegularUser::checkUser(int acc_num, int pin)
{
    if(acc_num == accNum && pin == pinCode) return true;
    else return false;
}

void RegularUser::readData(int acc_num, int pin)
{
    QSqlQuery query;

    bool success = query.exec("SELECT ACC_NUM, ACC_NAME, ACC_PIN, ACC_MONEY, ACC_DATE FROM user");

    if (!success) {
        qDebug() << "Query failed: " << query.lastError().text();
    } else {
        qDebug() << "Query succeeded!";
    }
    while (query.next()) {
        int accNumFromDb = query.value(0).toInt();
        int pinCodeFromDb = query.value(2).toInt();

        if (acc_num == accNumFromDb && pin == pinCodeFromDb) {
            accNum = accNumFromDb;
            accName = query.value(1).toString();
            pinCode = pinCodeFromDb;
            money = query.value(3).toDouble();
            date = query.value(4).toString();
            break;
        }
    }
}

void RegularUser::updateData(int pin, double Money)  {
    QSqlQuery query;
    query.prepare("UPDATE user SET ACC_PIN = :pin, ACC_MONEY = :money WHERE ACC_NUM = :accNum");

    if (pin != 0) {
        query.bindValue(":pin", pin);
    }else {
        query.bindValue(":pin", pinCode);
    }

    if (Money != 0) {
        query.bindValue(":money", Money);
    }else {
        query.bindValue(":money", money);
    }
    query.bindValue(":accNum", accNum);

    if (!query.exec()) {
        qDebug() << "Failed to update data: " << query.lastError().text();
    }
}


QString RegularUser::displayInfor()
{
    QString number = QString::number(accNum);
    QLocale locale = QLocale::system();
    QString formattedMoney = locale.toString(money, 'f', 2);
    QString infor_user = "Account Number: " + number +
                         "\nName: " + accName +
                         "\nMoney: "+ formattedMoney +
                         "\nDate: "+ date ;
    return infor_user;
}

QString RegularUser::acction_Menu(int type, double data, int data2)
{
    QString status;
    switch(type){
    case 0:
        if(money > data){
            money-=data;
            QLocale locale = QLocale::system();
            QString formattedMoney = locale.toString(money, 'f', 2);
            status = "WITH DRAW SUCCESSFUL: "+ formattedMoney;
            updateData(0,money);

            QDateTime current = QDateTime::currentDateTime();
            QString currentDateTime = current.toString("yyyy-MM-dd HH:mm:ss");
            updateHistory(accNum, currentDateTime,"Cash money", data);

        }else status = "WITH DRAW FAIL!!! - INSUFFICIENT BALANCE ";
        break;
    case 1:
        if(data2 == pinCode){
            pinCode = data;
            updateData(pinCode,0);
            status = "CHANGED PIN CODE SUCCESSFUL ";
        }else status = "CHANGED PIN CODE FAIL!!! - RE-ENTER OLD PIN ";
        break;
    case 2:
        if(money > data){
            money-=data;
            updateData(0,money);
            QLocale locale = QLocale::system();
            QString formattedMoney = locale.toString(money, 'f', 2);
            status = "TRASFER SUCCESSFUL: "+ formattedMoney;

            QSqlQuery query;
            query.prepare("UPDATE user SET ACC_MONEY = ACC_MONEY + :money WHERE ACC_NUM = :accNum");
            query.bindValue(":money", data);

            query.bindValue(":accNum", data2);

            if (query.exec()) {
                status = "TRANSFER SUCCESSFUL ";
            } else {
                status = "TRANSFER FAIL!!! - " + query.lastError().text();
            }

            QDateTime current = QDateTime::currentDateTime();
            QString currentDateTime = current.toString("yyyy-MM-dd HH:mm:ss");
            QString number = QString::number(data2);
            updateHistory(accNum, currentDateTime,"Transfer("+number+")", data);

        }else status = "TRANSFER FAIL!!! - INSUFFICIENT BALANCE ";
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

QString RegularUser::acction_Menu(int type, int data, int data2, const QString &data3)
{

}



QVariantList RegularUser::readHistory(int acc_num,int data)
{
    QSqlQuery query;
    QString order = (data == 1)?"DESC":"ASC";
    QString queryStr = "SELECT * FROM HISTORY WHERE ACC_NUM = :accNum ORDER BY ACC_DATE " + order;
    query.prepare(queryStr);
    query.bindValue(":accNum", acc_num);

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

void RegularUser::updateHistory(int acc_num,const QString &acc_date,const QString &acc_type, double money)
{
    QSqlQuery query;
    query.prepare("INSERT INTO HISTORY (ACC_NUM, ACC_DATE, ACC_TYPE, ACC_MONEY) "
                  "VALUES (:acc_num, :acc_date, :acc_type, :money)");

    query.bindValue(":acc_num", acc_num);
    query.bindValue(":acc_date", acc_date);
    query.bindValue(":acc_type", acc_type);
    query.bindValue(":money", money);

    if (!query.exec()) {
        qDebug() << "Failed to insert data into HISTORY:" << query.lastError().text();
    } else {
        qDebug() << "Data inserted successfully!";
    }
}
