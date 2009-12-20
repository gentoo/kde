# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
WEBKIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine"
KEYWORDS=""
IUSE="akonadi kdevplatform +phonon qscintilla qwt semantic-desktop"
# okular

COMMON_DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	>=kde-base/qimageblitz-0.0.4
	akonadi? ( $(add_kdebase_dep kdepimlibs) )
	kdevplatform? ( dev-util/kdevplatform:4 )
	phonon? ( >=media-sound/phonon-4.3.80[xcb] )
	qscintilla? ( x11-libs/qscintilla[qt4] )
	qwt? ( x11-libs/qwt:5 )
"
# okular? ( kde-base/okular)  -- it can't find it anyway

DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

KMEXTRACTONLY="kalyptus/"

PATCHES=( "${FILESDIR}"/${PN}-phonon-fix.patch )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable akonadi)
		$(cmake-utils_use_enable akonadi Kdepimlibs)
		$(cmake-utils_use_enable kdevplatform KDEVPLATFORM_SMOKE)
		# $(cmake-utils_use_enable okular)
		-DENABLE_Okular=OFF
		$(cmake-utils_use_enable phonon PHONON_SMOKE)
		$(cmake-utils_use_enable qscintilla QSCI_SMOKE)
		$(cmake-utils_use_enable qwt QWT_SMOKE)
		$(cmake-utils_use_enable semantic-desktop Nepomuk)
		$(cmake-utils_use_enable semantic-desktop Soprano)
		$(cmake-utils_use_enable webkit QTWEBKIT_SMOKE)
	)
	kde4-meta_src_configure
}
