// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/virtualdesktopsbackend.h"

VirtualDesktopsBackend::VirtualDesktopsBackend()
{
}

VirtualDesktopsBackend::~VirtualDesktopsBackend()
{
}

bool VirtualDesktopsBackend::slide() const
{
    return m_slide;
}

void VirtualDesktopsBackend::setSlide(bool slide)
{
    if (m_slide == slide) {
        return;
    }

    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup plugins = kwinrc.group("Plugins");
    plugins.writeEntry("slideEnabled", slide);

    if (slide)
        plugins.writeEntry("kwin4_effect_fadedesktopEnabled", false);
    else
        plugins.writeEntry("kwin4_effect_fadedesktopEnabled", true);

    m_slide = slide;
    emit slideChanged(m_slide);
}

void VirtualDesktopsBackend::getSlide()
{
    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup plugins = kwinrc.group("Plugins");

    if (plugins.hasKey("slideEnabled"))
        m_slide = plugins.readEntry("slideEnabled", bool());
    else
        m_slide = true;
}

int VirtualDesktopsBackend::rows() const
{
    return m_rows;
}

void VirtualDesktopsBackend::setRows(int rows)
{
    if (m_rows == rows) {
        return;
    }

    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup desktops = kwinrc.group("Desktops");
    desktops.writeEntry("Rows", rows);

    m_rows = rows;
    emit rowsChanged(m_rows);
}

void VirtualDesktopsBackend::getRows()
{
    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup desktops = kwinrc.group("Desktops");

    if (desktops.hasKey("Rows"))
        m_rows = desktops.readEntry("Rows", int());
    else
        m_rows = 1;
}

int VirtualDesktopsBackend::number() const
{
    return m_number;
}

void VirtualDesktopsBackend::setNumber(int number)
{
    if (m_number == number) {
        return;
    }

    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup desktops = kwinrc.group("Desktops");
    desktops.writeEntry("Number", number);

    m_number = number;
    emit numberChanged(m_number);
}

void VirtualDesktopsBackend::getNumber()
{
    KConfig kwinrc(QDir::homePath()+"/.config/kwinrc");
    KConfigGroup desktops = kwinrc.group("Desktops");

    if (desktops.hasKey("Number"))
        m_number = desktops.readEntry("Number", int());
    else
        m_number = 1;
}
