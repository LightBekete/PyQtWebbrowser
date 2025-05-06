// this is the qml file which contains and uses the QtWebEngine to render
// html documents from specified http urls

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebEngine 1.10

ApplicationWindow {
    id: root
    width: screen.width
    height: screen.height
    visible: true
    title: qsTr("Qt Web Broswer")

    Rectangle{
        id: searchBar
        width: parent.width
        height: 50
        radius: 20

        Row{
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                id: back
                height: 32
                width: height
                source: "broswer_assets/back.png"
                MouseArea{
                    id:backMouseArea
                    anchors.fill: parent
                    onClicked: webView.goBack()
                }
            }
            Rectangle{
                width: 1000
                height: 50
                radius: 20

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

                    if(webView.visible === false){
                        webView.url = urlPath.text
                        errorMessage.visible = false
                        webView.visible = true
                    }
                    else{
                        webView.url = urlPath.text
                        errorMessage.visible = false
                    }
                }
            }


            Image {
                id: forward
                height: 32
                width: height
                //fillMode: Image.PreserveAspectFit
                source: "broswer_assets/forward.png"
                MouseArea{
                    id:forwardMouseArea
                    anchors.fill: parent
                    onClicked: webView.goForward()
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

            //this to enabling toggle between full screen and normal or maximised view.
            // e.g fullscreen on youtube and back to initial state
            onFullScreenRequested: function(request) {
                if (request.toggleOn)
                    root.showFullScreen()
                else
                    root.showMaximized()
                request.accept()
            }
            onLoadingChanged: {
                if (loadRequest.status === WebEngineView.LoadFailedStatus ||loadRequest.status === WebEngineView.LoadStoppedStatus){
                    webView.visible = false
                    errorMessage.visible = true
                }
            }
            url: "http://localhost:8085/error.html"
        }

        Rectangle{
            id: errorMessage
            width: 200
            height: width
            anchors.centerIn: parent
            visible: false

            Column{
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: qsTr("Web page not found !! .Click the button below")
                    font.pointSize: 10
                }

                Rectangle{
                    width: 200
                    height: 50
                    radius: 10
                    Button{
                        text: "Search on Google"
                        anchors.fill: parent
                        font.pointSize: 10
                        background: Rectangle{
                            width: 200
                            height: 50
                            radius: 10
                            color: "skyblue"
                        }
                        onClicked: {
                            webView.url = "https://www.google.com"
                            webView.visible = true
                            errorMessage.visible = false
                        }
                    }
                }

            }

        }
    }


}
