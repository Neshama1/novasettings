import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: virtualDesktopsPage

    property bool slide
    property int number
    property int rows

    headBar.visible: false

    Component.onCompleted: {
        opacityAnimation.start()
        xAnimation.start()
        getSlice()
        getNumber()
        getRows()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: virtualDesktopsPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: virtualDesktopsPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getSlice() {
        VirtualDesktopsBackend.getSlide()
        slide = VirtualDesktopsBackend.slide
    }

    function getNumber() {
        VirtualDesktopsBackend.getNumber()
        number = VirtualDesktopsBackend.number
        console.info(number)
    }

    function getRows() {
        VirtualDesktopsBackend.getRows()
        rows = VirtualDesktopsBackend.rows
    }

    Timer {
        id: notificationVirtualDesktops
        interval: 2000; running: false; repeat: false
        onTriggered: {
            root.notify("notifications","Virtual Desktops","You must restart the session for the changes to take effect",null,5000,"Accept")
        }
    }

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        height: 50 * 3

        title: i18n("Virtual desktops")
        description: i18n("This feature lets you have many desktops with each containing a different set of windows that can be easily switched by the user")

        Maui.SectionItem
        {
            label1.text:  i18n("Slide")
            label2.text: i18n("Show slide animation when switching")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: slide ? true : false
                onToggled: {
                    visualPosition == 0 ? VirtualDesktopsBackend.setSlide(false) : VirtualDesktopsBackend.setSlide(true)
                    notificationVirtualDesktops.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text:  i18n("Number")
            label2.text: i18n("Set the number of virtual desktops")
            SpinBox {
                id: spinBox1
                from: 1
                to: 20
                value: number

                onValueModified: {
                    VirtualDesktopsBackend.setNumber(value)
                    notificationVirtualDesktops.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text:  i18n("Rows")
            label2.text: i18n("Number of rows")
            SpinBox {
                id: spinBox2
                from: 1
                to: 20
                value: rows

                onValueModified: {
                    VirtualDesktopsBackend.setRows(value)
                    notificationVirtualDesktops.start()
                }
            }
        }
    }
}
