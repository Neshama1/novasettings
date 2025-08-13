#include "dbusconnection.h"
#include <QDebug>
#include <QVariantMap>
#include <QDBusConnection>
#include <QDBusInterface>
#include <QDBusReply>
#include <QString>
#include <QStringList>
#include <QDBusMessage>
#include <QDBusArgument>

DBusConnection::DBusConnection(QObject *parent) : QObject(parent)
{
}

QVariant DBusConnection::get(const QString &service, const QString &path, const QString &interface, const QString &method)
{
    QDBusInterface iface(service, path, interface);

    if (!iface.isValid()) {
        qDebug() << "Interfaz no es valida";
    }

    QDBusMessage reply = iface.call(method);
    QDBusArgument dbusArgs = reply.arguments().at(0).value<QDBusArgument>();

    qDebug() << reply;
    qDebug() << reply.arguments();

    // Print "es"

    if (dbusArgs.currentType() == dbusArgs.ArrayType) {

        qDebug() << "Argumento es tipo array";

        dbusArgs.beginArray();
        while (!dbusArgs.atEnd()) {

            QString key;
            QDBusVariant value;

            dbusArgs >> key >> value;

            // Print "es"

            qDebug() << "Keyboard Layout" << key << value.variant().toString();
        }
        dbusArgs.endArray();
    }

    /*
    // Print /Layout

    QDBusArgument dbusArgument = reply.arguments().at(0).value<QDBusVariant>().variant().value<QDBusArgument>();

    if (dbusArgument.currentType() == dbusArgument.ArrayType) {

        QDBusObjectPath path;

        dbusArgument.beginArray();
        while(!dbusArgument.atEnd()) {
            dbusArgument >> path;
        }
        dbusArgument.endArray();
    }

    qDebug() << "Path es" << path;
    */

    return "valor retornado";
}
