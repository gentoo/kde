# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN="true"
KDE_HANDBOOK="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Free digital painting application. Digital Painting, Creative Freedom!"
HOMEPAGE="https://www.kde.org/applications/graphics/krita/ https://krita.org/"
KEYWORDS=""
IUSE="color-management fftw +gsl +jpeg jpeg2k openexr pdf +raw tiff vc"

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtx11extras)
	$(add_qt_dep qtxml)
	dev-libs/boost
	media-gfx/exiv2:=
	media-libs/lcms
	media-libs/libpng:=
	net-misc/curl
	sys-libs/zlib
	virtual/opengl
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXi
	color-management? ( media-libs/opencolorio )
	fftw? ( sci-libs/fftw:3.0 )
	gsl? ( sci-libs/gsl )
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/openjpeg:0 )
	openexr? ( media-libs/openexr )
	pdf? ( app-text/poppler[qt5] )
	raw? ( media-libs/libraw:= )
	tiff? ( media-libs/tiff:0 )
	vc? ( <dev-libs/vc-0.7.5 )
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:3
	dev-lang/perl
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!app-office/calligra:4[calligra_features_krita]
"

src_configure() {
	local mycmakeargs=(
		-DWITH_OCIO=$(usex color-management)
		-DWITH_FFTW3=$(usex fftw)
		-DWITH_GSL=$(usex gsl)
		-DWITH_JPEG=$(usex jpeg)
		-DWITH_LibRaw=$(usex raw)
		-DWITH_OpenJPEG=$(usex jpeg2k)
		-DWITH_OpenEXR=$(usex openexr)
		-DWITH_Poppler=$(usex pdf)
		-DWITH_TIFF=$(usex tiff)
		-DWITH_Vc=$(usex vc)
	)

	kde5_src_configure
}
