import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.mauikit.filebrowsing 1.3 as FB
import org.kde.novasettings 1.0
import org.kde.kirigami 2.7 as Kirigami

Maui.Page
{
    id: aboutPage

    headBar.visible: false

    Component.onCompleted: {
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: aboutPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: aboutPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    Controls.Label {
        id: labelAbout
        x: 20
        y: 15
        text: "About"
        font.pixelSize: 30
    }

    Rectangle {
        id: rect1
        y: 55 + 15
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.osName
            // color: Maui.Theme.disabledTextColor
        }
    }

    Rectangle {
        id: rect2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect1.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.architecture
            // color: Maui.Theme.disabledTextColor
        }
    }

    Rectangle {
        id: rect3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect2.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.kernelVersion
            // color: Maui.Theme.disabledTextColor
        }
    }

    Rectangle {
        id: rect4
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect3.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.hostname
            // color: Maui.Theme.disabledTextColor
        }
    }

    Rectangle {
        id: rect5
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect4.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.userName
            // color: Maui.Theme.disabledTextColor
        }
    }

    Rectangle {
        id: rect6
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect5.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.memorySize
            // color: Maui.Theme.disabledTextColor
        }
    }

    Rectangle {
        id: rect7
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect6.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.internalStorage
            // color: Maui.Theme.disabledTextColor
        }
    }

    Rectangle {
        id: rect8
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rect7.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.topMargin: 5
        height: 50
        radius: 3
        color: Maui.Theme.alternateBackgroundColor

        Controls.Label {
            anchors.fill: parent
            anchors.margins: 5
            text: AboutSystemBackend.cpuInfo
            // color: Maui.Theme.disabledTextColor
        }
    }
}


