# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/office"
inherit kde4-base

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="debug"

DEPEND="dev-lang/perl"
RDEPEND="virtual/tex-base
	virtual/latex-base"

src_install() {

	kde4-base_src_install
	rm -rf "${D}"/"${KDEDIR}/share/apps/katepart/syntax/bibtex.xml"
	rm -rf "${D}"/"${KDEDIR}/share/apps/katepart/syntax/latex.xml"
	rm -rf "${D}"/"${KDEDIR}/share/icons/hicolor/64x64/actions/preview.png"
}
