# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdesdk"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="kioslaves from kdesdk package"
KEYWORDS=""
IUSE="debug subversion"

DEPEND="
	subversion? (
		dev-libs/apr
		dev-util/subversion
	)
"
RDEPEND="${DEPEND}
	!kdeprefix? (
		subversion? ( !dev-util/kdesvn:4 )
	)
"

src_configure() {
	mycmakeargs=(
		-DAPRCONFIG_EXECUTABLE="${EPREFIX}"/usr/bin/apr-1-config
		$(cmake-utils_use_with subversion SVN)
	)

	kde4-meta_src_configure
}
