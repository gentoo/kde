# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KDE screen management library"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

# TODO: add X use flag, does not build at the moment

DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}
	!x11-libs/libkscreen:5
"
