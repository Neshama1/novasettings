// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/powerbackend.h"

PowerBackend::PowerBackend()
{
}

PowerBackend::~PowerBackend()
{
}

bool PowerBackend::acDimScrEnable() const
{
    return m_acDimScrEnable;
}

void PowerBackend::setAcDimScrEnable(bool acDimScrEnable)
{
    if (m_acDimScrEnable == acDimScrEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDimDisplay = powermanagementprofilesrc.group("AC").group("DimDisplay");

    if (acDimScrEnable)
        acDimDisplay.writeEntry("idleTime", m_acDimScrTime * 60000);
    else
        acDimDisplay.deleteGroup();

    m_acDimScrEnable = acDimScrEnable;
    emit acDimScrEnableChanged(m_acDimScrEnable);
}

void PowerBackend::getacDimScrEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDimDisplay = powermanagementprofilesrc.group("AC").group("DimDisplay");

    if (acDimDisplay.hasKey("idleTime"))
        m_acDimScrEnable = true;
    else
        m_acDimScrEnable = false;
}


int PowerBackend::acDimScrTime() const
{
    return m_acDimScrTime;
}

void PowerBackend::setAcDimScrTime(int acDimScrTime)
{
    if (m_acDimScrTime == acDimScrTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDimDisplay = powermanagementprofilesrc.group("AC").group("DimDisplay");
    acDimDisplay.writeEntry("idleTime", acDimScrTime * 60000);

    m_acDimScrTime = acDimScrTime;
    emit acDimScrTimeChanged(m_acDimScrTime);
}

void PowerBackend::getacDimScrTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDimDisplay = powermanagementprofilesrc.group("AC").group("DimDisplay");

    if (acDimDisplay.hasKey("idleTime"))
        m_acDimScrTime = acDimDisplay.readEntry("idleTime", int()) / 60000;
    else
        m_acDimScrTime = 10;
}

bool PowerBackend::acScrSwOffEnable() const
{
    return m_acScrSwOffEnable;
}

void PowerBackend::setAcScrSwOffEnable(bool acScrSwOffEnable)
{
    if (m_acScrSwOffEnable == acScrSwOffEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDPMSControl = powermanagementprofilesrc.group("AC").group("DPMSControl");

    if (acScrSwOffEnable)
    {
        acDPMSControl.writeEntry("idleTime", m_acScrSwOffTime * 60);
        acDPMSControl.writeEntry("lockBeforeTurnOff", 0);
    }
    else
        acDPMSControl.deleteGroup();

    m_acScrSwOffEnable = acScrSwOffEnable;
    emit acScrSwOffEnableChanged(m_acScrSwOffEnable);
}

void PowerBackend::getacScrSwOffEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDPMSControl = powermanagementprofilesrc.group("AC").group("DPMSControl");

    if (acDPMSControl.hasKey("idleTime"))
        m_acScrSwOffEnable = true;
    else
        m_acScrSwOffEnable = false;
}

int PowerBackend::acScrSwOffTime() const
{
    return m_acScrSwOffTime;
}

void PowerBackend::setAcScrSwOffTime(int acScrSwOffTime)
{
    if (m_acScrSwOffTime == acScrSwOffTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDPMSControl = powermanagementprofilesrc.group("AC").group("DPMSControl");
    acDPMSControl.writeEntry("idleTime", acScrSwOffTime * 60);

    m_acScrSwOffTime = acScrSwOffTime;
    emit acScrSwOffTimeChanged(m_acScrSwOffTime);
}

void PowerBackend::getacScrSwOffTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup acDPMSControl = powermanagementprofilesrc.group("AC").group("DPMSControl");

    if (acDPMSControl.hasKey("idleTime"))
        m_acScrSwOffTime = acDPMSControl.readEntry("idleTime", int()) / 60;
    else
        m_acScrSwOffTime = 10;
}

bool PowerBackend::acSpEnable() const
{
    return m_acSpEnable;
}


void PowerBackend::setAcSpEnable(bool acSpEnable)
{
    if (m_acSpEnable == acSpEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("AC").group("SuspendSession");

    if (acSpEnable)
    {
        suspendSession.writeEntry("idleTime", m_acSpTime * 60000);
        suspendSession.writeEntry("suspendThenHibernate", false);
        suspendSession.writeEntry("suspendType", 1);
    }
    else
        suspendSession.deleteGroup();

    m_acSpEnable = acSpEnable;
    emit acSpEnableChanged(m_acSpEnable);
}

void PowerBackend::getacSpEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("AC").group("SuspendSession");

    if (suspendSession.hasKey("idleTime"))
        m_acSpEnable = true;
    else
        m_acSpEnable = false;
}

