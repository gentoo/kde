# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.1"
KDE_LINGUAS="ar be bg ca cs da de el es et eu fa fi fr ga gl he hi is it ja km
ko lt lv lb nds ne nl nn pa pl pt pt_BR ro ru se sk sv th tr uk vi zh_CN zh_TW"

inherit kde4-base

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.bz2"

LICENSE="GPL-2"
RDEPEND="${DEPEND}"
SLOT="0.10"
IUSE="addressbook debug geolocation"

S="${WORKDIR}/${P/_/-}"

KEYWORDS="~amd64 ~x86"

# it have dynamic search for deps, so if they are in system it
# uses them otherwise does not, so any iuse are useless
DEPEND="
	!kdeprefix? ( !media-gfx/digikam:0 )
	dev-db/sqlite:3
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}
	>=media-libs/jasper-1.701.0
	media-libs/jpeg
	>=media-libs/lcms-1.17
	>=media-libs/libgphoto2-2.4.1-r1
	>=media-libs/libpng-1.2.26-r1
	>=media-libs/tiff-3.8.2-r3
	sys-devel/gettext
	x11-libs/qt-core[qt3support]
	x11-libs/qt-sql[sqlite]
	geolocation? (
		>=kde-base/marble-${KDE_MINIMAL}[kde]
	)
	addressbook? (
		>=kde-base/kdepimlibs-${KDE_MINIMAL}
	)
"
#liblensfun when added should be also optional dep.
RDEPEND="${DEPEND}"

src_prepare() {
	# fix files collision, use icon from kdebase-data rather that digikam ones
	sed -i \
		-e "s:add_subdirectory:#add_subdirectory:g" \
		data/icons/CMakeLists.txt || die "Failed to remove icon install"

	kde4-base_src_prepare
}

src_configure() {
	use addressbook || mycmakeargs="${mycmakeargs} -DWITH_KdepimLibs=OFF"
	use geolocation || mycmakeargs="${mycmakeargs} -DWITH_MarbleWidget=OFF"
	#use lens || mycmakeargs="${mycmakeargs} -DWITH_LensFun=OFF"

	kde4-base_src_configure
}
