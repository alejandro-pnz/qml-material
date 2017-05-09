/***** THIS FILE CANNOT BE RELICENSED UNDER THE MPL YET *****/

/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.4
import QtQuick.Layouts 1.1

import Material 0.3
import Material.ListItems 0.1

/*!
   \qmltype MenuField
   \inqmlmodule Material

   \brief A input field similar to a text field but that opens a dropdown menu.
 */
Item {
    id: field

    implicitHeight: hasHelperText ? helperTextLabel.y + helperTextLabel.height
                                  : underline.y + 8 * Units.dp
    implicitWidth: spinBoxContents.implicitWidth

    activeFocusOnTab: true

    property color accentColor: Theme.accentColor
    property color errorColor: "#F44336"

    property alias model: listView.model

    property string textRole
    property string valueRole

    readonly property string selectedText: (listView.currentItem) ? listView.currentItem.text : ""
    readonly property var selectedValue: (listView.currentItem) ? listView.currentItem.itemValue : ""

    property alias selectedIndex: listView.currentIndex
    property int maxVisibleItems: 4

    property alias placeholderText: fieldPlaceholder.text
    property alias helperText: helperTextLabel.text
    property alias tooltipText: tooltip.text

    property bool floatingLabel: false
    property bool hasError: false
    property bool hasHelperText: helperText.length > 0
    property string noItemsText: ""

    readonly property rect inputRect: Qt.rect(spinBox.x, spinBox.y, spinBox.width, spinBox.height)

    signal itemSelected(int index)

    Ink {
        id: ink
        anchors.fill: parent
        hoverEnabled: true
        preventStealing: true
        propagateComposedEvents: true
        onClicked: {
            if(listView.currentItem) {
                listView.positionViewAtIndex(listView.currentIndex, ListView.Center)
                var offset = listView.currentItem.itemLabel.mapToItem(menu, 0, 0)
                menu.open(label, 0, -offset.y)
            }
        }
    }

    Tooltip {
        id: tooltip
        mouseArea: ink
    }

    Item {
        id: spinBox

        anchors.top: fieldPlaceholder.bottom
        anchors.topMargin: placeholderText !== "" ? 8 * Units.dp : 0

        height: 24 * Units.dp
        width: parent.width

        y: {
            if(!floatingLabel)
                return 16 * Units.dp
            if(floatingLabel && !hasHelperText)
                return 40 * Units.dp
            return 28 * Units.dp
        }

        RowLayout {
            id: spinBoxContents

            height: parent.height
            width: parent.width + 5 * Units.dp

            SubheadingLabel {
                id: label

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter

                text: (listView.currentItem) ? listView.currentItem.text : noItemsText
                elide: Text.ElideRight
            }

            Icon {
                id: dropDownIcon

                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                Layout.preferredWidth: 24 * Units.dp
                Layout.preferredHeight: 24 * Units.dp

                name: "navigation/arrow_drop_down"
                size: 24 * Units.dp
            }
        }

        Dropdown {
            id: menu

            anchor: Item.TopLeft

            width: spinBox.width

            //If there are more than max items, show an extra half item so
            // it's clear the user can scroll
            height: Math.min(maxVisibleItems*48 * Units.dp + 24 * Units.dp, listView.contentHeight)

            ListView {
                id: listView

                width: menu.width
                height: count > 0 ? menu.height : 0

                interactive: true

                delegate: Item {
                    id: delegateItem

                    property bool selected
                    property bool darkBackground
                    property bool showDivider: false

                    property alias itemLabel: contentLabel
                    property alias itemValueLabel: valueLabel
                    property alias text: contentLabel.text
                    property alias valueText: valueLabel.text

                    property int margins: 16 * Units.dp
                    property int dividerInset: 0

                    property var itemValue: valueRole ?
                                (model[valueRole] !== undefined ? model[valueRole] : modelData[valueRole]): modelData

                    onClicked: {
                        listView.currentIndex = index
                        itemSelected(index)
                        menu.close()
                    }

                    anchors {
                        left: parent ? parent.left : undefined
                        right: parent ? parent.right : undefined
                    }

                    signal clicked()
                    signal pressAndHold()

                    Rectangle {
                        id: rect
                        anchors.fill: parent
                        property color backgroundColor: "transparent"
                        color: Qt.tint(backgroundColor, tintColor)

                        property color tintColor: delegateItem.selected
                                   ? Qt.rgba(0,0,0,0.05)
                                   : contentInk.containsMouse ? Qt.rgba(0,0,0,0.03) : Qt.rgba(0,0,0,0)

                        radius: 0
                        antialiasing: parent.rotation || radius > 0 ? true : false
                        clip: true

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }

                    ThinDivider {
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: dividerInset

                        visible: showDivider
                        darkBackground: delegateItem.darkBackground
                    }

                    Ink {
                        id: contentInk
                        onClicked: delegateItem.clicked()
                        onPressAndHold: delegateItem.pressAndHold()

                        anchors.fill: parent

                        enabled: delegateItem.enabled
                        z: -1
                    }

                    opacity: enabled ? 1 : 0.6
                    implicitHeight: 48 * Units.dp
                    height: 48 * Units.dp

                    property alias content: contentItem.children

                    implicitWidth: {
                        var width = delegateItem.margins * 2

                        if (contentItem.visible)
                            width += contentItem.implicitWidth + row.spacing
                        else
                            width += label.implicitWidth + row.spacing

                        return width
                    }

                    RowLayout {
                        id: row
                        anchors.fill: parent

                        anchors.leftMargin: delegateItem.margins
                        anchors.rightMargin: delegateItem.margins
                        spacing: 16 * Units.dp

                        ColumnLayout {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.preferredHeight: parent.height

                            Item {
                                id: contentItem

                                Layout.fillWidth: true
                                Layout.preferredHeight: parent.height

                                visible: children.length > 0
                            }

                            SubheadingLabel {
                                id: contentLabel

                                text: textRole ? (model[textRole] !== undefined ? model[textRole] : modelData[textRole]) : modelData
                                Layout.alignment: Qt.AlignVCenter
                                Layout.fillWidth: true

                                elide: Text.ElideRight

                                color: delegateItem.selected ? Theme.primaryColor
                                        : darkBackground ? Theme.dark.textColor : Theme.light.textColor

                                visible: !contentItem.visible
                            }
                        }

                        Label {
                            id: valueLabel

                            Layout.alignment: Qt.AlignVCenter

                            color: darkBackground ? Theme.dark.subTextColor : Theme.light.subTextColor
                            elide: Text.ElideRight

                            visible: text.length > 0
                        }
                    }
                }
            }
        }
    }

    Label {
        id: fieldPlaceholder

        text: field.placeholderText
        visible: floatingLabel

        font.pixelSize: 12 * Units.dp

        anchors.top: parent.top

        color: Theme.light.hintColor
    }

    Rectangle {
        id: underline

        color: field.hasError ? field.errorColor : field.activeFocus ? field.accentColor : Theme.light.hintColor

        height: field.activeFocus ? 2 * Units.dp : 1 * Units.dp

        anchors {
            left: parent.left
            right: parent.right
            top: spinBox.bottom
            topMargin: 8 * Units.dp
        }

        Behavior on height {
            NumberAnimation { duration: 200 }
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }

    Label {
        id: helperTextLabel

        anchors {
            left: parent.left
            right: parent.right
            top: underline.top
        }

        visible: hasHelperText
        font.pixelSize: 12 * Units.dp
        color: field.hasError ? field.errorColor : Qt.darker(Theme.light.hintColor)

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
