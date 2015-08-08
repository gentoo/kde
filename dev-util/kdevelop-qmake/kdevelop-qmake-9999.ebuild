# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-qmake"
inherit kde5

DESCRIPTION="qmake plugin for KDevelop 5"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="tools"

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-util/kdevelop:5
	dev-util/kdevelop-pg-qt:5
"
RDEPEND="${DEPEND}
	!dev-util/kdevelop-qmake:4
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build tools qmake_parser)
	)
	kde5_src_configure
}

src_install() {
	kde5_src_install
	#Move this file to prevent a collision with kappwizard
	mv "${D}"/usr/share/kdevappwizard/templates/qmake_qt4guiapp.tar.bz2 \
		"${D}"/usr/share/kdevappwizard/templates/kdevelop-qmake_qt4guiapp.tar.bz2
}
