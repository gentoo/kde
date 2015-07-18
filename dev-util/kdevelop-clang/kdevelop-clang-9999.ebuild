# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-clang"
inherit kde5

DESCRIPTION="Clang plugin for KDevelop 5"
LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-util/kdevplatform:5
	>=sys-devel/llvm-3.4[clang]
"

RDEPEND="${DEPEND}
	dev-util/kdevelop:5[-cxx]
"

pkg_postinst() {
	ewarn "For first time after migration from kdevelop[cxx] to kdevelop-clang plugin,"
	ewarn "please run \"CLEAR_DUCHAIN_DIR=1 kdevelop -s\"."
}
