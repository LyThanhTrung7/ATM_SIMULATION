#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "actionatm.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    ActionATM ATM;
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    QQmlContext * context (engine.rootContext());
    context->setContextProperty("ATM",&ATM);

    QSqlDatabase db;
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("ACCOUNT.db");
    // Mở cơ sở dữ liệu
    if (!db.open()) {
        qDebug() << "Database not opened: " << db.lastError().text();
    }
    return app.exec();
}
