import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page {

    id: screen

    anchors.fill: parent
    anchors.margins: 10

    headBar.visible: false

    property var scaleFactor: [1, 1.25, 1.50, 1.75, 2]

    enum Orientation {
        Horizontal,
        Vertical
    }

    ScreenManager {
        id: screenManager
    }

    Maui.SectionGroup {

        width: parent.width

        Layout.fillHeight: true

        template.label1.text: i18n("Screen")
        template.label1.font.weight: Font.Bold
        template.label1.font.pixelSize: 20

        description: i18n("System screen properties")

        Maui.FlexSectionItem {
            label1.text: i18n("Orientation")
            label2.text: i18n("The preferred orientation")

            Maui.ToolActions {
                Action {
                    text: "Horizontal"
                    checkable: true
                    checked: screenManager.orientation == 0 ? true : false
                    onTriggered: screenManager.orientation = 0
                }
                Action {
                    text: "Vertical"
                    checkable: true
                    checked: screenManager.orientation == 1 ? true : false
                    onTriggered: screenManager.orientation = 1
                }
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Scale")
            label2.text: i18n("The preferred scale factor")

            SpinBox {
                id: spinBox

                from: 0
                to: scaleFactor.length - 1
                value: scaleFactor.indexOf(screenManager.scaleFactor)

                validator: RegularExpressionValidator {
                    regularExpression: RegExt("1|1.25|1.5|1.75|2", "i")
                }

                textFromValue: function(value) {
                    return scaleFactor[value]
                }

                valueFromText: function(text) {
                    for (var i = 0; i < scaleFactor.length; i++) {
                        if (scaleFactor[i].toLowerCase().indexOf(text.toLowerCase()))
                            return i
                    }
                    return spinBox.value
                }

                onValueModified: {
                    screenManager.scaleFactor = scaleFactor[value]
                }
            }
        }
    }
}
