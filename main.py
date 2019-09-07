import sys
import os
from PySide2 import QtCore, QtGui, QtQuick, QtQml
from qmlModels import listview_contact_model
from qmlModels import window

backendWindow = window.BackendWindow()


def onClose():
    print("Closing backend..")


backendWindow.onWindowClose = onClose

if __name__ == '__main__':
    app = QtGui.QGuiApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()

    contacts = [{"name": "Vishaal", "photo_url": "photos/vishaal.jpg", "unread_message_count": "20"}]

    listViewContactModelProvider = listview_contact_model.ListViewContactModelProvider(contacts)

    backendWindow.onWindowClose = onClose

    engine.rootContext().setContextProperty("listViewContactModelProvider", listViewContactModelProvider)
    engine.rootContext().setContextProperty("backendWindow", backendWindow)

    directory = os.path.dirname(os.path.abspath(__file__))
    engine.load(QtCore.QUrl.fromLocalFile(os.path.join(directory, 'qml/main.qml')))

    if not engine.rootObjects():
        print("Error while enumerating root objects..")
    app.exec_()