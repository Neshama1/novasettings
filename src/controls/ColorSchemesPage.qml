import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FB
import org.kde.novasettings 1.0

Maui.Page
{
    id: pgColor

    headBar.visible: false

    Component.onCompleted: {
        getColorSchemes()
        colorView.currentIndex = ColorSchemesBackend.selectedScheme
    }

    function getColorSchemes() {
        ColorSchemesBackend.getThemes()
        var fcount = ColorSchemesBackend.filesCount
        for (var i = 0 ; i < fcount ; i++) {
            colorSchemesModel.append({"name": ColorSchemesBackend.colorSchemes[i].name,"titleBarColor": ColorSchemesBackend.colorSchemes[i].titleBarColor,"windowColor": ColorSchemesBackend.colorSchemes[i].windowColor,"selectionColor": ColorSchemesBackend.colorSchemes[i].selectionColor,"fileName": ColorSchemesBackend.colorSchemes[i].fileName,"path": ColorSchemesBackend.colorSchemes[i].path,"selected": ColorSchemesBackend.colorSchemes[i].selected})
        }
    }

    ListModel {
        id: colorSchemesModel
    }

    GridView {
        id: colorView

        anchors.fill: parent
        anchors.margins: 10

        model: colorSchemesModel
        delegate: Maui.GridBrowserDelegate
        {
            implicitWidth: 80
            implicitHeight: 80

            Rectangle {
                anchors.fill: parent
                color: windowColor
                radius: 3
            }

            label2.text: name

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var fcount = ColorSchemesBackend.filesCount
                    for (var i = 0 ; i < fcount ; i++) {
                        colorSchemesModel.setProperty(i, "selected", false)
                    }
                    colorSchemesModel.setProperty(index, "selected", true)
                    ColorSchemesBackend.setSelectedScheme(index)
                    colorView.currentIndex = index
                }
            }
        }
    }
}
