# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_DOC_DIRS="doc"
KDE_HANDBOOK="optional"
MY_P=${P/_beta/b}
inherit kde4-base

DESCRIPTION="A Latex Editor and TeX shell for KDE"
HOMEPAGE="http://kile.sourceforge.net/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="FDL-1.2 GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug +pdf +png"

DEPEND="
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdebase-data)
	$(add_kdebase_dep konsole)
	|| (
		$(add_kdebase_dep okular 'pdf?,postscript')
		app-text/acroread
	)
	virtual/latex-base
	virtual/tex-base
	pdf? (
		|| (
			app-text/dvipdfmx
			>=app-text/texlive-core-2014
		)
		app-text/ghostscript-gpl
	)
	png? (
		app-text/dvipng
		media-gfx/imagemagick[png]
	)
"

S=${WORKDIR}/${MY_P}

DOCS=( kile-remote-control.txt )

src_prepare() {
	kde4-base_src_prepare

	# I know upstream wants to help us but it doesn't work..
	sed -e '/INSTALL( FILES AUTHORS/s/^/#DISABLED /' \
		-i CMakeLists.txt || die
}
