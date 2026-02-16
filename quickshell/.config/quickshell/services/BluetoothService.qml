// BluetoothService.qml

pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import QtQuick

Singleton {

    readonly property var adapter: Bluetooth?.defaultAdapter ?? null
    readonly property var devices: {
        if (!adapter)
            return [];
        return adapter.devices.values;
    }
    readonly property var connected: {
        return devices.filter(device => device.connected);
    }

    function device(MAC) {
        return devices.find(device => device.address === MAC);
    }

    function statusText() {
        const count = connected.length;
        if (count === 0) {
            return "󰂲";
        } else if (count === 1) {
            return "";
        } else {
            return count.toString() + " ";
        }
    }
}
