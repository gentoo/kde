# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice word processor."

KEYWORDS=""
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
