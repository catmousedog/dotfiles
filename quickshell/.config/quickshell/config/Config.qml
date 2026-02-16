// Config.qml

pragma Singleton

import Quickshell
import QtQuick
import qs.services

Singleton {
    id: root

    /* ========================================================================================== */
    /*                                            Bars                                            */
    /* ========================================================================================== */

    /* ------------------------------------------ Theme ----------------------------------------- */
    readonly property string barBackgroundColor: Theme.base
    readonly property string barBorderColor: Theme.mauve
    readonly property int barBorderWidth: 3

    /* ------------------------------------------- Fonts ------------------------------------------- */
    readonly property string barFontColor: Theme.text
    readonly property real barFontSize: 13.5
    // readonly property real barFontSizeSmall: 12
    readonly property string barFontFamily: "Noto Sans Mono"
    readonly property int barFontWeight: Font.Bold

    /* ------------------------------------ Size and Position ----------------------------------- */
    readonly property int barMarginTop: 5
    readonly property int barMarginSide: 10
    readonly property real barHeightFactor: 1 / 45

    /* ========================================================================================== */
    /*                                            Clock                                           */
    /* ========================================================================================== */
    readonly property string clockFormat: "dddd dd MMM | hh:mm"
    readonly property real clockBarWidthFactor: 1 / 10

    /* ============================================================================================= */
    /*                                           Workspace                                           */
    /* ============================================================================================= */

    /* ========================================================================================== */
    /*                                          Sound Bar                                         */
    /* ========================================================================================== */

    readonly property real soundBarWidthFactor: 1 / 20
    readonly property int soundScrollInterval: 1
}
