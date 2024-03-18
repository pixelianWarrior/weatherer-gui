import QtQuick 2.15

Rectangle {
    color: "#FF3FD4"
    property bool infoAvailable

    Text {
        x:10
        y:10
        width:parent.width -20
        text:"Solar Panels information:"
        font.pixelSize: 30
        visible: infoAvailable
    }

    Text {
        x:10
        y:10
        width:parent.width -20
        text: "Press calculate to see more info here"
        wrapMode: Text.WordWrap
        font.pixelSize: 30
        visible: !infoAvailable
    }

    Component.onCompleted: {
        infoAvailable = false
    }

    onInfoAvailableChanged: {

    }

}
