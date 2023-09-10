// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/qtstylebackend.h"

QtStyleBackend::QtStyleBackend()
{
}

QtStyleBackend::~QtStyleBackend()
{
}

int QtStyleBackend::qtStyle() const
{
    return m_qtStyle;
}

void QtStyleBackend::setQtStyle(int qtStyle)
{
    if (m_qtStyle == qtStyle) {
        return;
    }

    QString oldStyle;
    QString newStyle;

    if (m_qtStyle == 0)
        oldStyle = "org.kde.desktop";
    else if (m_qtStyle == 1)
        oldStyle = "org.kde.breeze";
    else if (m_qtStyle == 2)
        oldStyle = "Plasma";
    else if (m_qtStyle == 3)
        oldStyle = "Material";
    else if (m_qtStyle == 4)
        oldStyle = "Universal";
    else if (m_qtStyle == 5)
        oldStyle = "Imagine";

    if (qtStyle == 0)
        newStyle = "org.kde.desktop";
    else if (qtStyle == 1)
        newStyle = "org.kde.breeze";
    else if (qtStyle == 2)
        newStyle = "Plasma";
    else if (qtStyle == 3)
        newStyle = "Material";
    else if (qtStyle == 4)
        newStyle = "Universal";
    else if (qtStyle == 5)
        newStyle = "Imagine";

    QString tx = "export QT_QUICK_CONTROLS_STYLE=";

    QFile file1(QDir::homePath()+"/.bash_profile");
    if (!file1.exists())
    {
        QString text = tx+newStyle;
        QFile file(QDir::homePath()+"/.bash_profile");
        QTextCodec *codec = QTextCodec::codecForLocale();

        if (!file.open(QFile::ReadWrite)) {
            qDebug() << "Error opening for write: " << file.errorString();
            return;
        }
        file.write(codec->fromUnicode(text));
        file.close();

    }
    else{
        QFile file(QDir::homePath()+"/.bash_profile");
        if (!file.open(QFile::ReadWrite)) {
            qDebug() << "Error opening for read: " << file.errorString();
        }
        QTextCodec *codec = QTextCodec::codecForLocale();
        QString text = codec->toUnicode(file.readAll());
        file.close();

        text.replace(tx+oldStyle,tx+newStyle);

        if (!file.open(QFile::ReadWrite|QFile::Truncate)) {
            qDebug() << "Error opening for read: " << file.errorString();
        }
        file.write(codec->fromUnicode(text));
        file.close();
    }

    m_qtStyle = qtStyle;
    emit qtStyleChanged(m_qtStyle);
}

void QtStyleBackend::getQtStyle()
{
    QFile inputFile(QString(QDir::homePath()+"/.bash_profile"));
    inputFile.open(QIODevice::ReadOnly);
    if (!inputFile.isOpen())
    {
        m_qtStyle = 0;
        return;
    }

    QTextStream stream(&inputFile);
    QString line = stream.readLine();
    QString style;
    QString cleanStyle;

    if (line.contains("QT_QUICK_CONTROLS_STYLE"))
    {
        style = line;
        cleanStyle = style.remove("export QT_QUICK_CONTROLS_STYLE=");
    }

    while (!line.isNull())
    {
        /* process information */
        line = stream.readLine();
        if (line.contains("QT_QUICK_CONTROLS_STYLE"))
        {
            style = line;
            cleanStyle = style.remove("export QT_QUICK_CONTROLS_STYLE=");
        }
    }

    if (cleanStyle == "org.kde.desktop")
        m_qtStyle = 0;
    else if (cleanStyle == "org.kde.breeze")
        m_qtStyle = 1;
    else if (cleanStyle == "Plasma")
        m_qtStyle = 2;
    else if (cleanStyle == "Material")
        m_qtStyle = 3;
    else if (cleanStyle == "Universal")
        m_qtStyle = 4;
    else if (cleanStyle == "Imagine")
        m_qtStyle = 5;
}