int PowerBackend::acSpTime() const
{
    return m_acSpTime;
}

void PowerBackend::setAcSpTime(int acSpTime)
{
    if (m_acSpTime == acSpTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("AC").group("SuspendSession");
    suspendSession.writeEntry("idleTime", acSpTime * 60000);

    m_acSpTime = acSpTime;
    emit acSpTimeChanged(m_acSpTime);
}

void PowerBackend::getacSpTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("AC").group("SuspendSession");

    if (suspendSession.hasKey("idleTime"))
        m_acSpTime = suspendSession.readEntry("idleTime", int()) / 60000;
    else
        m_acSpTime = 10;
}

bool PowerBackend::batteryDimScrEnable() const
{
    return m_batteryDimScrEnable;
}

void PowerBackend::setBatteryDimScrEnable(bool batteryDimScrEnable)
{
    if (m_batteryDimScrEnable == batteryDimScrEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDimDisplay = powermanagementprofilesrc.group("Battery").group("DimDisplay");

    if (batteryDimScrEnable)
        batteryDimDisplay.writeEntry("idleTime", m_batteryDimScrTime * 60000);
    else
        batteryDimDisplay.deleteGroup();

    m_batteryDimScrEnable = batteryDimScrEnable;
    emit batteryDimScrEnableChanged(m_batteryDimScrEnable);
}

void PowerBackend::getbatteryDimScrEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDimDisplay = powermanagementprofilesrc.group("Battery").group("DimDisplay");

    if (batteryDimDisplay.hasKey("idleTime"))
        m_batteryDimScrEnable = true;
    else
        m_batteryDimScrEnable = false;
}

int PowerBackend::batteryDimScrTime() const
{
    return m_batteryDimScrTime;
}

void PowerBackend::setBatteryDimScrTime(int batteryDimScrTime)
{
    if (m_batteryDimScrTime == batteryDimScrTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDimDisplay = powermanagementprofilesrc.group("Battery").group("DimDisplay");
    batteryDimDisplay.writeEntry("idleTime", batteryDimScrTime * 60000);

    m_batteryDimScrTime = batteryDimScrTime;
    emit batteryDimScrTimeChanged(m_batteryDimScrTime);
}

void PowerBackend::getbatteryDimScrTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDimDisplay = powermanagementprofilesrc.group("Battery").group("DimDisplay");

    if (batteryDimDisplay.hasKey("idleTime"))
        m_batteryDimScrTime = batteryDimDisplay.readEntry("idleTime", int()) / 60000;
    else
        m_batteryDimScrTime = 10;
}

bool PowerBackend::batteryScrSwOffEnable() const
{
    return m_batteryScrSwOffEnable;
}

void PowerBackend::setBatteryScrSwOffEnable(bool batteryScrSwOffEnable)
{
    if (m_batteryScrSwOffEnable == batteryScrSwOffEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDPMSControl = powermanagementprofilesrc.group("Battery").group("DPMSControl");

    if (batteryScrSwOffEnable)
    {
        batteryDPMSControl.writeEntry("idleTime", m_batteryScrSwOffTime * 60);
        batteryDPMSControl.writeEntry("lockBeforeTurnOff", 0);
    }
    else
        batteryDPMSControl.deleteGroup();

    m_batteryScrSwOffEnable = batteryScrSwOffEnable;
    emit batteryScrSwOffEnableChanged(m_batteryScrSwOffEnable);
}

void PowerBackend::getbatteryScrSwOffEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDPMSControl = powermanagementprofilesrc.group("Battery").group("DPMSControl");

    if (batteryDPMSControl.hasKey("idleTime"))
        m_batteryScrSwOffEnable = true;
    else
        m_batteryScrSwOffEnable = false;
}

int PowerBackend::batteryScrSwOffTime() const
{
    return m_batteryScrSwOffTime;
}

