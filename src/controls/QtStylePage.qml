import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: qtStylePage

    headBar.visible: false

    Component.onCompleted: {
        getQtStyle()
        qtStyle = QtStyleBackend.qtStyle
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: qtStylePage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: qtStylePage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    property int qtStyle

    function getQtStyle() {
        QtStyleBackend.getQtStyle()
    }

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        height: 50 * 3

        title: i18n("Qt Quick Controls Style")
        description: i18n("Adjust qt style")

        Maui.SectionItem
        {
            label1.text:  i18n("Desktop")
            label2.text: i18n("Default")
            Controls.CheckBox {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checked: qtStyle == 0 ? true : false
                enabled: qtStyle != 0 ? true : false
                onClicked: {
                    qtStyle = 0;
                    QtStyleBackend.setQtStyle(0)
                }
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Breeze")
            label2.text: i18n("Breeze theme")
            Controls.CheckBox {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checked: qtStyle == 1 ? true : false
                enabled: qtStyle != 1 ? true : false
                onClicked: {
                    qtStyle = 1;
                    QtStyleBackend.setQtStyle(1)
                }
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Plasma")
            label2.text: i18n("Plasma theme")
            Controls.CheckBox {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checked: qtStyle == 2 ? true : false
                enabled: qtStyle != 2 ? true : false
                onClicked: {
                    qtStyle = 2;
                    QtStyleBackend.setQtStyle(2)
                }
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Material")
            label2.text: i18n("Material theme")
            Controls.CheckBox {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checked: qtStyle == 3 ? true : false
                enabled: qtStyle != 3 ? true : false
                onClicked: {
                    qtStyle = 3;
                    QtStyleBackend.setQtStyle(3)
                }
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Universal")
            label2.text: i18n("Universal theme")
            Controls.CheckBox {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checked: qtStyle == 4 ? true : false
                enabled: qtStyle != 4 ? true : false
                onClicked: {
                    qtStyle = 4;
                    QtStyleBackend.setQtStyle(4)
                }
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Imagine")
            label2.text: i18n("Imagine theme")
            Controls.CheckBox {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checked: qtStyle == 5 ? true : false
                enabled: qtStyle != 5 ? true : false
                onClicked: {
                    qtStyle = 5;
                    QtStyleBackend.setQtStyle(5)
                }
            }
        }
    }

/*
    Controls.Label {
        id: labelAbout
        x: 20
        y: 15
        text: "Qt Quick Controls Style"
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
            text: "Desktop"
            // color: Maui.Theme.disabledTextColor
        }
        Controls.CheckBox {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            checked: qtStyle == 0 ? true : false
            enabled: qtStyle != 0 ? true : false
            onClicked: {
                qtStyle = 0;
                QtStyleBackend.setQtStyle(0)
            }
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
            text: "Breeze"
            // color: Maui.Theme.disabledTextColor
        }
        Controls.CheckBox {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            checked: qtStyle == 1 ? true : false
            enabled: qtStyle != 1 ? true : false
            onClicked: {
                qtStyle = 1;
                QtStyleBackend.setQtStyle(1)
            }
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
            text: "Plasma"
            // color: Maui.Theme.disabledTextColor
        }
        Controls.CheckBox {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            checked: qtStyle == 2 ? true : false
            enabled: qtStyle != 2 ? true : false
            onClicked: {
                qtStyle = 2;
                QtStyleBackend.setQtStyle(2)
            }
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
            text: "Material"
            // color: Maui.Theme.disabledTextColor
        }
        Controls.CheckBox {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            checked: qtStyle == 3 ? true : false
            enabled: qtStyle != 3 ? true : false
            onClicked: {
                qtStyle = 3;
                QtStyleBackend.setQtStyle(3)
            }
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
            text: "Universal"
            // color: Maui.Theme.disabledTextColor
        }
        Controls.CheckBox {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            checked: qtStyle == 4 ? true : false
            enabled: qtStyle != 4 ? true : false
            onClicked: {
                qtStyle = 4;
                QtStyleBackend.setQtStyle(4)
            }
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
            text: "Imagine"
            // color: Maui.Theme.disabledTextColor
        }
        Controls.CheckBox {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 10
            checked: qtStyle == 5 ? true : false
            enabled: qtStyle != 5 ? true : false
            onClicked: {
                qtStyle = 5;
                QtStyleBackend.setQtStyle(5)
            }
        }
    }
*/
}


