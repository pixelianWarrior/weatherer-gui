import QtQuick 2.15
import QtQuick.Window 2.15
import QtLocation 6.6


Window {
    id: window
    width: 640

    height: 480
    minimumHeight: 20
    visible: true
    title: qsTr("Weatherer")
    color: "#FF0000"

    property double verticalsplit
    property double horizontalsplit
    property double currwidth
    property double currheight
    UsableMap {
        id:map
        width: horizontalsplit
        height: verticalsplit

    }

    InputArea {
        id: input
        info: information
        width: horizontalsplit
        height: parent.height - verticalsplit
        y: verticalsplit
    }

    InfoArea {
        id: information
        width: parent.width - horizontalsplit
        height: parent.height
        x: horizontalsplit


    }

    Component.onCompleted: {
        verticalsplit = height*5/8
        horizontalsplit = width/2
        currwidth = width
        currheight = height
    }

    onWidthChanged: {
        horizontalsplit *= (width/currwidth)
        currwidth = width
    }

    onHeightChanged: {
        verticalsplit *= (height/currheight)
        currheight = height
    }

}
