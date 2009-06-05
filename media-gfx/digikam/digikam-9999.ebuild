# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/graphics"
inherit kde4-base

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0.10"
IUSE="addressbook debug geolocation +gphoto2"

DEPEND="
	dev-db/sqlite:3
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}
	>=media-libs/jasper-1.701.0
	media-libs/jpeg
	>=media-libs/lcms-1.17
	>=media-libs/libpng-1.2.26-r1
	>=media-libs/tiff-3.8.2-r3
	sys-devel/gettext
	x11-libs/qt-core[qt3support]
	x11-libs/qt-sql[sqlite]
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	geolocation? ( >=kde-base/marble-${KDE_MINIMAL} )
	gphoto2? ( >=media-libs/libgphoto2-2.4.1-r1 )
"
#liblensfun when added should be also optional dep.
RDEPEND="${DEPEND}
	!kdeprefix? ( !media-gfx/digikam:0 )
"

src_prepare() {
	# Fix files collision, use icon from kdebase-data rather that digikam ones
	sed -i \
		-e "s:add_subdirectory:#add_subdirectory:g" \
		data/icons/CMakeLists.txt || die "Failed to remove icon install"

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable gphoto2 GPHOTO2)
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_with geolocation MarbleWidget)"
	# $(cmake-utils_use_with lens LensFun)

	kde4-base_src_configure
}
