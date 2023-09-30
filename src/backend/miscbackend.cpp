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

    QString theme1 = "Noto Sans,10,-1,5,12,0,0,0,0,0,ExtraLight";
    QString theme2 = "Noto Sans,10,-1,5,25,0,0,0,0,0,Display Light";
    QString theme3 = "Noto Sans,10,-1,5,50,0,0,0,0,0";
    QString newTheme;

    if (fontThick == 0)
        newTheme = theme1;
    else if (fontThick == 1)
        newTheme = theme2;
    else if (fontThick == 2)
        newTheme = theme3;

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

    if (fontThickness == "ExtraLight")
    {
        m_fontThick = 0;
    }
    else if (fontThickness == "Display Light")
    {
        m_fontThick = 1;
    }
    else if (fontThickness == "")
    {
        m_fontThick = 2;
    }
}

bool MiscBackend::fileIndexing()
{
    return m_fileIndexing;
}

void MiscBackend::setFileIndexing(bool fileIndexing)
{
    if (m_fileIndexing == fileIndexing) {
        return;
    }

    KConfig baloofilerc(QDir::homePath()+"/.config/baloofilerc");
    KConfigGroup basicSettings = baloofilerc.group("Basic Settings");
    basicSettings.writeEntry("Indexing-Enabled", fileIndexing);

    m_fileIndexing = fileIndexing;
    emit fileIndexingChanged(m_fileIndexing);
}

void MiscBackend::getFileIndexing()
{
    KConfig baloofilerc(QDir::homePath()+"/.config/baloofilerc");
    KConfigGroup basicSettings = baloofilerc.group("Basic Settings");

    if (basicSettings.hasKey("Indexing-Enabled"))
        m_fileIndexing = basicSettings.readEntry("Indexing-Enabled", bool());
    else
        m_fileIndexing = true;
}

int MiscBackend::globalScale()
{
    return m_globalScale;
}

void MiscBackend::setGlobalScale(int globalScale)
{
    if (m_globalScale == globalScale) {
        return;
    }

    KConfig kcmfonts(QDir::homePath()+"/.config/kcmfonts");
    KConfigGroup general = kcmfonts.group("General");

    switch (globalScale) {
        case 0: general.writeEntry("forceFontDPI", 0);
                break;
        case 1: general.writeEntry("forceFontDPI", 120);
                break;
        case 2: general.writeEntry("forceFontDPI", 144);
                break;
        case 3: general.writeEntry("forceFontDPI", 168);
                break;
        case 4: general.writeEntry("forceFontDPI", 192);
                break;
        case 5: general.writeEntry("forceFontDPI", 216);
                break;
        case 6: general.writeEntry("forceFontDPI", 240);
                break;
        case 7: general.writeEntry("forceFontDPI", 264);
                break;
        case 8: general.writeEntry("forceFontDPI", 288);
                break;
    }

    m_globalScale = globalScale;
    emit globalScaleChanged(m_globalScale);
}

void MiscBackend::getGlobalScale()
{
    KConfig kcmfonts(QDir::homePath()+"/.config/kcmfonts");
    KConfigGroup general = kcmfonts.group("General");

    int globalScale = general.readEntry("forceFontDPI", int());

    switch (globalScale) {
        case 0:   m_globalScale = 0;
                  break;
        case 120: m_globalScale = 1;
                  break;
        case 144: m_globalScale = 2;
                  break;
        case 168: m_globalScale = 3;
                  break;
        case 192: m_globalScale = 4;
                  break;
        case 216: m_globalScale = 5;
                  break;
        case 240: m_globalScale = 6;
                  break;
        case 264: m_globalScale = 7;
                  break;
        case 288: m_globalScale = 8;
                  break;
    }
}
