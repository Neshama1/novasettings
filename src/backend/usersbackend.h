// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef USERSBACKEND_H
#define USERSBACKEND_H

#include <QObject>
#include <QDebug>
#include <QDir>
#include <QString>
#include <QStringList>
#include <QByteArray>
#include <QProcess>

/**
 * @todo write docs
 */
class UsersBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int number READ number WRITE setNumber NOTIFY numberChanged)
    Q_PROPERTY(QStringList users READ users WRITE setUsers NOTIFY usersChanged)

public:
    Q_INVOKABLE void getUsers();
    Q_INVOKABLE void addUser(QString newUser, QString newPass, QString adminPass);
    Q_INVOKABLE void selected(QString user);
    Q_INVOKABLE void removeSelectedUser(QString adminPass);
    Q_INVOKABLE void changePass(QString newPass, QString adminPass);

public:
    /**
     * Default constructor
     */
    UsersBackend();

    /**
     * Destructor
     */
    ~UsersBackend();

    /**
     * @return the number
     */
    int number() const;

    /**
     * @return the users
     */
    QStringList users() const;

public Q_SLOTS:
    /**
     * Sets the number.
     *
     * @param number the new number
     */
    void setNumber(int number);

    /**
     * Sets the users.
     *
     * @param users the new users
     */
    void setUsers(QStringList users);

Q_SIGNALS:
    void numberChanged(int number);

    void usersChanged(QStringList users);

private:
    int m_number;
    QStringList m_users;
    QString m_selected;
};

#endif // USERSBACKEND_H
