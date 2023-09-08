// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/miscbackend.h"

MiscBackend::MiscBackend()
{
}

MiscBackend::~MiscBackend()
{
}

int MiscBackend::fontThick() const
{
    return m_fontThick;
}

void MiscBackend::setFontThick(int fontThick)
{
    if (m_fontThick == fontThick) {
        return;
    }

    QString theme = "Noto Sans,10,-1,5,25,0,0,0,0,0,";
    QString newTheme;

    if (fontThick == 0)
        newTheme = theme + "Display Thin";
    else if (fontThick == 1)
        newTheme = theme + "Display Light";
    else if (fontThick == 2)
        newTheme = theme + "Regular";

    KConfig defaultThemesFile(QDir::homePath()+"/.config/kdeglobals");
    KConfigGroup general = defaultThemesFile.group("General");
    general.writeEntry("font", newTheme);

    m_fontThick = fontThick;
    emit fontThickChanged(m_fontThick);
}

void MiscBackend::getFont()
{
    // Obtener valor de estilo plasma seleccionado

    KConfig defaultThemesFile(QDir::homePath()+"/.config/kdeglobals");
    KConfigGroup general = defaultThemesFile.group("General");
    QString selectedTheme = general.readEntry("font", QString());
    QString fontThickness = selectedTheme.section(',',10,10);

    qDebug() << fontThickness;

    if (fontThickness == "Display Thin")
    {
        m_fontThick = 0;
    }
    else if (fontThickness == "Display Light")
    {
        m_fontThick = 1;
    }
    else if (fontThickness == "Regular")
    {
        m_fontThick = 2;
    }
}
