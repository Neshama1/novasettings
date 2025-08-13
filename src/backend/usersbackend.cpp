// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/usersbackend.h"

UsersBackend::UsersBackend()
{
}

UsersBackend::~UsersBackend()
{
}

int UsersBackend::number() const
{
    return m_number;
}

void UsersBackend::setNumber(int number)
{
    if (m_number == number) {
        return;
    }

    m_number = number;
    emit numberChanged(m_number);
}

QStringList UsersBackend::users() const
{
    return m_users;
}

void UsersBackend::setUsers(QStringList users)
{
    if (m_users == users) {
        return;
    }

    m_users = users;
    emit usersChanged(m_users);
}

void UsersBackend::getUsers()
{
    m_users.clear();

    QString path = "/home";
    QDir directory = QDir(path);
    m_users = directory.entryList(QStringList() << "*", QDir::Dirs | QDir::NoDotAndDotDot);
    m_number = m_users.length();
}

void UsersBackend::addUser(QString newUser, QString newPass, QString adminPass)
{
    QByteArray sudoPwd(adminPass.toUtf8());
    QByteArray user(newUser.toUtf8());
    QByteArray pass(newPass.toUtf8());

    int error = system("echo " + sudoPwd + " | sudo -S /usr/sbin/useradd -p $(openssl passwd -1 " + pass + " ) " + user);

    QProcess notification;

    if (error == 0)
    {
        //system("echo " + sudoPwd + " | sudo -S cp /novadefaults/config/* /home/" + user + "/.config");
        notification.execute("kdialog --passivepopup \"User has been added\" 10");
    }
    else
    {
        notification.execute("kdialog --passivepopup \"An error occurred\" 10");
    }
}

void UsersBackend::selected(QString user)
{
    m_selected = user;
}

void UsersBackend::removeSelectedUser(QString adminPass)
{
    QByteArray sudoPwd(adminPass.toUtf8());
    QByteArray user(m_selected.toUtf8());

    int error = system("echo " + sudoPwd + " | sudo -S userdel -r " + user);

    QProcess notification;

    if (error == 0)
    {
        notification.execute("kdialog --passivepopup \"User has been removed\" 10");
    }
    else
    {
        notification.execute("kdialog --passivepopup \"An error occurred\" 10");
    }
}

void UsersBackend::changePass(QString newPass, QString adminPass)
{
    QByteArray sudoPwd(adminPass.toUtf8());
    QByteArray user(m_selected.toUtf8());
    QByteArray pass(newPass.toUtf8());

    int error = system("echo " + sudoPwd + " | sudo -S su && echo '" + user + ":" + pass + "' | sudo chpasswd");

    QProcess notification;

    if (error == 0)
    {
        notification.execute("kdialog --passivepopup \"Password updated successfully\" 10");
    }
    else
    {
        notification.execute("kdialog --passivepopup \"An error occurred\" 10");
    }
}
