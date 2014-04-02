# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework for intercepting and handling application crashes"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="X"

RDEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kwindowsystem)
	X? (
		dev-qt/qtx11extras:5
		x11-libs/libX11
	)
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtwidgets:5 )
	X? ( x11-proto/xproto )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde5_src_configure
}
