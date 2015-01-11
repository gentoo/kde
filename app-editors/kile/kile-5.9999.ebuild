# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CMAKE_MIN_VERSION="3.0.2"
KDE_HANDBOOK=true
EGIT_BRANCH="frameworks"
MY_P=${P/_beta/b}
inherit kde5

DESCRIPTION="A Latex Editor and TeX shell for KDE"
HOMEPAGE="http://kile.sourceforge.net/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="FDL-1.2 GPL-2"
KEYWORDS=""
IUSE="debug +pdf +png"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep okular)
	dev-qt/qtdbus:5
	dev-qt/qtscript:5
	dev-qt/qttest:5
	dev-qt/qtwidgets:5
"

RDEPEND="${DEPEND}
	!app-editors/kile:4
	$(add_kdeapps_dep konsole)
	|| (
		$(add_kdeapps_dep okular 'pdf?')
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
	kde5_src_prepare

	# I know upstream wants to help us but it doesn't work..
	sed -e '/INSTALL( FILES AUTHORS/s/^/#DISABLED /' \
		-i CMakeLists.txt || die
}
