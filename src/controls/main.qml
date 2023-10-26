import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import QtQuick.Window 2.2
import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FB

import org.kde.novasettings 1.0

Maui.ApplicationWindow
{
    id: root
    title: qsTr("")

    width: Screen.desktopAvailableWidth - Screen.desktopAvailableWidth * 45 / 100
    height: Screen.desktopAvailableHeight - Screen.desktopAvailableHeight * 20 / 100

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
