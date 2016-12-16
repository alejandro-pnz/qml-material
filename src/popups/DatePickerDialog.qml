import QtQuick 2.4
import Material 0.3

Dialog {
    contentMargins: 0
    hasActions: true
    floatingActions: true

    property alias datePicker: datePicker
    signal datePicked(date datePicked)

    DatePicker {
        id: datePicker
        frameVisible: true
        isLandscape: false
    }

    onAccepted: {
        datePicked(datePicker.date)
    }
}
