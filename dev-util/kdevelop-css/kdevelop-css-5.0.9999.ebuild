# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="5.0"
KDEBASE="kdevelop"
KMNAME="kdev-css"
inherit kde5

DESCRIPTION="CSS Language Support plugin for KDevelop 5"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtgui:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-util/kdevelop-pg-qt:5
	dev-util/kdevplatform:5
"
DEPEND="${COMMON_DEPEND}
	sys-devel/flex
"
RDEPEND="${COMMON_DEPEND}
	dev-util/kdevelop:5
"
