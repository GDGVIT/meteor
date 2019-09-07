pragma Singleton
import QtQuick 2.0
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0

QtObject {
    property var transparentColor: "#00000000"

    property var windowBackgroundColor: "#2f2d52"
    property var windowCornerRadius: 6
    property var windowDropShadowHorizontalPadding: 8
    property var windowDropShadowVerticalPadding: 8

    property var windowTitleBarHeight: 30
    property var windowTitleBarBackgroundColor: "#242345"
    property var windowTitleBarForegroundColor: "#7f7da2"
    property var windowTitleBarCloseButtonBackgroundColor: "#ff6256"
    property var windowTitleBarRestoreButtonBackgroundColor: "#ffbf2f"
    property var windowTitleBarMinimizeButtonBackgroundColor: "#29cb42"
    property var windowTitleBarButtonOffset: 7
    property var windowTitleBarButtonRadius: 6
    property var windowTitleBarFontSize: 13
    property var windowTitleBarBottomOffset: 20


    property var leftChatBubbleBackgroundColor: "#ffffff"
    property var rightChatBubbleBackgroundColor: "#859ffe"
    property var chatBackgroundColor: "#ddddf7"
    property var chatBubbleRadius: 5
    property var chatBubblePadding: 20
    property var leftChatBubbleForegroundColor: "#8d88b0"
    property var rightChatBubbleForegroundColor: "#f1f3ff"
    property var chatBubbleFontPointSize: 10
    property var consecutiveBubbleSpacing: 40
    property var consecutiveSameBubbleSpacing: 5
    property var chatBubbleOutgrowthOffset: 10
    property var chatBubbleHorizontalPadding: 10
    property var chatBubbleVerticalPadding: 10
    property var chatBubbleDropShadowVerticalOffset: 1
    property var chatBubbleDropShadowHorizontalOffset: 1

    property var chatListViewScrollBarHorizontalOffset: 10

    property var chatMessageContainerBackgroundColor: "#ffffff"
    property var chatMessageContainerHeight: 50

    property var chatBubble: Component {
        id: chatBubble
        Row {
            id: chatBubbleRow

            anchors.right: isRightBubble ? parent.right : undefined

            Rectangle {
                id: chatBubbleContainer
                width: rect.width + chatBubbleHorizontalPadding + chatBubbleOutgrowthOffset
                height: rect.height + (consecutiveBubbleSpacing - consecutiveSameBubbleSpacing) * applyBubbleSpace + consecutiveSameBubbleSpacing
                color: transparentColor
                Rectangle {
                    id: rect
                    anchors.top: parent.top
                    anchors.left: isRightBubble ? parent.left : undefined
                    anchors.right: isRightBubble ? undefined : parent.right


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
                        visible: renderBubbleOutgrowth

                        ShapePath {

                            strokeWidth: 1
                            strokeColor: isRightBubble ? rightChatBubbleBackgroundColor : leftChatBubbleBackgroundColor
                            fillColor: isRightBubble ? rightChatBubbleBackgroundColor : leftChatBubbleBackgroundColor

                            strokeStyle: ShapePath.SolidLine
                            startX: 0; startY: 0
                            PathLine { x: 0; y: 5 }
                            PathLine { x: isRightBubble ? chatBubbleOutgrowthOffset: -chatBubbleOutgrowthOffset; y: 0 }
                            PathLine { x: 0; y: 0 }
                        }
                    }

                }

                DropShadow {
                    id: chatBubbleDropShadow
                    anchors.fill: rect
                    cached: true
                    horizontalOffset: chatBubbleDropShadowHorizontalOffset
                    verticalOffset: chatBubbleDropShadowVerticalOffset
                    radius: 8
                    samples: 16
                    color: "#80000000"
                    source: rect
                }
            }

        }

    }


}

