# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOXYGEN="true"
KDE_HANDBOOK="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="A free digital painting application. Digital Painting, Creative Freedom!"
HOMEPAGE="https://www.kde.org/applications/graphics/krita/ https://krita.org/"
KEYWORDS=""
IUSE="color-management fftw +gsl +jpeg jpeg2k +mime openexr pdf png +raw tiff vc X"

COMMON_DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-cpp/eigen:3
	dev-lang/perl
	dev-libs/boost
	$(add_qt_dep designer)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtopengl)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtscript)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtx11extras)
	$(add_qt_dep qtxml)
	media-gfx/exiv2:=
	media-libs/lcms
	sys-libs/zlib
	virtual/opengl
	color-management? ( media-libs/opencolorio )
	fftw? ( sci-libs/fftw:3.0 )
	gsl? ( sci-libs/gsl )
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/openjpeg:0 )
	mime? ( x11-misc/shared-mime-info )
	openexr? ( media-libs/openexr )
	pdf? ( app-text/poppler[qt5] )
	png? ( media-libs/libpng:= )
	raw? ( $(add_kdeapps_dep libkdcraw) )
	tiff? ( media-libs/tiff:0 )
	vc? ( dev-libs/vc )
	X? (
		$(add_qt_dep qtx11extras)
		x11-libs/libX11
		x11-libs/libxcb
	)
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	x11-misc/shared-mime-info
"
RDEPEND="${COMMON_DEPEND}
	!app-office/calligra:4[calligra_features_krita]
"

src_configure() {
	local mycmakeargs=(
		-DUSEOPENGL=ON
		$(cmake-utils_use_with color-management OCIO)
		$(cmake-utils_use_with fftw FFTW3)
		$(cmake-utils_use_with gsl GSL)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with jpeg2k OpenJPEG)
		$(cmake-utils_use_with raw KF5KDcraw)
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with png PNG)
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with vc Vc)
	)

	kde5_src_configure
}
