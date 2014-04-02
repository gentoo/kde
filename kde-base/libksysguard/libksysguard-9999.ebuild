# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Task management and system monitoring library"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="X"

COMMON_DEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kde4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwebkit:5[widgets]
	dev-qt/qtwidgets:5
	sys-libs/zlib
	X? (
		dev-qt/qtx11extras:5
		x11-libs/libX11
		x11-libs/libXres
	)
"
RDEPEND="${COMMON_DEPEND}
	!kde-base/ksysguard:4
"
DEPEND="${COMMON_DEPEND}
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep plasma)
	X? ( x11-proto/xproto )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde-frameworks_src_configure
}
