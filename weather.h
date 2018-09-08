#ifndef WEATHER_H
#define WEATHER_H

#include <QObject>
#include <QJsonObject>
#include <QJsonDocument>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class weatherInfo : public QObject
{
    Q_OBJECT

public:
//    weatherInfo() {}
    weatherInfo(void);
    void fetchWeather(const QString &cityName);


public slots:
    void startInquiry(const QString &cityName);

private slots:
    void onGetWeather(QNetworkReply *reply);

signals:
    void finished(const QString message, const QJsonObject weatherData);


private:
    QNetworkAccessManager manager;


};

#endif // WEATHER_H
