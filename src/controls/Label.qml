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

/*!
   \qmltype Label
   \inqmlmodule Material

   \brief A text label with many different font styles from Material Design.
 */
Text {
    id: label
    property string style: "body1"
    property var fontInfo: LabelExtra.styles[style]

    font.pixelSize: fontInfo.size * Units.dp
    font.family: "Roboto"
    font.weight: fontInfo.font
    font.capitalization: style == "button" ? Font.AllUppercase : Font.MixedCase

    color: Theme.light.textColor
}
