# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="ModemManager bindings for Qt"
LICENSE="LGPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtxml:5
	net-misc/modemmanager
	!kde-plasma/libmm-qt
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"
