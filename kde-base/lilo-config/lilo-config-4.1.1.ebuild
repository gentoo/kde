# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

KMNAME=kdeadmin
inherit kde4-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="sys-boot/lilo"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_lilo-config=TRUE -DLILO_EXECUTABLE=TRUE"

	kde4-meta_src_compile
}
