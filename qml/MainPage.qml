import QtQuick 2.0
import VPlayApps 1.0


Page{
    id:mainPage
    anchors.fill: parent

    Column {

        anchors.horizontalCenter: parent.horizontalCenter
        spacing: dp(10)

        // Current time
        AppText {
            id: timeLabel
            color: "white"
            font.pixelSize: sp(14)
            anchors.horizontalCenter: parent.horizontalCenter

            Timer {
                running: true
                interval: 1000 * 30
                triggeredOnStart: true
                repeat: true
                onTriggered: {
                    timeLabel.text = new Date().toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
                }
            }
        }
    }

    AppImage {
        id: image
        source : "../assets/0.png"
        smooth: true
        anchors.fill: parent
    }

    AppFlickable {
        id:scroll
        anchors.fill: parent
        contentHeight: column.height + weatherIcon.height + middleRow.height + bottomGrid.height + line.height + details.height + 350

        AppImage{
            id:weatherIcon
            Connections{
                target: WeatherInfo
                onFinished:{
                    weatherIcon.source ="../assets/" + weatherData["HeWeather5"][0]["now"]["cond"]["code"] + "icon.png";
                }
            }
            anchors.fill: parent.Center
            anchors.top: column.bottom
            anchors.margins: dp(10)
            //            y:dp(150)
            anchors.horizontalCenter:parent.horizontalCenter
            width: dp(120)
            height: dp(100)
        }
        Connections{
            target: WeatherInfo;
            onFinished:{
                if(message == "OK")
                {
                    labelName.text =weatherData["HeWeather5"][0]["basic"]["city"]+" |";
                    tem.text =weatherData["HeWeather5"][0]["now"]["tmp"]+"℃";
                    dam.text =weatherData["HeWeather5"][0]["now"]["hum"]
                    windSpeed.text = weatherData["HeWeather5"][0]["now"]["wind"]["spd"]
                    windDir.text = weatherData["HeWeather5"][0]["now"]["wind"]["dir"]
                    damLabel.text = "湿度"
                    airLaber.text = "空气质量"
                    air.text = weatherData["HeWeather5"][0]["aqi"]["city"]["qlty"]
                    symbol1.text = symbol2.text = "|"
                    var c = weatherData["HeWeather5"][0]["now"]["cond"]["code"];
                    w = getWeatherCode(c);
                    //console.log("that that that is " + w)
                    image.source ="../assets/" + w + ".png";
                }
            }
        }

        Column{
            id:column
            y:dp(30)
            anchors.left: parent.left
            anchors.leftMargin: 30
            //温度
            AppText{
                font.pixelSize: sp(50)
                id:tem
                text:"waiting..."
                color: "white"
            }
            Row{
                spacing: dp(5)
                //城市
                AppText {
                    font.pixelSize:sp(25)
                    id: labelName
                    text: qsTr("wait...")
                    color: "white"

                }
                //天气
                AppText{
                    font.pixelSize:sp(25)
                    id:weather
                    text:"waiting..."
                    color: "white"
                    Connections{
                        target: WeatherInfo
                        onFinished:{
                            weather.text =weatherData["HeWeather5"][0]["now"]["cond"]["txt"];
                        }
                    }
                }
            }
        }
        Component.onCompleted: {
            n = getDate(n)
            importCity(arry,a)
            WeatherInfo.startInquiry(arry[0])
        }
        Row{
            id:middleRow
            spacing: dp(23)
            //                y:dp(58)
            anchors.bottom:bottomGrid.top
            anchors.margins: 25
            anchors.horizontalCenter: parent.horizontalCenter
            //风
            Column{
                AppText{
                    id:windDir
                    text:""
                    font.pixelSize: sp(19)
                    color:"white"
                }

                AppText{
                    id:windSpeed
                    text: ""
                    font.pixelSize: sp(15)
                    //                    x:Math.min(parent.width - dp(170), dp(450))
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Column{
                AppText{
                    id:symbol1
                    text: ""
                    color: "white"
                    font.pixelSize: sp(35)

                }
            }
            //湿度
            Column{
                AppText{
                    id:damLabel
                    text:""
                    font.pixelSize: sp(19)
                    color: "white"
                }

                AppText{
                    id:dam
                    text:""
                    font.pixelSize: sp(15)
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Column{
                AppText {
                    id:symbol2
                    text: ""
                    color: "white"
                    font.pixelSize: sp(35)
                }
            }

            //空气质量
            Column{
                AppText{
                    id:airLaber
                    text:""
                    font.pixelSize: sp(19)
                    color: "white"
                }

                AppText{
                    anchors.horizontalCenter: parent.horizontalCenter
                    id:air
                    text:""
                    font.pixelSize: sp(15)
                    color:"white"
                }
            }
        }


        Grid{
            id:bottomGrid
            rows: 3
            spacing: dp(2)
            height: Math.min(parent.width - dp(200), dp(400))
            y:dp(300)
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater{
                model: [
                    {day:"今天",i : 0},
                    {day:getCurDate(n+1),i : 1},
                    {day:getCurDate(n+2),i : 2},
                ]

                Row{
                    //                    width:bottomGrid.width
                    spacing: dp(60)
                    height: bottomGrid.height/3
                    AppText {
                        id:day
                        text:""
                        font.pixelSize: sp(17)
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    AppImage{
                        id:gridImage
                        Connections{
                            target: WeatherInfo
                            onFinished:{
                                var n = modelData.i
                                gridImage.source ="../assets/" + weatherData["HeWeather5"][0]["daily_forecast"][n]["cond"]["code_d"] + ".png";
                                day.text = modelData.day
                            }
                        }
                        height: dp(35)
                        width: dp(35)
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    AppText{
                        id:gridText
                        Connections{
                            target: WeatherInfo
                            onFinished:{
                                var n = modelData.i
                                gridText.text = (weatherData["HeWeather5"][0]["daily_forecast"][n]["tmp"]["max"])+"℃" + "/" +(weatherData["HeWeather5"][0]["daily_forecast"][n]["tmp"]["min"])+"℃"
                            }
                        }
                        color: "white"
                        font.pixelSize: sp(17)
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }  //Grid

        Rectangle{
            id:line
            width: mainPage.width - dp(10)
            height: 1
            color: "gray"
            anchors.top: bottomGrid.bottom
            anchors.topMargin: dp(10)
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row{
            id:details
            spacing: 4
            anchors.top:line.bottom
            anchors.topMargin: dp(10)
            anchors.horizontalCenter: parent.horizontalCenter

            Column{
                id:explain
                spacing: 2
                anchors.right:parent.horizontalCenter
                anchors.rightMargin: dp(10)

                Connections{
                    target: WeatherInfo
                    onFinished:{
                        sunrise.text = "日出："
                        sunset.text = "日落："
                        rainfallprobabillty.text ="降雨概率："
                        rainfall.text ="降雨量："
                        aqi.text ="空气质量指数："
                        pm25.text ="PM2.5："
                        pressure.text ="气压："
                        conspicurity.text ="能见度："
                    }
                }

                AppText{
                    id: sunrise
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: sunset
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: rainfallprobabillty
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: rainfall
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: aqi
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: pm25
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: pressure
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: conspicurity
                    anchors.right: explain.right
                    font.pixelSize: sp(14)
                    color: "white"
                }
            }

            Column{
                id: data
                spacing: 2
                anchors.left:parent.horizontalCenter
                anchors.leftMargin: dp(10)

                Connections{
                    target: WeatherInfo
                    onFinished:{
                        sunrisedata.text = weatherData["HeWeather5"][0]["daily_forecast"][0]["astro"]["sr"]
                        sunsetdata.text = weatherData["HeWeather5"][0]["daily_forecast"][0]["astro"]["ss"]
                        rainfallprobabilltydata.text = weatherData["HeWeather5"][0]["daily_forecast"][0]["pop"]
                        rainfalldata.text = (weatherData["HeWeather5"][0]["daily_forecast"][0]["pcpn"])+"毫米"
                        aqidata.text = weatherData["HeWeather5"][0]["aqi"]["city"]["aqi"]
                        pm25data.text = weatherData["HeWeather5"][0]["aqi"]["city"]["pm25"]
                        pressuredata.text = (weatherData["HeWeather5"][0]["daily_forecast"][0]["pres"])+"百帕"
                        conspicuritydata.text = (weatherData["HeWeather5"][0]["daily_forecast"][0]["vis"])+"公里"
                    }
                }
                AppText{
                    id: sunrisedata
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: sunsetdata
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: rainfallprobabilltydata
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: rainfalldata
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: aqidata
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: pm25data
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: pressuredata
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
                AppText{
                    id: conspicuritydata
                    text: "..."
                    font.pixelSize: sp(14)
                    color: "white"
                }
            }

        }

        Rectangle{
            id:linetwo
            width: mainPage.width - dp(10)
            height: 1
            color: "gray"
            anchors.bottom: sourse.top
            //           anchors.bottomMargin: dp(10)
            anchors.horizontalCenter: parent.horizontalCenter
        }
        AppText{
            id:sourse
            text:"数据来源：和风天气API"
            font.pixelSize: sp(7)
            color: "gray"
            anchors.bottom:  parent.bottom
            anchors.bottomMargin: dp(10)
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }//Flickable

    SearchBar{
        id:search
        icon:IconType.search
        barBackgroundColor:"transparent"
        inputBackgroundColor: "transparent"
        placeHolderText: "请输入城市名"
        onAccepted:{
            WeatherInfo.startInquiry(search.text.toString())
            a = search.text.toString()
        }
    }

    IconButton{
        icon: IconType.plus
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        y:dp(1)
        onClicked:{var object=Qt.createComponent("CityList.qml").createObject(app)
            }
    }

    IconButton{
        icon: IconType.list
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        y:dp(1)
        //onClicked:{var object=Qt.createComponent("CityList.qml").createObject(app)}
    }

    PageControl{
        id:pageControl
        pages: imgSwipeView.count
        pageIcons: ({
          0: IconType.home
                    })
        clickableIndicator: true
        spacing: dp(10)
        anchors.top: parent.top
        anchors.bottomMargin: dp(15)
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
