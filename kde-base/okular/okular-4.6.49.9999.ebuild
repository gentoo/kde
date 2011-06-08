# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Okular is an universal document viewer based on KPDF for KDE 4."
KEYWORDS=""
IUSE="chm crypt debug djvu ebook +jpeg +ps +pdf +tiff"

DEPEND="
	media-libs/freetype
	sys-libs/zlib
	chm? ( dev-libs/chmlib )
	crypt? ( app-crypt/qca:2 )
	djvu? ( app-text/djvu )
	ebook? ( app-text/ebook-tools )
	jpeg? ( virtual/jpeg:0 )
	pdf? ( >=app-text/poppler-0.12.3-r3[lcms,qt4,-exceptions] )
	ps? ( app-text/libspectre )
	tiff? ( media-libs/tiff )
"
RDEPEND="${DEPEND}"

src_unpack() {
	kde4-base_src_unpack

	# HACK HACK HACK
	# The package assumes that ../okular == .
	ln -sf ${P} "${WORKDIR}/okular" || die "could not symlink the sources properly"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with chm)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_with ebook EPub)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with ps LibSpectre)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff)
	)

	kde4-base_src_configure
}

src_install() {
	kde4-meta_src_install

	# why, oh why?!
	rm "${ED}/usr/share/apps/cmake/modules/FindKSane.cmake" || die
}
