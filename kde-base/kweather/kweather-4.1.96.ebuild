# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdetoys"
inherit kde4-meta

DESCRIPTION="KDE weather status display"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/plasma-workspace-${PV}:${SLOT}"

src_configure() {
	mycmakeargs="${mycmakeargs}
				-DWITH_Plasma=ON"

	kde4-base_src_configure
}
