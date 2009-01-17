# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit cmake-utils

DESCRIPTION="PoDoFo is a C++ library to work with the PDF file format."
HOMEPAGE="http://sourceforge.net/projects/podofo/"
SRC_URI="mirror://sourceforge/podofo/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost debug test"

DEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	boost? ( dev-util/boost-build )
	test? ( dev-util/cppunit )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		-DPODOFO_BUILD_SHARED=1
		-DPODOFO_HAVE_JPEG_LIB=1
		-DPODOFO_HAVE_TIFF_LIB=1
		-DWANT_FONTCONFIG=1
		$(cmake-utils_use_want boost BOOST)
		$(cmake-utils_has test CPPUNIT)"

	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog NEWS TODO || die "dodoc failed"
}
