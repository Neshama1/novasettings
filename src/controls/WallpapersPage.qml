import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.15
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: wallpapersPage

    headBar.visible: false

    Component.onCompleted: {
        getWallpapers()
        //wallpapersView.currentIndex = WallpapersBackend.selectedWallpaper
        wallpapersView.currentIndex = -1
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: wallpapersPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: wallpapersPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getWallpapers() {
        WallpapersBackend.getThemes()
        var fcount = WallpapersBackend.filesCount
        for (var i = 0 ; i < fcount ; i++) {
            wallpapersModel.append({"name": WallpapersBackend.wallpapers[i].name,"paperUrl": WallpapersBackend.wallpapers[i].paperUrl,"selected": WallpapersBackend.wallpapers[i].selected,"paperSizes": WallpapersBackend.wallpapers[i].paperSizes,"paperSizesAvailable": WallpapersBackend.wallpapers[i].paperSizesAvailable})
        }
    }

    ListModel {
        id: wallpapersModel
    }

    GridView {
        id: wallpapersView

        anchors.fill: parent
        anchors.margins: 20

        cellWidth: 80
        cellHeight: 95

        model: wallpapersModel
        delegate: Maui.GridBrowserDelegate
        {
            implicitWidth: 75
            implicitHeight: 90

            Maui.IconItem
            {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                imageSource: Qt.resolvedUrl("file://" + paperUrl)
                imageSizeHint: 75
                maskRadius: Maui.Style.radiusV
                fillMode: Image.PreserveAspectCrop
            }

            label2.text: name

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var fcount = WallpapersBackend.filesCount
                    for (var i = 0 ; i < fcount ; i++) {
                        wallpapersModel.setProperty(i, "selected", false)
                    }
                    wallpapersModel.setProperty(index, "selected", true)
                    WallpapersBackend.setSelectedWallpaper(index)
                    wallpapersView.currentIndex = index
                }
            }
        }
    }
}
