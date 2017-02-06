import QtQuick 2.4
import Material 0.3

pragma Singleton

Object {
    id: viewShadow
    readonly property var topShadow: [
        {
            opacity: 0,
            offset: 0,
            blur: 0
        },

        {
            opacity: 0.12,
            offset: 1 * Units.dp,
            blur: 1.5 * Units.dp
        },

        {
            opacity: 0.16,
            offset: 3 * Units.dp,
            blur: 3 * Units.dp
        },

        {
            opacity: 0.19,
            offset: 10 * Units.dp,
            blur: 10 * Units.dp
        },

        {
            opacity: 0.25,
            offset: 14 * Units.dp,
            blur: 14 * Units.dp
        },

        {
            opacity: 0.30,
            offset: 19 * Units.dp,
            blur: 19 * Units.dp
        }
    ]

    readonly property var bottomShadow: [
        {
            opacity: 0,
            offset: 0,
            blur: 0
        },

        {
            opacity: 0.24,
            offset: 1 * Units.dp,
            blur: 1 * Units.dp
        },

        {
            opacity: 0.23,
            offset: 3 * Units.dp,
            blur: 3 * Units.dp
        },

        {
            opacity: 0.23,
            offset: 6 * Units.dp,
            blur: 3 * Units.dp
        },

        {
            opacity: 0.22,
            offset: 10 * Units.dp,
            blur: 5 * Units.dp
        },

        {
            opacity: 0.22,
            offset: 15 * Units.dp,
            blur: 6 * Units.dp
        }
    ]
}
