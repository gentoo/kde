# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okular/okular-4.0.5.ebuild,v 1.1 2008/06/05 22:43:14 keytoaster Exp $

EAPI="2"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="Okular is a universal document viewer based on KPDF for KDE 4"
KEYWORDS="~amd64 ~x86"
IUSE="chm debug djvu htmlhandbook jpeg pdf tiff"

RDEPEND=">=app-text/libspectre-0.2
	media-libs/freetype
	kde-base/qimageblitz
	chm? ( dev-libs/chmlib )
	djvu? ( >=app-text/djvu-3.5.17 )
	jpeg? ( media-libs/jpeg )
	pdf? ( >=app-text/poppler-0.8.5
		>=app-text/poppler-bindings-0.8.5[qt4] )
	tiff? ( media-libs/tiff )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#PATCHES=("${FILESDIR}/${KMNAME}-4.0.2-system-libspectre.patch")

src_configure() {
	# remove internal copy of libspectre
#	rm -r "${S}"/okular/generators/spectre/libspectre || \
#		die "Failed to remove internal copy of libspectre."

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with chm CHM)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff TIFF)"

	kde4-meta_src_configure
}
