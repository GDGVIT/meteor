from PySide2 import QtQuick, QtCore, QtGui, QtQml

class ListViewContactModel(QtCore.QAbstractListModel):
    PhotoUrlRole = QtCore.Qt.UserRole + 1000
    NameRole = QtCore.Qt.UserRole + 1001
    UnreadMessageCountRole = QtCore.Qt.UserRole + 1002

    def __init__(self, contacts, parent=None):
        super(ListViewContactModel, self).__init__(parent)
        self._contacts = contacts

    def rowCount(self, parent=QtCore.QModelIndex()):
        if parent.isValid():
            return 0
        return len(self._contacts)

    def data(self, index, role=QtCore.Qt.DisplayRole):
        if 0 <= index.row() < self.rowCount() and index.isValid():
            item = self._contacts[index.row()]
            if role == ListViewContactModel.NameRole:
                return item["name"]
            elif role == ListViewContactModel.PhotoUrlRole:
                return item["photo_url"]
            elif role == ListViewContactModel.UnreadMessageCountRole:
                return item["unread_message_count"]

    def roleNames(self):
        roles = {}
        roles[ListViewContactModel.NameRole] = b"name"
        roles[ListViewContactModel.PhotoUrlRole] = b"photo_url"
        roles[ListViewContactModel.UnreadMessageCountRole] = b"unread_message_count"
        return roles

    def appendRow(self, row):
        self.beginInsertRows(QtCore.QModelIndex(), self.rowCount(), self.rowCount())
        self._contacts.append(row)
        self.endInsertRows()

class ListViewContactModelProvider(QtCore.QObject):
    def __init__(self, contacts, parent=None):
        super(ListViewContactModelProvider, self).__init__(parent)
        self._model = ListViewContactModel(contacts)

    @QtCore.Property(QtCore.QObject, constant=True)
    def model(self):
        return self._model




