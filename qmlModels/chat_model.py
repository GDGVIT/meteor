from PySide2 import QtCore
from PySide2.QtCore import Qt

class ChatModel(QtCore.QAbstractListModel):
    NameRole = Qt.UserRole + 1000
    DataRole = Qt.UserRole + 1001
    BubbleTypeRole = Qt.UserRole + 1002
    SpaceRole = Qt.UserRole + 1003
    RenderOutgrowthRole = Qt.UserRole + 1004

    def __init__(self, entries, parent=None):
        super(ChatModel, self).__init__(parent)
        self._model = entries

    def rowCount(self, parent=QtCore.QModelIndex()):
        if parent.isValid(): return 0
        return len(self._model)

    def data(self, index, role=Qt.DisplayRole):
        if 0 <= index.row() < self.rowCount() and index.isValid():
            item = self._model[index.row()]
            if role == ChatModel.NameRole:
                return item["name"]
            elif role == ChatModel.DataRole:
                return item["bubbleData"]
            elif role == ChatModel.BubbleTypeRole:
                return item["isRightBubble"]
            elif role == ChatModel.SpaceRole:
                return item["applyBubbleSpace"]
            elif role == ChatModel.RenderOutgrowthRole:
                return item["renderBubbleOutgrowth"]

    def get(self, index):
        return self._model[index]

    def roleNames(self):
        return {ChatModel.NameRole: b"name", ChatModel.DataRole: b"bubbleData", ChatModel.BubbleTypeRole: b"isRightBubble",
           ChatModel.SpaceRole: b"applyBubbleSpace", ChatModel.RenderOutgrowthRole: b"renderBubbleOutgrowth"}

    def resetView(self, new_model=None):
        self.beginResetModel()
        if new_model != None:
            self._model = new_model
        self.endResetModel()


    def appendRow(self, chat_row):
        self.beginInsertRows(QtCore.QModelIndex(), self.rowCount(), self.rowCount())
        if self.rowCount() == 0:
            chat_row["renderBubbleOutgrowth"] = True
            chat_row["applyBubbleSpace"] = True
        else:
            if self._model[self.rowCount() - 1]["isRightBubble"] == chat_row["isRightBubble"]:
                self._model[self.rowCount() - 1]["applyBubbleSpace"] = False
                chat_row["renderBubbleOutgrowth"] = False
            else:
                self._model[self.rowCount() - 1]["applyBubbleSpace"] = True
                chat_row["renderBubbleOutgrowth"] = True


        self._model.append(chat_row)
        self.endInsertRows()
        self.resetView()
    




class ChatModelProvider(QtCore.QObject):
    def __init__(self, model, parent=None):
        super(ChatModelProvider, self).__init__(parent)
        self._model = ChatModel(model)

    @QtCore.Property(QtCore.QObject, constant=True)
    def model(self):
        return self._model