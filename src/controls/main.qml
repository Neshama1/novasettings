import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FB

import org.kde.novasettings 1.0

Maui.ApplicationWindow
{
    id: root
    title: qsTr("Astro")

    Component.onCompleted: {
        _stackView.push("qrc:/ColorSchemesPage.qml")
    }

    // Datos del menú

    ListModel {
    id: startMenuModel

        ListElement { name: "Colors" ; description: "Choose color scheme" ; icon: "preferences-desktop-color" }
        ListElement { name: "Plasma Style" ; description: "Choose plasma style" ; icon: "preferences-desktop-plasma-theme" }
        ListElement { name: "Wallpapers" ; description: "Choose wallpaper" ; icon: "preferences-desktop-wallpaper" }
        ListElement { name: "About the system" ; description: "About the system" ; icon: "help-about-symbolic" }
        ListElement { name: "Misc" ; description: "Configure other options" ; icon: "love" }
    }

    Maui.SideBarView
    {
        id: _sideBarView
        anchors.fill: parent

        sideBarContent:  Maui.Page
        {
            id: sideBarPage

            anchors.fill: parent
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
                }
            ]

            // Relleno de menú

            ListView {
                id: menuView
                anchors.fill: parent
                anchors.margins: 10

                spacing: 5

                model: startMenuModel
                delegate: Maui.ListBrowserDelegate
                {
                    id: list1
                    implicitWidth: parent.width
                    implicitHeight: 35
                    iconSource: icon
                    label1.text: name

//                    isCurrentItem: startMenuModel.currentIndex === index

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            switch (index) {
                                case 0: {
                                    menuView.currentIndex = index
                                    _stackView.push("qrc:/ColorSchemesPage.qml")
                                    return
                                }
                                case 1: {
                                    menuView.currentIndex = index
                                    _stackView.push("qrc:/PlasmaStylePage.qml")
                                    return
                                }
                                case 2: {
                                    menuView.currentIndex = index
                                    _stackView.push("qrc:/WallpapersPage.qml")
                                    return
                                }
                                case 3: {
                                    menuView.currentIndex = index
                                    _stackView.push("qrc:/AboutSystemPage.qml")
                                    return
                                }
                                case 4: {
                                    menuView.currentIndex = index
                                    _stackView.push("qrc:/MiscPage.qml")
                                    return
                                }
                            }
                        }
                    }
                }
            }

            StackView {
                id:_stackViewMenu
                anchors.fill: parent
                clip: true
            }
        }

        Maui.Page
        {
            anchors.fill: parent
            showCSDControls: true

            headBar.background: null
            headBar.farRightContent: [
                ToolButton
                {
                    icon.name: "dialog-ok-apply"
                }
            ]

            StackView {
                id:_stackView
                anchors.fill: parent
                clip: true
            }
        }
    }
}
