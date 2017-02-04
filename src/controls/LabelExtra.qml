import QtQuick 2.4
//import Material 0.3

pragma Singleton

QtObject {
    id: labelExtra

    readonly property var styles: {
        "display4": {
            size: 112,
            font: Font.Light
        },

       "display3": {
            size: 56,
            font: Font.Normal
        },

        "display2": {
            size: 45,
            font: Font.Normal
        },

        "display1": {
            size: 34,
            font: Font.Normal
        },

        "headline": {
            size: 24,
            font: Font.Normal
        },

        "title": {
            size: 20,
            font: Font.DemiBold
        },

        "dialog": {
            size: 17,
            font: Font.Normal
        },

        "subheading": {
            size: 15,
            font: Font.Normal
        },

        "body2": {
            size: 13,
            font: Font.DemiBold
        },

        "body1": {
            size: 13,
            font: Font.Normal
        },

        "caption": {
            size: 12,
            font: Font.Normal
        },

        "menu": {
            size: 13,
            font: Font.DemiBold
        },

        "button": {
            size: 14,
            font: Font.DemiBold
        },

        "tooltip": {
            size: 13,
            font: Font.DemiBold
        },

        "hint": {
            size: 12,
            font: Font.Normal
        },

        "notification": {
            size: 10,
            font: Font.DemiBold
        }
    }
}
