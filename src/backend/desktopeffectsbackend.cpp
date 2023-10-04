// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/desktopeffectsbackend.h"

DesktopEffectsBackend::DesktopEffectsBackend()
{
}

DesktopEffectsBackend::~DesktopEffectsBackend()
{
}

bool DesktopEffectsBackend::slideBack() const
{
    return m_slideBack;
}

void DesktopEffectsBackend::setSlideBack(bool slideBack)
{
    if (m_slideBack == slideBack) {
        return;
    }

    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup plugins = kwinrc.group("Plugins");
    plugins.writeEntry("slidebackEnabled", slideBack);

    m_slideBack = slideBack;
    emit slideBackChanged(m_slideBack);
}

void DesktopEffectsBackend::getSlideBack()
{
    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup plugins = kwinrc.group("Plugins");

    if (plugins.hasKey("slidebackEnabled"))
        m_slideBack = plugins.readEntry("slidebackEnabled", bool());
    else
        m_slideBack = false;
}

bool DesktopEffectsBackend::dimInactive() const
{
    return m_dimInactive;
}

void DesktopEffectsBackend::setDimInactive(bool dimInactive)
{
    if (m_dimInactive == dimInactive) {
        return;
    }

    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup plugins = kwinrc.group("Plugins");
    plugins.writeEntry("diminactiveEnabled", dimInactive);

    m_dimInactive = dimInactive;
    emit dimInactiveChanged(m_dimInactive);
}

void DesktopEffectsBackend::getDimInactive()
{
    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup plugins = kwinrc.group("Plugins");

    if (plugins.hasKey("diminactiveEnabled"))
        m_dimInactive = plugins.readEntry("diminactiveEnabled", bool());
    else
        m_dimInactive = false;
}
