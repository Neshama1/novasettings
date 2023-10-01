import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: mainMenuPage

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

    ListModel {
    id: mainMenuModel
        ListElement { name: "General behavior" ; description: "Configure other options" ; icon: "love" }
        ListElement { name: "Mouse" ; description: "Mouse" ; icon: "input-mouse" }
        ListElement { name: "Virtual desktops" ; description: "Virtual desktops" ; icon: "virtual-desktops" }
        ListElement { name: "Power management" ; description: "Power management" ; icon: "battery-ups" }
        ListElement { name: "Appearance" ; description: "Appearance" ; icon: "edit-paste-style" }
        ListElement { name: "About the system" ; description: "About the system" ; icon: "help-about-symbolic" }
    }

    ListView {
        id: menuView
        anchors.fill: parent
        anchors.margins: 10

        spacing: 5

        model: mainMenuModel
        delegate: Maui.ListBrowserDelegate
        {
            id: list1
            implicitWidth: parent.width
            implicitHeight: 35
            iconSource: icon
            label1.text: name

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    switch (index) {
                        case 0: {
                            menuView.currentIndex = index
                            _stackView.push("qrc:/MiscPage.qml")
                            return
                        }
                        case 1: {
                            menuView.currentIndex = index
                            _stackView.push("qrc:/MousePage.qml")
                            return
                        }
                        case 2: {
                            menuView.currentIndex = index
                            _stackView.push("qrc:/VirtualDesktopsPage.qml")
                            return
                        }
                        case 3: {
                            menuView.currentIndex = index
                            _stackViewMenu.push("qrc:/PowerMenuPage.qml")
                            _stackView.push("qrc:/PowerACPage.qml")
                            return
                        }
                        case 4: {
                            menuView.currentIndex = index
                            _stackViewMenu.push("qrc:/AppearanceMenuPage.qml")
                            _stackView.push("qrc:/QtStylePage.qml")
                            return
                        }
                        case 5: {
                            menuView.currentIndex = index
                            _stackView.push("qrc:/AboutSystemPage.qml")
                            return
                        }
                    }
                }
            }
        }
    }
}
