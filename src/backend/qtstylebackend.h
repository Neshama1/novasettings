// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef QTSTYLEBACKEND_H
#define QTSTYLEBACKEND_H

#include <QDebug>
#include <QObject>
#include <QFile>
#include <QDir>
#include <QTextStream>
#include <QTextCodec>
#include <QString>
#include <QByteArray>

/**
 * @todo write docs
 */
class QtStyleBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int qtStyle READ qtStyle WRITE setQtStyle NOTIFY qtStyleChanged)

public:
    Q_INVOKABLE void getQtStyle();

public:
    /**
     * Default constructor
     */
    QtStyleBackend();

    /**
     * Destructor
     */
    ~QtStyleBackend();

    /**
     * @return the qtStyle
     */
    int qtStyle() const;

public Q_SLOTS:
    /**
     * Sets the qtStyle.
     *
     * @param qtStyle the new qtStyle
     */
    void setQtStyle(int qtStyle);

Q_SIGNALS:
    void qtStyleChanged(int qtStyle);

private:
    int m_qtStyle;
};

#endif // QTSTYLEBACKEND_H
