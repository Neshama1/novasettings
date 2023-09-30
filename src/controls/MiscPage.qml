import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: miscPage

    property int fontThickness
    property bool fileIndexing
    property int globalScale

    headBar.visible: false

    Component.onCompleted: {
        getFont()
        getFileIndexing()
        getGlobalScale()
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: miscPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: miscPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getFont() {
        MiscBackend.getFont()
        fontThickness = MiscBackend.fontThick
    }

    function getFileIndexing() {
        MiscBackend.getFileIndexing()
        fileIndexing = MiscBackend.fileIndexing
    }

    function getGlobalScale() {
        MiscBackend.getGlobalScale()
        globalScale = MiscBackend.globalScale
    }

    Timer {
        id: notificationTimer
        interval: 5000; running: false; repeat: false
        onTriggered: {
            root.notify("notifications","Global scale","You must restart the session for the changes to take effect",null,5000,"Accept")
        }
    }

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        height: 50 * 3

        title: i18n("General")
        description: i18n("Configure the behaviour")

        Maui.SectionItem
        {
            label1.text:  i18n("Desktop search")
            label2.text: i18n("Enable file indexing")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: fileIndexing ? true : false
                onToggled: {
                    visualPosition == 0 ? MiscBackend.setFileIndexing(false) : MiscBackend.setFileIndexing(true)
                }
            }
        }

        Maui.SectionItem
        {
            label1.text:  i18n("Global scale")
            label2.text: i18n("Display configuration")
            SpinBox {
                id: spinBox
                from: 0
                to: items.length - 1
                value: globalScale

                property var items: ["100%", "125%", "150%", "175%", "200%", "225%", "250%", "275%", "300%"]

                validator: RegularExpressionValidator {
                    regularExpression: new RegExp("(100%|125%|150%|175%|200%|225%|225%|250%|275%|300%)", "i")
                }

                textFromValue: function(value) {
                    return items[value];
                }

                valueFromText: function(text) {
                    for (var i = 0; i < items.length; ++i) {
                        if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                            return i
                    }
                    return spinBox.value
                }
                onValueModified: {
                    MiscBackend.setGlobalScale(value)
                    notificationTimer.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text:  i18n("Fonts")
            label2.text: i18n("Font thickness")
            Maui.ToolActions
            {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10

                Action
                {
                    text: "Thin"
                    checked: {
                        if (fontThickness == 0) {
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
                    onTriggered: MiscBackend.setFontThick(0)
                }
                Action
                {
                    text: "Light"
                    checked: {
                        if (fontThickness == 1) {
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
                    onTriggered: MiscBackend.setFontThick(1)
                }
                Action
                {
                    text: "Bold"
                    checked: {
                        if (fontThickness == 2) {
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
                    onTriggered: MiscBackend.setFontThick(2)
                }
            }
        }
    }
}
