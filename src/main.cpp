// INCLUDE (BASIC SET)

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCommandLineParser>
#include <QFileInfo>
#include <QIcon>

#include <KAboutData>
#include <KLocalizedString>

// INCLUDE

#include <MauiKit4/Core/mauiapp.h>
#include <MauiKit4/FileBrowsing/fmstatic.h>
#include <MauiKit4/FileBrowsing/moduleinfo.h>
#include <MauiMan4/thememanager.h>
#include <MauiMan4/accessibilitymanager.h>
#include <MauiMan4/formfactormanager.h>
#include <MauiMan4/screenmanager.h>
#include <MauiMan4/inputdevicesmanager.h>

#include "code/dbusconnection.h"
#include "code/keyboardglobal.h"
#include "code/about.h"

#include "../novasettings_version.h"

#define NOVASETTINGS_URI "org.kde.novasettings"

// MAIN FUNCTION

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    // APP

#ifdef Q_OS_ANDROID
    QGuiApplication app(argc, argv);
    if (!MAUIAndroid::checkRunTimePermissions({"android.permission.WRITE_EXTERNAL_STORAGE"}))
        return -1;
#else
    QGuiApplication app(argc, argv);
#endif

    app.setOrganizationName("KDE");
    app.setWindowIcon(QIcon(":/assets/logo.svg"));
    QGuiApplication::setDesktopFileName(QStringLiteral("project"));
    KLocalizedString::setApplicationDomain("novasettings");

    // SETS THE VALUE OF THE ENVIRONMENT VARIABLES

    // To make requests to a REST API (RadioBrowser) XMLHttpRequest is used.
    // Set QML_XHR_ALLOW_FILE_READ to 1 to access local files (read).

    qputenv("QML_XHR_ALLOW_FILE_READ", "1");

    // SETS THE LOCALE

    // Qt sets the locale in the QGuiApplication constructor, but libmpv
    // requires the LC_NUMERIC category to be set to "C", so change it back.

    std::setlocale(LC_NUMERIC, "C");

    // ABOUT DIALOG

    KAboutData about(QStringLiteral("novasettings"),
                     QStringLiteral("novasettings"),
                     NOVASETTINGS_VERSION_STRING,
                     i18n("Browse and play your online radio stations."),
                     KAboutLicense::LGPL_V3,
                     APP_COPYRIGHT_NOTICE,
                     QString(GIT_BRANCH) + "/" + QString(GIT_COMMIT_HASH));

    about.addAuthor(QStringLiteral("Miguel Beltrán"), i18n("Developer"), QStringLiteral("novaflowos@gmail.com"));
    about.setHomepage("https://www.novaflowos.com");
    about.setProductName("novasettings");
    about.setBugAddress("https://github.com/Neshama1/novasettings/issues");
    about.setOrganizationDomain(NOVASETTINGS_URI);
    about.setProgramLogo(app.windowIcon());

    const auto FBData = MauiKitFileBrowsing::aboutData();
    about.addComponent(FBData.name(), MauiKitFileBrowsing::buildVersion(), FBData.version(), FBData.webAddress());

    KAboutData::setApplicationData(about);
    MauiApp::instance()->setIconName("qrc:/assets/logo.svg");

    // COMMAND LINE

    QCommandLineParser parser;

    about.setupCommandLine(&parser);
    parser.process(app);
    about.processCommandLine(&parser);

    const QStringList args = parser.positionalArguments();
    QPair<QString, QList<QUrl>> arguments;

    // arguments.first
    // args.isEmpty()

    // QQMLAPPLICATIONENGINE

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/org/kde/novasettings/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url, &arguments](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    // C++ BACKENDS

    AboutSystemBackend aboutsystembackend;
    qmlRegisterSingletonInstance<AboutSystemBackend>("org.kde.novasettings", 1, 0, "AboutSystemBackend", &aboutsystembackend);

    // TIPOS

    qmlRegisterType<MauiMan::ThemeManager>("org.kde.novasettings", 1, 0, "ThemeManager");
    qmlRegisterType<MauiMan::AccessibilityManager>("org.kde.novasettings", 1, 0, "AccessibilityManager");
    qmlRegisterType<MauiMan::FormFactorManager>("org.kde.novasettings", 1, 0, "FormFactorManager");
    qmlRegisterType<MauiMan::ScreenManager>("org.kde.novasettings", 1, 0, "ScreenManager");
    qmlRegisterType<MauiMan::InputDevicesManager>("org.kde.novasettings", 1, 0, "InputDevicesManager");
    qmlRegisterType<KeyboardGlobal>("org.kde.novasettings", 1, 0, "KeyboardGlobal");
    qmlRegisterType<DBusConnection>("org.kde.novasettings", 1, 0, "DBusConnection");

    // LOAD MAIN.QML

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    //engine.loadFromModule("org.kde.novasettings", "Main");
    engine.load(url);

    // EXEC APP

    return app.exec();
}
