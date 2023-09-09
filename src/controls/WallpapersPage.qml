import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.15
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: pgWallpapers

    headBar.visible: false

    Component.onCompleted: {
        getWallpapers()
        wallpapersView.currentIndex = WallpapersBackend.selectedWallpaper
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

    Controls.Label {
        id: labelWallpaper
        x: 20
        y: 15
        text: "Wallpapers"
        font.pixelSize: 30
    }

    GridView {
        id: wallpapersView

        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.topMargin: 50 + labelWallpaper.y

        model: wallpapersModel
        delegate: Maui.GridBrowserDelegate
        {
            implicitWidth: 80
            implicitHeight: 80

            Rectangle {
                id: paperRect
                anchors.fill: parent
                radius: 3

                Image {
                    id: wallpaperImage

                    anchors.fill: parent
                    asynchronous: true
                    fillMode: Image.PreserveAspectCrop
                    source: Qt.resolvedUrl("file://" + paperUrl)

                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Item {
                            width: wallpaperImage.width
                            height: wallpaperImage.height
                            Rectangle {
                                anchors.centerIn: parent
                                width: wallpaperImage.width
                                height: wallpaperImage.height
                                radius: 4
                            }
                        }
                    }
                }
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
