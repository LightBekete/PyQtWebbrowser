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

    WebEngineView {
            id: webView
            anchors.fill: parent
            url: "https://www.google.com"
        }

}
