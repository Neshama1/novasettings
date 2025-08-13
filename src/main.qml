import QtCore
import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import org.mauikit.controls as Maui
import org.kde.novasettings 1.0

Maui.ApplicationWindow
{
    id: root
    title: qsTr("")

    Maui.Style.styleType: themeManager.styleType
    Maui.Style.accentColor: themeManager.accentColor
    Maui.Style.defaultSpacing: themeManager.spacingSize
    Maui.Style.defaultPadding: themeManager.paddingSize
    Maui.Style.contentMargins: themeManager.marginSize
    Maui.Style.radiusV: themeManager.borderRadius

    ThemeManager {
        id: themeManager
    }

    width: Screen.desktopAvailableWidth - Screen.desktopAvailableWidth * 45 / 100
    height: Screen.desktopAvailableHeight - Screen.desktopAvailableHeight * 20 / 100

    Component.onCompleted: {

        // Theme

        Maui.Style.windowControlsTheme = themeManager.windowControlsTheme

        // Pages

        _stackViewMenu.push("controls/Menu.qml")
        _stackView.push("controls/Generic.qml")
    }

    Maui.SideBarView
    {
        id: _sideBarView
        anchors.fill: parent

        sideBarContent:  Maui.Page
        {
            id: sideBarPage

            anchors.fill: parent

            Behavior on opacity {
                NumberAnimation { duration: 500; easing.type: Easing.OutExpo }
            }

            Behavior on scale {
                NumberAnimation { duration: 500; easing.type: Easing.OutExpo }
            }

            onOpacityChanged: opacity == 0 ? opacity = 1 : undefined
            onScaleChanged: scale == 0.98 ? scale = 1 : undefined

            headBar.visible: false
            Maui.Theme.colorSet: Maui.Theme.Window

            StackView {
                id:_stackViewMenu
                anchors.fill: parent
                clip: true
            }
        }

        Maui.Page
        {
            id: page

            anchors.fill: parent

            Behavior on opacity {
                NumberAnimation { duration: 500; easing.type: Easing.OutExpo }
            }

            Behavior on scale {
                NumberAnimation { duration: 500; easing.type: Easing.OutExpo }
            }

            onOpacityChanged: opacity == 0 ? opacity = 1 : undefined
            onScaleChanged: scale == 0.98 ? scale = 1 : undefined

            Maui.Controls.showCSD: true
            floatingHeader: true
            headBar.background: null
            headBar.farRightContent: [
                /*ToolButton
                {
                    icon.name: "dialog-ok-apply"
                }*/
            ]

            StackView {
                id:_stackView
                anchors.fill: parent
                clip: true
            }
        }
    }

    // FUNCTIONS

    function startTransition() {
        page.opacity = 0
        page.scale = 0.98
        sideBarPage.opacity = 0
        sideBarPage.scale = 0.98
    }
}
