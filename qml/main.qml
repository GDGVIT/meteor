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
                font.pixelSize: Resources.windowTitleBarFontSize
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

        Rectangle {
            id: chatContainer
            x: parent.width / 3
            y: windowTitleBar.height + Resources.windowTitleBarBottomOffset
            width: 2 * parent.width / 3
            anchors.bottom: chatMessageContainer.top
            anchors.top: windowTitleBar.bottom

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



                model: ListModel {
                    ListElement {
                        name: "data"
                        isRightBubble: true
                        bubbleData: "Hello meteor!"
                        applyBubbleSpace: false
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: true
                        bubbleData: "I am Vishaal."
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: false
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: false
                        bubbleData: "I am meteor. I live in kademlia."
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: false
                        bubbleData: "I am meteor. I live in kademlia."
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: false
                        bubbleData: "I am meteor. I live in kademlia."
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: false
                        bubbleData: "I am meteor. I live in kademlia."
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: true
                    }
                    ListElement {
                        name: "data"
                        isRightBubble: false
                        bubbleData: "I am meteor. I live in kademlia."
                        applyBubbleSpace: true
                        renderBubbleOutgrowth: true
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
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

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
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom

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
