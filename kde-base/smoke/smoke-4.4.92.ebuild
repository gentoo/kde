# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebindings"
MULTIMEDIA_REQUIRED="optional"
WEBKIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="akonadi attica debug kate okular +phonon qimageblitz qscintilla qwt semantic-desktop"

COMMON_DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	akonadi? ( $(add_kdebase_dep kdepimlibs) )
	attica? ( dev-libs/libattica )
	kate? ( $(add_kdebase_dep kate) )
	okular? ( $(add_kdebase_dep okular) )
	phonon? ( >=media-sound/phonon-4.3.80[xcb] )
	qimageblitz? ( >=media-libs/qimageblitz-0.0.4 )
	qscintilla? ( x11-libs/qscintilla )
	qwt? ( x11-libs/qwt:5 )
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

KMEXTRA="generator/"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_disable multimedia QtMultimedia)
		$(cmake-utils_use_with okular)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_with qimageblitz QImageBlitz)
		$(cmake-utils_use_with qscintilla QScintilla)
		$(cmake-utils_use_with qwt Qwt)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_disable webkit QtWebKit)
	)
	kde4-meta_src_configure
}
