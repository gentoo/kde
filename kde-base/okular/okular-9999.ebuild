# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Okular is an universal document viewer based on KPDF for KDE 4."
KEYWORDS=""
IUSE="chm crypt debug djvu ebook +handbook +jpeg +ps +pdf +tiff"

DEPEND="
	media-libs/freetype
	sys-libs/zlib
	chm? ( dev-libs/chmlib )
	crypt? ( app-crypt/qca:2 )
	djvu? ( app-text/djvu )
	ebook? ( app-text/ebook-tools )
	jpeg? ( media-libs/jpeg )
	pdf? ( >=virtual/poppler-qt4-0.8.5 )
	ps? ( app-text/libspectre )
	tiff? ( media-libs/tiff )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libs/mobipocket"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with chm)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with ebook EPub)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with ps LibSpectre)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff)"

	kde4-meta_src_configure
}
