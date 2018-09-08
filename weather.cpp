#include "weather.h"

weatherInfo::weatherInfo(void)
{
    connect(&manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(onGetWeather(QNetworkReply*)));
}

void weatherInfo::fetchWeather(const QString &cityName)
{
    //Actually, we can set cnt number to show how many citys wo want to get, but it shoud not go beyond 16.
    //manager.get(QNetworkRequest(QUrl(QString("http://api.openweathermap.org/data/2.5/forecast?q=%1&mode=json&units=metric&lang=zh_cn&cnt=4&APPID=6b55db98c0b1a112f1f98bd93e4726ac").arg(cityName))));

    manager.get(QNetworkRequest(QUrl(QString("https://free-api.heweather.com/v5/weather?city=%1&key=b598fb83e6674d66a99576fa4897efd1").arg(cityName))));

}

void weatherInfo::startInquiry(const QString &cityName)
{
    this->fetchWeather(cityName);
}


void weatherInfo::onGetWeather(QNetworkReply *reply)
{
    QJsonObject data = QJsonDocument::fromJson(reply->readAll()).object();

    //we just use the value that can't directly read from json, but it should exist.
    if(!data.contains("status"))
    {
        emit finished("OK", data);
    }
    else
    {
        qDebug("Get weather fail");
        emit finished("Get weather fail: " +
                      data.value("status").toString(), QJsonObject());
    }

}

