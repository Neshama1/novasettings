import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.workspace.components as PW
import org.kde.plasma.workspace.keyboardlayout as KL
import org.kde.plasma.private.kcm_keyboard as KCMKeyboard
import Nemo.DBus

Maui.Page {
    id: keyboard

    anchors.fill: parent
    anchors.margins: 10

    property var layouts
    property var currentLayout

    headBar.visible: false

    InputDevicesManager {
        id: inputDevicesManager
    }

    KeyboardGlobal {
        id: keyboardGlobal
    }

    DBusConnection {
        id: dbusConnection
    }

    PW.KeyboardLayoutSwitcher {
        id: kbswitcher
    }

    KeyboardLayout {
        id: keyboardLayout
    }
    /*
    DBusInterface {
        id: dbusConnection

        service: "org.kde.keyboard"
        path: "/Layouts"
        iface: "org.kde.KeyboardLayouts"

        Component.onCompleted: {
            dbusConnection.typedCall("getLayoutsList", [], function(result) {
                console.info("Resultado", result);
            })
        }
    }
    */

    Component.onCompleted: {

        currentLayout = dbusConnection.get("org.kde.keyboard", "/Layouts", "org.kde.KeyboardLayouts", "getLayoutsList")
        console.info(currentLayout.toString())

        var kblayouts = Qt.inputMethod.keyboard.layouts
        var selectedLayout

        for (var i = 0; i < kblayouts.length; i++) {
            var kblayout = kblayouts[i]
            if (kblayout.language === "it" && kblayout.name === "Italian") {
                selectedLayout = kblayout.name
                Qt.inputMethod.keyboard.activeLayout = selectedLayout
            }
        }

        console.info("layout activo", selectedLayout)

        layouts = keyboardGlobal.getKbLayouts()

        for (var i = 0; i < layouts.length; i++) {

            console.info(layouts[i].name, layouts[i].description)

            if (layouts[i].variantsName.length != layouts[i].variantsDescription.length) {
                console.info("nombres y descripciones en variantes no coinciden para idioma", layouts[i].name, layouts[i].description)
            }

            var variantsName = layouts[i].variantsName

            console.info("variants name:", variantsName.length)

            for (var j = 0; j < variantsName.length; j++) {
                console.info(layouts[i].name, "variant name", j, variantsName[j])
            }

            var variantsDescription = layouts[i].variantsDescription

            console.info("variants description:", variantsDescription.length)

            for (var j = 0; j < variantsDescription.length; j++) {
                console.info(layouts[i].name, "variant description", j, variantsDescription[j])
            }
        }
    }

    Maui.SectionGroup {

        width: parent.width
        height: parent.height

        template.label1.text: i18n("Keyboard")
        template.label1.font.weight: Font.Bold
        template.label1.font.pixelSize: 20

        description: i18n("Input devices properties")

        Maui.FlexSectionItem {
            label1.text: i18n("Keyboard Layout")
            label2.text: i18n("The preferred keyboard language")

            /*
            Label {
                text: textInput.keyboardLayout.currentLayout
                //text: keyboardLayout.currentLayout
            }
            */

            Button {
                icon.name: layoutSection.expanded ? "arrow-up" : "arrow-down"
                icon.width: 22
                icon.height: 22
                flat: true
                onClicked: layoutSection.expanded = !layoutSection.expanded
            }
        }

        Maui.SectionItem {

            id: layoutSection

            Layout.fillHeight: true

            label2.text: i18n("Show more options")
            label2.visible: expanded ? false : true

            property alias expanded: list.expanded

            //visible: expanded ? true : false

            ListView {
                id: list

                property bool expanded: true

                Layout.fillWidth: true
                Layout.fillHeight: true

                clip: true

                Behavior on y {
                    NumberAnimation { duration: 250 }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }

                width: parent.width
                //height: expanded ? parent.height : 0
                y: expanded ? 0 : -10
                opacity: expanded ? 1 : 0
                spacing: 5

                //currentIndex: accessibilityManager.scrollBarPolicy

                onWidthChanged: list.Layout.preferredWidth = width
                onHeightChanged: list.Layout.preferredHeight = height

                Component.onCompleted: {
                    list.y = -10
                }

                model: kbswitcher.keyboardLayout.layoutsList

                //model: layouts

                delegate: Maui.ListBrowserDelegate {

                    id: listBrowserDelegate

                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 40

                    label2.text: kbswitcher.keyboardLayout.layoutsList[index].longName

                    //label2.text: layouts[index].description

                    checkable: false
                    checked: list.currentIndex == index ? true : false

                    onClicked: {
                        //accessibilityManager.scrollBarPolicy = index
                        list.currentIndex = index
                    }
                }
            }
        }
    }
}
