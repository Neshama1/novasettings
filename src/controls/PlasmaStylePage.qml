import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: pgPlasma

    headBar.visible: false

    Component.onCompleted: {
        getPlasmaStyles()
        plasmaView.currentIndex = PlasmaStyleBackend.selectedStyle
    }

    function getPlasmaStyles() {
        PlasmaStyleBackend.getThemes()
        var fcount = PlasmaStyleBackend.stylesCount
        for (var i = 0 ; i < fcount ; i++) {
            plasmaStyleModel.append({"name": PlasmaStyleBackend.plasmaStyles[i].name,"folder": PlasmaStyleBackend.plasmaStyles[i].folder,"path": PlasmaStyleBackend.plasmaStyles[i].path,"selected": PlasmaStyleBackend.plasmaStyles[i].selected,"plasmaColor": PlasmaStyleBackend.plasmaStyles[i].plasmaColor,"followSystem": PlasmaStyleBackend.plasmaStyles[i].followSystem})
        }
    }

    ListModel {
        id: plasmaStyleModel
    }

    Controls.Label {
        id: labelPlasma
        x: 20
        y: 15
        text: "Plasma style"
        font.pixelSize: 30
    }

    GridView {
        id: plasmaView

        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.topMargin: 50 + labelPlasma.y

        model: plasmaStyleModel
        delegate: Maui.GridBrowserDelegate
        {
            implicitWidth: 80
            implicitHeight: 80

            Rectangle {
                anchors.fill: parent
                color: plasmaColor
                radius: 3

                Maui.Badge
                {
                    visible: followSystem ? true: false
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 4
                    text: "S"
                }
            }

            label2.text: name

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var fcount = PlasmaStyleBackend.stylesCount
                    for (var i = 0 ; i < fcount ; i++) {
                        plasmaStyleModel.setProperty(i, "selected", false)
                    }
                    plasmaStyleModel.setProperty(index, "selected", true)
                    PlasmaStyleBackend.setSelectedStyle(index)
                    plasmaView.currentIndex = index
                }
            }
        }
    }
}
