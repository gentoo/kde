# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils multilib

DESCRIPTION="PoDoFo is a C++ library to work with the PDF file format."
HOMEPAGE="http://sourceforge.net/projects/podofo/"
SRC_URI="mirror://sourceforge/podofo/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+boost debug test"

DEPEND="dev-lang/lua
	dev-libs/openssl
	>=dev-libs/STLport-5.1.5
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	boost? ( dev-util/boost-build )
	test? ( dev-util/cppunit )"
RDEPEND="${DEPEND}"

src_prepare() {
	# yay for stupidity
	# fix libs
	# fix soname
	ebegin "Fixing insane build system"
	sed -i \
		-e "s:\"lib\":\"$(get_libdir)\":g" \
		CMakeLists.txt || die "fix for insane lib detection failed"
	sed -i \
		-e "s:0.6.99:0.7.0:g" \
		src/CMakeLists.txt || die "fix soname failed"
	eend $?
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DPODOFO_BUILD_SHARED=1
		-DPODOFO_HAVE_JPEG_LIB=1
		-DPODOFO_HAVE_TIFF_LIB=1
		-DWANT_FONTCONFIG=1
		-DUSE_STLPORT=1
		$(cmake-utils_use_want boost BOOST)
		$(cmake-utils_use_has test CPPUNIT)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog NEWS TODO || die "dodoc failed"
}
