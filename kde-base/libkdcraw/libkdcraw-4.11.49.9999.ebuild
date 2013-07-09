# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS=""
IUSE="debug jasper"

DEPEND="
	>=media-libs/libraw-0.15:=
	virtual/jpeg
	jasper? ( media-libs/jasper )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.10.90-extlibraw.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package jasper)
	)

	kde4-base_src_configure
}
