// Bartext.qml

import Quickshell
import QtQuick
import qs.config

Text {
    anchors.centerIn: parent

    color: Config.barFontColor
    font.pointSize: Config.barFontSize
    font.family: Config.barFontFamily
    font.weight: Config.barFontWeight
}
