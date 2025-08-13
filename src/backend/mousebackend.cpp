// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "backend/mousebackend.h"

MouseBackend::MouseBackend()
{
}

MouseBackend::~MouseBackend()
{
}

int MouseBackend::pointerAcceleration() const
{
    return m_pointerAcceleration;
}

void MouseBackend::setPointerAcceleration(int pointerAcceleration)
{
    if (m_pointerAcceleration == pointerAcceleration) {
        return;
    }

    KConfig kcminputrc(QDir::homePath()+"/.config/kcminputrc");
    KConfigGroup mouse = kcminputrc.group("Mouse");

    switch (pointerAcceleration) {
        case 0:  mouse.writeEntry("XLbInptPointerAcceleration", -1);;
                 break;
        case 1:  mouse.writeEntry("XLbInptPointerAcceleration", -0.8);
                 break;
        case 2:  mouse.writeEntry("XLbInptPointerAcceleration", -0.6);
                 break;
        case 3:  mouse.writeEntry("XLbInptPointerAcceleration", -0.4);
                 break;
        case 4:  mouse.writeEntry("XLbInptPointerAcceleration", -0.2);
                 break;
        case 5:  mouse.writeEntry("XLbInptPointerAcceleration", 0);
                 break;
        case 6:  mouse.writeEntry("XLbInptPointerAcceleration", 0.2);
                 break;
        case 7:  mouse.writeEntry("XLbInptPointerAcceleration", 0.4);
                 break;
        case 8:  mouse.writeEntry("XLbInptPointerAcceleration", 0.6);
                 break;
        case 9:  mouse.writeEntry("XLbInptPointerAcceleration", 0.8);
                 break;
        case 10: mouse.writeEntry("XLbInptPointerAcceleration", 1);
                 break;
    }

    m_pointerAcceleration = pointerAcceleration;
    emit pointerAccelerationChanged(m_pointerAcceleration);
}

void MouseBackend::getPointerAcceleration()
{
    KConfig kcminputrc(QDir::homePath()+"/.config/kcminputrc");
    KConfigGroup mouse = kcminputrc.group("Mouse");

    if (mouse.hasKey("XLbInptPointerAcceleration"))
    {
        qreal pointerAcceleration = mouse.readEntry("XLbInptPointerAcceleration", qreal());

        if (pointerAcceleration == -1)
            m_pointerAcceleration = 0;
        else if (pointerAcceleration == -0.8)
            m_pointerAcceleration = 1;
        else if (pointerAcceleration == -0.6)
            m_pointerAcceleration = 2;
        else if (pointerAcceleration == -0.4)
            m_pointerAcceleration = 3;
        else if (pointerAcceleration == -0.2)
            m_pointerAcceleration = 4;
        else if (pointerAcceleration == 0)
            m_pointerAcceleration = 5;
        else if (pointerAcceleration == 0.2)
            m_pointerAcceleration = 6;
        else if (pointerAcceleration == 0.4)
            m_pointerAcceleration = 7;
        else if (pointerAcceleration == 0.6)
            m_pointerAcceleration = 8;
        else if (pointerAcceleration == 0.8)
            m_pointerAcceleration = 9;
        else if (pointerAcceleration == 1)
            m_pointerAcceleration = 10;
    }
    else
        m_pointerAcceleration = 5;
}

bool MouseBackend::flatAccelProfile() const
{
    return m_flatAccelProfile;
}

void MouseBackend::setFlatAccelProfile(bool flatAccelProfile)
{
    if (m_flatAccelProfile == flatAccelProfile) {
        return;
    }

    KConfig kcminputrc(QDir::homePath()+"/.config/kcminputrc");
    KConfigGroup mouse = kcminputrc.group("Mouse");
    mouse.writeEntry("XLbInptAccelProfileFlat", flatAccelProfile);

    m_flatAccelProfile = flatAccelProfile;
    emit flatAccelProfileChanged(m_flatAccelProfile);
}

void MouseBackend::getFlatAccelProfile()
{
    KConfig kcminputrc(QDir::homePath()+"/.config/kcminputrc");
    KConfigGroup mouse = kcminputrc.group("Mouse");

    if (mouse.hasKey("XLbInptAccelProfileFlat"))
        m_flatAccelProfile = mouse.readEntry("XLbInptAccelProfileFlat", bool());
    else
        m_flatAccelProfile = true;
}


bool MouseBackend::leftHanded() const
{
    return m_leftHanded;
}

void MouseBackend::setLeftHanded(bool leftHanded)
{
    if (m_leftHanded == leftHanded) {
        return;
    }

    KConfig kcminputrc(QDir::homePath()+"/.config/kcminputrc");
    KConfigGroup mouse = kcminputrc.group("Mouse");
    mouse.writeEntry("XLbInptLeftHanded", leftHanded);

    m_leftHanded = leftHanded;
    emit leftHandedChanged(m_leftHanded);
}

void MouseBackend::getLeftHanded()
{
    KConfig kcminputrc(QDir::homePath()+"/.config/kcminputrc");
    KConfigGroup mouse = kcminputrc.group("Mouse");

    if (mouse.hasKey("XLbInptLeftHanded"))
        m_leftHanded = mouse.readEntry("XLbInptLeftHanded", bool());
    else
        m_leftHanded = false;
}
