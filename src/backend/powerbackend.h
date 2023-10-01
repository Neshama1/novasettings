// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef POWERBACKEND_H
#define POWERBACKEND_H

#include <QObject>
#include <QDir>
#include <QDebug>
#include <KConfig>
#include <KConfigGroup>

/**
 * @todo write docs
 */
class PowerBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool acDimScrEnable READ acDimScrEnable WRITE setAcDimScrEnable NOTIFY acDimScrEnableChanged)
    Q_PROPERTY(int acDimScrTime READ acDimScrTime WRITE setAcDimScrTime NOTIFY acDimScrTimeChanged)
    Q_PROPERTY(bool acScrSwOffEnable READ acScrSwOffEnable WRITE setAcScrSwOffEnable NOTIFY acScrSwOffEnableChanged)
    Q_PROPERTY(int acScrSwOffTime READ acScrSwOffTime WRITE setAcScrSwOffTime NOTIFY acScrSwOffTimeChanged)
    Q_PROPERTY(bool acSpEnable READ acSpEnable WRITE setAcSpEnable NOTIFY acSpEnableChanged)
    Q_PROPERTY(int acSpTime READ acSpTime WRITE setAcSpTime NOTIFY acSpTimeChanged)
    Q_PROPERTY(bool batteryDimScrEnable READ batteryDimScrEnable WRITE setBatteryDimScrEnable NOTIFY batteryDimScrEnableChanged)
    Q_PROPERTY(int batteryDimScrTime READ batteryDimScrTime WRITE setBatteryDimScrTime NOTIFY batteryDimScrTimeChanged)
    Q_PROPERTY(bool batteryScrSwOffEnable READ batteryScrSwOffEnable WRITE setBatteryScrSwOffEnable NOTIFY batteryScrSwOffEnableChanged)
    Q_PROPERTY(int batteryScrSwOffTime READ batteryScrSwOffTime WRITE setBatteryScrSwOffTime NOTIFY batteryScrSwOffTimeChanged)
    Q_PROPERTY(bool batterySpEnable READ batterySpEnable WRITE setBatterySpEnable NOTIFY batterySpEnableChanged)
    Q_PROPERTY(int batterySpTime READ batterySpTime WRITE setBatterySpTime NOTIFY batterySpTimeChanged)
    Q_PROPERTY(bool lowBatteryDimScrEnable READ lowBatteryDimScrEnable WRITE setLowBatteryDimScrEnable NOTIFY lowBatteryDimScrEnableChanged)
    Q_PROPERTY(int lowBatteryDimScrTime READ lowBatteryDimScrTime WRITE setLowBatteryDimScrTime NOTIFY lowBatteryDimScrTimeChanged)
    Q_PROPERTY(bool lowBatteryScrSwOffEnable READ lowBatteryScrSwOffEnable WRITE setLowBatteryScrSwOffEnable NOTIFY lowBatteryScrSwOffEnableChanged)
    Q_PROPERTY(int lowBatteryScrSwOffTime READ lowBatteryScrSwOffTime WRITE setLowBatteryScrSwOffTime NOTIFY lowBatteryScrSwOffTimeChanged)
    Q_PROPERTY(bool lowBatterySpEnable READ lowBatterySpEnable WRITE setLowBatterySpEnable NOTIFY lowBatterySpEnableChanged)
    Q_PROPERTY(int lowBatterySpTime READ lowBatterySpTime WRITE setLowBatterySpTime NOTIFY lowBatterySpTimeChanged)

public:
    Q_INVOKABLE void getacDimScrEnable();
    Q_INVOKABLE void getacDimScrTime();
    Q_INVOKABLE void getacScrSwOffEnable();
    Q_INVOKABLE void getacScrSwOffTime();
    Q_INVOKABLE void getacSpEnable();
    Q_INVOKABLE void getacSpTime();
    Q_INVOKABLE void getbatteryDimScrEnable();
    Q_INVOKABLE void getbatteryDimScrTime();
    Q_INVOKABLE void getbatteryScrSwOffEnable();
    Q_INVOKABLE void getbatteryScrSwOffTime();
    Q_INVOKABLE void getbatterySpEnable();
    Q_INVOKABLE void getbatterySpTime();
    Q_INVOKABLE void getlowBatteryDimScrEnable();
    Q_INVOKABLE void getlowBatteryDimScrTime();
    Q_INVOKABLE void getlowBatteryScrSwOffEnable();
    Q_INVOKABLE void getlowBatteryScrSwOffTime();
    Q_INVOKABLE void getlowBatterySpEnable();
    Q_INVOKABLE void getlowBatterySpTime();

