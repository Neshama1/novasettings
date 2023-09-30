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
        _stackViewMenu.push("qrc:/MainMenuPage.qml")
        _stackView.push("qrc:/MiscPage.qml")
    }

    Maui.SideBarView
    {
        id: _sideBarView
        anchors.fill: parent

        sideBarContent:  Maui.Page
        {
            id: sideBarPage

            anchors.fill: parent
            headBar.visible: false
            Maui.Theme.colorSet: Maui.Theme.Window
/*
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
*/
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
                /*ToolButton
                {
                    icon.name: "dialog-ok-apply"
                }*/
            ]

            StackView {
                id:_stackView
                anchors.fill: parent
                clip: true
            }
        }
    }
}
