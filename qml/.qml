import VPlayApps 1.0
import QtQuick 2.0


Grid{
    id:bottomGrid
    rows: 7
    spacing: 2
    height: Math.min(parent.width - dp(150), dp(450))
    y:dp(300)
    anchors.horizontalCenter: parent.horizontalCenter

    Repeater{
        model: [
            {day:"今天",i:0},
            {day:getCurDate(n+1),i:1},
            {day:getCurDate(n+2),i:2},
        ]

        Row{
            //                    width:bottomGrid.width
            spacing: dp(40)
            height: bottomGrid.height/3
            AppText {
                text: modelData.day
                font.pixelSize: sp(14)
            }

            AppImage{
                id:gridImage
                Connections{
                    target: WeatherInfo
                    onFinished:{
                        var n = modelData.i
                        gridImage.source ="../assets/" + weatherData["HeWeather5"][0]["daily_forecast"][n]["cond"]["code_d"] + ".png";
                    }
                }
                height: dp(30)
                width: dp(30)
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
                color: "lightblue"
                font.pixelSize: sp(14)
            }
        }
    }
}  //Grid
