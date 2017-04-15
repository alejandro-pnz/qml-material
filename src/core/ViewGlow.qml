import QtQuick 2.4
import QtGraphicalEffects 1.0
import Material 0.3

RectangularGlow {
    property real horizontalShadowOffset: 0
    property real verticalShadowOffset: 0
    property bool elevationInverted: false
    anchors.horizontalCenterOffset: horizontalShadowOffset * (elevationInverted ? -1 : 1)
    anchors.verticalCenterOffset: verticalShadowOffset * (elevationInverted ? -1 : 1)

    glowRadius: 0
    opacity: 0
    spread: 0.05
    color: "black"
    //visible: parent.opacity == 1

    function updateShadow(elevationInfo, radius) {
        cornerRadius = radius;

        if(elevationInfo !== undefined && elevationInfo.offset > 0) {
            horizontalShadowOffset = elevationInfo.offset * Math.sin((2 * Math.PI) * (parent.rotation / 360.0));
            verticalShadowOffset = elevationInfo.offset * Math.cos((2 * Math.PI) * (parent.rotation / 360.0));

            glowRadius = elevationInfo.blur;
            opacity = elevationInfo.opacity;
            cornerRadius += glowRadius * 2.5;
        }
    }
}
