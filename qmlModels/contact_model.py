from PySide2 import QtQuick, QtCore, QtGui, QtQml

class ContactModel(QtCore.QAbstractListModel):
    PhotoUrlRole = QtCore.Qt.UserRole + 1000
    NameRole = QtCore.Qt.UserRole + 1001
    UnreadMessageCountRole = QtCore.Qt.UserRole + 1002
    RecentTextRole = QtCore.Qt.UserRole + 1003
    StatusRole = QtCore.Qt.UserRole + 1004
    DHTIdRole = QtCore.Qt.UserRole + 1005

    def __init__(self, contacts, parent=None):
        super(ContactModel, self).__init__(parent)
        self._contacts = contacts

    def rowCount(self, parent=QtCore.QModelIndex()):
        if parent.isValid():
            return 0
        return len(self._contacts)

    def data(self, index, role=QtCore.Qt.DisplayRole):
        if 0 <= index.row() < self.rowCount() and index.isValid():
            item = self._contacts[index.row()]
            if role == ContactModel.NameRole:
                return item["name"]
            elif role == ContactModel.PhotoUrlRole:
                return item["imageUrl"]
            elif role == ContactModel.UnreadMessageCountRole:
                return item["msgCount"]
            elif role == ContactModel.StatusRole:
                return item["status"]
            elif role == ContactModel.RecentTextRole:
                return item["recentText"]
            elif role == ContactModel.DHTIdRole:
                return item["dhtId"]

    def roleNames(self):
        roles = {}
        roles[ContactModel.NameRole] = b"name"
        roles[ContactModel.PhotoUrlRole] = b"imageUrl"
        roles[ContactModel.UnreadMessageCountRole] = b"msgCount"
        roles[ContactModel.RecentTextRole] = b"recentText"
        roles[ContactModel.StatusRole] = b"status"
        roles[ContactModel.DHTIdRole] = b"dhtId"
        return roles

    def appendRow(self, row):
        self.beginInsertRows(QtCore.QModelIndex(), self.rowCount(), self.rowCount())
        self._contacts.append(row)
        self.endInsertRows()
    
    def reset(self, new_contacts):
        self.beginResetModel()
        self._contacts = new_contacts
        self.endResetModel()

    @QtCore.Slot(int, result=str)
    def getName(self, index):
        if index not in range(0, self.rowCount()):
            return ''
        return self._contacts[index]['name']
    
    @QtCore.Slot(int, result=str)
    def getDHTId(self, index):
        if index not in range(0, self.rowCount()):
            return ''
        return self._contacts[index]['dhtId']

    @QtCore.Slot(int, result=int)
    def getStatus(self, index):
        if index not in range(0, self.rowCount()):
            return 0
        return self._contacts[index]['status']

class ContactModelProvider(QtCore.QObject):
    def __init__(self, contacts, parent=None):
        super(ContactModelProvider, self).__init__(parent)
        self._model = ContactModel(contacts)

    @QtCore.Property(QtCore.QObject, constant=True)
    def model(self):
        return self._model
