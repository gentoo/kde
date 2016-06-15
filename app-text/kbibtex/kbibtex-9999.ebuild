# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_GCC_MINIMAL="4.9"
KDE_HANDBOOK="optional"
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
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwebkit)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	app-text/poppler[qt5]
	dev-libs/icu:=
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/qoauth:5
	virtual/tex-base
"
RDEPEND="${DEPEND}
	!app-text/kbibtex:4
	dev-tex/bibtex2html
	x11-misc/shared-mime-info
"

S=${WORKDIR}/${P/_/-}

PATCHES=(
	"${FILESDIR}/${PN}-revert-removing-qtoauth.patch"
	"${FILESDIR}/${PN}-part-revert-reenable-qtoauth.patch"

	"${FILESDIR}/${PN}-doctools-optional.patch" # RR pending upstream
)

src_prepare() {
	kde5_src_prepare

	rm -r src/3rdparty/qoauth || die "Failed to remove bundled qoauth"
}
