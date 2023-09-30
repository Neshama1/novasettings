import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    Maui.Theme.colorSet: Maui.Theme.Window

    headBar.leftContent: [
        Maui.ToolButtonMenu
        {
            icon.name: "application-menu"

            MenuItem
            {
                text: i18n("Settings")
                icon.name: "settings-configure"
            }

            MenuItem
            {
                text: i18n("About")
                icon.name: "documentinfo"
                onTriggered: root.about()
            }
        }
    ]

    headBar.rightContent: [
        ToolButton
        {
            icon.name: "draw-arrow-back"
            onClicked: {
                _stackViewMenu.pop()
                _stackView.push("qrc:/QtStylePage.qml")
            }
        }
    ]

    ListModel {
        id: appareanceModel
        ListElement { name: "Qt style" ; description: "Choose Qt Style" ; icon: "pattern-qt-devel" }
        ListElement { name: "Plasma style" ; description: "Choose plasma style" ; icon: "preferences-desktop-plasma-theme" }
        ListElement { name: "Colors" ; description: "Choose color scheme" ; icon: "preferences-desktop-color" }
        ListElement { name: "Wallpapers" ; description: "Choose wallpaper" ; icon: "preferences-desktop-wallpaper" }
    }

    ListView {
        id: appareanceMenuView
        anchors.fill: parent			// dimensión completa de la vista de lista
        anchors.margins: 10			// espaciado exterior

        spacing: 5				// espaciado entre elementos de la lista

        model: appareanceModel
        delegate: Maui.ListBrowserDelegate
        {
            implicitWidth: parent.width	// anchura de un elemento de la lista
            implicitHeight: 35		// altura de un elemento de la lista

            iconSource: icon
            label1.text: name

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    switch (index) {
                        case 0: {
                            appareanceMenuView.currentIndex = index
                            _stackView.push("qrc:/QtStylePage.qml")
                            return
                        }
                        case 1: {
                            appareanceMenuView.currentIndex = index
                            _stackView.push("qrc:/PlasmaStylePage.qml")
                            return
                        }
                        case 2: {
                            appareanceMenuView.currentIndex = index
                            _stackView.push("qrc:/ColorSchemesPage.qml")
                            return
                        }
                        case 3: {
                            appareanceMenuView.currentIndex = index
                            _stackView.push("qrc:/WallpapersPage.qml")
                            return
                        }
                    }
                }
            }
        }
    }
}
