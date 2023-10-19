// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/lookandfeelbackend.h"

LookAndFeelBackend::LookAndFeelBackend()
{
}

LookAndFeelBackend::~LookAndFeelBackend()
{
}

int LookAndFeelBackend::selectedStyle() const
{
    return m_selectedStyle;
}

void LookAndFeelBackend::setSelectedStyle(int selectedStyle)
{
    if (m_selectedStyle == selectedStyle) {
        return;
    }

    // Look and feel

    for (int i=0; i<stylesCount(); i++) {
        QVariantMap lookAndFeelStyle = m_lookAndFeelStyles[i].toMap();
        lookAndFeelStyle["selected"] = false;
    }

    QVariantMap lookAndFeelStyle = m_lookAndFeelStyles[selectedStyle].toMap();
    lookAndFeelStyle["selected"] = true;
    QString selectedPackage = lookAndFeelStyle["folder"].toString();

    QProcess *blendEffectProcess = new QProcess(this->parent());
    QStringList blendEffectArguments;
    blendEffectArguments << "org.kde.KWin" << "/org/kde/KWin/BlendChanges" << "start" << "1000";
    blendEffectProcess->execute("qdbus-qt5",blendEffectArguments);

    QProcess *process = new QProcess(this->parent());
    QStringList arguments;
    arguments << "-a" << selectedPackage << "--resetLayout";
    process->execute("plasma-apply-lookandfeel",arguments);

    // SDDM

    int error = 0;
    QByteArray sudoPwd(m_password.toUtf8());

    if (selectedPackage == "org.wildberry.desktop")
    {
        error = system("echo " + sudoPwd + " | sudo -S kwriteconfig5 --file /etc/sddm.conf.d/kde_settings.conf --group Theme --key Current Wildberry");
    }
    else if (selectedPackage == "org.bubblegum.desktop")
    {
        error = system("echo " + sudoPwd + " | sudo -S kwriteconfig5 --file /etc/sddm.conf.d/kde_settings.conf --group Theme --key Current Bubblegum");
    }
    else if (selectedPackage == "org.mint.desktop")
    {
        error = system("echo " + sudoPwd + " | sudo -S kwriteconfig5 --file /etc/sddm.conf.d/kde_settings.conf --group Theme --key Current Mint");
    }

    if (error != 0)
    {
        QProcess notification;
        notification.execute("kdialog --passivepopup \"Login manager has not been changed\" 10");
    }

    m_selectedStyle = selectedStyle;
    emit selectedStyleChanged(m_selectedStyle);
}

int LookAndFeelBackend::stylesCount() const
{
    return m_stylesCount;
}

void LookAndFeelBackend::setStylesCount(int stylesCount)
{
    if (m_stylesCount == stylesCount) {
        return;
    }

    m_stylesCount = stylesCount;
    emit stylesCountChanged(m_stylesCount);
}

QVariantList LookAndFeelBackend::lookAndFeelStyles() const
{
    return m_lookAndFeelStyles;
}

void LookAndFeelBackend::setLookAndFeelStyles(QVariantList lookAndFeelStyles)
{
    if (m_lookAndFeelStyles == lookAndFeelStyles) {
        return;
    }

    m_lookAndFeelStyles = lookAndFeelStyles;
    emit lookAndFeelStylesChanged(m_lookAndFeelStyles);
}

