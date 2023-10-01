import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: powerBatteryPage

    property bool batteryDimScrEnable
    property int batteryDimScrTime
    property bool batteryScrSwOffEnable
    property int batteryScrSwOffTime
    property bool batterySpEnable
    property int batterySpTime

    headBar.visible: false

    Component.onCompleted: {
        opacityAnimation.start()
        xAnimation.start()
        getbatteryDimScrEnable()
        getbatteryDimScrTime()
        getbatteryScrSwOffEnable()
        getbatteryScrSwOffTime()
        getbatterySpEnable()
        getbatterySpTime()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: powerBatteryPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: powerBatteryPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getbatteryDimScrEnable() {
        PowerBackend.getbatteryDimScrEnable()
        batteryDimScrEnable = PowerBackend.batteryDimScrEnable
    }

    function getbatteryDimScrTime() {
        PowerBackend.getbatteryDimScrTime()
        batteryDimScrTime = PowerBackend.batteryDimScrTime
    }

    function getbatteryScrSwOffEnable() {
        PowerBackend.getbatteryScrSwOffEnable()
        batteryScrSwOffEnable = PowerBackend.batteryScrSwOffEnable
    }

    function getbatteryScrSwOffTime() {
        PowerBackend.getbatteryScrSwOffTime()
        batteryScrSwOffTime = PowerBackend.batteryScrSwOffTime
    }

    function getbatterySpEnable() {
        PowerBackend.getbatterySpEnable()
        batterySpEnable = PowerBackend.batterySpEnable
    }

    function getbatterySpTime() {
        PowerBackend.getbatterySpTime()
        batterySpTime = PowerBackend.batterySpTime
    }

    Timer {
        id: notificationPowerAC
        interval: 10000; running: false; repeat: false
        onTriggered: {
            root.notify("notifications","AC Power","You must restart the session for the changes to take effect",null,5000,"Accept")
        }
    }

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        height: 50 * 3

        title: i18n("Power management")
        description: i18n("Battery")

        Maui.SectionItem
        {
            label1.text: i18n("Dim Display")
            label2.text: i18n("Enable")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: batteryDimScrEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setBatteryDimScrEnable(false) : PowerBackend.setBatteryDimScrEnable(true)
                    visualPosition == 0 ? spinBox1.enabled = false : spinBox1.enabled = true
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text: i18n("Screen energy saving")
            label2.text: i18n("Enable")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: batteryScrSwOffEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setBatteryScrSwOffEnable(false) : PowerBackend.setBatteryScrSwOffEnable(true)
                    visualPosition == 0 ? spinBox2.enabled = false : spinBox2.enabled = true
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text:  i18n("Suspend session")
            label2.text: i18n("Enable")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: batterySpEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setBatterySpEnable(false) : PowerBackend.setBatterySpEnable(true)
                    visualPosition == 0 ? spinBox3.enabled = false : spinBox3.enabled = true
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text: i18n("Dim Display")
            label2.text: i18n("Time (min)")
            SpinBox {
                id: spinBox1
                from: 1
                to: 360
                value: batteryDimScrTime
                enabled: batteryDimScrEnable ? true : false

                onValueModified: {
                    PowerBackend.setBatteryDimScrTime(value)
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text:  i18n("Screen energy saving")
            label2.text: i18n("Switch off after (min)")
            SpinBox {
                id: spinBox2
                from: 1
                to: 360
                value: batteryScrSwOffTime
                enabled: batteryScrSwOffEnable ? true : false

                onValueModified: {
                    PowerBackend.setBatteryScrSwOffTime(value)
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            label1.text:  i18n("Suspend session")
            label2.text: i18n("Time (min)")
            SpinBox {
                id: spinBox3
                from: 1
                to: 360
                value: batterySpTime
                enabled: batterySpEnable ? true : false

                onValueModified: {
                    PowerBackend.setBatterySpTime(value)
                    notificationPowerAC.start()
                }
            }
        }
    }
}
