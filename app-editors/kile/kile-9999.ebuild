# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/office"
inherit kde4-base

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug +pdf +png"

RDEPEND="
	|| (
		>=kde-base/okular-${KDE_MINIMAL}[pdf?,ps]
		app-text/acroread
	)
	virtual/latex-base
	virtual/tex-base
	pdf? (
		app-text/dvipdfmx
		app-text/ghostscript-gpl
	)
	png? (
		app-text/dvipng
		media-gfx/imagemagick[png]
	)
"

src_install() {
	kde4-base_src_install

	# TODO: come back later and see if there still is a collision
	rm -f "${D}/${KDEDIR}"/share/{apps/katepart/syntax/{bibtex,latex}.xml,icons/hicolor/{64x64,22x22}/actions/{preview,output_win}.png}
}
