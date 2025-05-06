// this is the qml file which contains and uses the QtWebEngine to render
// html documents from specified http urls

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebEngine 1.10

ApplicationWindow {
    width: screen.width
    height: screen.height
    visible: true
    title: qsTr("Qt Web Broswer")

    Rectangle{
        id: searchBar
        width: parent.width
        height: 50
        //color: "red"

        Row{
            spacing: 10
            anchors.fill: parent
            Rectangle{
                width: 1000
                height: 50
                radius: 10

                TextField{
                    id: urlPath
                    anchors.fill: parent
                    placeholderText: "e.g http://example.com"
                    color: "green"
                }
            }

            Button{
                text: "search"
                onClicked: {
                    webView.url = urlPath.text
                }
            }
        }
    }


    Rectangle{
        anchors{
            top: searchBar.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
       // color: "green"

        WebEngineView {
                id: webView
                anchors.fill: parent
                url: "http://www.google.com"
            }
    }


}
