// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef VIRTUALDESKTOPSBACKEND_H
#define VIRTUALDESKTOPSBACKEND_H

#include <QObject>
#include <QDebug>
#include <QDir>
#include <KConfig>
#include <KConfigGroup>

/**
 * @todo write docs
 */
class VirtualDesktopsBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool slide READ slide WRITE setSlide NOTIFY slideChanged)
    Q_PROPERTY(int rows READ rows WRITE setRows NOTIFY rowsChanged)
    Q_PROPERTY(int number READ number WRITE setNumber NOTIFY numberChanged)

public:
    Q_INVOKABLE void getSlide();
    Q_INVOKABLE void getRows();
    Q_INVOKABLE void getNumber();

public:
    /**
     * Default constructor
     */
    VirtualDesktopsBackend();

    /**
     * Destructor
     */
    ~VirtualDesktopsBackend();

    /**
     * @return the slide
     */
    bool slide() const;

    /**
     * @return the rows
     */
    int rows() const;

    /**
     * @return the number
     */
    int number() const;

public Q_SLOTS:
    /**
     * Sets the slide.
     *
     * @param slide the new slide
     */
    void setSlide(bool slide);

    /**
     * Sets the rows.
     *
     * @param rows the new rows
     */
    void setRows(int rows);

    /**
     * Sets the number.
     *
     * @param number the new number
     */
    void setNumber(int number);

Q_SIGNALS:
    void slideChanged(bool slide);

    void rowsChanged(int rows);

    void numberChanged(int number);

private:
    bool m_slide;
    int m_rows;
    int m_number;
};

#endif // VIRTUALDESKTOPSBACKEND_H
