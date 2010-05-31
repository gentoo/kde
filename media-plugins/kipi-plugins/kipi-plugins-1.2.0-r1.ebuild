# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

OPENGL_REQUIRED="optional"
KDE_LINGUAS="ar be ca cs da de el en_GB es et fi fr ga gl hi hne is it ja km
lt lv ms nb nds nl nn oc pa pl pt pt_BR ro ru se sk sv th tr uk zh_CN zh_TW"
KMNAME="extragear/graphics"
inherit flag-o-matic kde4-base

DESCRIPTION="Plugins for the KDE Image Plugin Interface"
HOMEPAGE="http://www.kipi-plugins.org"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="cdr calendar crypt debug +imagemagick ipod mjpeg redeyes scanner"

DEPEND="
	>=dev-libs/expat-2.0.1
	>=dev-libs/libxml2-2.7
	>=dev-libs/libxslt-1.1
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2
	>=media-libs/tiff-3.6
	calendar? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	crypt? ( app-crypt/qca:2 )
	ipod? (
		>=media-libs/libgpod-0.7
		x11-libs/gtk+:2
	)
	redeyes? ( >=media-libs/opencv-1.0 )
	scanner? (
		>=kde-base/libksane-${KDE_MINIMAL}
		media-gfx/sane-backends
	)
"
RDEPEND="${DEPEND}
	cdr? ( app-cdr/k3b )
	imagemagick? ( >=media-gfx/imagemagick-5.5.4 )
	mjpeg? ( media-video/mjpegtools )
"

PATCHES=( "${FILESDIR}/${P}-jpeg.patch.bz2" )

src_configure() {
	# Remove flags -floop-block -floop-interchange
	# -floop-strip-mine due to bug #305443.
	filter-flags -floop-block
	filter-flags -floop-interchange
	filter-flags -floop-strip-mine

	mycmakeargs+=(
		$(cmake-utils_use_with ipod GLIB2)
		$(cmake-utils_use_with ipod GObject)
		$(cmake-utils_use_with ipod Gdk)
		$(cmake-utils_use_with ipod Gpod)
		$(cmake-utils_use_with calendar KdepimLibs)
		$(cmake-utils_use_with redeyes OpenCV)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with scanner Sane)
	)

	kde4-base_src_configure
}
