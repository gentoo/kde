# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okular/okular-4.2.0-r1.ebuild,v 1.1 2009/02/19 12:17:09 scarabeus Exp $

EAPI="2"

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Okular is an universal document viewer based on KPDF for KDE 4."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="chm crypt debug +djvu +ebook htmlhandbook jpeg +ps +pdf +tiff"

DEPEND="
	media-libs/freetype
	chm? ( dev-libs/chmlib )
	crypt? ( app-crypt/qca:2 )
	djvu? ( app-text/djvu )
	ebook? ( app-text/ebook-tools )
	jpeg? ( media-libs/jpeg )
	ps? ( app-text/libspectre )
	pdf? ( >=app-text/poppler-0.8.5
		>=app-text/poppler-bindings-0.8.5[qt4] )
	tiff? ( media-libs/tiff )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with chm CHM)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with ebook EPub)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with ps LibSpectre)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff TIFF)"

	kde4-meta_src_configure
}