void PowerBackend::setBatteryScrSwOffTime(int batteryScrSwOffTime)
{
    if (m_batteryScrSwOffTime == batteryScrSwOffTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDPMSControl = powermanagementprofilesrc.group("Battery").group("DPMSControl");
    batteryDPMSControl.writeEntry("idleTime", batteryScrSwOffTime * 60);

    m_batteryScrSwOffTime = batteryScrSwOffTime;
    emit batteryScrSwOffTimeChanged(m_batteryScrSwOffTime);
}

void PowerBackend::getbatteryScrSwOffTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup batteryDPMSControl = powermanagementprofilesrc.group("Battery").group("DPMSControl");

    if (batteryDPMSControl.hasKey("idleTime"))
        m_batteryScrSwOffTime = batteryDPMSControl.readEntry("idleTime", int()) / 60;
    else
        m_batteryScrSwOffTime = 10;
}

bool PowerBackend::batterySpEnable() const
{
    return m_batterySpEnable;
}

void PowerBackend::setBatterySpEnable(bool batterySpEnable)
{
    if (m_batterySpEnable == batterySpEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("Battery").group("SuspendSession");

    if (batterySpEnable)
    {
        suspendSession.writeEntry("idleTime", m_batterySpTime * 60000);
        suspendSession.writeEntry("suspendThenHibernate", false);
        suspendSession.writeEntry("suspendType", 1);
    }
    else
        suspendSession.deleteGroup();

    m_batterySpEnable = batterySpEnable;
    emit batterySpEnableChanged(m_batterySpEnable);
}

void PowerBackend::getbatterySpEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("Battery").group("SuspendSession");

    if (suspendSession.hasKey("idleTime"))
        m_batterySpEnable = true;
    else
        m_batterySpEnable = false;
}

int PowerBackend::batterySpTime() const
{
    return m_batterySpTime;
}

void PowerBackend::setBatterySpTime(int batterySpTime)
{
    if (m_batterySpTime == batterySpTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("Battery").group("SuspendSession");
    suspendSession.writeEntry("idleTime", batterySpTime * 60000);

    m_batterySpTime = batterySpTime;
    emit batterySpTimeChanged(m_batterySpTime);
}

void PowerBackend::getbatterySpTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("Battery").group("SuspendSession");

    if (suspendSession.hasKey("idleTime"))
        m_batterySpTime = suspendSession.readEntry("idleTime", int()) / 60000;
    else
        m_batterySpTime = 10;
}

bool PowerBackend::lowBatteryDimScrEnable() const
{
    return m_lowBatteryDimScrEnable;
}

void PowerBackend::setLowBatteryDimScrEnable(bool lowBatteryDimScrEnable)
{
    if (m_lowBatteryDimScrEnable == lowBatteryDimScrEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDimDisplay = powermanagementprofilesrc.group("LowBattery").group("DimDisplay");

    if (lowBatteryDimScrEnable)
        lowBatteryDimDisplay.writeEntry("idleTime", m_lowBatteryDimScrTime * 60000);
    else
        lowBatteryDimDisplay.deleteGroup();

    m_lowBatteryDimScrEnable = lowBatteryDimScrEnable;
    emit lowBatteryDimScrEnableChanged(m_lowBatteryDimScrEnable);
}

void PowerBackend::getlowBatteryDimScrEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDimDisplay = powermanagementprofilesrc.group("LowBattery").group("DimDisplay");

    if (lowBatteryDimDisplay.hasKey("idleTime"))
        m_lowBatteryDimScrEnable = true;
    else
        m_lowBatteryDimScrEnable = false;

}

int PowerBackend::lowBatteryDimScrTime() const
{
    return m_lowBatteryDimScrTime;
}

void PowerBackend::setLowBatteryDimScrTime(int lowBatteryDimScrTime)
{
    if (m_lowBatteryDimScrTime == lowBatteryDimScrTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDimDisplay = powermanagementprofilesrc.group("LowBattery").group("DimDisplay");
    lowBatteryDimDisplay.writeEntry("idleTime", lowBatteryDimScrTime * 60000);

    m_lowBatteryDimScrTime = lowBatteryDimScrTime;
    emit lowBatteryDimScrTimeChanged(m_lowBatteryDimScrTime);
}

void PowerBackend::getlowBatteryDimScrTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDimDisplay = powermanagementprofilesrc.group("LowBattery").group("DimDisplay");

    if (lowBatteryDimDisplay.hasKey("idleTime"))
        m_lowBatteryDimScrTime = lowBatteryDimDisplay.readEntry("idleTime", int()) / 60000;
    else
        m_lowBatteryDimScrTime = 10;
}

bool PowerBackend::lowBatteryScrSwOffEnable() const
{
    return m_lowBatteryScrSwOffEnable;
}

