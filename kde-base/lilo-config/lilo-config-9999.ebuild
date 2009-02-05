# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeadmin"
inherit kde4-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND="sys-boot/lilo"
DEPEND="${RDEPEND}
	kde-base/kdepimlibs:${SLOT}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_lilo-config=TRUE -DLILO_EXECUTABLE=TRUE"
	kde4-meta_src_compile
}
