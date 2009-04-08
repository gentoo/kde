# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice word processor."

KEYWORDS="~amd64 ~x86"
IUSE="+wpd +wv2"

DEPEND="
	app-text/libwpd
	app-text/wv2
"
RDEPEND="${DEPEND}"

KMEXTRA="filters/${KMMODULE}/"

KMEXTRACTONLY="
	filters/
	kspread/
	libs/
	plugins/
"

KMLOADLIBS="koffice-libs"

PATCHES=( "${FILESDIR}/kword-1.9.98.7-int-cast-fix.patch" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with wpd WPD)
		$(cmake-utils_use_with wv2 WV2)"

	kde4-meta_src_configure
}
