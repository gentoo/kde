# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

OPENGL_REQUIRED="optional"
#KDE_LINGUAS="ar be ca cs da de el es et fr ga gl hi is it ja km lv ms nb nds nl
#nn oc pa pl pt pt_BR ro ru se sk sv th tr uk zn_CN"
KMNAME="extragear/graphics"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="Plugins for the KDE Image Plugin Interface (libkipi)."
HOMEPAGE="http://www.kipi-plugins.org"
#SRC_URI="mirror://sourceforge/kipi/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="2"
IUSE="cdr calendar debug +imagemagick ipod mjpeg redeyes scanner"

DEPEND="
	>=dev-libs/expat-2.0.1
	dev-libs/libxml2
	dev-libs/libxslt
	>=kde-base/libkdcraw-${KDE_MINIMAL}
	>=kde-base/libkexiv2-${KDE_MINIMAL}
	>=kde-base/libkipi-${KDE_MINIMAL}
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/tiff-3.5
	calendar? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} )
	ipod? ( media-libs/libgpod )
	opengl? ( virtual/opengl )
	redeyes? ( media-libs/opencv )
	scanner? (
		media-gfx/sane-backends
		>=kde-base/libksane-${KDE_MINIMAL}
	)
"
RDEPEND="${DEPEND}
	cdr? ( app-cdr/k3b )
	imagemagick? ( media-gfx/imagemagick )
	mjpeg? ( media-video/mjpegtools )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	kde4-base_src_prepare

	# This Plugin hard depends on libksane, deactivate it if use flag scanner is
	# not set.
	if ! use scanner; then
		sed -i \
			-e '/acquireimages/ s:^:#DONOTCOMPILE :' \
			"${S}"/CMakeLists.txt || die "Sed deactivating scanner support failed."
	fi

	# Fix linking
	sed -i \
		-e '/KDE4_KDEUI_LIBS/ c\\${KDE4_KIO_LIBS}'\
		"${S}"/common/libkipiplugins/CMakeLists.txt \
		|| die "Sed fixing kipi linking failed."
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with calendar KdepimLibs)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with scanner KSane)
		$(cmake-utils_use_with scanner Sane)
		$(cmake-utils_use_with ipod Gpod)
		$(cmake-utils_use_with ipod GLIB2)
		$(cmake-utils_use_with ipod GObject)
		$(cmake-utils_use_with redeyes OpenCV)
	)

	kde4-base_src_configure
}
