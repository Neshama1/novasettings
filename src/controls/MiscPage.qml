import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    Component.onCompleted: {
        getFont()
    }

    function getFont() {
        MiscBackend.getFont()
    }

    headBar.visible: false

        Rectangle
        {
            x: 20
            y: 20
            width: parent.width - 20 * 2
            height: 60

            color: Maui.Theme.alternateBackgroundColor
            radius: 5

            Label {
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

                Action
                {
                    text: "Thin"
                    checked: {
                        if (MiscBackend.fontThick == 0) {
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
                    onTriggered: MiscBackend.setFontThick(0)
                }
                Action
                {
                    text: "Light"
                    checked: {
                        if (MiscBackend.fontThick == 1) {
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
                    onTriggered: MiscBackend.setFontThick(1)
                }
                Action
                {
                    text: "Bold"
                    checked: {
                        if (MiscBackend.fontThick == 2) {
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
