import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page {
    id: fonts

    anchors.fill: parent
    anchors.margins: 10

    headBar.visible: false

    Item {
        id: currentFont
        property string fontstr
        property string name
        property var styles
        property var sizes
    }

    Maui.FontPickerModel {
        id: fontPicker
    }

    Component.onCompleted: {
        getCurrentFont()
    }

    Maui.SectionGroup {
        width: parent.width
        height: parent.height

        template.label1.text: i18n("Fonts")
        template.label1.font.weight: Font.Bold
        template.label1.font.pixelSize: 20

        description: i18n("The preferred font")

        Maui.FlexSectionItem {
            id: dropdown

            property bool expanded: false

            label1.text: i18n("Fonts")
            label2.text: i18n("The current picked option")

            Label {
                text: currentFont.name
            }

            Button {
                icon.name: dropdown.expanded ? "arrow-up" : "arrow-down"
                icon.width: 22
                icon.height: 22
                flat: true
                onClicked: dropdown.expanded = !dropdown.expanded
            }
        }

        Maui.SectionItem {
            label2.text: i18n("Show more options")

            Layout.fillHeight: dropdown.expanded
            clip: true

            Maui.ListBrowser {
                id: list

                width: parent.width
                height: parent.height

                visible: dropdown.expanded
                opacity: dropdown.expanded ? 1 : 0

                Layout.fillHeight: true
                Layout.topMargin: dropdown.expanded ? 0 : -10

                currentIndex: fontPicker.fontsModel.indexOf(currentFont.name)

                verticalScrollBarPolicy: ScrollBar.AsNeeded

                clip: true

                Behavior on Layout.topMargin {
                    NumberAnimation { duration: 250 }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 250 }
                }

                model: fontPicker.fontsModel

                delegate: Maui.ListBrowserDelegate {
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 40
                    label2.text: modelData
                    checkable: false
                    checked: list.currentIndex == index ? true : false

                    onClicked: {
                        list.currentIndex = index
                        var name = fontPicker.fontsModel[index]
                        themeManager.defaultFont = name
                        //var qfont = Qt.font({family: name})
                        //fontPicker.setFont(qfont)
                        fontPicker.updateModel()
                        getCurrentFont()
                    }
                }
            }
        }

        Maui.FlexSectionItem {
            id: styles

            property bool expanded: false

            visible: !dropdown.expanded

            label1.text: i18n("Styles")
            label2.text: i18n("The available styles for the current font")

            Label {
                //text: currentFont.name
            }

            Button {
                icon.name: styles.expanded ? "arrow-up" : "arrow-down"
                icon.width: 22
                icon.height: 22
                flat: true
                onClicked: styles.expanded = !styles.expanded
            }
        }

        Maui.SectionItem {
            visible: styles.expanded
            clip: true

            Layout.fillHeight: styles.expanded

            Maui.ListBrowser {
                id: styleslist

                width: parent.width
                height: parent.height

                visible: styles.expanded
                opacity: styles.expanded ? 1 : 0

                Layout.fillHeight: true
                Layout.topMargin: styles.expanded ? 0 : -10

                verticalScrollBarPolicy: ScrollBar.AsNeeded

                clip: true

                Behavior on Layout.topMargin {
                    NumberAnimation { duration: 250 }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 250 }
                }

                model: fontPicker.styles

                delegate: Maui.ListBrowserDelegate {
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 40
                    label2.text: modelData
                    checkable: false
                    checked: styleslist.currentIndex == index ? true : false

                    onClicked: {
                        list.currentIndex = index
                    }
                }
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Monospaced")
            label2.text: i18n("Show only monospaced fonts")

            visible: dropdown.expanded || styles.expanded ? false : true

            Switch {
                checkable: true
                checked: fontPicker.onlyMonospaced
                onToggled: {
                    fontPicker.onlyMonospaced = visualPosition === 0 ? false : true
                    fontPicker.fontsModelChanged()
                }
            }
        }

        Rectangle {
            color: "transparent"
            Layout.fillHeight: true
        }
    }

    // FUNCTIONS

    function getCurrentFont() {
        currentFont.fontstr = fontPicker.fontToString()

        var fontspl = currentFont.fontstr.split(",")

        currentFont.name = fontspl[0]
        currentFont.styles = fontPicker.styles()
        currentFont.sizes = fontPicker.sizes()
    }
}
