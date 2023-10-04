import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: desktopEffectsPage

    property bool dimInactive
    property bool slideBack

    headBar.visible: false

    Component.onCompleted: {
        getDimInactive()
        getSlideBack()
        opacityAnimation.start()
        xAnimation.start()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: desktopEffectsPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: desktopEffectsPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getDimInactive() {
        DesktopEffectsBackend.getDimInactive()
        dimInactive = DesktopEffectsBackend.dimInactive
    }

    function getSlideBack() {
        DesktopEffectsBackend.getSlideBack()
        slideBack = DesktopEffectsBackend.slideBack
    }

    Timer {
        id: notificationTimer
        interval: 5000; running: false; repeat: false
        onTriggered: {
            root.notify("notifications","Desktop effects","You must restart the session for the changes to take effect",null,5000,"Accept")
        }
    }

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        height: 50 * 3

        title: i18n("Desktop Effects")
        description: i18n("Improve the way your desktop looks")

        Maui.SectionItem
        {
            label1.text:  i18n("Dim inactive")
            label2.text: i18n("Darkens the parent window of the currently active dialog")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: dimInactive ? true : false
                onToggled: {
                    visualPosition == 0 ? DesktopEffectsBackend.setDimInactive(false) : DesktopEffectsBackend.setDimInactive(true)
                    notificationTimer.start()
                }
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Slide back")
            label2.text: i18n("Slide back windows when another window is raised")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: slideBack ? true : false
                onToggled: {
                    visualPosition == 0 ? DesktopEffectsBackend.setSlideBack(false) : DesktopEffectsBackend.setSlideBack(true)
                    notificationTimer.start()
                }
            }
        }
    }
}
