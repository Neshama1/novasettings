// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef MISCBACKEND_H
#define MISCBACKEND_H

#include <QObject>
#include <KConfig>
#include <KConfigGroup>
#include <QString>
#include <QDir>
#include <QDebug>

/**
 * @todo write docs
 */
class MiscBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int fontThick READ fontThick WRITE setFontThick NOTIFY fontThickChanged)
    Q_PROPERTY(bool fileIndexing READ fileIndexing WRITE setFileIndexing NOTIFY fileIndexingChanged)
    Q_PROPERTY(int globalScale READ globalScale WRITE setGlobalScale NOTIFY globalScaleChanged)

public:
    Q_INVOKABLE void getFont();
    Q_INVOKABLE void getFileIndexing();
    Q_INVOKABLE void getGlobalScale();

public:
    /**
     * Default constructor
     */
    MiscBackend();

    /**
     * Destructor
     */
    ~MiscBackend();

    /**
     * @return the fontThick
     */
    int fontThick() const;
    bool fileIndexing();
    int globalScale();

public Q_SLOTS:
    /**
     * Sets the fontThick.
     *
     * @param fontThick the new fontThick
     */
    void setFontThick(int fontThick);
    void setFileIndexing(bool fileIndexing);
    void setGlobalScale(int globalScale);

Q_SIGNALS:
    void fontThickChanged(int fontThick);
    void fileIndexingChanged(bool fileIndexing);
    void globalScaleChanged(int globalScale);

private:
    int m_fontThick;
    bool m_fileIndexing;
    int m_globalScale;
};

#endif // MISCBACKEND_H
