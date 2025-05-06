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
        //color: "red"

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

            onNewViewRequested: function(request) {
                        // Handle the new view request
                        if (request.userInitiated) {
                            // For tabs (same window)
                            var newTab = tabView.createNewTab(request.requestedUrl)
                            request.openIn(newTab.webView)
                        } else {
                            // For popups (new window)
                            var newWindow = createPopupWindow(request.requestedUrl)
                            request.openIn(newWindow.webView)
                        }
                    }
            url: "http://www.google.com"
        }
    }


}
