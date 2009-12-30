# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: media-gfx/digikam/digikam-1.0.0.ebuild, 2009/12/22 Ronis_BR $

EAPI="2"

KDE_LINGUAS="ar be bg ca cs da de el es et eu fa fi fr ga gl he hi is it ja km
ko lt lv lb nds ne nl nn pa pl pt pt_BR ro ru se sk sl sv th tr uk vi zh_CN zh_TW"
KMNAME="extragear/graphics"
inherit kde4-base

MY_P="${PN}-${PV/_/-}"

DESCRIPTION="A digital photo management application for KDE."
HOMEPAGE="http://www.digikam.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="4"
IUSE="addressbook debug geolocation gphoto2 lensfun semantic-desktop +thumbnails"

RDEPEND="
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop?]
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	>=kde-base/solid-${KDE_MINIMAL}
	>=kde-base/kreadconfig-${KDE_MINIMAL}
	media-libs/jasper
	media-libs/jpeg
	media-libs/lcms
	>=media-libs/libpgf-6.09.44-r1
	media-libs/liblqr
	media-libs/libpng
	media-libs/tiff
	x11-libs/qt-gui[qt3support]
	x11-libs/qt-sql[sqlite]
	addressbook? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	geolocation? ( >=kde-base/marble-${KDE_MINIMAL} )
	gphoto2? ( >=media-libs/libgphoto2-2.4.1-r1 )
	lensfun? ( media-libs/lensfun )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Patch to unbundled libpgf.
	epatch "${FILESDIR}/libpgf-unbundled-r0.patch"

	kde4-base_src_prepare
}

src_configure() {
	local backend

	use semantic-desktop && backend="Nepomuk" || backend="None"
	# LQR = only allows to choose between bundled/external
	mycmakeargs="${mycmakeargs}
		-DWITH_LQR=ON
		-DENABLE_THEMEDESIGNER=OFF
		-DGWENVIEW_SEMANTICINFO_BACKEND=${backend}
		$(cmake-utils_use_enable gphoto2 GPHOTO2)
		$(cmake-utils_use_with gphoto2)
		$(cmake-utils_use_enable thumbnails THUMBS_DB)
		$(cmake-utils_use_with addressbook KdepimLibs)
		$(cmake-utils_use_with geolocation MarbleWidget)
		$(cmake-utils_use_with lensfun LensFun)
		$(cmake-utils_use_with semantic-desktop Soprano)"

	kde4-base_src_configure
}
