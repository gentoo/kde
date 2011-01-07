# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/karbon/karbon-2.2.2.ebuild,v 1.4 2010/11/04 13:42:29 hwoarang Exp $

EAPI="2"
KMNAME="koffice"
KMMODULE="${PN}"

inherit kde4-meta

DESCRIPTION="KOffice vector drawing application."

KEYWORDS="~amd64 ~x86"
IUSE="+pstoedit wpg"

DEPEND="
	media-libs/libart_lgpl
	pstoedit? ( media-gfx/pstoedit )
	wpg? ( media-libs/libwpg )
"
RDEPEND="${DEPEND}"

KMEXTRA="filters/${KMMODULE}"
KMEXTRACTONLY="
	KoConfig.h.cmake
	libs/
	plugins/
	filters/
"
KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with wpg)
		$(cmake-utils_use_with pstoedit)
	)
	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
