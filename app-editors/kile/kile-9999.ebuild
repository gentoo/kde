# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="extragear/office"
NEED_KDE="svn"

inherit kde4svn-meta

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
PREFIX="${KDEDIR}"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="virtual/tex-base
	virtual/latex-base"

# Suggestions:
# app-text/acroread: Display pdf files
# app-text/dvipdfmx: Convert dvi files to pdf
# app-text/dvipng: Convert dvi files to png
# app-text/ghostscript-gpl: Display ps files
# dev-tex/latex2html: Compile latex files as html
# kde-base/okular: View document files
# media-gfx/imagemagick: ?
#PDEPEND="
#	app-text/acroread
#	app-text/dvipdfmx
#	app-text/dvipng
#	app-text/ghostscript-gpl
#	dev-tex/latex2html
#	kde-base/okular:${SLOT}
#	media-gfx/imagemagick"
