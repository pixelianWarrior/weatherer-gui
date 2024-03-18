import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: base
    color:  "#fff0db"
    property var info
    Text {
        x:10
        y:10
        height:20
        font.pixelSize: 20
        text: "Address:"
    }

    Rectangle {

        x:10
        y:35
        width: parent.width-20
        height:20
        color: "#FFFFFF"
        TextEdit {
            id: address
            x:0
            y:0
            width: parent.width
            height: parent.width
        }
    }
    Rectangle {
        x: 10
        y: 65
        height: parent.height - 75
        width: parent.width -130
        Text {
            height: parent.height
            width: parent.width
            text: "Enter your address above or double click on the map to set the location, then press calculate to learn about the area"
            wrapMode: Text.WordWrap
            font.pixelSize: 20
        }
    }


    Rectangle {
        id: button
        y: parent.height-30
        x: parent.width-110

        height:20
        width:100
        color: "#AAAAAA"
        Text {
            anchors.fill: parent
            text: "Calculate"
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        TapHandler {
            onTapped: sendInfo()

        }
    }

    function sendInfo() {
        base.info.infoAvailable = false
        base.info.infoAvailable = true
    }
}
