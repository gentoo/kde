# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework providing access to certain properties and features of the window manager"
LICENSE="LGPL-2+ MIT"
KEYWORDS="~amd64"
IUSE="X"

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	X? (
		dev-qt/qtx11extras:5
		x11-libs/libX11
		x11-libs/libXfixes
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
	)
"
DEPEND="${RDEPEND}
	X? ( x11-proto/xproto )
"

DOCS=( "docs/README.kstartupinfo" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde-frameworks_src_configure
}
