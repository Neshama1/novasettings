import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.kirigami 2.12 as Kirigami
import org.kde.novasettings 1.0

Maui.Page {
    id: sddmPage

    header.visible: false

    property int indexTheme

    Component.onCompleted: {
        getSddmThemes()
        sddmView.currentIndex = SDDMBackend.selected
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: sddmPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: sddmPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getSddmThemes() {
        SDDMBackend.getThemes()
        var fcount = SDDMBackend.count
        for (var i = 0 ; i < fcount ; i++) {
            sddmModel.append({"name": SDDMBackend.themes[i].name,"screenshot": SDDMBackend.themes[i].screenshot})
        }
    }

    ListModel {
        id: sddmModel
    }

    GridView {
        id: sddmView

        anchors.fill: parent
        anchors.margins: 20

        cellWidth: 80
        cellHeight: 95

        model: sddmModel
        delegate: Maui.GridBrowserDelegate
        {
            implicitWidth: 75
            implicitHeight: 90

            Maui.IconItem
            {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                imageSource: Qt.resolvedUrl("file://" + screenshot)
                imageSizeHint: 75
                maskRadius: Maui.Style.radiusV
                fillMode: Image.PreserveAspectCrop
            }

            label2.text: name

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    indexTheme = index
                    passwordDialog.visible = true
                }
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: passwordDialog

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: pass
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Enter your password")
            echoMode: TextInput.Password
            onAccepted: {
                passwordDialog.visible = false
                SDDMBackend.setTheme(indexTheme,text)
                sddmModel.clear()
                getSddmThemes()
                sddmView.currentIndex = SDDMBackend.selected
            }
        }
    }
}
