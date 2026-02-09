// Bar.qml

import Quickshell
import QtQuick
import qs.services
import qs.config
import qs.components

PanelWindow {
    required property var modelData
    screen: modelData

    anchors {
        top: true
    }

    margins.top: Config.barMarginTop

    color: "transparent"

    implicitHeight: screen.height * Config.barHeightFactor
    implicitWidth: screen.width - Config.barMarginSide * 2

    /* ------------------------------------------ Clock ----------------------------------------- */
    Barbox {
        implicitHeight: parent.height
        implicitWidth: screen.width * Config.barWidthFactor
        anchors.centerIn: parent

        Bartext {
            anchors.centerIn: parent
            text: TimeService.format(Config.clockFormat)
        }
    }

    /* ---------------------------------------- Workspace --------------------------------------- */
    Barbox {
        implicitHeight: parent.height
        implicitWidth: parent.height * 1.2
        anchors.left: parent.left

        Bartext {
            anchors.centerIn: parent
            text: WorkspaceService.activeWorkspace?.name ?? ""
        }
    }

    /* -------------------------------------- Control Panel ------------------------------------- */
    Barbox {
        implicitHeight: parent.height
        implicitWidth: 200
        anchors.right: parent.right
    }
}