void PowerBackend::setLowBatteryScrSwOffEnable(bool lowBatteryScrSwOffEnable)
{
    if (m_lowBatteryScrSwOffEnable == lowBatteryScrSwOffEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDPMSControl = powermanagementprofilesrc.group("LowBattery").group("DPMSControl");

    if (lowBatteryScrSwOffEnable)
    {
        lowBatteryDPMSControl.writeEntry("idleTime", m_lowBatteryScrSwOffTime * 60);
        lowBatteryDPMSControl.writeEntry("lockBeforeTurnOff", 0);
    }
    else
        lowBatteryDPMSControl.deleteGroup();

    m_lowBatteryScrSwOffEnable = lowBatteryScrSwOffEnable;
    emit lowBatteryScrSwOffEnableChanged(m_lowBatteryScrSwOffEnable);
}

void PowerBackend::getlowBatteryScrSwOffEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDPMSControl = powermanagementprofilesrc.group("LowBattery").group("DPMSControl");

    if (lowBatteryDPMSControl.hasKey("idleTime"))
        m_lowBatteryScrSwOffEnable = true;
    else
        m_lowBatteryScrSwOffEnable = false;
}

int PowerBackend::lowBatteryScrSwOffTime() const
{
    return m_lowBatteryScrSwOffTime;
}

void PowerBackend::setLowBatteryScrSwOffTime(int lowBatteryScrSwOffTime)
{
    if (m_lowBatteryScrSwOffTime == lowBatteryScrSwOffTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDPMSControl = powermanagementprofilesrc.group("LowBattery").group("DPMSControl");
    lowBatteryDPMSControl.writeEntry("idleTime", lowBatteryScrSwOffTime * 60);

    m_lowBatteryScrSwOffTime = lowBatteryScrSwOffTime;
    emit lowBatteryScrSwOffTimeChanged(m_lowBatteryScrSwOffTime);
}

void PowerBackend::getlowBatteryScrSwOffTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup lowBatteryDPMSControl = powermanagementprofilesrc.group("LowBattery").group("DPMSControl");

    if (lowBatteryDPMSControl.hasKey("idleTime"))
        m_lowBatteryScrSwOffTime = lowBatteryDPMSControl.readEntry("idleTime", int()) / 60;
    else
        m_lowBatteryScrSwOffTime = 10;
}

bool PowerBackend::lowBatterySpEnable() const
{
    return m_lowBatterySpEnable;
}

void PowerBackend::setLowBatterySpEnable(bool lowBatterySpEnable)
{
    if (m_lowBatterySpEnable == lowBatterySpEnable) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("LowBattery").group("SuspendSession");

    if (lowBatterySpEnable)
    {
        suspendSession.writeEntry("idleTime", m_lowBatterySpTime * 60000);
        suspendSession.writeEntry("suspendThenHibernate", false);
        suspendSession.writeEntry("suspendType", 1);
    }
    else
        suspendSession.deleteGroup();

    m_lowBatterySpEnable = lowBatterySpEnable;
    emit lowBatterySpEnableChanged(m_lowBatterySpEnable);
}

void PowerBackend::getlowBatterySpEnable()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("LowBattery").group("SuspendSession");

    if (suspendSession.hasKey("idleTime"))
        m_lowBatterySpEnable = true;
    else
        m_lowBatterySpEnable = false;
}

int PowerBackend::lowBatterySpTime() const
{
    return m_lowBatterySpTime;
}

void PowerBackend::setLowBatterySpTime(int lowBatterySpTime)
{
    if (m_lowBatterySpTime == lowBatterySpTime) {
        return;
    }

    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("LowBattery").group("SuspendSession");
    suspendSession.writeEntry("idleTime", lowBatterySpTime * 60000);

    m_lowBatterySpTime = lowBatterySpTime;
    emit lowBatterySpTimeChanged(m_lowBatterySpTime);
}

void PowerBackend::getlowBatterySpTime()
{
    KConfig powermanagementprofilesrc(QDir::homePath()+"/.config/powermanagementprofilesrc");
    KConfigGroup suspendSession = powermanagementprofilesrc.group("LowBattery").group("SuspendSession");

    if (suspendSession.hasKey("idleTime"))
        m_lowBatterySpTime = suspendSession.readEntry("idleTime", int()) / 60000;
    else
        m_lowBatterySpTime = 10;
}
