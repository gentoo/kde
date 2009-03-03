# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KOffice image manipulation program."

KEYWORDS="~amd64 ~x86"
IUSE="+gmm htmlhandbook +kdcraw +openexr +pdf +tiff"

DEPEND="
	>=app-office/koffice-libs-${PV}:${SLOT}[openexr=]
	dev-cpp/eigen:2
	>=kde-base/qimageblitz-0.0.4
	>=media-gfx/exiv2-0.16
	>=media-gfx/imagemagick-0.6.4.9.2[openexr=,png,tiff?]
	gmm? ( sci-mathematics/gmm )
	kdcraw? ( kde-base/kdcraw[kdeprefix=] )
	opengl? ( media-libs/glew )
	pdf? (
		>=app-text/poppler-0.10.0
		>=app-text/poppler-bindings-0.10.0[qt4]
	)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libs/"
KMEXTRA="filters/${KMMODULE}/"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_Eigen2=On
		-DWITH_Exiv2=On
		-DWITH_JPEG=On
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with gmm GMM)
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with kdcraw Kdcraw)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with opengl GLEW)"

	kde4-meta_src_configure
}
