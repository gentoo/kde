# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_SCM="svn"
inherit versionator kde4-base

DESCRIPTION="BibTeX editor for KDE to edit bibliographies used with LaTeX"
HOMEPAGE="http://home.gna.org/kbibtex/"
ESVN_REPO_URI="svn://svn.gna.org/svn/${PN}/branches/${PV/.9999/}"
ESVN_PROJECT="${PN}"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	app-text/poppler:=[qt4]
	dev-libs/libxml2
	dev-libs/libxslt
	virtual/tex-base
"
RDEPEND="${DEPEND}
	dev-tex/bibtex2html"

S=${WORKDIR}/${P/_/-}
