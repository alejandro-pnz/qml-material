/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2015-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype SimpleMenu
   \inqmlmodule Material.ListItems

   \brief A list item that opens a dropdown menu when tapped.
 */
Subtitled {
    id: listItem

    property alias model: listView.model
    property string textRole
    property string valueRole

    readonly property string selectedText: (listView.currentItem) ? listView.currentItem.text : ""
    readonly property var selectedValue: (listView.currentItem) ? listView.currentItem.itemValue : ""
    property alias selectedIndex: listView.currentIndex

    subText: listView.currentItem.text

    onClicked: menu.open(listItem, 16 * Units.dp, 0)

    property int __maxWidth: 0

    Label {
        id: hiddenLabel
        style: "subheading"
        visible: false
        color: darkBackground ? Theme.dark.textColor : Theme.light.textColor

        onContentWidthChanged: {
            __maxWidth = Math.max(contentWidth + 33 * Units.dp, __maxWidth)
        }
    }

    onModelChanged: {
        var longestString = 0;
        for (var i = 0; i < model.length; i++) {
            if(model[i].length > longestString)
            {
                longestString = model[i].length
                hiddenLabel.text = model[i]
            }
        }
    }

    Dropdown {
        id: menu

        anchor: Item.TopLeft

        width: Math.max(56 * 2 * Units.dp, Math.min(listItem.width - 32 * Units.dp, __maxWidth))
        height: Math.min(10 * 48 * Units.dp + 16 * Units.dp, model.length * 48 * Units.dp + 16 * Units.dp)

        Rectangle {
            anchors.fill: parent
            radius: 2 * Units.dp
        }

        ListView {
            id: listView

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: 8 * Units.dp
            }

            interactive: false
            height: count > 0 ? contentHeight : 0

            delegate: Standard {
                id: delegateItem

                text: textRole ? (model[textRole] !== undefined ? model[textRole] : modelData[textRole]) : modelData
                property var itemValue: valueRole ?
                            (model[valueRole] !== undefined ? model[valueRole] : modelData[valueRole]): modelData

                onClicked: {
                    listView.currentIndex = index
                    menu.close()
                }
            }
        }
    }
}
