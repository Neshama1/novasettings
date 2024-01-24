import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: powerACPage

    property bool acDimScrEnable
    property int acDimScrTime
    property bool acScrSwOffEnable
    property int acScrSwOffTime
    property bool acSpEnable
    property int acSpTime

    headBar.visible: false

    Component.onCompleted: {
        opacityAnimation.start()
        xAnimation.start()
        getacDimScrEnable()
        getacDimScrTime()
        getacScrSwOffEnable()
        getacScrSwOffTime()
        getacSpEnable()
        getacSpTime()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: powerACPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: powerACPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getacDimScrEnable() {
        PowerBackend.getacDimScrEnable()
        acDimScrEnable = PowerBackend.acDimScrEnable
    }

    function getacDimScrTime() {
        PowerBackend.getacDimScrTime()
        acDimScrTime = PowerBackend.acDimScrTime
    }

    function getacScrSwOffEnable() {
        PowerBackend.getacScrSwOffEnable()
        acScrSwOffEnable = PowerBackend.acScrSwOffEnable
    }

    function getacScrSwOffTime() {
        PowerBackend.getacScrSwOffTime()
        acScrSwOffTime = PowerBackend.acScrSwOffTime
    }

    function getacSpEnable() {
        PowerBackend.getacSpEnable()
        acSpEnable = PowerBackend.acSpEnable
    }

    function getacSpTime() {
        PowerBackend.getacSpTime()
        acSpTime = PowerBackend.acSpTime
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

        template.label1.text: i18n("Power management")
        template.label1.font.weight: Font.Normal
        template.label1.font.pixelSize: 20

        description: i18n("AC")

        Maui.SectionItem
        {
            template.label1.text: i18n("Dim Display")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Enable")

            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: acDimScrEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setAcDimScrEnable(false) : PowerBackend.setAcDimScrEnable(true)
                    visualPosition == 0 ? spinBox1.enabled = false : spinBox1.enabled = true
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            template.label1.text: i18n("Screen energy saving")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Enable")

            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: acScrSwOffEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setAcScrSwOffEnable(false) : PowerBackend.setAcScrSwOffEnable(true)
                    visualPosition == 0 ? spinBox2.enabled = false : spinBox2.enabled = true
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            template.label1.text: i18n("Suspend session")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Enable")

            Switch {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                checkable: true
                checked: acSpEnable ? true : false
                onToggled: {
                    visualPosition == 0 ? PowerBackend.setAcSpEnable(false) : PowerBackend.setAcSpEnable(true)
                    visualPosition == 0 ? spinBox3.enabled = false : spinBox3.enabled = true
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            template.label1.text: i18n("Dim Display")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Time (min)")

            SpinBox {
                id: spinBox1
                from: 1
                to: 360
                value: acDimScrTime
                enabled: acDimScrEnable ? true : false

                onValueModified: {
                    PowerBackend.setAcDimScrTime(value)
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            template.label1.text: i18n("Screen energy saving")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Switch off after (min)")

            SpinBox {
                id: spinBox2
                from: 1
                to: 360
                value: acScrSwOffTime
                enabled: acScrSwOffEnable ? true : false

                onValueModified: {
                    PowerBackend.setAcScrSwOffTime(value)
                    notificationPowerAC.start()
                }
            }
        }

        Maui.SectionItem
        {
            template.label1.text: i18n("Suspend session")
            template.label1.font.weight: Font.Normal

            label2.text: i18n("Time (min)")

            SpinBox {
                id: spinBox3
                from: 1
                to: 360
                value: acSpTime
                enabled: acSpEnable ? true : false

                onValueModified: {
                    PowerBackend.setAcSpTime(value)
                    notificationPowerAC.start()
                }
            }
        }
    }
}
