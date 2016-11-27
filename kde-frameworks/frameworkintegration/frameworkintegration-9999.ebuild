# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework for integrating Qt applications with KDE Plasma workspaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="X"

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kpackage)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	X? (
		$(add_qt_dep qtx11extras)
		x11-libs/libxcb
	)
"
DEPEND="${RDEPEND}"

# requires running kde environment
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X XCB)
		-DCMAKE_DISABLE_FIND_PACKAGE_AppStreamQt=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_packagekitqt5=ON
	)
	# appstream requires app-admin/packagekit-qt and
	# not yet packaged AppStreamQt 0.10

	kde5_src_configure
}
