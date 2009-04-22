# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Desktop Publishing (DTP) and Layout program for Linux."
HOMEPAGE="http://www.scribus.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/.}.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cairo cups debug podofo python spell"

COMMONDEPEND="
	dev-libs/libxml2
	media-libs/fontconfig
	>=media-libs/freetype-2.3.7
	media-libs/jpeg
	media-libs/lcms
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-xmlpatterns:4
	cairo? ( x11-libs/cairo[X,svg] )
	cups? ( net-print/cups )
	podofo? ( app-text/podofo )
	spell? ( app-text/aspell )
"
DEPEND="${COMMONDEPEND}
	app-arch/lzma-utils
"
RDEPEND="${COMMONDEPEND}
	virtual/ghostscript
"

S="${WORKDIR}/${P/_/.}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DHAVE_CMS=ON
		-DHAVE_FONTCONFIG=ON
		-DHAVE_LIBZ=ON
		-DHAVE_TIFF=ON
		-DHAVE_XML=ON
		-DWANT_QTARTHUR=ON
		$(cmake-utils_use_has cups)
		$(cmake-utils_use_has podofo)
		$(cmake-utils_use_has python)
		$(cmake-utils_use_has spell ASPELL)
		$(cmake-utils_use_want cairo)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodoc AUTHORS ChangeLogSVN README || die "dodoc failed"

	newmenu "${S}/${PN}.desktop" "${PN}.desktop" || die "domenu failed"
	doicon "${S}/scribus/icons/scribus.png" || die "doicon failed"
}
