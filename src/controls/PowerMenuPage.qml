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
                _stackView.push("qrc:/PowerACPage.qml")
            }
        }
    ]

    ListModel {
        id: powerModel
        ListElement { name: "AC" ; description: "AC" ; icon: "battery-ups" }
        ListElement { name: "Battery" ; description: "Battery" ; icon: "battery-080" }
        ListElement { name: "Low battery" ; description: "Low battery" ; icon: "battery-caution" }
    }

    ListView {
        id: powerMenuView
        anchors.fill: parent			// dimensión completa de la vista de lista
        anchors.margins: 10			// espaciado exterior

        spacing: 5				// espaciado entre elementos de la lista

        model: powerModel
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
                            powerMenuView.currentIndex = index
                            _stackView.push("qrc:/PowerACPage.qml")
                            return
                        }
                        case 1: {
                            powerMenuView.currentIndex = index
                            _stackView.push("qrc:/PowerBatteryPage.qml")
                            return
                        }
                        case 2: {
                            powerMenuView.currentIndex = index
                            _stackView.push("qrc:/PowerLowBatteryPage.qml")
                            return
                        }
                    }
                }
            }
        }
    }
}
