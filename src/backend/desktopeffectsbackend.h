// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef DESKTOPEFFECTSBACKEND_H
#define DESKTOPEFFECTSBACKEND_H

#include <QObject>
#include <QDebug>
#include <QDir>
#include <KConfig>
#include <KConfigGroup>

/**
 * @todo write docs
 */
class DesktopEffectsBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool slideBack READ slideBack WRITE setSlideBack NOTIFY slideBackChanged)
    Q_PROPERTY(bool dimInactive READ dimInactive WRITE setDimInactive NOTIFY dimInactiveChanged)

public:
    Q_INVOKABLE void getSlideBack();
    Q_INVOKABLE void getDimInactive();

public:
    /**
     * Default constructor
     */
    DesktopEffectsBackend();

    /**
     * Destructor
     */
    ~DesktopEffectsBackend();

    /**
     * @return the slideBack
     */
    bool slideBack() const;

    /**
     * @return the dimInactive
     */
    bool dimInactive() const;

public Q_SLOTS:
    /**
     * Sets the slideBack.
     *
     * @param slideBack the new slideBack
     */
    void setSlideBack(bool slideBack);

    /**
     * Sets the dimInactive.
     *
     * @param dimInactive the new dimInactive
     */
    void setDimInactive(bool dimInactive);

Q_SIGNALS:
    void slideBackChanged(bool slideBack);

    void dimInactiveChanged(bool dimInactive);

private:
    bool m_slideBack;
    bool m_dimInactive;
};

#endif // DESKTOPEFFECTSBACKEND_H
