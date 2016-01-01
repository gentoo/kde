# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-cppcheck"
inherit kde5

DESCRIPTION="cppcheck support for kdevelop"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-util/kdevplatform:5
"
DEPEND="${COMMON_DEPEND}
	$(add_frameworks_dep kxmlgui)
"
RDEPEND="${COMMON_DEPEND}
	dev-util/cppcheck
	dev-util/kdevelop:5
"
