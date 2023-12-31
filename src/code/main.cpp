#include <QApplication>
#include <QQmlApplicationEngine>
#include <QCommandLineParser>
#include <QDate>
#include <QIcon>
#include <QQmlContext>

#include <MauiKit3/Core/mauiapp.h>

#include <KAboutData>
#include <KI18n/KLocalizedString>

#include "../project_version.h"

#include "backend/colorschemesbackend.h"
#include "backend/plasmastylebackend.h"
#include "backend/wallpapersbackend.h"
#include "backend/qtstylebackend.h"
#include "backend/aboutsystembackend.h"
#include "backend/miscbackend.h"
#include "backend/mousebackend.h"
#include "backend/virtualdesktopsbackend.h"
#include "backend/powerbackend.h"
#include "backend/usersbackend.h"
#include "backend/desktopeffectsbackend.h"
#include "backend/lookandfeelbackend.h"
#include "backend/sddmbackend.h"

//Useful for setting quickly an app template
#define ORG_NAME "KDE"
#define PROJECT_NAME "Nova Settings"
#define COMPONENT_NAME "novasettings"
#define PROJECT_DESCRIPTION "KDE Settings App"
#define PROJECT_YEAR "2023"
#define PRODUCT_NAME "novasettings"
#define PROJECT_PAGE "https://novasettings.kde.org"
#define REPORT_PAGE "https://bugs.kde.org/enter_bug.cgi?product=novasettings"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    app.setOrganizationName(QStringLiteral(ORG_NAME));
    app.setWindowIcon(QIcon(":/logo.png"));

    KLocalizedString::setApplicationDomain(COMPONENT_NAME);

    KAboutData about(QStringLiteral(COMPONENT_NAME), i18n(PROJECT_NAME), PROJECT_VERSION_STRING, i18n(PROJECT_DESCRIPTION),
                     KAboutLicense::LGPL_V3, QString("© %1-%2 %3 Development Team").arg(PROJECT_YEAR, QString::number(QDate::currentDate().year()), ORG_NAME), QString(GIT_BRANCH) + "/" + QString(GIT_COMMIT_HASH));

    about.addAuthor(i18n("Miguel Beltrán"), i18n("Developer"), QStringLiteral("hopeandtruth6517@gmail.com"));

    about.setHomepage(PROJECT_PAGE);
    about.setProductName(PRODUCT_NAME);
    about.setBugAddress(REPORT_PAGE);
    about.setOrganizationDomain(PROJECT_URI);
    about.setProgramLogo(app.windowIcon());
    //about.addComponent("Akonadi");
    about.addCredit(i18n("MauiKit Developers"));

    KAboutData::setApplicationData(about);
    MauiApp::instance()->setIconName("qrc:/logo.svg");

    QCommandLineParser parser;
    parser.setApplicationDescription(about.shortDescription());
    parser.process(app);
    about.processCommandLine(&parser);

    QQmlApplicationEngine engine;

    ColorSchemesBackend colorschemesbackend;
    qmlRegisterSingletonInstance<ColorSchemesBackend>("org.kde.novasettings", 1, 0, "ColorSchemesBackend", &colorschemesbackend);

    PlasmaStyleBackend plasmastylebackend;
    qmlRegisterSingletonInstance<PlasmaStyleBackend>("org.kde.novasettings", 1, 0, "PlasmaStyleBackend", &plasmastylebackend);

    WallpapersBackend wallpapersbackend;
    qmlRegisterSingletonInstance<WallpapersBackend>("org.kde.novasettings", 1, 0, "WallpapersBackend", &wallpapersbackend);

    QtStyleBackend qtstylebackend;
    qmlRegisterSingletonInstance<QtStyleBackend>("org.kde.novasettings", 1, 0, "QtStyleBackend", &qtstylebackend);

    LookAndFeelBackend lookandfeelbackend;
    qmlRegisterSingletonInstance<LookAndFeelBackend>("org.kde.novasettings", 1, 0, "LookAndFeelBackend", &lookandfeelbackend);

    SDDMBackend sddmbackend;
    qmlRegisterSingletonInstance<SDDMBackend>("org.kde.novasettings", 1, 0, "SDDMBackend", &sddmbackend);

    AboutSystemBackend aboutsystembackend;
    qmlRegisterSingletonInstance<AboutSystemBackend>("org.kde.novasettings", 1, 0, "AboutSystemBackend", &aboutsystembackend);

    MiscBackend miscbackend;
    qmlRegisterSingletonInstance<MiscBackend>("org.kde.novasettings", 1, 0, "MiscBackend", &miscbackend);

    MouseBackend mousebackend;
    qmlRegisterSingletonInstance<MouseBackend>("org.kde.novasettings", 1, 0, "MouseBackend", &mousebackend);

    VirtualDesktopsBackend virtualdesktopsbackend;
    qmlRegisterSingletonInstance<VirtualDesktopsBackend>("org.kde.novasettings", 1, 0, "VirtualDesktopsBackend", &virtualdesktopsbackend);

    PowerBackend powerbackend;
    qmlRegisterSingletonInstance<PowerBackend>("org.kde.novasettings", 1, 0, "PowerBackend", &powerbackend);

    UsersBackend usersbackend;
    qmlRegisterSingletonInstance<UsersBackend>("org.kde.novasettings", 1, 0, "UsersBackend", &usersbackend);

    DesktopEffectsBackend desktopeffectsbackend;
    qmlRegisterSingletonInstance<DesktopEffectsBackend>("org.kde.novasettings", 1, 0, "DesktopEffectsBackend", &desktopeffectsbackend);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
