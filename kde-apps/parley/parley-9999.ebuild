# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="KDE Educational: vocabulary trainer"
HOMEPAGE="http://www.kde.org/applications/education/parley
http://edu.kde.org/applications/school/parley"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_kdeapps_dep libkeduvocdocument)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kross)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	dev-libs/libxml2:2
	dev-libs/libxslt
	dev-qt/qtdbus:5
	dev-qt/qtconcurrent:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kdeedu-data)
	!kde-base/parley:4
"
