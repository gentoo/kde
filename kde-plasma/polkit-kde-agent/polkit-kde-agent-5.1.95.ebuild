# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="${PN}-1"
EGIT_REPONAME="${MY_PN}"
inherit kde5

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/unstable/plasma/${PV}/${MY_PN}-${PV}.tar.xz"
fi
DESCRIPTION="PolKit agent module for KDE"
HOMEPAGE="http://www.kde.org"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="5"
IUSE=""

DEPEND="
	>=sys-auth/polkit-qt-0.112.0
"
RDEPEND="${DEPEND}
	!sys-auth/polkit-kde
"
