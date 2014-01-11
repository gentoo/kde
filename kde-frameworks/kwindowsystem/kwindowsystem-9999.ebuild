# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework providing access to certain properties and features of the window manager"
LICENSE="LGPL-2+ MIT"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libxcb
	x11-libs/xcb-util-keysyms
"
DEPEND="${RDEPEND}"

DOCS=( "docs/README.kstartupinfo" )
