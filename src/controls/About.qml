import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.Page
{
    id: about

    anchors.fill: parent
    anchors.margins: 10

    headBar.visible: false

    Maui.SectionGroup
    {
        width: parent.width

        template.label1.text: i18n("About")
        template.label1.font.weight: Font.Bold
        template.label1.font.pixelSize: 20

        description: i18n("Information about the system")

        Maui.FlexSectionItem {
            label1.text: i18n("OS Name")
            label2.text: i18n("Distribution name")

            Label {
                text: AboutSystemBackend.osName
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Computer architecture")
            label2.text: i18n("Instruction set architecture")

            Label {
                text: AboutSystemBackend.architecture
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Kernel")
            label2.text: i18n("Kernel version")

            Label {
                text: AboutSystemBackend.kernelVersion
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Hostname")
            label2.text: i18n("Network label")

            Label {
                text: AboutSystemBackend.hostname
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("User")
            label2.text: i18n("Your user")

            Label {
                text: AboutSystemBackend.userName
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Memory")
            label2.text: i18n("Computer memory")

            Label {
                text: AboutSystemBackend.memorySize
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("Storage")
            label2.text: i18n("Storage size")

            Label {
                text: AboutSystemBackend.internalStorage
            }
        }

        Maui.FlexSectionItem {
            label1.text: i18n("CPU")
            label2.text: i18n("CPU info")

            Label {
                text: AboutSystemBackend.cpuInfo
            }
        }
    }
}


