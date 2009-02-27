# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice image manipulation program."

KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	app-text/libwpd
	app-text/wv2
	<media-gfx/exiv2-0.18
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kchart/
	interfaces/
	libs/
	filters/
	plugins/
"
KMEXTRA="
	filters/${KMMODULE}/
"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_WV2=1 -DWITH_WPD=1"

#	Unfortunately it won't build at all if you disable exiv2 support...
#	if ! use exif; then
#		mycmakeargs="${mycmakeargs}
#			-DWITH_Exiv2:BOOL=OFF"
#	fi

	kde4-meta_src_configure
}
