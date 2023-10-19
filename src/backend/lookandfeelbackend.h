// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef LOOKANDFEELBACKEND_H
#define LOOKANDFEELBACKEND_H

#include <qobject.h>
#include <QVariantList>
#include <QVariantMap>
#include <QString>
#include <QStringList>
#include <QDir>
#include <QProcess>
#include <KConfig>
#include <KConfigGroup>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QFile>
#include <QDebug>

/**
 * @todo write docs
 */
class LookAndFeelBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int selectedStyle READ selectedStyle WRITE setSelectedStyle NOTIFY selectedStyleChanged)
    Q_PROPERTY(int stylesCount READ stylesCount WRITE setStylesCount NOTIFY stylesCountChanged)
    Q_PROPERTY(QVariantList lookAndFeelStyles READ lookAndFeelStyles WRITE setLookAndFeelStyles NOTIFY lookAndFeelStylesChanged)

public:
    Q_INVOKABLE void getThemes();
    Q_INVOKABLE void setPassword(QString password);

public:
    /**
     * Default constructor
     */
    LookAndFeelBackend();

    /**
     * Destructor
     */
    ~LookAndFeelBackend();

    /**
     * @return the selectedStyle
     */
    int selectedStyle() const;

    /**
     * @return the stylesCount
     */
    int stylesCount() const;

    /**
     * @return the lookAndFeelStyles
     */
    QVariantList lookAndFeelStyles() const;

public Q_SLOTS:
    /**
     * Sets the selectedStyle.
     *
     * @param selectedStyle the new selectedStyle
     */
    void setSelectedStyle(int selectedStyle);

    /**
     * Sets the stylesCount.
     *
     * @param stylesCount the new stylesCount
     */
    void setStylesCount(int stylesCount);

    /**
     * Sets the lookAndFeelStyles.
     *
     * @param lookAndFeelStyles the new lookAndFeelStyles
     */
    void setLookAndFeelStyles(QVariantList lookAndFeelStyles);

Q_SIGNALS:
    void selectedStyleChanged(int selectedStyle);

    void stylesCountChanged(int stylesCount);

    void lookAndFeelStylesChanged(QVariantList lookAndFeelStyles);

private:
    int m_selectedStyle;
    int m_stylesCount;
    QVariantList m_lookAndFeelStyles;
    QString m_password;

private:
    QStringList GetLookAndFeelFolderList(QString path) const;
};

#endif // LOOKANDFEELBACKEND_H
