import QtQuick 2.15

Rectangle {
    property string defaultText
    color: "white"
    border.color: "dark gray"
    border.width: 2
    property string inputText
    property string typedText
    Text{
        anchors.horizontalCenter: parent.horizontalCenter
        x:2
        text: typedText
        color: "#000000"
    }
    TextInput {
        id: input
        anchors.left: parent.left
        anchors.leftMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 3
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        color: "white"

        text: inputText
    }
    Item {

    }
}
