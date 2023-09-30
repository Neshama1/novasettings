// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2023 asterion <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef MOUSEBACKEND_H
#define MOUSEBACKEND_H

#include <QObject>
#include <QDir>
#include <QDebug>
#include <KConfig>
#include <KConfigGroup>

/**
 * @todo write docs
 */
class MouseBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int pointerAcceleration READ pointerAcceleration WRITE setPointerAcceleration NOTIFY pointerAccelerationChanged)
    Q_PROPERTY(bool flatAccelProfile READ flatAccelProfile WRITE setFlatAccelProfile NOTIFY flatAccelProfileChanged)
    Q_PROPERTY(bool leftHanded READ leftHanded WRITE setLeftHanded NOTIFY leftHandedChanged)

public:
    Q_INVOKABLE void getPointerAcceleration();
    Q_INVOKABLE void getFlatAccelProfile();
    Q_INVOKABLE void getLeftHanded();

public:
    /**
     * Default constructor
     */
    MouseBackend();

    /**
     * Destructor
     */
    ~MouseBackend();

    /**
     * @return the pointerAcceleration
     */
    int pointerAcceleration() const;

    /**
     * @return the flatAccelProfile
     */
    bool flatAccelProfile() const;

    /**
     * @return the leftHanded
     */
    bool leftHanded() const;

public Q_SLOTS:
    /**
     * Sets the pointerAcceleration.
     *
     * @param pointerAcceleration the new pointerAcceleration
     */
    void setPointerAcceleration(int pointerAcceleration);

    /**
     * Sets the flatAccelProfile.
     *
     * @param flatAccelProfile the new flatAccelProfile
     */
    void setFlatAccelProfile(bool flatAccelProfile);

    /**
     * Sets the leftHanded.
     *
     * @param leftHanded the new leftHanded
     */
    void setLeftHanded(bool leftHanded);

Q_SIGNALS:
    void pointerAccelerationChanged(int pointerAcceleration);

    void flatAccelProfileChanged(bool flatAccelProfile);

    void leftHandedChanged(bool leftHanded);

private:
    int m_pointerAcceleration;
    bool m_flatAccelProfile;
    bool m_leftHanded;
};

#endif // MOUSEBACKEND_H
