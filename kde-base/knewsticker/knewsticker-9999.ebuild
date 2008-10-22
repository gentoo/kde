# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdenetwork
inherit kde4svn-meta

DESCRIPTION="Plasma widget: rss news ticker"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="kde-base/libplasma:${SLOT}"
RDEPEND="${DEPEND}"

KMLOADLIBS="libplasma"

src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_Plasma=ON"

	kde4overlay-meta_src_compile
}
