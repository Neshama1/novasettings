import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page {
    id: theme

    anchors.fill: parent
    anchors.margins: 10

    headBar.visible: false

    Component.onCompleted: {
        console.info("Allow custom styling", themeManager.allowCustomStyling)
    }

    ColumnLayout {

        width: parent.width
        spacing: 0

        Maui.SectionGroup {
            width: parent.width

            template.label1.text: i18n("Theme")
            template.label1.font.weight: Font.Bold
            template.label1.font.pixelSize: 20

            description: i18n("Manage theme preferences")

            Maui.FlexSectionItem {
                label1.text: i18n("Theme")
                label2.text: i18n("Light, dark and system theme")

                Maui.ToolActions {
                    Action {
                        text: "Light"
                        checkable: true
                        checked: themeManager.styleType == 0 ? true : false
                        onTriggered: themeManager.styleType = 0
                    }
                    Action {
                        text: "Dark"
                        checkable: true
                        checked: themeManager.styleType == 1 ? true : false
                        onTriggered: themeManager.styleType = 1
                    }
                    Action {
                        text: "System"
                        checkable: true
                        checked: themeManager.styleType == 3 ? true : false
                        onTriggered: themeManager.styleType = 3
                    }
                    Action {
                        text: "Adaptive"
                        checkable: true
                        checked: themeManager.styleType == 2 ? true : false
                        onTriggered: themeManager.styleType = 2
                    }
                    Action {
                        text: "Black"
                        checkable: true
                        checked: themeManager.styleType == 4 ? true : false
                        onTriggered: themeManager.styleType = 4
                    }
                    Action {
                        text: "Inverted"
                        checkable: true
                        checked: themeManager.styleType == 5 ? true : false
                        onTriggered: themeManager.styleType = 5
                    }
                }
            }

            Maui.FlexSectionItem {
                label1.text: i18n("Allow custom style")
                label2.text: i18n("Change the visual theme with a Qt Quick Controls style for MauiKit")

                Switch {
                    checkable: true
                    checked: themeManager.allowCustomStyling
                    onToggled: themeManager.allowCustomStyling = visualPosition == 0 ? false : true
                }
            }

            Maui.FlexSectionItem {
                label1.text: i18n("Spacing")
                label2.text: i18n("Spacing between elements in a list or browsing elements")

                SpinBox {
                    from: 0
                    to: 20
                    value: themeManager.spacingSize
                    onValueModified: {
                        startTransition()
                        themeManager.spacingSize = value
                    }
                }
            }

            Maui.FlexSectionItem {
                label1.text: i18n("Padding")
                label2.text: i18n("Padding for the UI elements such as buttons, tool bars, menu entries")

                SpinBox {
                    from: 0
                    to: 10
                    value: themeManager.paddingSize
                    onValueModified: {
                        startTransition()
                        themeManager.paddingSize = value
                    }
                }
            }

            Maui.FlexSectionItem {
                label1.text: i18n("Margins")
                label2.text: i18n("The margin around views")

                SpinBox {
                    from: 0
                    to: 20
                    value: themeManager.marginSize
                    onValueModified: {
                        startTransition()
                        themeManager.marginSize = value
                    }
                }
            }

            Maui.FlexSectionItem {
                label1.text: i18n("Border Radius")
                label2.text: i18n("The corner border radius of the elements")

                SpinBox {
                    from: 0
                    to: 10
                    value: themeManager.borderRadius
                    onValueModified: themeManager.borderRadius = value
                }
            }

            Maui.FlexSectionItem {
                id: dropdown

                property bool expanded: false

                Behavior on label2.opacity {
                    NumberAnimation { duration: 100 }
                }

                label2.text: expanded ? i18n("Hide options") : i18n("Show more options")

                Button {
                    icon.name: dropdown.expanded ? "arrow-up" : "arrow-down"
                    icon.width: 22
                    icon.height: 22
                    flat: true
                    onClicked: dropdown.expanded = !dropdown.expanded
                }
            }

            Maui.FlexSectionItem {
                id: csd

                visible: dropdown.expanded
                opacity: dropdown.expanded ? 1 : 0
                Layout.topMargin: dropdown.expanded ? 0 : -10

                Behavior on Layout.topMargin {
                    NumberAnimation { duration: 250 }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }

                label1.text: i18n("CSD")
                label2.text: i18n("Enable client side decorations for maui apps")

                Switch {
                    checkable: true
                    checked: themeManager.enableCSD
                    onToggled: themeManager.enableCSD = visualPosition == 0 ? false: true
                }
            }

            Maui.FlexSectionItem {
                id: effects

                visible: dropdown.expanded
                opacity: dropdown.expanded ? 1 : 0

                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }

                Component.onCompleted: {
                    effects.y = -10
                }
                label1.text: i18n("Effects")
                label2.text: i18n("Enable visual effects such as animations or blur")

                Switch {
                    checkable: true
                    checked: themeManager.enableEffects
                    onToggled: themeManager.enableEffects = visualPosition == 0 ? false : true
                }
            }
        }

        Maui.SectionGroup {

            title: "Accent"

            Maui.SectionItem {

                label1.text: i18n("Color")
                label2.text: i18n("The accent color used for the highlighted and checked states")

                Maui.ColorsRow {

                    defaultColor: "#65f6cf"
                    currentColor: themeManager.accentColor

                    colors: ["#65f6cf", "#16bf91", "#04624c", "lightskyblue", "deepskyblue", "dodgerblue", "lightgrey", "silver", "dimgrey"]

                    onColorPicked: (color) =>
                    {
                        themeManager.accentColor = color
                    }
                }
            }
        }

        Maui.SectionGroup {

            visible: false

            title: "Accent"

            Maui.FlexSectionItem {
                label1.text: i18n("Color")
                label2.text: i18n("The accent color used for the highlighted and checked states")

                Maui.ColorsRow {

                    defaultColor: "aquamarine"
                    currentColor: themeManager.accentColor

                    colors: ["aquamarine", "mediumspringgreen", "limegreen", "lightskyblue", "deepskyblue", "dodgerblue", "lightgrey", "silver", "dimgrey"]

                    onColorPicked: (color) =>
                    {
                        themeManager.accentColor = color
                    }
                }
            }
        }
    }
}
