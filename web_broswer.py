# This Python file loads the PyQtWeb_browser.qml and instatiates the QtWebEngine 
import sys
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWebEngine import QtWebEngine



if __name__ == "__main__":
    # possibly to handler graphics
    QGuiApplication.setAttribute(Qt.AA_ShareOpenGLContexts)
    app = QGuiApplication(sys.argv)
    
    # this line below initialises the QtWebEngine which the the PyQtWeb_browser.qml will use to load
    # the html documents
    QtWebEngine.initialize()
    
    engine = QQmlApplicationEngine()
    engine.load("PyQtWeb_browser.qml")
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
