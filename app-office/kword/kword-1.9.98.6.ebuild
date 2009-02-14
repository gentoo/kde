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

KMEXTRACTONLY="
	libs/
	filters/
	plugins/
	kspread/
"
KMEXTRA="filters/${KMMODULE}"
KMLOADLIBS="koffice-libs"

src_prepare() {
	kde4-meta_src_prepare

	# fix filters
	sed -i \
		-e "/add_subdirectory(filters)/s/^#DONOTCOMPILE //" \
		${S}/CMakeLists.txt || die "fixing filters failed"
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_WV2=1 -DWITH_WPD=1"
	kde4-meta_src_configure
}
