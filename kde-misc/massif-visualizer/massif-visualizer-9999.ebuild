# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Tool visualising massif data"
HOMEPAGE="http://kde-apps.org/content/show.php/Massif+Visualizer?content=122409"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep kdiagram)
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"
DEPEND="${COMMON_DEPEND}
	dev-qt/qtxmlpatterns:5
	x11-misc/shared-mime-info
"
RDEPEND="${COMMON_DEPEND}"
