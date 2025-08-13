// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/sddmbackend.h"

SDDMBackend::SDDMBackend()
{
}

SDDMBackend::~SDDMBackend()
{
}

int SDDMBackend::count() const
{
    return m_count;
}

void SDDMBackend::setCount(int count)
{
    if (m_count == count) {
        return;
    }

    m_count = count;
    emit countChanged(m_count);
}

QVariantList SDDMBackend::themes() const
{
    return m_themes;
}

void SDDMBackend::setThemes(QVariantList themes)
{
    if (m_themes == themes) {
        return;
    }

    m_themes = themes;
    emit themesChanged(m_themes);
}

int SDDMBackend::selected() const
{
    return m_selected;
}

void SDDMBackend::setSelected(int selected)
{
    if (m_selected == selected) {
        return;
    }

    m_selected = selected;
    emit selectedChanged(m_selected);
}

void SDDMBackend::getThemes()
{
    m_themes.clear();

    QString path = "/usr/share/sddm/themes";
    QDir directory = QDir(path);
    QStringList themes = directory.entryList(QStringList() << "*", QDir::Dirs | QDir::NoDotAndDotDot);
    m_count = 0;

    KConfig sddmConf("/etc/sddm.conf.d/kde_settings.conf");
    KConfigGroup theme = sddmConf.group("Theme");
    QString selected = theme.readEntry("Current", QString());

    for (int i = 0; i < themes.length(); i++) {
        QString path = "/usr/share/sddm/themes/" + themes[i] + "/metadata.desktop";
        QFile file(path);

        if (file.exists(path)) {
            if (themes[i] == selected)
            {
                m_selected = i;
            }
            QVariantMap item;
            item["folder"] = themes[i];
            KConfig sddmTheme(path);
            KConfigGroup sddmGreeterTheme = sddmTheme.group("SddmGreeterTheme");
            item["name"] = sddmGreeterTheme.readEntry("Name", QString());
            item["screenshot"] = "/usr/share/sddm/themes/" + themes[i] + "/" + sddmGreeterTheme.readEntry("Screenshot", QString());
            m_themes.append(item);
            m_count++;
        }
    }
}

void SDDMBackend::setTheme(int index, QString password)
{
    QVariantMap theme = m_themes[index].toMap();
    QString sddmFolder = theme["folder"].toString();

    QByteArray sudoPwd(password.toUtf8());
    QByteArray sddmFolderName(sddmFolder.toUtf8());
    int error = system("echo " + sudoPwd + " | sudo -S kwriteconfig5 --file /etc/sddm.conf.d/kde_settings.conf --group Theme --key Current " + sddmFolderName);

    if (error == 0)
    {
        m_selected = index;
    }
    else {
        QProcess notification;
        notification.execute("kdialog --passivepopup \"An error occurred\" 10");
    }
}
