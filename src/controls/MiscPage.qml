import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: miscPage

    Component.onCompleted: {
        getFont()
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: miscPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: miscPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    property int fontThickness

    function getFont() {
        MiscBackend.getFont()
        fontThickness = MiscBackend.fontThick
    }

    headBar.visible: false

    Controls.Label {
        id: labelMiscellanius
        x: 20
        y: 15
        text: "Miscellanius"
        font.pixelSize: 30
    }

    Rectangle
    {
        x: 20
        y: 55 + labelMiscellanius.y
        width: parent.width - 20 * 2
        height: 60

        color: Maui.Theme.alternateBackgroundColor
        radius: 5

        Controls.Label {
            x: 10
            width: parent.width - 20 * 2
            anchors.verticalCenter: parent.verticalCenter
            text: "Fonts"
        }

        Maui.ToolActions
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10

            Controls.Action
            {
                text: "Thin"
                checked: {
                    if (fontThickness == 0) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                onTriggered: MiscBackend.setFontThick(0)
            }
            Controls.Action
            {
                text: "Light"
                checked: {
                    if (fontThickness == 1) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                onTriggered: MiscBackend.setFontThick(1)
            }
            Controls.Action
            {
                text: "Bold"
                checked: {
                    if (fontThickness == 2) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                onTriggered: MiscBackend.setFontThick(2)
            }
        }
    }
}
