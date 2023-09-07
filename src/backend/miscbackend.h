// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef MISCBACKEND_H
#define MISCBACKEND_H

#include <QObject>
#include <KConfig>
#include <KConfigGroup>
#include <QString>
#include <QDir>
#include <QDebug>

/**
 * @todo write docs
 */
class MiscBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int fontThick READ fontThick WRITE setFontThick NOTIFY fontThickChanged)

    public:
    Q_INVOKABLE void getFont();

public:
    /**
     * Default constructor
     */
    MiscBackend();

    /**
     * Destructor
     */
    ~MiscBackend();

    /**
     * @return the fontThick
     */
    int fontThick() const;

public Q_SLOTS:
    /**
     * Sets the fontThick.
     *
     * @param fontThick the new fontThick
     */
    void setFontThick(int fontThick);

Q_SIGNALS:
    void fontThickChanged(int fontThick);

private:
    int m_fontThick;
};

#endif // MISCBACKEND_H
