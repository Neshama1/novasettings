import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: mousePage

    property bool leftHanded
    property bool flatAccelProfile
    property int pointerAcceleration

    headBar.visible: false

    Component.onCompleted: {
        opacityAnimation.start()
        xAnimation.start()
        getLeftHanded()
        getFlatAccelProfile()
        getPointerAcceleration()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: mousePage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: mousePage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getLeftHanded() {
        MouseBackend.getLeftHanded()
        leftHanded = MouseBackend.leftHanded
    }

    function getFlatAccelProfile() {
        MouseBackend.getFlatAccelProfile()
        flatAccelProfile = MouseBackend.flatAccelProfile
    }

    function getPointerAcceleration() {
        MouseBackend.getPointerAcceleration()
        pointerAcceleration = MouseBackend.pointerAcceleration
    }

    Timer {
        id: notificationMouse
        interval: 2000; running: false; repeat: false
        onTriggered: {
            root.notify("notifications","Mouse","You must restart the session for the changes to take effect",null,5000,"Accept")
        }
    }

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        height: 50 * 3

        template.label1.text: i18n("Mouse")
        template.label1.font.weight: Font.Normal
        template.label1.font.pixelSize: 20

        description: i18n("Adjust mouse behavior")

        Maui.SectionItem
        {
            template.label1.text: i18n("Left handed")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Mode")

            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: leftHanded ? true : false
                onToggled: {
                    visualPosition == 0 ? MouseBackend.setLeftHanded(false) : MouseBackend.setLeftHanded(true)
                    notificationMouse.start()
                }
            }
        }

        Maui.SectionItem
        {
            template.label1.text: i18n("Flat acceleration profile")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Set the acceleration profile")

            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: flatAccelProfile ? true : false
                onToggled: {
                    visualPosition == 0 ? MouseBackend.setFlatAccelProfile(false) : MouseBackend.setFlatAccelProfile(true)
                    notificationMouse.start()
                }
            }
        }

        Maui.SectionItem
        {
            template.label1.text: i18n("Pointer speed")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Set pointer acceleration")

            SpinBox {
                id: spinBox
                from: 0
                to: items.length - 1
                value: pointerAcceleration

                property var items: ["-1", "-0.8", "-0.6", "-0.4", "-0.2", "0", "0.2", "0.4", "0.6", "0.8", "1"]

                validator: RegularExpressionValidator {
                    regularExpression: new RegExp("(-1|-0.8|-0.6|-0.4|-0.2|0|0.2|0.4|0.6|0.8|1)", "i")
                }

                textFromValue: function(value) {
                    return items[value];
                }

                valueFromText: function(text) {
                    for (var i = 0; i < items.length; ++i) {
                        if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                            return i
                    }
                    return spinBox.value
                }
                onValueModified: {
                    MouseBackend.setPointerAcceleration(value)
                    notificationMouse.start()
                }
            }
        }
    }
}
