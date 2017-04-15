/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import QtGraphicalEffects 1.0
import Material 0.3

/*!
   \qmltype View
   \inqmlmodule Material

   \brief Provides a base view component, with support for Material Design elevation,
   background colors, and tinting.
 */
Item {
    id: item
    width: 100
    height: 62

    property int elevation: 0
    property real radius: 0

    property string style: "default"

    property color backgroundColor: elevation > 0 ? "white" : "transparent"
    property color tintColor: "transparent"

    property alias border: rect.border

    property bool fullWidth
    property bool fullHeight

    property alias clipContent: rect.clip

    default property alias data: rect.data

    property bool elevationInverted: false
    property var topElevationInfo: undefined
    property var bottomElevationInfo: undefined

    Component.onCompleted: {
        updateElevation();
        updateSize();
    }

    onWidthChanged: {
        updateWidth();
    }

    onHeightChanged: {
        updateHeight();
    }

    onElevationChanged: {
        updateElevation();
    }

    onFullWidthChanged: {
        updateWidth();
    }

    onFullHeightChanged: {
        updateHeight();
    }

    function updateSize() {
        updateWidth();
        updateHeight();
    }

    function updateWidth() {
        if(fullWidth) {
            var width = item.width + 10 * Units.dp;
            topGlow.width = width;
            bottomGlow.width = width;
        } else {
            topGlow.width = item.width;
            bottomGlow.width = item.width;
        }
    }

    function updateHeight() {
        if(fullHeight) {
            var height = item.height + 20 * Units.dp;
            topGlow.height = height;
            bottomGlow.height = height;
        } else {
            topGlow.height = item.height;
            bottomGlow.height = item.height;
        }
    }

    function updateElevation() {
        topElevationInfo = elevation > 0 ? ViewShadow.topShadow[Math.min(elevation, 5)] : undefined;
        topGlow.updateShadow(topElevationInfo, radius)

        bottomElevationInfo = elevation > 0 ? ViewShadow.bottomShadow[Math.min(elevation, 5)] : undefined;
        bottomGlow.updateShadow(bottomElevationInfo, radius)
    }

    ViewGlow {
        id: topGlow
        anchors.centerIn: parent
        elevationInverted: parent.elevationInverted
    }

    ViewGlow {
        id: bottomGlow
        anchors.centerIn: parent
        elevationInverted: parent.elevationInverted
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        color: Qt.tint(backgroundColor, tintColor)
        radius: item.radius
        antialiasing: parent.rotation || radius > 0 ? true : false
        clip: true

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
