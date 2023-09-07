import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FB
import org.kde.novasettings 1.0

Maui.Page
{
    Maui.Theme.colorSet: Maui.Theme.Window

    ListModel {
        id: appareanceModel

        ListElement { name: "Colors" ; description: "Choose color scheme" ; iconItem: "preferences-desktop-color" }
        ListElement { name: "Plasma Style" ; description: "Choose plasma style" ; iconItem: "preferences-desktop-plasma-theme" }
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
                            return
                        }
                        case 1: {
                            appareanceMenuView.currentIndex = index
                            return
                        }
                    }
                }
            }
        }
    }
}
