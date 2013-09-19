# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier1"
VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Provides access to certain properties and features of the window manager"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtnetwork:5 )
"

DOCS=( "docs/README.kstartupinfo" )
