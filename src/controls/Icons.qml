import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page {
    id: icons

    anchors.fill: parent
    anchors.margins: 10

    headBar.visible: false

    property var iconSize: [16, 22, 32, 48, 64, 128]

    Maui.SectionGroup {
        width: parent.width

        Layout.fillHeight: true

        template.label1.text: i18n("Icons")
        template.label1.font.weight: Font.Bold
        template.label1.font.pixelSize: 20

        description: i18n("The preferred icon theme")

        Maui.FlexSectionItem {
            label1.text: i18n("Icon Theme")
            label2.text: i18n("The preferred theme")

            visible: false

            Label {
                text: themeManager.iconTheme
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Icon Size")
            label2.text: i18n("The preferred size on the icons")

            SpinBox {
                id: spinBox

                from: 0
                to: iconSize.length - 1
                value: iconSize.indexOf(themeManager.iconSize)

                validator: RegularExpressionValidator {
                    regularExpression: RegExp("16|22|32|48|64|128", "i")
                }

                textFromValue: function(value) {
                    return iconSize[value]
                }

                valueFromText: function(text) {
                    for (var i = 0; i < iconSize.length; i++) {
                        if (iconSize[i].toLowerCase().indexOf(text.toLowerCase()))
                            return i
                    }
                    return spinBox.value
                }

                onValueModified: {
                    themeManager.iconSize = iconSize[value]
                }
            }
        }
    }
}
