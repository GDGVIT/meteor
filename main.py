import sys
import os
from PySide2 import QtCore, QtGui, QtQuick, QtQml
from qmlModels import window
from qmlModels import chat_model
from qmlModels import contact_model

import utils
from utils import getContactsFromDB


backendWindow = window.BackendWindow()
chatModelProvider = chat_model.ChatModelProvider([])
contactModelProvider = contact_model.ContactModelProvider([])

currContacts = []

class MainBackend(QtCore.QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.engine = None
    
    @QtCore.Slot(str)
    def search(self, data):
        filtered_contacts = []
        if data == "":
            contactModelProvider.model.reset(currContacts)
            return
        for contact in currContacts:
            if data.lower() in contact["name"].lower():
                filtered_contacts.append(contact)
        contactModelProvider.model.reset(filtered_contacts)
    
    @QtCore.Slot(str)
    def loadChat(self, DHTId):
        chatModelProvider.model.resetView([])
        utils.loadChatFromDB(DHTId, chatModelProvider)
        
    
    @QtCore.Slot()
    def openAddContactsWindow(self):
        engine.load(QtCore.QUrl.fromLocalFile(os.path.join(os.path.dirname(__file__), "qml/addContacts.qml")))

    @QtCore.Slot(str, str)
    def addContact(self, dhtId, name):
        utils.addContactToDB(dhtId, name)
        loadContacts()
    
    @QtCore.Slot(str, str)
    def sendMessage(self, dhtId, message):
        dc_message = {"name": "x", "bubbleData": message, "isRightBubble": 1, "applyBubbleSpace": True, "renderBubbleOutgrowth": True}
        utils.addChatToDB(dhtId, dc_message)
        chatModelProvider.model.appendRow(dc_message)
    
    def receiveMessage(self, dhtId, message):
        dc_message = {"name": "x", "bubbleData": message, "isRightBubble": 0, "applyBubbleSpace": True, "renderBubbleOutgrowth": True}
        utils.addChatToDB(dhtId, dc_message)
        chatModelProvider.model.appendRow(dc_message)

mainBackend = MainBackend()

def onClose():
    print("Closing backend..")

def qtBind(engine):
    backendWindow.onWindowClose = onClose
    mainBackend.engine = engine

    engine.rootContext().setContextProperty("backendWindow", backendWindow)
    engine.rootContext().setContextProperty("chatModelProvider", chatModelProvider)
    engine.rootContext().setContextProperty("contactModelProvider", contactModelProvider)
    engine.rootContext().setContextProperty("mainBackend", mainBackend)

    directory = os.path.dirname(os.path.abspath(__file__))
    engine.load(QtCore.QUrl.fromLocalFile(os.path.join(directory, 'qml/main.qml')))
    if not engine.rootObjects():
        print("Error while enumerating root objects..")

def loadContacts():
    global currContacts
    currContacts = getContactsFromDB()
    contactModelProvider.model.reset([])
    for contact in currContacts:
        contactModelProvider.model.appendRow(contact)


if __name__ == '__main__':
    app = QtGui.QGuiApplication(sys.argv)
    engine = QtQml.QQmlApplicationEngine()
    qtBind(engine)
    loadContacts()
    
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

