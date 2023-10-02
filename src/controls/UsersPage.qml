import QtQuick 2.15
import QtQml 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import org.mauikit.controls 1.3 as Maui
import org.kde.novasettings 1.0
import org.kde.kirigami 2.12 as Kirigami

Maui.Page
{
    id: usersPage

    headBar.visible: false

    Component.onCompleted: {
        opacityAnimation.start()
        xAnimation.start()
        getUsers()
    }

    PropertyAnimation {
        id: opacityAnimation
        target: usersPage
        properties: "opacity"
        from: 0
        to: 1.0
        duration: 250
    }

    PropertyAnimation {
        id: xAnimation
        target: usersPage
        properties: "x"
        from: -10
        to: 0
        duration: 500
    }

    function getUsers() {
        UsersBackend.getUsers()
        var count = UsersBackend.number
        for (var i = 0 ; i < count ; i++) {
            usersModel.append({"user": UsersBackend.users[i]})
        }
    }

    ListModel {
        id: usersModel
    }

    Maui.SectionGroup
    {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20

        title: i18n("Users")
        description: i18n("Manage system users")

        Repeater {
            model: usersModel
            Maui.SectionItem
            {
                implicitHeight: 45

                label1.text:  i18n("User")
                label2.text: user
                Button {
                    id: chPassButton
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    flat: true
                    icon.name: "dialog-password"
                    onClicked: {
                        UsersBackend.selected(UsersBackend.users[index])
                        changePassDialog1.visible = true
                    }
                }
                Button {
                    id: removeButton
                    anchors.right: chPassButton.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 5
                    flat: true
                    icon.name: "list-remove-user"
                    onClicked: {
                        if (UsersBackend.number > 1) {
                            UsersBackend.selected(UsersBackend.users[index])
                            adminDialogRemoveUser.visible = true
                        }
                        else {
                            root.notify("notifications","Remove user","User deletion rejected",null,5000,"Accept")
                        }
                    }
                }
            }
        }
    }

    Maui.FloatingButton
    {
        icon.name: "list-add"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        onClicked: {
            adduserDialog.visible = true
        }
    }

    Kirigami.ShadowedRectangle {
        id: adduserDialog

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: newUser
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Enter your username")
            onAccepted: {
                adduserDialog.visible = false
                passwordDialog1.visible = true
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: passwordDialog1

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: pass1
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Enter your password")
            echoMode: TextInput.Password
            onAccepted: {
                passwordDialog1.visible = false
                passwordDialog2.visible = true
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: passwordDialog2

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: pass2
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Re-Enter your password")
            echoMode: TextInput.Password
            onAccepted: {
                passwordDialog2.visible = false
                if (text == pass1.text) {
                    adminDialog.visible = true
                }
                else {
                    root.notify("notifications","Add user","Passwords are not the same",null,5000,"Accept")
                }
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: adminDialog

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: adminPass
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Enter your admin password")
            echoMode: TextInput.Password
            onAccepted: {
                adminDialog.visible = false
                UsersBackend.addUser(newUser.text,pass1.text,text)
                usersModel.clear()
                getUsers()
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: adminDialogRemoveUser

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: adminPassRemoveUser
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Enter your admin password")
            echoMode: TextInput.Password
            onAccepted: {
                adminDialogRemoveUser.visible = false
                UsersBackend.removeSelectedUser(text)
                usersModel.clear()
                getUsers()
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: changePassDialog1

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: changePass1
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Enter your new password")
            echoMode: TextInput.Password
            onAccepted: {
                changePassDialog1.visible = false
                changePassDialog2.visible = true
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: changePassDialog2

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            id: changePass2
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Re-Enter your password")
            echoMode: TextInput.Password
            onAccepted: {
                changePassDialog2.visible = false
                if (text == changePass1.text) {
                    adminDialogChangePass.visible = true
                }
                else {
                    root.notify("notifications","Change password","Passwords are not the same",null,5000,"Accept")
                }
            }
        }
    }

    Kirigami.ShadowedRectangle {
        id: adminDialogChangePass

        Kirigami.Theme.colorSet: Kirigami.Theme.View
        anchors.centerIn: parent
        visible: false
        width: 300
        height: 100
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.backgroundColor
        border.width: 2
        shadow.size: 20
        shadow.color: "#5c5c5c"
        shadow.xOffset: 0
        shadow.yOffset: 0
        radius: 6
        z: 1

        TextField {
            anchors.centerIn: parent
            width: 250
            placeholderText: i18n("Enter your admin password")
            echoMode: TextInput.Password
            onAccepted: {
                adminDialogChangePass.visible = false
                UsersBackend.changePass(changePass1.text,text)
            }
        }
    }
}
