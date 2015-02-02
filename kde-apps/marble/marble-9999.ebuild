# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Generic geographical map widget"
HOMEPAGE="http://marble.kde.org/"
KEYWORDS=""

IUSE="aprs designer-plugin gps +kde phonon shapefile zip"

# FIXME (new packages):
# libwlocate, WLAN-based geolocation
# qextserialport, interface to old fashioned serial ports
RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	gps? ( >=sci-geosciences/gpsd-2.95 )
	kde? (
		$(add_frameworks_dep kconfig)
		$(add_frameworks_dep kcoreaddons)
		$(add_frameworks_dep kdoctools)
		$(add_frameworks_dep ki18n)
		$(add_frameworks_dep kio)
		$(add_frameworks_dep knewstuff)
		$(add_frameworks_dep kparts)
		$(add_frameworks_dep krunner)
		$(add_frameworks_dep kservice)
		$(add_frameworks_dep kwallet)
	)
	phonon? ( media-libs/phonon[qt5] )
	shapefile? ( sci-libs/shapelib )
	zip? ( dev-libs/quazip[qt5] )
"
DEPEND="${RDEPEND}
	aprs? ( dev-lang/perl )
"

src_prepare() {
	use handbook || comment_add_subdirectory doc
	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test MARBLE_TESTS)
		$(cmake-utils_use_find_package aprs Perl)
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)
		$(cmake-utils_use_with gps libgps)
		$(cmake-utils_use_with kde KF5)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_with shapefile libshp)
		$(cmake-utils_use_with zip quazip)
		-DWITH_QextSerialPort=OFF
		-DWITH_liblocation=0
	)
	kde5_src_configure
}
