# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base
DESCRIPTION="Plasma Active artwork"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/active/4.0/src/${P}.tar.xz"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="phone"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=()
	if use phone; then
		mycmakeargs+="-DSCREEN_RESOLUTION=800x480"
	else
		mycmakeargs+="-DSCREEN_RESOLUTION=1366x768"
	fi
	kde4-base_src_configure
}
