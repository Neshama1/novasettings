#pragma once

#include <QObject>
#include <QDebug>
#include <QVariant>
#include <QStringList>

#include <KConfig>
#include <KConfigGroup>
#include <KSharedConfig>

class RcLink: public QObject
{
    Q_OBJECT
    /*
    Q_PROPERTY(QVariantList users READ users WRITE setUsers NOTIFY usersChanged)
    */

public:
    explicit RcLink(QObject *parent = nullptr);

    Q_INVOKABLE QVariant getValue(const QString &file, const QStringList &groupPath, const QString &key, const QVariant &defaultValue = QVariant());

	Q_INVOKABLE void setValue(const QString &file, const QStringList &groupPath, const QString &key, const QVariant &value);

	/*
public:
    Q_INVOKABLE QVariant get(const QString &service, const QString &path, const QString &interface, const QString &method);
	*/

    /*
    QVariantList users() const;
    void setUsers(const QVariantList &users);
    Q_SIGNAL void usersChanged();
    */

private:
	KSharedConfigPtr m_config;

private:
	KConfigGroup getGroupFromPath(const QString &file, const QStringList &path);

private Q_SLOTS:
    //void on_UsersChanged();
};
