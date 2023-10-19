import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.kirigami 2.12 as Kirigami
import org.kde.novasettings 1.0

Maui.Page {
    id: lookAndFeelPage

    header.visible: false

    property int indexTheme

    Component.onCompleted: {
        getLookAndFeelPackages()
        lookAndFeelView.currentIndex = LookAndFeelBackend.selectedStyle
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: lookAndFeelPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: lookAndFeelPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getLookAndFeelPackages() {
        LookAndFeelBackend.getThemes()
        var fcount = LookAndFeelBackend.stylesCount
        for (var i = 0 ; i < fcount ; i++) {
            lookAndFeelModel.append({"name": LookAndFeelBackend.lookAndFeelStyles[i].name,"folder": LookAndFeelBackend.lookAndFeelStyles[i].folder,"path": LookAndFeelBackend.lookAndFeelStyles[i].path,"selected": LookAndFeelBackend.lookAndFeelStyles[i].selected,"preview": LookAndFeelBackend.lookAndFeelStyles[i].preview})
        }
    }

    ListModel {
        id: lookAndFeelModel
    }

    GridView {
        id: lookAndFeelView

        anchors.fill: parent
        anchors.margins: 20

        cellWidth: 80
        cellHeight: 95

        model: lookAndFeelModel
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
                imageSource: Qt.resolvedUrl("file://" + preview)
                imageSizeHint: 75
                maskRadius: Maui.Style.radiusV
                fillMode: Image.PreserveAspectCrop
            }

            label2.text: name

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (LookAndFeelBackend.lookAndFeelStyles[index].name == "Wildberry" ||
                        LookAndFeelBackend.lookAndFeelStyles[index].name == "Bubblegum" ||
                        LookAndFeelBackend.lookAndFeelStyles[index].name == "Mint")
                    {
                        indexTheme = index
                        passwordDialog.visible = true
                    }
                    else
                    {
                        var fcount = LookAndFeelBackend.stylesCount
                        for (var i = 0 ; i < fcount ; i++) {
                            lookAndFeelModel.setProperty(i, "selected", false)
                        }
                        lookAndFeelModel.setProperty(index, "selected", true)
                        LookAndFeelBackend.setSelectedStyle(index)
                        lookAndFeelModel.clear()
                        getLookAndFeelPackages()
                        lookAndFeelView.currentIndex = LookAndFeelBackend.selectedStyle
                    }
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
                LookAndFeelBackend.setPassword(text)
                var fcount = LookAndFeelBackend.stylesCount
                for (var i = 0 ; i < fcount ; i++) {
                    lookAndFeelModel.setProperty(i, "selected", false)
                }
                lookAndFeelModel.setProperty(indexTheme, "selected", true)
                LookAndFeelBackend.setSelectedStyle(indexTheme)
                lookAndFeelModel.clear()
                getLookAndFeelPackages()
                lookAndFeelView.currentIndex = LookAndFeelBackend.selectedStyle
            }
        }
    }
}
