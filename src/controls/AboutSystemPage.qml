import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
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

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        height: 100

        title: i18n("About")
        description: i18n("Information about the system")

        Maui.SectionItem
        {
            label1.text:  i18n("OS name")
            label2.text: i18n("Distribution name")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.osName
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Computer architecture")
            label2.text: i18n("Instruction set architecture")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.architecture
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Kernel")
            label2.text: i18n("Kernel version")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.kernelVersion
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Hostname")
            label2.text: i18n("Network label")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.hostname
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("User")
            label2.text: i18n("Your user")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.userName
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Memory Size")
            label2.text: i18n("Computer memory")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.memorySize
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("Storage")
            label2.text: i18n("Storage size")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.internalStorage
            }
        }
        Maui.SectionItem
        {
            label1.text:  i18n("CPU")
            label2.text: i18n("CPU info")
            Label {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: AboutSystemBackend.cpuInfo
            }
        }
    }
}


