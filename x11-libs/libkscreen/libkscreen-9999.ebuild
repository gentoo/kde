# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="Supporting library for new intelligent KDE screen management"
HOMEPAGE="https://projects.kde.org/projects/playground/libs/libkscreen"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	>=dev-libs/qjson-0.8
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXrandr
"
DEPEND="
	${RDEPEND}
	test? ( dev-qt/qttest:4 )
"
