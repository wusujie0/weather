#include <QApplication>
#include <VPApplication>

#include <QQmlApplicationEngine>
#include <QtQml>
#include "weather.h"
#include <QSqlDatabase>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    VPApplication vplay;

    vplay.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("WeatherInfo", new weatherInfo);

    vplay.initialize(&engine);

    vplay.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    engine.load(QUrl(vplay.mainQmlFileName()));

    return app.exec();
}