void LookAndFeelBackend::getThemes()
{
    m_lookAndFeelStyles.clear();

    // Obtener valor look and feel seleccionado
    KConfig kdeglobals(QDir::homePath()+"/.config/kdeglobals");
    KConfigGroup KDE = kdeglobals.group("KDE");
    QString selectedStyle = KDE.readEntry("LookAndFeelPackage", QString());

    // Obtener cuenta de paquetes look and feel
    QStringList folderlist1 = GetLookAndFeelFolderList(QDir::homePath()+"/.local/share/plasma/look-and-feel");
    QStringList folderlist2 = GetLookAndFeelFolderList("/usr/share/plasma/look-and-feel");
    int count = folderlist1.length() + folderlist2.length();

    m_stylesCount = count;
    qDebug() << "Look and feel packages: " << count;

    // Idioma del sistema:

    QFile inputFile(QString(QDir::homePath() + "/.config/user-dirs.locale"));
    inputFile.open(QIODevice::ReadOnly);
    if (!inputFile.isOpen())
        return;

    QTextStream stream(&inputFile);
    QString line = stream.readLine();

    QString locale = line;
    QString shortLocale = locale.mid(0,2);

    // Cuenta total de añadidos de folderlist1
    int total = 0;

    // Leer la totalidad de paquetes look and feel
    for (int i = 0; i < folderlist1.length(); i++) {

        QVariantMap item;

        item["folder"] = folderlist1[i];
        item["path"] = QDir::homePath() + "/.local/share/plasma/look-and-feel";

        QString previewpath1 = QDir::homePath() + "/.local/share/plasma/look-and-feel/" + folderlist1[i] + "/contents/previews/preview.png";
        QFile previewfile1(previewpath1);
        if (previewfile1.exists(previewpath1)) {
            item["preview"] = QDir::homePath() + "/.local/share/plasma/look-and-feel/" + folderlist1[i] + "/contents/previews/preview.png";
        }
        else {
            item["preview"] = QDir::homePath() + "/.local/share/plasma/look-and-feel/" + folderlist1[i] + "/contents/previews/preview.jpg";
        }

        if (folderlist1[i] == selectedStyle) {
            item["selected"] = true;
            m_selectedStyle = i;
        }
        else {
            item["selected"] = false;
        }

        QString path1 = QDir::homePath() + "/.local/share/plasma/look-and-feel/" + folderlist1[i] + "/" + "metadata.desktop";
        QFile file1(path1);

        QString path2 = QDir::homePath() + "/.local/share/plasma/look-and-feel/" + folderlist1[i] + "/" + "metadata.json";
        QFile file2(path2);

        if (file1.exists(path1)) {
            KConfig lookAndFeelPackage(path1);
            KConfigGroup desktopEntry = lookAndFeelPackage.group("Desktop Entry");
            item["name"] = desktopEntry.readEntry("Name", QString());
            m_lookAndFeelStyles.append(item);
            total = total + 1;
        }
        else if (file2.exists(path2)) {
            file2.open(QIODevice::ReadOnly | QIODevice::Text);
            QString val;
            val = file2.readAll();
            file2.close();

            QJsonDocument jsonDocument = QJsonDocument::fromJson(val.toUtf8());
            QJsonObject documentObject = jsonDocument.object();

            QJsonObject objectKPlugin = documentObject.value(QString("KPlugin")).toObject();

            QString name;

            QString localeName = "Name[" + locale + "]";
            QString shortLocaleName = "Name[" + shortLocale + "]";

            if (objectKPlugin[localeName].toString() != "") {
                name = objectKPlugin[localeName].toString();
            }
            else if (objectKPlugin[shortLocaleName].toString() != "") {
                name = objectKPlugin[shortLocaleName].toString();
            }
            else {
                name = objectKPlugin["Name"].toString();
            }

            item["name"] = name;

            m_lookAndFeelStyles.append(item);
            total = total + 1;
        }
    }

    for (int i = 0; i < folderlist2.length(); i++) {

        QVariantMap item;

        item["folder"] = folderlist2[i];
        item["path"] = "/usr/share/plasma/look-and-feel";

        QString previewpath2 = "/usr/share/plasma/look-and-feel/" + folderlist2[i] + "/contents/previews/preview.png";
        QFile previewfile2(previewpath2);
        if (previewfile2.exists(previewpath2)) {
            item["preview"] = "/usr/share/plasma/look-and-feel/" + folderlist2[i] + "/contents/previews/preview.png";
        }
        else {
            item["preview"] = "/usr/share/plasma/look-and-feel/" + folderlist2[i] + "/contents/previews/preview.jpg";
        }

        if (folderlist2[i] == selectedStyle) {
            item["selected"] = true;
            m_selectedStyle = total;
        }
        else {
            item["selected"] = false;
        }

        QString path1 = "/usr/share/plasma/look-and-feel/" + folderlist2[i] + "/" + "metadata.desktop";
        QFile file1(path1);

        QString path2 = "/usr/share/plasma/look-and-feel/" + folderlist2[i] + "/" + "metadata.json";
        QFile file2(path2);

        if (file1.exists(path1)) {
            KConfig lookAndFeelPackage(path1);
            KConfigGroup desktopEntry = lookAndFeelPackage.group("Desktop Entry");
            item["name"] = desktopEntry.readEntry("Name", QString());
            m_lookAndFeelStyles.append(item);
            total = total + 1;
        }
        else if (file2.exists(path2)) {
            file2.open(QIODevice::ReadOnly | QIODevice::Text);
            QString val;
            val = file2.readAll();
            file2.close();

            QJsonDocument jsonDocument = QJsonDocument::fromJson(val.toUtf8());
            QJsonObject documentObject = jsonDocument.object();

            QJsonObject objectKPlugin = documentObject.value(QString("KPlugin")).toObject();

            QString name;

            QString localeName = "Name[" + locale + "]";
            QString shortLocaleName = "Name[" + shortLocale + "]";

            if (objectKPlugin[localeName].toString() != "") {
                name = objectKPlugin[localeName].toString();
            }
            else if (objectKPlugin[shortLocaleName].toString() != "") {
                name = objectKPlugin[shortLocaleName].toString();
            }
            else {
                name = objectKPlugin["Name"].toString();
            }

            item["name"] = name;

            m_lookAndFeelStyles.append(item);
            total = total + 1;
        }
    }

    qDebug() << "Índice seleccionado: " << m_selectedStyle;
}

QStringList LookAndFeelBackend::GetLookAndFeelFolderList(QString path) const
{
    QDir directory = QDir(path);
    QStringList folders = directory.entryList(QStringList() << "*", QDir::Dirs | QDir::NoDotAndDotDot);

    return folders;
}

void LookAndFeelBackend::setPassword(QString password)
{
    m_password = password;
}
