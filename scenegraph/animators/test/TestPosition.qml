import QtQuick 2.0
import Animators 1.0 as Rt
import ".."

Rectangle {
    id: root
    width: 320
    height: 480
    color: "black"
    property var out33in60: [ 0.33, 0.0, 0.40, 1.0, 1.0, 1.0 ]
    property var out60in33: [ 0.60, 0.0, 0.67, 1.0, 1.0, 1.0 ]

    Rt.Item {
        id: renderThreadItem
        width: parent.width
        height: parent.height / 2
        x: 150
        visible: !renderThreadAnimationsDisabled

        Text {
            anchors.centerIn: parent
            text: "Render thread animation"
            smooth: true
            color: "white"
            font.pixelSize: 20
        }

        Rt.PropertyAnimation {
            id: testAnimation
            loops: 1
            running: control.running && !renderThreadAnimationsDisabled
            paused: control.paused
            target: renderThreadItem
            property: "x"
            from: 0.0
            to: 360.0
            duration: 6000
            easing.type: Easing.Bezier
            easing.bezierCurve: out60in33
        }
    }

    Item {
        id: mainThreadItem
        y: parent.height / 2
        width: parent.width
        height: parent.height / 2
        visible: !mainThreadAnimationsDisabled

        Text {
            anchors.centerIn: parent
            text: "Main thread animation"
            smooth: true
            color: "white"
            font.pixelSize: 20
        }

        PropertyAnimation {
            id: referenceAnimation
            loops: 1
            running: control.running && !mainThreadAnimationsDisabled
            paused: control.paused
            target: mainThreadItem
            property: "x"
            from: 0.0
            to: 360.0
            duration: 6000
            easing.type: Easing.Bezier
            easing.bezierCurve: out60in33
        }
    }

    Control {
        id: control
        anchors.bottom: parent.bottom
        running: true
    }
}
