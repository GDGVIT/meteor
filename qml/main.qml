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
    property var targetUrl
    property var targetName
    property var targetStatus


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
                text: contactListView.model.get(contactListView.currentIndex).name
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
                        context.fillStyle = contactListView.model.get(contactListView.currentIndex).status === 0 ? Resources.onlineMarkerColor : Resources.offlineMarkerColor;
                        context.fill();

                    }

                }

            }

            Text {
                id: chatHeaderStatusText

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: statusLayer.right
                color: Resources.chatHeaderForegroundColor
                font.pointSize: Resources.chatHeaderFontPointSize
                text: contactListView.model.get(contactListView.currentIndex).status === 0 ? "online" : "offline"
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

                model: ListModel {
                    ListElement {
                        name: "data"
                        isRightBubble: true
                        bubbleData: "Hello Vishaal!"
                        applyBubbleSpace: false
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: true
                        bubbleData: "I am meteor."
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: false
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: false
                        bubbleData: "Nice to meet you meteor."
                        applyBubbleSpace: false
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: false
                        bubbleData: "Where do you live ?"
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: false
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: true
                        bubbleData: "I live in kademlia."
                        applyBubbleSpace: false
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: true
                        bubbleData: "The land of the DHT."
                        applyBubbleSpace: false
                        renderBubbleOutgrowth: false
                    }

                    ListElement {
                        name: "data"
                        isRightBubble: true
                        bubbleData: "If you wanna see how I work, then check out my <br><a href=\"https://github.com/GDGVIT/meteor\">repository.</a>"
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: false
                    }
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

            Flickable {
                id: flick
                width: parent.width
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
                    property var nlines: 0
                    onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                    Keys.onPressed: {

                        var delta = 10;
                        if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter){

                            if(nlines < 3) {
                                chatMessageContainer.height += delta;
                                nlines++;
                            }
                        }

                        if(event.key === Qt.Key_Backspace) {
                            if(text[text.length - 1] === '\n' && nlines > 0) {

                                chatMessageContainer.height -= delta;
                                nlines--;
                            }
                        }
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
                model: ["meteor-DSC", "meteor-global"]

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
                model: ListModel {
                    ListElement {
                        name: "Vishaal Selvaraj"
                        imageUrl: "file:///F:/prof.jpg"
                        recentText: "meteor rocks!"
                        msgCount: 1
                        status: 0
                    }

                    ListElement {
                        name: "Amogh Lele"
                        imageUrl: "file:///F:/pp.jpg"
                        recentText: "meteor is cool!"
                        msgCount: 135
                        status: 0
                    }

                    ListElement {
                        name: "Abhishek Kushwaha"
                        imageUrl: "file:///F:/abhishek.jpg"
                        recentText: "Nice to meet you!"
                        msgCount: 0
                        status: 1
                    }

                    ListElement {
                        name: "Ayush Priya"
                        imageUrl: "file:///F:/ayush.jpg"
                        recentText: "Got 99 problems but a breach ain't one."
                        msgCount: 2
                        status: 1
                    }

                    ListElement {
                        name: "Angad Sharma"
                        imageUrl: "file:///F:/angad.jpg"
                        recentText: "Webinar on async patterns in node ^."
                        msgCount: 0
                        status: 0
                    }

                    ListElement {
                        name: "Samarth Nayyar"
                        imageUrl: "file:///F:/samarth.jpg"
                        recentText: "Hi there!"
                        msgCount: 1
                        status: 1
                    }





                }

                delegate: Resources.contactDelegate

                onCurrentIndexChanged: {
                    statusCanvas.requestPaint();
                }
            }
        }

        Rectangle {
            id: extrasContainer
            height: Resources.chatMessageContainerHeight
            anchors.right: chatMessageContainer.left
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: Resources.extrasContainerBackgroundColor
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
