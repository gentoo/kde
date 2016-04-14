# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDEBASE="kdevelop"
KMNAME="kdev-valgrind"
inherit kde5

DESCRIPTION="Plugin offering full integration of the valgrind suite to KDevelop"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	dev-util/kdevplatform:5
"
DEPEND="${COMMON_DEPEND}
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemmodels)
"
RDEPEND="${COMMON_DEPEND}
	dev-util/valgrind
	dev-util/kdevelop:5
"
