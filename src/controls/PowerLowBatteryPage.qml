import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: powerLowBatteryPage

    property bool lowBatteryDimScrEnable
    property int lowBatteryDimScrTime
    property bool lowBatteryScrSwOffEnable
    property int lowBatteryScrSwOffTime
    property bool lowBatterySpEnable
    property int lowBatterySpTime

    headBar.visible: false

    Component.onCompleted: {
        opacityAnimation.start()
        xAnimation.start()
        getlowBatteryDimScrEnable()
        getlowBatteryDimScrTime()
        getlowBatteryScrSwOffEnable()
        getlowBatteryScrSwOffTime()
        getlowBatterySpEnable()
        getlowBatterySpTime()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: powerLowBatteryPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: powerLowBatteryPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getlowBatteryDimScrEnable() {
        PowerBackend.getlowBatteryDimScrEnable()
        lowBatteryDimScrEnable = PowerBackend.lowBatteryDimScrEnable
    }

    function getlowBatteryDimScrTime() {
        PowerBackend.getlowBatteryDimScrTime()
        lowBatteryDimScrTime = PowerBackend.lowBatteryDimScrTime
    }

    function getlowBatteryScrSwOffEnable() {
        PowerBackend.getlowBatteryScrSwOffEnable()
        lowBatteryScrSwOffEnable = PowerBackend.lowBatteryScrSwOffEnable
    }

    function getlowBatteryScrSwOffTime() {
        PowerBackend.getlowBatteryScrSwOffTime()
        lowBatteryScrSwOffTime = PowerBackend.lowBatteryScrSwOffTime
    }

    function getlowBatterySpEnable() {
        PowerBackend.getlowBatterySpEnable()
        lowBatterySpEnable = PowerBackend.lowBatterySpEnable
    }

    function getlowBatterySpTime() {
        PowerBackend.getlowBatterySpTime()
        lowBatterySpTime = PowerBackend.lowBatterySpTime
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
        description: i18n("Low battery")

        Maui.SectionItem
        {
            label1.text: i18n("Dim Display")
            label2.text: i18n("Enable")
            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: lowBatteryDimScrEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setLowBatteryDimScrEnable(false) : PowerBackend.setLowBatteryDimScrEnable(true)
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
                checked: lowBatteryScrSwOffEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setLowBatteryScrSwOffEnable(false) : PowerBackend.setLowBatteryScrSwOffEnable(true)
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
                checked: lowBatterySpEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setLowBatterySpEnable(false) : PowerBackend.setLowBatterySpEnable(true)
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
                value: lowBatteryDimScrTime
                enabled: lowBatteryDimScrEnable ? true : false

                onValueModified: {
                    PowerBackend.setLowBatteryDimScrTime(value)
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
                value: lowBatteryScrSwOffTime
                enabled: lowBatteryScrSwOffEnable ? true : false

                onValueModified: {
                    PowerBackend.setLowBatteryScrSwOffTime(value)
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
                value: lowBatterySpTime
                enabled: lowBatterySpEnable ? true : false

                onValueModified: {
                    PowerBackend.setLowBatterySpTime(value)
                    notificationPowerAC.start()
                }
            }
        }
    }
}
