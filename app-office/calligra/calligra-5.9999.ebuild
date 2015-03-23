# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/calligra/calligra-9999.ebuild,v 1.51 2015/01/28 22:40:16 johu Exp $

# note: files that need to be checked for dependencies etc:
# CMakeLists.txt, kexi/CMakeLists.txt kexi/migration/CMakeLists.txt
# krita/CMakeLists.txt

EAPI=5

CHECKREQS_DISK_BUILD="4G"
EGIT_BRANCH="frameworks"
inherit check-reqs kde5

DESCRIPTION="KDE Office Suite"
HOMEPAGE="http://www.calligra.org/"

case ${PV} in
	2.[456789].[789]?)
		# beta or rc releases
		SRC_URI="mirror://kde/unstable/${P}/${P}.tar.xz" ;;
	2.[456789].?)
		# stable releases
		SRC_URI="mirror://kde/stable/${P}/${P}.tar.xz" ;;
	2.[456789].9999)
		# stable branch live ebuild
		SRC_URI="" ;;
	9999)
		# master branch live ebuild
		SRC_URI="" ;;
esac

LICENSE="GPL-2"
KEYWORDS=""

CAL_FTS=( author braindump converter flow gemini karbon kexi krita plan sheets stage words )

IUSE="colorio crypt dbus diagrams eigen exif fontconfig gsl iconv icu
import-filter jpeg2k kdepim lcms openexr opengl okular phonon pdf qtquick raw
spacenav sql truetype vc webkit
${CAL_FTS[@]/#/calligra_features_}"

cfeat() {
	echo calligra_features_$1
}

REQUIRED_USE="
	$(cfeat gemini)? ( qtquick )
	$(cfeat krita)? (
		eigen
		exif
		lcms
	)
	$(cfeat kexi)? ( $(cfeat sheets) )
	$(cfeat plan)? ( diagrams )
	$(cfeat sheets)? ( eigen )
	$(cfeat stage)? (
		phonon
		webkit
	)
	colorio? ( $(cfeat krita) )
	okular? ( $(cfeat stage) )
	qtquick? ( $(cfeat stage) )
"

COMMON_DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep sonnet)
	dev-libs/boost
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtquick1:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/libpng:0
	sys-libs/zlib
	colorio? ( media-libs/opencolorio )
	crypt? ( >=app-crypt/qca-2.1.0:2[qt5] )
	dbus? ( dev-qt/qtdbus:5 )
	diagrams? ( $(add_kdeapps_dep kdiagram) )
	exif? ( >=media-gfx/exiv2-0.16:= )
	fontconfig? ( media-libs/fontconfig )
	gsl? ( sci-libs/gsl )
	import-filter? (
		app-text/libetonyek
		app-text/libodfgen
		app-text/libwpd:0.10
		app-text/libwpg:0.3
		app-text/libwps
		dev-libs/librevenge
		media-libs/libvisio
	)
	jpeg2k? ( media-libs/openjpeg:0 )
	lcms? ( >=media-libs/lcms-2.4:2 )
	openexr? ( media-libs/openexr )
	opengl? ( virtual/opengl )
	okular? ( $(add_kdeapps_dep okular) )
	pdf? ( >=app-text/poppler-0.28:=[qt5] )
	phonon? ( media-libs/phonon[qt5] )
	raw? ( $(add_kdeapps_dep libkdcraw) )
	spacenav? ( dev-libs/libspnav )
	sql? ( dev-qt/qtsql:5 )
	truetype? ( media-libs/freetype:2 )
	webkit? ( dev-qt/qtwebkit:5 )
"
RDEPEND="
	${COMMON_DEPEND}
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	dev-qt/qtnetwork:5
	dev-qt/qtconcurrent:5
	dev-qt/qtx11extras:5
	media-libs/glew
	media-libs/glu
	media-libs/ilmbase
	media-libs/libjpeg-turbo
	media-libs/tiff
	sci-libs/fftw
	x11-libs/libX11
	x11-libs/libXi
