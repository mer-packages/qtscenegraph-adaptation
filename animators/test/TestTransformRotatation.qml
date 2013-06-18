import QtQuick 2.0
import Animators 1.0 as Rt

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
        visible: !renderThreadAnimationsDisabled

        transform: [
            Rotation { id: rotationTransform; origin.x: renderThreadItem.width / 2; origin.y: renderThreadItem.height / 2; }
        ]

        Text {
            anchors.centerIn: parent
            text: "Render thread animation"
            smooth: true
            color: "white"
            font.pixelSize: 20
        }

        Rt.SequentialAnimation {
            id: testAnimation
            running: control.running && !renderThreadAnimationsDisabled
            paused: control.paused
            Rt.NumberAnimation {
                loops: 1
                target: rotationTransform
                property: "angle"
                from: 0.0
                to: 360
                duration: 6000
                easing.type: Easing.Bezier
                easing.bezierCurve: out60in33
            }
            Rt.PauseAnimation { duration: 2000 }
            Rt.NumberAnimation {
                loops: 1
                target: rotationTransform
                property: "angle"
                from: 360
                to: 0.0
                duration: 6000
                easing.type: Easing.Bezier
                easing.bezierCurve: out60in33
            }
        }
    }

    Item {
        id: mainThreadItem
        y: parent.height / 2
        width: parent.width
        height: parent.height / 2
        visible: !mainThreadAnimationsDisabled

        transform: [
            Rotation { id: referenceRotationTransform; origin.x: renderThreadItem.width / 2; origin.y: renderThreadItem.height / 2; }
        ]

        Text {
            anchors.centerIn: parent
            text: "Main thread animation"
            smooth: true
            color: "white"
            font.pixelSize: 20
        }

        SequentialAnimation {
            id: referenceAnimation
            running: control.running && !mainThreadAnimationsDisabled
            paused: control.paused
            NumberAnimation {
                loops: 1
                target: referenceRotationTransform
                property: "angle"
                from: 0.0
                to: 360
                duration: 6000
                easing.type: Easing.Bezier
                easing.bezierCurve: out60in33
            }
            PauseAnimation { duration: 2000 }
            NumberAnimation {
                loops: 1
                target: referenceRotationTransform
                property: "angle"
                from: 360
                to: 0.0
                duration: 6000
                easing.type: Easing.Bezier
                easing.bezierCurve: out60in33
            }
        }
    }

    Control {
        id: control
        anchors.bottom: parent.bottom
        running: true
    }
}
