import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page {

    id: formFactor

    anchors.fill: parent
    anchors.margins: 10

    headBar.visible: false

    enum PreferredMode {
        Desktop,
        Tablet,
        Phone
    }

    FormFactorManager {
        id: formFactorManager
    }

    Maui.SectionGroup {

        width: parent.width

        Layout.fillHeight: true

        template.label1.text: i18n("Form Factor")
        template.label1.font.weight: Font.Bold
        template.label1.font.pixelSize: 20

        description: i18n("System form factor properties")

        Maui.FlexSectionItem {
            label1.text: i18n("Mode")
            label2.text: i18n("The preferred mode to display information")

            Maui.ToolActions {
                Action {
                    text: "Desktop"
                    checkable: true
                    checked: formFactorManager.preferredMode == FormFactor.PreferredMode.Desktop ? true : false
                    onTriggered: formFactorManager.preferredMode = FormFactor.PreferredMode.Desktop
                }
                Action {
                    text: "Tablet"
                    checkable: true
                    checked: formFactorManager.preferredMode == FormFactor.PreferredMode.Tablet ? true : false
                    onTriggered: formFactorManager.preferredMode = FormFactor.PreferredMode.Tablet
                }
                Action {
                    text: "Phone"
                    checkable: true
                    checked: formFactorManager.preferredMode == FormFactor.PreferredMode.Phone ? true : false
                    onTriggered: formFactorManager.preferredMode = FormFactor.PreferredMode.Phone
                }
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Force Touch Screen")
            label2.text: i18n("Force interaction with the screen if a device is not detected to have a touch screen and still has it")

            Switch {
                checkable: true
                checked: formFactorManager.forceTouchScreen
                onToggled: formFactorManager.forceTouchScreen = visualPosition == 0 ? false : true
            }
        }

        /*
        Maui.SectionGroup {
            title: i18n("Form Factor Info")
            //description: i18n("Contains information about the input devices available in the current system")

            Maui.FlexSectionItem {
                label1.text: i18n("Best Mode")
                label2.text: i18n("The best mode according to available input devices in the current system")
            }
        }
        */
    }
}
