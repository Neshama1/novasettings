import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page {

    id: menu

    anchors.fill: parent

    Maui.Theme.colorSet: Maui.Theme.Window

    ListModel {
        id: menuModel

        ListElement { name: "Generic" ; description: "Generic options" ; icon: "favorite" }
        ListElement { name: "Form Factor" ; description: "System form factor properties" ; icon: "desktop" }
        ListElement { name: "Screen" ; description: "Screen properties" ; icon: "preferences-desktop-display" }
        ListElement { name: "Theme" ; description: "Change visual theme" ; icon: "edit-paste-style"}
        ListElement { name: "Icons" ; description: "The preferred options for icons" ; icon: "stateshape" }
        ListElement { name: "About" ; description: "About the system" ; icon: "help-about-symbolic" }
        //ListElement { name: "Keyboard" ; description: "The preferred keyboard language" ; icon: "keyboard-layout"}
        //ListElement { name: "Fonts" ; description: "The preferred default font" ; icon: "font" }
    }

    ListView {

        id: menuList

        anchors.fill: parent
        anchors.margins: 10

        spacing: 5

        model: menuModel

        delegate: Maui.ListBrowserDelegate {
            implicitWidth: parent.width
            //implicitHeight: 35
            iconSource: icon
            iconSizeHint: 22
            height: 45
            label1.text: name
            onClicked: {
                if (index == 0)
                {
                    _stackView.push("Generic.qml")
                }
                else if (index == 1)
                {
                    _stackView.push("FormFactor.qml")
                }
                else if (index == 2)
                {
                    _stackView.push("Screen.qml")
                }
                else if (index == 3)
                {
                    _stackView.push("Theme.qml")
                }
                else if (index == 4)
                {
                    _stackView.push("Icons.qml")
                }
                else if (index == 5)
                {
                    _stackView.push("About.qml")
                }
                menuList.currentIndex = index
            }
        }
    }
}
