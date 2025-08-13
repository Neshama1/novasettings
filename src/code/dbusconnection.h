#pragma once

#include <QObject>
#include <QDebug>
#include <QVariant>
#include <QVariantList>

class DBusConnection : public QObject
{
    Q_OBJECT
    /*
    Q_PROPERTY(QVariantList users READ users WRITE setUsers NOTIFY usersChanged)
    */

public:
    explicit DBusConnection(QObject *parent = nullptr);

public:
    Q_INVOKABLE QVariant get(const QString &service, const QString &path, const QString &interface, const QString &method);

    /*
    QVariantList users() const;
    void setUsers(const QVariantList &users);
    Q_SIGNAL void usersChanged();
    */

private:
    //QVariantList m_users;

private Q_SLOTS:
    //void on_UsersChanged();
};
