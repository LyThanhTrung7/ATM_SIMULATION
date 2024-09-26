#ifndef LOGIN_H
#define LOGIN_H
#include <QVector>
#include <QObject>
#include <QtQml>
#include <QFile>
#include <QString>
#include <QDebug>
#include <QString>


class Login : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit Login(QObject *parent = nullptr);

    Q_INVOKABLE void login_user(QString const num, int pass);
    Q_INVOKABLE void login_admin(QString const num, QString const pass);
    QString status() const;
    void set_status(const QString &newStatus);

signals:
    void status_changed();
    void login_success();
    void login_fails();

    void login_success_ad();
    void login_fails_ad();

private:
    QString m_status;
};

#endif // LOGIN_H
