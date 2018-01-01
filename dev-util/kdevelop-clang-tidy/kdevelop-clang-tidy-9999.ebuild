# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDEBASE="kdevelop"
KDE_TEST="forceoptional"
KMNAME="kdev-clang-tidy"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KDevelop plugin for clang-tidy static analysis support"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	dev-util/kdevelop:5
"
DEPEND="${RDEPEND}
	$(add_frameworks_dep threadweaver)
"
