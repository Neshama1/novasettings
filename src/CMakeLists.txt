# Copyright 2018-2021 Camilo Higuita <milo.h@aol.com>
# Copyright 2018-2021 Nitrux Latinoamericana S.C.
#
# SPDX-License-Identifier: GPL-3.0-or-later

set(project_SRCS
    code/main.cpp
    assets/assets.qrc
    )

qtquick_compiler_add_resources(project_QML_QRC controls/qml.qrc)

add_executable(${PROJECT_NAME}
    ${project_SRCS}
    ${project_QML_QRC}
    backend/colorschemesbackend.cpp
    backend/plasmastylebackend.cpp
    backend/aboutsystembackend.cpp
    backend/wallpapersbackend.cpp
    backend/qtstylebackend.cpp
    backend/miscbackend.cpp
    backend/mousebackend.cpp
    backend/virtualdesktopsbackend.cpp
    backend/powerbackend.cpp
    backend/usersbackend.cpp
    backend/desktopeffectsbackend.cpp
    )

target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    MauiKit3
    MauiKit3::FileBrowsing

    Qt5::Core
    Qt5::Quick
    Qt5::Widgets

    KF5::CoreAddons
    KF5::I18n
    KF5::ConfigCore
    KF5::ConfigGui
    )

install(TARGETS ${PROJECT_NAME} ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
