import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: plasmaPage

    headBar.visible: false

    Component.onCompleted: {
        getPlasmaStyles()
        plasmaView.currentIndex = PlasmaStyleBackend.selectedStyle
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: plasmaPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: plasmaPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
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

    GridView {
        id: plasmaView

        anchors.fill: parent
        anchors.margins: 20

        cellWidth: 85
        cellHeight: 95

        model: plasmaStyleModel
        delegate: Maui.GridBrowserDelegate
        {
            implicitWidth: 80
            implicitHeight: 90

            Rectangle {
                anchors.fill: parent
                anchors.bottomMargin: 20
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
                    plasmaStyleModel.clear()
                    getPlasmaStyles()
                    plasmaView.currentIndex = PlasmaStyleBackend.selectedStyle
                }
            }
        }
    }
}
