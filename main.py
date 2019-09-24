import sys
import os
from PySide2 import QtCore, QtGui, QtQuick, QtQml
from qmlModels import window
from qmlModels import chat_model
from qmlModels import contact_model

backendWindow = window.BackendWindow()
chatModelProvider = chat_model.ChatModelProvider([])
contactModelProvider = contact_model.ContactModelProvider([])

def onClose():
    print("Closing backend..")

def qtBind(engine):
    backendWindow.onWindowClose = onClose

    engine.rootContext().setContextProperty("backendWindow", backendWindow)
    engine.rootContext().setContextProperty("chatModelProvider", chatModelProvider)
    engine.rootContext().setContextProperty("contactModelProvider", contactModelProvider)

    directory = os.path.dirname(os.path.abspath(__file__))
    engine.load(QtCore.QUrl.fromLocalFile(os.path.join(directory, 'qml/main.qml')))
    if not engine.rootObjects():
        print("Error while enumerating root objects..")


if __name__ == '__main__':
    app = QtGui.QGuiApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()

    qtBind(engine)

    chatModelProvider.model.appendRow({'name': 'x', 'isRightBubble': True, 'bubbleData': 'Hello there !'})
    contactModelProvider.model.appendRow({'name': 'Vishaal Selvaraj',
                                          'imageUrl': 'file:///F:/prof.jpg',
                                          'status': 0, 'msgCount': 100,
                                          'recentText': 'The Math and computer enthusiast'})
    contactModelProvider.model.appendRow({'name': 'Amogh Lele',
                                          'imageUrl': 'file:///F:/pp.jpg',
                                          'status': 1, 'msgCount': 17,
                                          'recentText': 'sphericalFlyingKat'})


    app.exec_()
'''

from proto import meteor_pb2
from proto import meteor_pb2_grpc
import grpc


def sendMessage(text_):
    with grpc.insecure_channel("localhost:9999") as channel:
        stub = meteor_pb2_grpc.MessageSenderStub(channel)
        response = stub.SendMessage(meteor_pb2.SendMessageRequest(text=text_))
        channel.close()


if __name__ == "__main__":
    sendMessage(input())

'''

