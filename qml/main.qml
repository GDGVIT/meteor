import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0

import "Global"

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480

    minimumHeight: 480
    minimumWidth: 640

    title: "meteor"
    flags: Qt.Window | Qt.FramelessWindowHint

    color: Resources.transparentColor

    property var isFullScreen: false
    property var prevHeight: 480
    property var prevWidth: 640
    property var prevWindowX: 0
    property var prevWindowY: 0


    Rectangle {
        id: windowLayer
        height: parent.height - Resources.windowDropShadowVerticalPadding
        width: parent.width - Resources.windowDropShadowHorizontalPadding
        radius: Resources.windowCornerRadius
        color: Resources.windowBackgroundColor


        Rectangle {
            id: windowTitleBar
            width: parent.width
            height: Resources.windowTitleBarHeight
            color: Resources.windowTitleBarBackgroundColor
            radius: parent.radius

            Text {
                id: windowTitleBarText
                text: window.title
                font.pointSize: Resources.windowTitleBarFontPointSize
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: Resources.windowTitleBarForegroundColor
            }

            Rectangle {
                id: windowTitleBarCornerRadiusOffset
                //offset to hide corner radius at bottom of titlebar.
                width: parent.width
                height: parent.radius
                color: parent.color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }

            MouseArea {
                id: windowTitleBarMoveArea
                height: parent.height
                width: parent.width

                property int previousX
                property int previousY

                onPressed: {
                    previousX = mouseX
                    previousY = mouseY
                }

                onMouseXChanged: {
                    window.setX(window.x + mouseX - previousX)
                }

                onMouseYChanged: {
                    window.setY(window.y + mouseY - previousY)
                }
            }

            RoundButton {
                id: windowTitleBarCloseButton
                x: Resources.windowTitleBarButtonOffset
                anchors.verticalCenter: parent.verticalCenter
                height: windowTitleBarText.height
                radius: Resources.windowTitleBarButtonRadius
                background: Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    radius: parent.radius
                    color: Resources.windowTitleBarCloseButtonBackgroundColor
                    height: 2 * parent.radius
                    width: 2 * parent.radius
                }
                onClicked: {
                    console.log("You are closing this window.");
                    backendWindow.onClose();
                }
            }

            RoundButton {
                id: windowTitleBarRestoreButton
                x: windowTitleBarCloseButton.x + windowTitleBarCloseButton.width + Resources.windowTitleBarButtonOffset
                anchors.verticalCenter: parent.verticalCenter
                height: windowTitleBarText.height
                radius: Resources.windowTitleBarButtonRadius
                background: Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    radius: parent.radius
                    color: Resources.windowTitleBarRestoreButtonBackgroundColor
                    height: 2 * parent.radius
                    width: 2 * parent.radius
                }

                onClicked: {
                    if(isFullScreen) {
                        isFullScreen = false
                        window.height = prevHeight
                        window.width = prevWidth
                        window.x = prevWindowX
                        window.y = prevWindowY
                    } else {
                        prevHeight = window.height
                        prevWidth = window.width
                        isFullScreen = true
                        window.height = Screen.height
                        window.width = Screen.width
                        prevWindowX = window.x
                        prevWindowY = window.y
                        window.x = 0
                        window.y = 0
                    }
                }
            }

            RoundButton {
                id: windowTitleBarMinimizeButton
                x: windowTitleBarRestoreButton.x + windowTitleBarRestoreButton.width + Resources.windowTitleBarButtonOffset
                anchors.verticalCenter: parent.verticalCenter
                height: windowTitleBarText.height
                radius: Resources.windowTitleBarButtonRadius
                background: Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    radius: parent.radius
                    color: Resources.windowTitleBarMinimizeButtonBackgroundColor
                    height: 2 * parent.radius
                    width: 2 * parent.radius
                }

                onClicked: {
                    window.visibility = Window.Minimized
                }
            }

        }

        //chat layouts

        Rectangle {
            id: chatHeaderContainer
            anchors.top: windowTitleBar.bottom

            anchors.right: chatContainer.right
            height: Resources.chatHeaderContainerHeight
            width: chatContainer.width
            color: Resources.chatHeaderContainerBackgroundColor

            Text {
                id: chatHeaderText
                x: 30
                anchors.verticalCenter: parent.verticalCenter
                color: Resources.chatHeaderForegroundColor
                font.pointSize: Resources.chatHeaderFontPointSize
                text: contactModelProvider.model.getName(contactListView.currentIndex)
                rightPadding: 10
            }

            Rectangle {
                id: statusLayer
                color: Resources.transparentColor
                width: 10
                height: parent.height
                anchors.left: chatHeaderText.right
                Canvas {
                    id: statusCanvas
                    anchors.fill: parent
                    contextType: "2d"
                    antialiasing: true

                    onPaint: {
                        context.reset();

                        var cx = width / 2;
                        var cy = height / 2
                        var radius = 3;

                        context.beginPath();
                        context.moveTo(cx + radius, cy);
                        context.arc(cx,cy,radius,0,2 * Math.PI);
                        context.fillStyle = contactModelProvider.model.getStatus(contactListView.currentIndex) === 1 ? Resources.onlineMarkerColor : Resources.offlineMarkerColor;
                        if(contactListView.currentIndex != -1) {
                            context.fill();
                        }

                    }

                }

            }

            Text {
                id: chatHeaderStatusText

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: statusLayer.right
                color: Resources.chatHeaderForegroundColor
                font.pointSize: Resources.chatHeaderFontPointSize
                text: contactModelProvider.model.getStatus(contactListView.currentIndex) === 1 ? "online" : "offline"
                visible: contactListView.currentIndex !== -1
                leftPadding: 10
            }
        }

        Rectangle {
            id: chatContainer
            x: parent.width / 3

            width: 2 * parent.width / 3
            anchors.bottom: chatMessageContainer.top
            anchors.top: chatHeaderContainer.bottom

            color: Resources.chatBackgroundColor

            ListView {
                id: chatListView
                x: Resources.chatBubbleOutgrowthOffset
                y: Resources.chatBubbleVerticalPadding
                width: parent.width - Resources.chatListViewScrollBarHorizontalOffset
                height: parent.height - 2 * Resources.chatBubbleVerticalPadding
                antialiasing: true
                delegate: Resources.chatBubble

                ScrollBar.vertical: ScrollBar {
                    visible: false
                }

                clip: true
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.StopAtBounds
                interactive: true

                model: chatModelProvider.model

                onCountChanged: {
                    currentIndex = count - 1;
                }
            }
        }

        Rectangle {
            id: chatMessageContainer
            anchors.bottom: parent.bottom
            anchors.right: chatContainer.right
            height: Resources.chatMessageContainerHeight
            radius: parent.radius
            width: chatContainer.width
            color: Resources.chatMessageContainerBackgroundColor

            RoundButton {
                id: btnSend
                height: 30
                y: parent.height - height - 5
                x: parent.width - width - 5
                width: 50
                radius: 10
                background: Rectangle {
                    id: btnSend_rect
                    anchors.fill: parent
                    radius: parent.radius
                    color: "#5e5c8d"
                    border.color: "white"
                    border.width: 1

                    Text {
                        id: btnSendText
                        text: "Send"
                        anchors.centerIn: parent
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged: {
                            parent.color = containsMouse ? "#3e3c6d" : "#5e5c8d";
                        }

                        onClicked: {
                            mainBackend.sendMessage(contactModelProvider.model.getDHTId(contactListView.currentIndex), messageEdit.text)
                            messageEdit.text = ""
                        }
                    }
            }
            }

            Flickable {
                id: flick
                anchors.left: parent.left
                anchors.right: btnSend.left
                height: parent.height - parent.radius;
                contentWidth: messageEdit.paintedWidth
                contentHeight: messageEdit.paintedHeight
                clip: true
                boundsBehavior: Flickable.StopAtBounds

                function ensureVisible(r)
                {
                    if (contentX >= r.x)
                        contentX = r.x;
                    else if (contentX+width <= r.x+r.width)
                        contentX = r.x+r.width-width;
                    if (contentY >= r.y)
                        contentY = r.y;
                    else if (contentY+height <= r.y+r.height)
                        contentY = r.y+r.height-height + 10;
                }


                TextArea {
                    id: messageEdit
                    x: 5
                    y: 5

                    width: flick.width
                    color: "grey"
                    font.pointSize: Resources.contactSearchBarContainerFontPointSize
                    placeholderText: "Type something to send ..."
                    placeholderTextColor: "#b0acc7"
                    focus: true
                    wrapMode: TextEdit.Wrap

                    background: Rectangle {
                        width: parent.width
                        height: parent.height
                        color: Resources.transparentColor
                    }
                    onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)

                    property var pressCtrl: 0

                    Shortcut {
                        sequences: ["Ctrl+Return"]
                        context: Qt.ApplicationShortcut
                        onActivated: {
                            messageEdit.text += "\n";
                            var nlines = messageEdit.text.split("\n").length - 1
                            if(nlines <= 4) {
                                chatMessageContainer.height = Resources.chatMessageContainerHeight + nlines * 10
                            }
                            messageEdit.cursorPosition = messageEdit.text.length;
                        }
                    }

                    Keys.onReturnPressed: {
                        postMessage();
                    }

                    Keys.onPressed: {
                        var nlines = messageEdit.text.split("\n").length - 1
                        if(nlines <= 4) {
                            chatMessageContainer.height = Resources.chatMessageContainerHeight + nlines * 10
                        }
                        messageEdit.cursorPosition = messageEdit.text.length;
                    }

                    function postMessage() {
                        if(messageEdit.text.length > 0) {
                            mainBackend.sendMessage(contactModelProvider.model.getDHTId(contactListView.currentIndex), messageEdit.text.substr(0, messageEdit.text.length));
                        }
                        messageEdit.text = "";
                        chatMessageContainer.height = Resources.chatMessageContainerHeight
                    }
                    
                }

                ScrollBar.vertical: ScrollBar {visible: true; height: 5}
            }



            //conceal top corner radius
            Rectangle {
                width: parent.width
                height: parent.radius
                color: parent.color
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
            }

            //conceal left corner radius
            Rectangle {
                width: parent.radius
                height: parent.height
                color: parent.color
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
            }

        }

        //contact layouts

        Rectangle {
            id: contactHeaderContainer
            anchors.top: windowTitleBar.bottom

            anchors.right: chatHeaderContainer.left
            height: chatHeaderContainer.height
            width: 0.5 * chatHeaderContainer.width
            color: Resources.contactHeaderContainerBackgroundColor
            border.width: 1
            border.color: Resources.contactHeaderBorderColor

            ComboBox {
                id: contactHeaderComboBox
                anchors.left: parent.left
                anchors.right: contactHeaderHamburgerButton.left
                y: parent.border.width
                height: parent.height - 2 * parent.border.width
                font.pointSize: Resources.contactHeaderContainerFontPointSize
                model: ["meteor-global"]

                indicator: Canvas {
                    id: contactHeaderComboBoxCanvas
                    x: contactHeaderComboBox.width - width - contactHeaderComboText.rightPadding
                    y: contactHeaderComboBox.topPadding + (contactHeaderComboBox.availableHeight - height) / 2
                    width: 8
                    height: 4
                    contextType: "2d"
                    antialiasing: true

                    Connections {
                        target: contactHeaderComboBox
                        onPressedChanged: contactHeaderComboBoxCanvas.requestPaint()
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineWidth = 2;
                        context.lineTo(width / 2, height - 1);
                        context.lineTo(width, 0);

                        context.strokeStyle = contactHeaderComboBox.pressed ? Resources.contactHeaderContainerPressedForegroundColor : Resources.contactHeaderContainerForegroundColor;
                        context.stroke()
                    }
                }

                contentItem: Rectangle {
                    color: Resources.contactHeaderContainerBackgroundColor
                    width: contactHeaderComboText.width
                    Text {
                        id: contactHeaderComboText
                        anchors.verticalCenter: parent.verticalCenter

                        leftPadding: Resources.contactHeaderContainerLeftPadding
                        rightPadding: contactHeaderComboBox.indicator.width + contactHeaderComboBox.spacing

                        text: contactHeaderComboBox.displayText
                        font: contactHeaderComboBox.font
                        color: contactHeaderComboBox.pressed ? Resources.contactHeaderContainerPressedForegroundColor : Resources.contactHeaderContainerForegroundColor
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                }

                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    implicitHeight: 40
                    color: Resources.contactHeaderContainerBackgroundColor
                }

                popup: Popup {
                    id: contactHeaderComboBoxPopup
                    y: contactHeaderComboBox.height - 1
                    width: contactHeaderContainer.width
                    //implicitHeight: contentItem.implicitHeight
                    padding: 0

                    contentItem: ListView {
                        width: parent.width
                        id: contactHeaderComboBoxPopupList
                        clip: true
                        boundsBehavior: Flickable.StopAtBounds

                        implicitHeight: contentHeight <= 200 ? contentHeight : 200

                        model: contactHeaderComboBox.popup.visible ? contactHeaderComboBox.model : null
                        currentIndex: contactHeaderComboBox.highlightedIndex

                        delegate: ItemDelegate {
                            padding: 0
                            width: parent.width

                            contentItem: Rectangle {
                                id: contactHeaderComboBoxPopupItemLayer
                                width: parent.width
                                color: Resources.contactHeaderContainerPopupBackgroundColor

                                Text {
                                    color: Resources.contactHeaderContainerBackgroundColor
                                    font.pixelSize: contactHeaderComboBox.font.pixelSize - 3
                                    anchors.verticalCenter: parent.verticalCenter
                                    leftPadding: contactHeaderComboText.leftPadding
                                    text: modelData
                                }

                                MouseArea {
                                    id: contactHeaderComboBoxPopupItemMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        contactHeaderComboBox.currentIndex = index
                                        contactHeaderComboBoxPopupList.currentIndex = index
                                        contactHeaderComboBoxPopup.close()
                                    }

                                    onHoveredChanged: {
                                        contactHeaderComboBoxPopupItemLayer.color = contactHeaderComboBoxPopupItemMouseArea.containsMouse ? Resources.contactHeaderContainerFocusColor : Resources.contactHeaderContainerPopupBackgroundColor
                                    }

                                }

                            }
                        }

                        ScrollBar.vertical: ScrollBar{ visible: false}

                    }

                    background: Rectangle {
                        color: Resources.contactHeaderContainerBackgroundColor
                    }
                }
            }

            Button {
                id: contactHeaderHamburgerButton
                anchors.right: parent.right
                width: parent.height
                height: parent.height

                background: Rectangle {

                    width: parent.width
                    height: parent.height
                    color: Resources.transparentColor


                    Canvas {
                        id: hamburgerButtonCanvas
                        anchors.fill: parent
                        contextType: "2d"

                        onPaint: {
                            context.reset();
                            var cx = width / 2;
                            var cy = height / 2;
                            var hamspace = height / 8;
                            var hamdot = 2;
                            var hamdotgap = 2;
                            var length = width / 2;
                            var cxl = cx - length / 2;
                            cy -= hamspace;

                            context.lineWidth = 2;
                            context.beginPath();

                            for(var i = 0; i < 3; i++) {
                                context.moveTo(cxl, cy)
                                context.lineTo(cxl + hamdot, cy)
                                context.moveTo(cxl + hamdot + hamdotgap, cy)
                                context.lineTo(cxl + length, cy)
                                cy += hamspace
                            }

                            context.strokeStyle = contactHeaderHamburgerButton.hovered ? Resources.contactHeaderContainerFocusColor : Resources.contactHeaderContainerForegroundColor;

                            context.stroke();

                        }
                    }

                
                }

                onHoveredChanged:  {
                    hamburgerButtonCanvas.requestPaint();
                }
            }
        }

        Rectangle {
            id: contactSearchBarContainer
            anchors.top: contactHeaderContainer.bottom
            anchors.left: contactHeaderContainer.left
            anchors.right: chatContainer.left
            height: Resources.contactSearchBarContainerHeight
            color: Resources.contactSearchBarContainerBackgroundColor
            border.width: 1
            border.color: Resources.contactSearchBarBorderColor

            Button {
                id: searchButton
                width: parent.height
                height: parent.height



                background: Rectangle {

                    width: parent.width
                    height: parent.height
                    color: Resources.transparentColor


                    Canvas {
                        id: searchButtonCanvas
                        anchors.fill: parent
                        contextType: "2d"

                        onPaint: {
                            context.reset();
                            var centreX = width / 2.5;
                            var centreY = width / 2.2;
                            var radius = width / 7
                            context.lineWidth = 2;
                            context.beginPath();
                            context.moveTo(centreX + radius, centreY);
                            context.arc(centreX, centreY, radius, 0, 2 * Math.PI, false);
                            var fx = centreX + radius * Math.cos(Math.PI / 4);
                            var fy = centreY + radius * Math.sin(Math.PI / 4);
                            context.moveTo(fx, fy);
                            context.lineTo(fx + 5, fy + 5)
                            context.strokeStyle = searchButton.hovered ? Resources.contactSearchBarFocusColor : Resources.contactSearchBarContainerForegroundColor;

                            context.stroke();

                        }
                    }


                }

                onHoveredChanged:  {
                    searchButtonCanvas.requestPaint();
                }

                onClicked: {
                    mainBackend.search(searchField.text)
                }
            }

            TextField {
                id: searchField
                anchors.left: searchButton.right
                anchors.right: addContactsButton.left
                height: parent.height
                color: Resources.contactSearchBarContainerForegroundColor
                font.pointSize: Resources.contactSearchBarContainerFontPointSize
                placeholderText: "Search"
                placeholderTextColor: Resources.contactSearchBarContainerPlaceholderColor
                leftPadding: 0
                background: Rectangle {
                    width: parent.width
                    height: parent.height
                    color: Resources.transparentColor
                }

                onTextChanged: {
                    mainBackend.search(searchField.text)
                }

            }

            Button {
                id: addContactsButton
                anchors.right: contactSearchBarContainer.right
                anchors.top: contactSearchBarContainer.top
                width: Resources.contactSearchBarContainerHeight
                height: Resources.contactSearchBarContainerHeight
                background: Rectangle {
                    id: addContactsButtonLayer
                    height: parent.height
                    width: parent.width
                    color: Resources.transparentColor

                    Canvas {
                        id: addContactsButtonCanvas
                        contextType: "2d"
                        anchors.fill: parent

                        onPaint: {
                            context.reset();
                            context.lineWidth = 2;
                            var cx = width / 2;
                            var cy = height / 2;
                            var length = Math.min(height, width) / 3;
                            context.beginPath();
                            context.moveTo(cx - length / 2, cy);
                            context.lineTo(cx + length / 2, cy);
                            context.moveTo(cx, cy - length / 2);
                            context.lineTo(cx, cy + length / 2);
                            context.strokeStyle = addContactsButton.hovered ? Resources.contactSearchBarFocusColor : Resources.contactSearchBarContainerForegroundColor;
                            context.stroke();
                        }

                    }


                }

                onHoveredChanged: {
                    addContactsButtonCanvas.requestPaint();
                }

                onClicked: {
                    mainBackend.openAddContactsWindow()
                }
            }
        }

        Rectangle {
            id: contactContainer
            anchors.top: contactSearchBarContainer.bottom
            anchors.bottom: extrasContainer.top
            anchors.left: parent.left
            anchors.right: chatContainer.left
            color: Resources.contactContainerBackgroundColor
            property var selectedItemName
            ListView {
                id: contactListView
                anchors.left: parent.left
                anchors.right: parent.right
                y: Resources.contactContainerVerticalPadding
                height: parent.height - 2 * Resources.contactContainerVerticalPadding
                boundsBehavior: Flickable.StopAtBounds
                clip: true
                flickableDirection: Flickable.VerticalFlick
                model: contactModelProvider.model

                delegate: Resources.contactDelegate

                onCurrentIndexChanged: {
                    mainBackend.loadChat(contactModelProvider.model.getDHTId(currentIndex))
                    statusCanvas.requestPaint();
                }
            }
        }

        Rectangle {
            id: extrasContainer
            radius: Resources.windowCornerRadius
            height: Resources.chatMessageContainerHeight
            anchors.right: chatMessageContainer.left
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: Resources.extrasContainerBackgroundColor

            //conceal top corner radius
            Rectangle {
                width: parent.width
                height: parent.radius
                color: parent.color
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
            }

            //conceal right corner radius
            Rectangle {
                width: parent.radius
                height: parent.height
                color: parent.color
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }



    }

    DropShadow {
        id: windowLayerDropShadow
        anchors.fill: windowLayer
        cached: true
        verticalOffset: 1
        horizontalOffset: 1
        radius: 8
        samples: 16
        color: "#80000000"
        source: windowLayer
    }

    MouseArea {
        id: windowHorizontalResizeArea
        width: 5
        anchors.right: windowLayer.right
        anchors.top: windowLayer.top
        anchors.bottom: windowLayer.bottom

        cursorShape: Qt.SizeHorCursor

        property int previousX

        onPressed: previousX = mouseX

        onMouseXChanged: {
            var dx = mouseX - previousX
            var newWidth = window.width + dx
            if(newWidth >= window.minimumWidth) {
                window.setWidth(newWidth)
            } else {
                if(window.width !== window.minimumWidth) {
                    window.setWidth(window.minimumWidth)
                }
            }
        }
    }

    MouseArea {
        id: windowVerticalResizeArea
        height: 5
        anchors.right: windowLayer.right
        anchors.left: windowLayer.left
        anchors.bottom: windowLayer.bottom

        cursorShape: Qt.SizeVerCursor

        property int previousY

        onPressed: previousY = mouseY

        onMouseYChanged: {
            var dy = mouseY - previousY
            var newHeight = window.height + dy
            if(newHeight >= 480) {
                window.setHeight(newHeight)
            } else {
                if(window.height !== window.minimumHeight) {
                    window.setHeight(window.minimumHeight)
                }
            }
        }
    }

}
