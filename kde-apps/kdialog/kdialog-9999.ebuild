# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KMNAME="kde-baseapps"
inherit kde5

DESCRIPTION="Can be used to show nice dialog boxes from shell scripts"
KEYWORDS=""
IUSE="X"

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	X? ( x11-libs/libX11 )
"
RDEPEND="${DEPEND}"

S="${S}/${PN}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)
	kde5_src_configure
}
