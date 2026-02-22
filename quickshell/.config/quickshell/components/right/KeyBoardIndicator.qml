// KeyBoardIndicator.qml

import QtQuick
import Quickshell
import qs.services
import qs.components.generic

Bartext {
    text: {
        if (KeyboardService.layout.includes("Belgian"))
            return "BE";
        if (KeyboardService.layout.includes("English (US)"))
            return "US";
        // fallback: grab first two letters
        return KeyboardService.layout;
    }
}
