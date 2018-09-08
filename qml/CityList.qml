import QtQuick 2.0
import VPlayApps 1.0



NavigationStack{
    id:stac
    property var choose: 0
    ListPage {
        id: page

        title: qsTr("City")
        leftBarItem:IconButtonBarItem{
            icon: IconType.close
            onClicked: {var object=Qt.createComponent("MainPage.qml").createObject(app)
                WeatherInfo.startInquiry(a)

            }
        }



        rightBarItem:IconButtonBarItem {
            icon: IconType.plus
            onClicked: {
                InputDialog.inputTextSingleLine(page,qsTr("New city"), qsTr("Enter text..."),
                                                function(ok, text) {
                                                    page.model.push({ text:text })
                                                    arryEmpty(arry,i,text)
                                                    saveCity(arry,a)
                                                    page.modelChanged()

                                                })


            }
        }

        Component.onCompleted: {
            var n = 0
            while(arry[n]){
                page.model.push({text:arry[n].toString()})
                n++
            }
            page.modelChanged()
        }

        model: []

        delegate: SwipeOptionsContainer {
            id: container

            rightOption: AppButton {
                text: qsTr("Delete")
                onClicked: {
                    container.hideOptions()
                    arry.splice(index,1)
                    page.model.splice(index, 1)
                    saveCity(arry)
                    page.modelChanged()

                }
            }

            SimpleRow {
                onSelected: {
                    //                    i = index
                    var object=Qt.createComponent("MainPage.qml").createObject(app);
                    WeatherInfo.startInquiry(page.model[index].text)
                    a = page.model[index].text
                    console.log("123456" + a)
                    //                    console.log("123123" + a)
                    //                    saveCity(arry,a)

                }
            }
        }
    }
}


