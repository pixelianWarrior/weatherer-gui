import QtQuick
import QtQuick.Window 2.12
import QtPositioning 5.14
import QtLocation 5.14

Item {
    Map {
        id: map
        anchors.fill: parent
        center: QtPositioning.coordinate(0, 0)
        zoomLevel: 1

        property var markerPoint
        property var lati
        property var longi
        property geoCoordinate startCentroid

        
        plugin: Plugin {
            name: "osm"
            PluginParameter { name: "osm.mapping.host"; value: "https://tile.openstreetmap.org/" }
            PluginParameter { name: "osm.geocoding.host"; value: "https://nominatim.openstreetmap.org" }
            PluginParameter { name: "osm.routing.host"; value: "https://router.project-osrm.org/viaroute" }
            PluginParameter { name: "osm.places.host"; value: "https://nominatim.openstreetmap.org/search" }
            PluginParameter { name: "osm.mapping.copyright"; value: "" }
            PluginParameter { name: "osm.mapping.highdpi_tiles"; value: true }
        }
        
        
        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        
        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                                 map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                             }
            onScaleChanged: (delta) => {
                                map.zoomLevel += Math.log2(delta)
                                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                            }
            onRotationChanged: (delta) => {
                                   map.bearing -= delta
                                   map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                               }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        
        
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }
        
        MapQuickItem {
            id:marker
            zoomLevel:map.zoomLevel
            sourceItem:   Rectangle {
                id: rect
                width: 25
                height: width
                color: "red"
                border.color: "black"
                border.width: 1
                radius: width*0.5
            }
            coordinate: map.markerPoint
            anchorPoint.x: rect.width / 2
            anchorPoint.y: rect.height / 2
        }
        
        TapHandler {
            id: tapHandler
            acceptedButtons: Qt.LeftButton
            gesturePolicy: TapHandler.ReleaseWithinBounds
            onTapped: if (tapCount === 2) parent.mark(point.position.x,point.position.y)
        }
        
        Component.onCompleted: {
            for( var i_type in supportedMapTypes ) {
                if( supportedMapTypes[i_type].name.localeCompare( "Custom URL Map" ) === 0 ) {
                    activeMapType = supportedMapTypes[i_type]
                }
            }
        }
        
        function mark(x,y) {
            var coord = map.toCoordinate(Qt.point(x, y))
            var lat = coord.latitude
            var lon = coord.longitude
            console.log(lat + " "+ lon)
            markerPoint = coord
        }
        function setCoords(lat,lon) {
            lati = lat
            longi = lon
            if(coord.isValid) {
                markerpoint = coord;
            }
        }


        Location {
            id: coord
            coordinate {

                latitude: map.lati
                longitude: map.longi
            }
        }
    }
    
}

