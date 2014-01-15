# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework for managing menu and toolbar actions in an abstract way"
KEYWORDS="~amd64"
LICENSE="LGPL-2+"
IUSE="X"

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}
	dev-qt/qtx11extras:5
	X? ( x11-proto/xproto )
"

src_configure() {
	# libattica changes for KF5 not finalised yet
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_LibAttica=ON
		$(cmake-utils_use_find_package X X11)
	)

	kde-frameworks_src_configure
}
