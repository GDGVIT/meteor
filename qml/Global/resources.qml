pragma Singleton
import QtQuick 2.0
import QtQuick.Shapes 1.12

QtObject {
    property var transparentColor: "#00000000"

    property var windowBackgroundColor: "#2f2d52"
    property var windowCornerRadius: 6

    property var windowTitleBarHeight: 30
    property var windowTitleBarBackgroundColor: "#242345"
    property var windowTitleBarForegroundColor: "#615f86"
    property var windowTitleBarCloseButtonBackgroundColor: "#ff6256"
    property var windowTitleBarRestoreButtonBackgroundColor: "#ffbf2f"
    property var windowTitleBarMinimizeButtonBackgroundColor: "#29cb42"
    property var windowTitleBarButtonOffset: 7
    property var windowTitleBarButtonRadius: 6
    property var windowTitleBarFontSize: 13


    property var leftChatBubbleBackgroundColor: "#ffffff"
    property var rightChatBubbleBackgroundColor: "#859ffe"
    property var chatBackgroundColor: "#ddddf7"
    property var chatBubbleRadius: 5
    property var chatBubblePadding: 20
    property var leftChatBubbleForegroundColor: "#8d88b0"
    property var rightChatBubbleForegroundColor: "#f1f3ff"
    property var chatBubbleFontPointSize: 10
    property var consecutiveBubbleSpacing: 10

    property var chatBubble: Component {
        id: chatBubble
        Row {
            id: chatBubbleRow
            anchors.right: isRightBubble ? parent.right : undefined

            Rectangle {
                id: chatBubbleContainer
                width: rect.width
                height: rect.height + consecutiveBubbleSpacing
                color: transparentColor
                Rectangle {
                    id: rect
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: chatBubbleData.height + chatBubblePadding
                    width: chatBubbleData.width + chatBubblePadding
                    radius: chatBubbleRadius
                    color: isRightBubble ? rightChatBubbleBackgroundColor : leftChatBubbleBackgroundColor

                    Text {
                        id: chatBubbleData
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: bubbleData
                        color: isRightBubble ? rightChatBubbleForegroundColor : leftChatBubbleForegroundColor
                        font.pointSize: chatBubbleFontPointSize
                    }

                    //chatBubble outgrowth
                    Shape {
                        x: isRightBubble ? parent.width - parent.radius: parent.radius
                        y: 1
                        width: parent.width
                        height: parent.height
                        antialiasing: true

                        ShapePath {
                            strokeWidth: 1
                            strokeColor: isRightBubble ? rightChatBubbleBackgroundColor : leftChatBubbleBackgroundColor
                            fillColor: isRightBubble ? rightChatBubbleBackgroundColor : leftChatBubbleBackgroundColor

                            strokeStyle: ShapePath.SolidLine
                            startX: 0; startY: 0
                            PathLine { x: 0; y: 5 }
                            PathLine { x: isRightBubble ? 10: -10; y: 0 }
                            PathLine { x: 0; y: 0 }
                        }
                    }

                }

            }

        }

    }


}

