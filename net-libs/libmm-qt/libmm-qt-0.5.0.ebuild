# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KEYWORDS="~amd64"
	SRC_URI="mirror://kde/unstable/modemmanager-qt/${PV}/src/${P}.tar.xz"
else
	KEYWORDS=""
fi

DESCRIPTION="Modemmanager bindings for Qt"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="4"
IUSE="debug"

RDEPEND="
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.9.0[modemmanager]
"
DEPEND="${RDEPEND}"
