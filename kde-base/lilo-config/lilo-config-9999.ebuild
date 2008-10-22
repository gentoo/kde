# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdeadmin
inherit kde4svn-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND="sys-boot/lilo"
DEPEND="${RDEPEND}
	kde-base/kdepimlibs:${SLOT}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_lilo-config=TRUE -DLILO_EXECUTABLE=TRUE"

	kde4overlay-meta_src_compile
}
