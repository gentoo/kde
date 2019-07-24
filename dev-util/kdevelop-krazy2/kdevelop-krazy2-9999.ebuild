# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_TEST="forceoptional"
KMNAME="kdev-krazy2"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Plugin for KDevelop to perform Krazy2 analysis"
HOMEPAGE="https://www.kdevelop.org/"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	dev-util/kdevelop:5=
"
DEPEND="${RDEPEND}
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep threadweaver)
"
