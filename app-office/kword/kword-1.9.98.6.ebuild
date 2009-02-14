# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KMNAME="koffice"
KMMODULE="${PN}"

inherit kde4-meta

DESCRIPTION="KOffice word processor."

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-text/libwpd
	app-text/wv2
"

KMEXTRA="filters/${KMMODULE}"
KMEXTRACTONLY="
	libs/
	filters/
	plugins/
	kspread/
"
KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_WV2=1 -DWITH_WPD=1"
	kde4-meta_src_configure
}
