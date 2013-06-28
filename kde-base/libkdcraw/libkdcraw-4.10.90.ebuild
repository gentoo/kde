# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug jasper lcms"

DEPEND="
	media-libs/lcms:0
	virtual/jpeg
	jasper? ( media-libs/jasper )
	lcms? ( media-libs/lcms:2 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_LCMS=ON
		$(cmake-utils_use_find_package jasper)
		$(cmake-utils_use_find_package lcms LCMS2)
	)

	kde4-base_src_configure
}
