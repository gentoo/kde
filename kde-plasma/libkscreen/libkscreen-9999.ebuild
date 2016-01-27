# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="forceoptional"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Plasma screen management library"
KEYWORDS=""
IUSE="X"

DEPEND="
	$(add_plasma_dep kwayland)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtx11extras:5
	X? ( x11-libs/libxcb )
"
RDEPEND="${DEPEND}
	!x11-libs/libkscreen:5
"

# requires running session
RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X XCB)
	)

	kde5_src_configure
}
