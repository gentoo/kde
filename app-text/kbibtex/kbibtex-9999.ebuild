# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_GCC_MINIMAL="4.9"
KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="BibTeX editor to edit bibliographies used with LaTeX"
HOMEPAGE="http://home.gna.org/kbibtex/"
if [[ ${PV} != *9999* ]]; then
	inherit versionator
	SRC_URI="http://download.gna.org/${PN}/$(get_version_component_range 1-2)/${P/_/-}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	app-text/poppler[qt5]
	dev-libs/icu:=
	dev-libs/libxml2
	dev-libs/libxslt
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	virtual/tex-base
"
RDEPEND="${DEPEND}
	dev-tex/bibtex2html
	!app-text/kbibtex:4
"

S=${WORKDIR}/${P/_/-}
