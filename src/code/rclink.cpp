#include "rclink.h"
#include <QDBusMessage>
#include <QDBusArgument>
#include <KConfigGui>

RcLink::RcLink(QObject *parent) : QObject(parent)
{
}

QVariant RcLink::getValue(const QString &file, const QStringList &groupPath, const QString &key, const QVariant &defaultValue)
{
	KConfigGroup group = getGroupFromPath(file, groupPath);
	return group.readEntry(key, defaultValue);
}

void RcLink::setValue(const QString &file, const QStringList &groupPath, const QString &key, const QVariant &value)
{
	KConfigGroup group = getGroupFromPath(file, groupPath);
	group.writeEntry(key, value);
	group.sync();
	KConfigGui::setSessionConfig(file, group.name());
}

KConfigGroup RcLink::getGroupFromPath(const QString &file, const QStringList &path)
{
	if (path.isEmpty()) {
		return KConfigGroup();
	}

	m_config = KSharedConfig::openConfig(file);

	KConfigGroup currentGroup(m_config, path.first());

	for ( int i = 1; i < path.size(); i++) {
		currentGroup = currentGroup.group(path.at(i));
	}

	return currentGroup;
}