// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef SDDMBACKEND_H
#define SDDMBACKEND_H

#include <qobject.h>
#include <QVariantList>
#include <QVariantMap>
#include <QDir>
#include <QFile>
#include <QString>
#include <QStringList>
#include <QByteArray>
#include <QProcess>
#include <KConfig>
#include <KConfigGroup>
#include <QDebug>

/**
 * @todo write docs
 */
class SDDMBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int count READ count WRITE setCount NOTIFY countChanged)
    Q_PROPERTY(int selected READ selected WRITE setSelected NOTIFY selectedChanged)
    Q_PROPERTY(QVariantList themes READ themes WRITE setThemes NOTIFY themesChanged)

public:
Q_INVOKABLE void getThemes();
Q_INVOKABLE void setTheme(int index, QString password);

public:
    /**
     * Default constructor
     */
    SDDMBackend();

    /**
     * Destructor
     */
    ~SDDMBackend();

    /**
     * @return the count
     */
    int count() const;

    /**
     * @return the themes
     */
    QVariantList themes() const;

    /**
     * @return the selected
     */
    int selected() const;

public Q_SLOTS:
    /**
     * Sets the count.
     *
     * @param count the new count
     */
    void setCount(int count);

    /**
     * Sets the themes.
     *
     * @param themes the new themes
     */
    void setThemes(QVariantList themes);

    /**
     * Sets the themes.
     *
     * @param selected the new selected
     */
    void setSelected(int selected);

Q_SIGNALS:
    void countChanged(int count);

    void themesChanged(QVariantList themes);

    void selectedChanged(int selected);

private:
    int m_count;
    QVariantList m_themes;
    int m_selected;
};

#endif // SDDMBACKEND_H
