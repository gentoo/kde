# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kword/kword-2.2.2.ebuild,v 1.4 2010/11/04 13:44:28 hwoarang Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice word processor."

KEYWORDS="~amd64 ~x86"
IUSE="wpd"

DEPEND="
	wpd? ( app-text/libwpd )
"
RDEPEND="${DEPEND}
	!app-text/wv2
"

KMEXTRA="filters/${KMMODULE}/
	filters/libmso/
"

KMEXTRACTONLY="
	KoConfig.h.cmake
	filters/
	kspread/
	libs/
	plugins/
"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with wpd)
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
