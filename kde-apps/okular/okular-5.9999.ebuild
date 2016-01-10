# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="forceoptional"
EGIT_BRANCH="frameworks"
FRAMEWORKS_MINIMAL="5.18.0"
inherit kde5

DESCRIPTION="Universal document viewer based on KPDF"
HOMEPAGE="https://okular.kde.org https://www.kde.org/applications/graphics/okular"
KEYWORDS=""
IUSE="chm crypt dpi djvu ebook +jpeg +pdf +postscript +tiff"
# TODO:
# * Deactivated dependency media-libs/qimageblitz as there is no Qt5 version
#   yet

DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjs)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-libs/freetype
	media-libs/phonon[qt5]
	sys-devel/gettext
	sys-libs/zlib
	chm? ( dev-libs/chmlib )
	crypt? ( app-crypt/qca:2[qt5] )
	djvu? ( app-text/djvu )
	dpi? ( $(add_plasma_dep libkscreen) )
	ebook? ( app-text/ebook-tools )
	jpeg? (
		$(add_kdeapps_dep libkexiv2)
		virtual/jpeg:0
	)
	pdf? ( app-text/poppler[qt5,-exceptions(-)] )
	postscript? ( app-text/libspectre )
	tiff? ( media-libs/tiff:0 )
"
RDEPEND="${DEPEND}
	!kde-base/okular:4
"
RESTRICT=test
# test 2: parttest hangs

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package chm CHM)
		$(cmake-utils_use_find_package crypt Qca-qt5)
		$(cmake-utils_use_find_package djvu DjVuLibre)
		$(cmake-utils_use_find_package dpi KF5Screen)
		$(cmake-utils_use_find_package ebook EPub)
		$(cmake-utils_use_find_package jpeg KF5KExiv2)
		$(cmake-utils_use_find_package pdf Poppler)
		$(cmake-utils_use_find_package postscript LibSpectre)
		$(cmake-utils_use_find_package tiff)
	)

	kde5_src_configure
}
