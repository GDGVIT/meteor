pragma Singleton
import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
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
    property var windowTitleBarFontPointSize: 10
    property var windowTitleBarBottomOffset: 20


    property var leftChatBubbleBackgroundColor: "#ffffff"
    property var rightChatBubbleBackgroundColor: "#859ffe"
    property var chatBackgroundColor: "#ddddf7"
    property var chatBubbleRadius: 3
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
    property var chatMessageContainerHeight: 40

    property var chatHeaderContainerHeight: 40
    property var chatHeaderContainerBackgroundColor: "#5e5c8d"
    property var chatHeaderForegroundColor: "#c2c1ed"
    property var chatHeaderFontPointSize: 10

    property var contactHeaderContainerBackgroundColor: "#2e2c51"
    property var contactHeaderContainerForegroundColor: "#d3cdf9"
    property var contactHeaderContainerPressedForegroundColor: "#ffffff"
    property var contactHeaderContainerPopupBackgroundColor: "#bbb9e1"
    property var contactHeaderContainerFontPointSize: 12
    property var contactHeaderContainerLeftPadding: 10
    property var contactHeaderContainerFocusColor: "#e8e8f5"
    property var contactHeaderBorderColor: "#393776"

    property var contactSearchBarContainerBackgroundColor: "#3f3e60"
    property var contactSearchBarContainerForegroundColor: "#b9b7df"
    property var contactSearchBarContainerPlaceholderColor: "#a5a2dd"
    property var contactSearchBarBorderColor: "#464469"
    property var contactSearchBarContainerHeight: 40
    property var contactSearchBarContainerFontPointSize: 10
    property var contactSearchBarFocusColor: "#e8e8f5"

    property var contactContainerBackgroundColor: "#3f3e60"
    property var contactContainerForegroundColor: "#b9b7df"
    property var contactContainerVerticalPadding: 10
    property var contactRowForegroundColor: "#b8b7d9"
    property var contactRowRecentTextForegroundColor: "#7c79a0"
    property var contactRowFocusColor: "#373658"

    property var extrasContainerBackgroundColor: "#474b7b"
    property var extrasContainerForegroundColor: "#dad4f6"

    property var profileImageHeight: 40
    property var profileImageWidth: 40
    property var profileNameFontPointSize: 9


    property var onlineMarkerColor: "lightgreen"
    property var offlineMarkerColor: "white"

    property var msgCountMarkerSize: 15
    property var msgCountMarkerColor: "#02db58"
    property var msgCountMarkerForegroundColor: "white"



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
                        linkColor: isRightBubble ? "#ffe46b" : "#7eb8f8"
                        onLinkActivated: Qt.openUrlExternally(link)
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

    property var contactDelegate: Component {
        id: contact
        Rectangle {
            id: contactRow

            height: cr_image.height + 20
            width: parent.width
            color: transparentColor
            property var url: imageUrl
            property var stat: status
            property var listViewTree: parent.parent


            Loader {
                id: cr_image; sourceComponent: profileImageItem; x: 10
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                id: cr_textContent

                anchors.left: cr_image.right
                width: cr_msgcount.x - x - 10
                color: transparentColor
                Text {
                    id: cr_text
                    text: name
                    clip: true
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    topPadding: contactRow.height / 4
                    leftPadding: 10
                    rightPadding: 20
                    color: contactRowForegroundColor
                    font.pointSize: profileNameFontPointSize
                }
                Text {
                    id: cr_recentText
                    text: recentText
                    clip: true
                    anchors.top: cr_text.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    leftPadding: 10
                    topPadding: 5
                    color: contactRowRecentTextForegroundColor
                    font.pointSize: profileNameFontPointSize - 1
                }
            }

            Rectangle {
                id: cr_msgcount
                anchors.verticalCenter: parent.verticalCenter
                height: msgCountMarkerSize
                width: cr_msgcount_text.width
                x: parent.width - width - contactSearchBarContainerHeight / 4
                radius: 3
                visible: msgCount !== 0
                color: msgCountMarkerColor

                Text {
                    id: cr_msgcount_text
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: msgCount > 99 ? "99+" : msgCount
                    leftPadding: msgCountMarkerSize / 4
                    rightPadding: msgCountMarkerSize / 4
                    color: msgCountMarkerForegroundColor
                }


            }

            MouseArea {
                id: cr_mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onHoveredChanged: {
                    contactRow.color = cr_mouseArea.containsMouse ? contactRowFocusColor : transparentColor
                }

                onClicked: {
                    contactRow.listViewTree.currentIndex = index
                    //console.log(contactRow.listViewTree.model.get(index))
                }
            }

        }
    }

    property var profileImageItem: Component {
        id: profileImageItem
        Rectangle {
            width: profileImageWidth
            height: profileImageHeight
            color: transparentColor

            Image {
                property var root: parent.parent.parent
                source: root.url
                width: parent.width
                height: parent.height
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: opacityMask
                }
            }

            Rectangle {
                id: opacityMask
                width: parent.width
                height: parent.height
                radius: Math.min(parent.width, parent.height) / 2
                visible: false

            }

            Canvas {
                id: statusMarkerCanvas
                anchors.fill: parent
                contextType: "2d"

                onPaint: {
                    context.reset();
                    context.lineWidth = 2;
                    var effsize = Math.min(width, height);
                    var cx = width / 2
                    var cy = height / 2
                    var radius = effsize / 2
                    var mradius = 3;

                    context.beginPath();
                    var mx = cx + radius * Math.cos(Math.PI / 4);
                    var my = cy - radius * Math.sin(Math.PI / 4);
                    context.moveTo(mx, my);
                    //now we are at the circumference of the circle.
                    // now draw the marker with centre = mx,my and radius = mradius

                    context.arc(mx, my, mradius, 0, Math.PI * 2);

                    var rootElement = parent.parent.parent;

                    if(rootElement.stat === 0) {
                        context.fillStyle = onlineMarkerColor;
                    } else if(rootElement.stat === 1) {
                        context.fillStyle = offlineMarkerColor;
                    }
                    context.fill();

                    context.closePath();


                    context.lineWidth = mradius / 2;
                    context.beginPath();

                    context.moveTo(mx + mradius + context.lineWidth - 1, my);
                    //now we are at the circumference of the circle.
                    // now draw the marker with centre = mx,my and radius = mradius

                    context.arc(mx, my, mradius + context.lineWidth, 0, Math.PI * 2);
                    //context.strokeStyle = "white";
                    context.strokeStyle = contactContainerBackgroundColor;
                    context.stroke();

                }

            }
        }
    }



}

