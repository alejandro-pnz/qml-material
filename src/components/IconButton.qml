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
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype IconButton
   \inqmlmodule Material

   \brief Icon buttons are appropriate for app bars, toolbars, action buttons or toggles.
 */
Item {
    id: iconButton

    property Action action
    property string iconName
    property string iconSource: action ? action.iconSource : "icon://" + iconName
    property bool hoverAnimation: action ? action.hoverAnimation : false
    property alias color: icon.color
    property alias size: icon.size
    property int notificationCount: 0

    onNotificationCountChanged: {
        if(notificationCount > 0) {
            ink.createTapCircle(iconButton.x + width/2, iconButton.y + height/2)
            ink.lastCircle.removeCircle();
        }
    }

    signal clicked

    width: icon.width
    height: icon.height
    enabled: action ? action.enabled : true
    opacity: enabled ? 1 : 0.6

    onClicked: {
        if (action) action.triggered(icon)
    }

    Ink {
        id: ink

        anchors.centerIn: parent
        enabled: iconButton.enabled
        centered: true
        circular: true

        width: parent.width + 20 * Units.dp
        height: parent.height + 20 * Units.dp

        z: 0

        onClicked: {
            iconButton.clicked()
        }
    }

    View {
        id: notificationView
        width: iconButton.size/3*2
        height: iconButton.size/3*2
        anchors {
            left: iconButton.left
            top: iconButton.top
            leftMargin: -dp(4)
            topMargin: -dp(4)
        }
        elevation: 1
        radius: width/2
        backgroundColor: Palette.colors["red"]["500"]
        visible: notificationCount > 0
        z: 2

        Label {
            id: notificationCountText
            text: notificationCount <= 99 ? notificationCount : "99"
            anchors.centerIn: parent
            color: "white"
            font.pointSize: 10
            font.weight: Font.DemiBold
        }
    }

    Icon {
        id: icon

        anchors.centerIn: parent

        source: iconButton.iconSource
        rotation: iconButton.hoverAnimation ? ink.containsMouse ? 90 : 0
                                            : 0

        Behavior on rotation {
            NumberAnimation { duration: 200 }
        }
    }

    Tooltip {
        text: action ? action.name : ""
        mouseArea: ink
    }
}