"
# declarative and kactivities are optional though
DEPEND="
	${COMMON_DEPEND}
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kemoticons)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kross)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep threadweaver)
	dev-lang/perl
	dev-libs/libical
	>=x11-misc/shared-mime-info-0.18
	eigen? ( dev-cpp/eigen:3 )
	iconv? ( virtual/libiconv )
	icu? ( dev-libs/icu:= )
	kdepim? (
		$(add_kdeapps_dep kcalcore)
		$(add_kdeapps_dep kcontacts)
		$(add_kdeapps_dep kdepimlibs)
	)
	vc? ( dev-libs/vc )
"

#[[ ${PV} == 9999 ]] && LANGVERSION="2.4" || LANGVERSION="$(get_version_component_range 1-2)"
#PDEPEND=">=app-office/calligra-l10n-${LANGVERSION}"

RESTRICT=test
# bug 394273

pkg_pretend() {
	kde5_pkg_pretend
	check-reqs_pkg_pretend
}

pkg_setup() {
	kde5_pkg_setup
	check-reqs_pkg_setup
}

__cmake_remove_optional_module() {
	sed -i -e "s/\(find_package($1 [0-9\.]* COMPONENTS .*\)\($2\)\([ )].*)\)/\1\3/g" CMakeLists.txt || die "couldn't remove $2 from find_package($1)"
}

src_prepare() {
	# remove webkit from optional components
	use dbus || __cmake_remove_optional_module Qt5 DBus
	if ! use webkit; then
		__cmake_remove_optional_module Qt5 WebKit
		__cmake_remove_optional_module Qt5 WebKitWidgets
	fi
	if ! use sql; then
		__cmake_remove_optional_module Qt5 Sql
	fi
	kde5_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DPACKAGERS_BUILD=off
		$(cmake-utils_use_find_package colorio OCIO)
		$(cmake-utils_use_find_package crypt Qca-qt5)
		$(cmake-utils_use_find_package diagrams KGantt)
		-DCMAKE_DISABLE_FIND_PACKAGE_KChart=ON
#		$(cmake-utils_use_find_package diagrams KChart)
		$(cmake-utils_use_find_package eigen Eigen3)
		$(cmake-utils_use_find_package exif Exiv2)
		$(cmake-utils_use_find_package fontconfig)
		$(cmake-utils_use_find_package gsl)
		$(cmake-utils_use_find_package iconv)
		$(cmake-utils_use_find_package icu)
		$(cmake-utils_use_find_package import-filter LibEtonyek)
		$(cmake-utils_use_find_package import-filter LibOdfGen)
		$(cmake-utils_use_find_package import-filter LibRevenge)
		$(cmake-utils_use_find_package import-filter LibVisio)
		$(cmake-utils_use_find_package import-filter LibWpd)
		$(cmake-utils_use_find_package import-filter LibWpg)
		$(cmake-utils_use_find_package import-filter LibWps)
		$(cmake-utils_use_find_package jpeg2k OpenJPEG)
		$(cmake-utils_use_find_package kdepim KF5Akonadi)
		$(cmake-utils_use_find_package kdepim KF5AkonadiContact)
		$(cmake-utils_use_find_package kdepim KF5CalendarCore)
		$(cmake-utils_use_find_package kdepim KF5Contacts)
		$(cmake-utils_use_find_package lcms LCMS2)
		$(cmake-utils_use_find_package openexr OpenEXR)
		$(cmake-utils_use_find_package opengl OpenGL)
		$(cmake-utils_use_find_package okular)
		$(cmake-utils_use_find_package pdf Poppler)
		$(cmake-utils_use_find_package phonon Phonon4Qt5)
		$(cmake-utils_use_find_package raw KF5KDcraw)
		$(cmake-utils_use_find_package spacenav Spnav)
		$(cmake-utils_use_find_package truetype Freetype)
		$(cmake-utils_use_find_package vc Vc)
	)

	# applications
	for cal_ft in ${CAL_FTS}; do
		mycmakeargs+=( $(cmake-utils_use_build $(cfeat ${cal_ft}) ${cal_ft}) )
	done

	kde5_src_configure
}