public:
    /**
     * Default constructor
     */
    PowerBackend();

    /**
     * Destructor
     */
    ~PowerBackend();

    /**
     * @return the acDimScrEnable
     */
    bool acDimScrEnable() const;

    /**
     * @return the acDimScrTime
     */
    int acDimScrTime() const;

    /**
     * @return the acScrSwOffEnable
     */
    bool acScrSwOffEnable() const;

    /**
     * @return the acScrSwOffTime
     */
    int acScrSwOffTime() const;

    /**
     * @return the acSpEnable
     */
    bool acSpEnable() const;

    /**
     * @return the acSpTime
     */
    int acSpTime() const;

    /**
     * @return the batteryDimScrEnable
     */
    bool batteryDimScrEnable() const;

    /**
     * @return the batteryDimScrTime
     */
    int batteryDimScrTime() const;

    /**
     * @return the batteryScrSwOffEnable
     */
    bool batteryScrSwOffEnable() const;

    /**
     * @return the batteryScrSwOffTime
     */
    int batteryScrSwOffTime() const;

    /**
     * @return the batterySpEnable
     */
    bool batterySpEnable() const;

    /**
     * @return the batterySpTime
     */
    int batterySpTime() const;

    /**
     * @return the lowBatteryDimScrEnable
     */
    bool lowBatteryDimScrEnable() const;

    /**
     * @return the lowBatteryDimScrTime
     */
    int lowBatteryDimScrTime() const;

    /**
     * @return the lowBatteryScrSwOffEnable
     */
    bool lowBatteryScrSwOffEnable() const;

    /**
     * @return the lowBatteryScrSwOffTime
     */
    int lowBatteryScrSwOffTime() const;

    /**
     * @return the lowBatterySpEnable
     */
    bool lowBatterySpEnable() const;

    /**
     * @return the lowBatterySpTime
     */
    int lowBatterySpTime() const;

