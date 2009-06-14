# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
WEBKIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Scripting Meta Object Kompiler Engine"
KEYWORDS="~amd64 ~x86"
IUSE="akonadi kdevplatform +phonon qscintella qwt +semantic-desktop"
# okular

COMMON_DEPEND="
	>=kde-base/qimageblitz-0.0.4
	akonadi? (
		app-office/akonadi-server
		>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	)
	kdevplatform? ( dev-util/kdevplatform:4 )
	phonon? ( >=media-sound/phonon-4.4_pre[xcb] )
	qscintella? ( x11-libs/qscintella[qt4] )
	qwt? ( x11-libs/qwt:5 )
	semantic-desktop? (
		dev-libs/soprano
		>=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=]
	)
"
# okular? ( kde-base/okular)  -- it can't find it anyway

DEPEND="${COMMON_DEPEND}
	dev-lang/perl
"
RDEPEND="${COMMON_DEPEND}"

KMEXTRACTONLY="kalyptus/"

PATCHES=( "${FILESDIR}"/${PN}-phonon-fix.patch )

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable webkit QTWEBKIT_SMOKE)
		$(cmake-utils_use_enable qwt QWT_SMOKE)
		$(cmake-utils_use_enable qscintella QSCI_SMOKE)
		$(cmake-utils_use_enable phonon PHONON_SMOKE)
		$(cmake-utils_use_enable kdevplatform KDEVPLATFORM_SMOKE)
		$(cmake-utils_use_enable semantic-desktop Nepomuk)
		$(cmake-utils_use_enable semantic-desktop Soprano)
		$(cmake-utils_use_enable akonadi Kdepimlibs)
		$(cmake-utils_use_enable akonadi)
		-DENABLE_Okular=OFF
	"
		# $(cmake-utils_use_enable okular Okular)
	kde4-meta_src_configure
}
