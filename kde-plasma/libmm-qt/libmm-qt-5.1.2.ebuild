# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Modemmanager bindings for Qt"
LICENSE="LGPL-2"
KEYWORDS=" ~amd64"
IUSE=""

DEPEND="
	dev-qt/qtdbus:5
	dev-qt/qtxml:5
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.9.8[modemmanager]
"
RDEPEND="${DEPEND}
	!net-libs/libmm-qt
"