public Q_SLOTS:
    /**
     * Sets the acDimScrEnable.
     *
     * @param acDimScrEnable the new acDimScrEnable
     */
    void setAcDimScrEnable(bool acDimScrEnable);

    /**
     * Sets the acDimScrTime.
     *
     * @param acDimScrTime the new acDimScrTime
     */
    void setAcDimScrTime(int acDimScrTime);

    /**
     * Sets the acScrSwOffEnable.
     *
     * @param acScrSwOffEnable the new acScrSwOffEnable
     */
    void setAcScrSwOffEnable(bool acScrSwOffEnable);

    /**
     * Sets the acScrSwOffTime.
     *
     * @param acScrSwOffTime the new acScrSwOffTime
     */
    void setAcScrSwOffTime(int acScrSwOffTime);

    /**
     * Sets the acSpEnable.
     *
     * @param acSpEnable the new acSpEnable
     */
    void setAcSpEnable(bool acSpEnable);

    /**
     * Sets the acSpTime.
     *
     * @param acSpTime the new acSpTime
     */
    void setAcSpTime(int acSpTime);

    /**
     * Sets the batteryDimScrEnable.
     *
     * @param batteryDimScrEnable the new batteryDimScrEnable
     */
    void setBatteryDimScrEnable(bool batteryDimScrEnable);

    /**
     * Sets the batteryDimScrTime.
     *
     * @param batteryDimScrTime the new batteryDimScrTime
     */
    void setBatteryDimScrTime(int batteryDimScrTime);

    /**
     * Sets the batteryScrSwOffEnable.
     *
     * @param batteryScrSwOffEnable the new batteryScrSwOffEnable
     */
    void setBatteryScrSwOffEnable(bool batteryScrSwOffEnable);

    /**
     * Sets the batteryScrSwOffTime.
     *
     * @param batteryScrSwOffTime the new batteryScrSwOffTime
     */
    void setBatteryScrSwOffTime(int batteryScrSwOffTime);

    /**
     * Sets the batterySpEnable.
     *
     * @param batterySpEnable the new batterySpEnable
     */
    void setBatterySpEnable(bool batterySpEnable);

    /**
     * Sets the batterySpTime.
     *
     * @param batterySpTime the new batterySpTime
     */
    void setBatterySpTime(int batterySpTime);

    /**
     * Sets the lowBatteryDimScrEnable.
     *
     * @param lowBatteryDimScrEnable the new lowBatteryDimScrEnable
     */
    void setLowBatteryDimScrEnable(bool lowBatteryDimScrEnable);

    /**
     * Sets the lowBatteryDimScrTime.
     *
     * @param lowBatteryDimScrTime the new lowBatteryDimScrTime
     */
    void setLowBatteryDimScrTime(int lowBatteryDimScrTime);

    /**
     * Sets the lowBatteryScrSwOffEnable.
     *
     * @param lowBatteryScrSwOffEnable the new lowBatteryScrSwOffEnable
     */
    void setLowBatteryScrSwOffEnable(bool lowBatteryScrSwOffEnable);

    /**
     * Sets the lowBatteryScrSwOffTime.
     *
     * @param lowBatteryScrSwOffTime the new lowBatteryScrSwOffTime
     */
    void setLowBatteryScrSwOffTime(int lowBatteryScrSwOffTime);

    /**
     * Sets the lowBatterySpEnable.
     *
     * @param lowBatterySpEnable the new lowBatterySpEnable
     */
    void setLowBatterySpEnable(bool lowBatterySpEnable);

    /**
     * Sets the lowBatterySpTime.
     *
     * @param lowBatterySpTime the new lowBatterySpTime
     */
    void setLowBatterySpTime(int lowBatterySpTime);

Q_SIGNALS:
    void acDimScrEnableChanged(bool acDimScrEnable);

    void acDimScrTimeChanged(int acDimScrTime);

    void acScrSwOffEnableChanged(bool acScrSwOffEnable);

    void acScrSwOffTimeChanged(int acScrSwOffTime);

    void acSpEnableChanged(bool acSpEnable);

    void acSpTimeChanged(int acSpTime);

    void batteryDimScrEnableChanged(bool batteryDimScrEnable);

    void batteryDimScrTimeChanged(int batteryDimScrTime);

    void batteryScrSwOffEnableChanged(bool batteryScrSwOffEnable);

    void batteryScrSwOffTimeChanged(int batteryScrSwOffTime);

    void batterySpEnableChanged(bool batterySpEnable);

    void batterySpTimeChanged(int batterySpTime);

    void lowBatteryDimScrEnableChanged(bool lowBatteryDimScrEnable);

    void lowBatteryDimScrTimeChanged(int lowBatteryDimScrTime);

    void lowBatteryScrSwOffEnableChanged(bool lowBatteryScrSwOffEnable);

    void lowBatteryScrSwOffTimeChanged(int lowBatteryScrSwOffTime);

    void lowBatterySpEnableChanged(bool lowBatterySpEnable);

    void lowBatterySpTimeChanged(int lowBatterySpTime);

private:
    bool m_acDimScrEnable;
    int m_acDimScrTime;
    bool m_acScrSwOffEnable;
    int m_acScrSwOffTime;
    bool m_acSpEnable;
    int m_acSpTime;
    bool m_batteryDimScrEnable;
    int m_batteryDimScrTime;
    bool m_batteryScrSwOffEnable;
    int m_batteryScrSwOffTime;
    bool m_batterySpEnable;
    int m_batterySpTime;
    bool m_lowBatteryDimScrEnable;
    int m_lowBatteryDimScrTime;
    bool m_lowBatteryScrSwOffEnable;
    int m_lowBatteryScrSwOffTime;
    bool m_lowBatterySpEnable;
    int m_lowBatterySpTime;
};

#endif // POWERBACKEND_H
