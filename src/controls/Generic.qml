import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page {

    id: generic

    anchors.fill: parent
    anchors.margins: 10

    headBar.visible: false

    property var scrollBarPolicy: ["Always visible", "Visible when needed", "Auto hide", "Always hidden"]

    AccessibilityManager {
        id: accessibilityManager
    }

    Maui.SectionGroup {

        anchors.left: parent.left
        anchors.right: parent.right

        template.label1.text: i18n("Behavior and Generic Options")
        template.label1.font.weight: Font.Bold
        template.label1.font.pixelSize: 20

        description: "Browsing options and notifications"

        Maui.FlexSectionItem {
            label1.text: i18n("Single Click")
            label2.text: i18n("Open items with a single click")

            Switch {
                checkable: true
                checked: accessibilityManager.singleClick
                onToggled: accessibilityManager.singleClick = visualPosition == 0 ? false : true
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Scrollbar Policy")
            label2.text: i18n("How to display the scrollbar")

            Label {
                text: scrollBarPolicy[accessibilityManager.scrollBarPolicy]
            }

            Button {
                icon.name: scrollBarPolicySection.expanded ? "arrow-up" : "arrow-down"
                icon.width: 22
                icon.height: 22
                flat: true
                onClicked: scrollBarPolicySection.expanded = !scrollBarPolicySection.expanded
            }
        }

        Maui.SectionItem {

            id: scrollBarPolicySection

            label2.text: i18n("Show more options")
            label2.visible: expanded ? false : true

            property alias expanded: list.expanded

            //visible: expanded ? true : false

            ListView {
                id: list

                property bool expanded: false

                Layout.fillWidth: true

                Behavior on y {
                    NumberAnimation { duration: 250 }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }

                width: parent.width
                height: expanded ? 40 * scrollBarPolicy.length + spacing * scrollBarPolicy.length - 5 * scrollBarPolicy.length : 0
                y: expanded ? 0 : -10
                opacity: expanded ? 1 : 0
                spacing: 5

                currentIndex: accessibilityManager.scrollBarPolicy

                onWidthChanged: list.Layout.preferredWidth = width
                onHeightChanged: list.Layout.preferredHeight = height

                Component.onCompleted: {
                    list.y = -10
                }

                model: scrollBarPolicy

                delegate: Maui.ListBrowserDelegate {

                    id: listBrowserDelegate

                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 40
                    label2.text: scrollBarPolicy[index]
                    checkable: false
                    checked: list.currentIndex == index ? true : false

                    onClicked: {
                        accessibilityManager.scrollBarPolicy = index
                        list.currentIndex = index
                    }
                }
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Play Sounds")
            label2.text: i18n("Sets wether apps emit alarm sounds or notifications")

            Switch {
                checkable: true
                checked: accessibilityManager.playSounds
                onToggled: accessibilityManager.playSounds = visualPosition == 0 ? false : true
            }
        }
    }
}
