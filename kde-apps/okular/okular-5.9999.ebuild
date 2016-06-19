# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
KDE_TEST="forceoptional"
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Universal document viewer based on KPDF"
HOMEPAGE="https://okular.kde.org https://www.kde.org/applications/graphics/okular"
KEYWORDS=""
IUSE="chm crypt djvu ebook +jpeg mobi +pdf +postscript +tiff"
# TODO:
# * Deactivated media-libs/qimageblitz as there is no Qt5 version yet
# * Deactivated kde-apps/kdegraphics-mobipocket, no Qt5 version yet
# * Not packaged: Qt5TextToSpeech

COMMON_DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcompletion)
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
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	media-libs/freetype
	media-libs/phonon[qt5]
	sys-libs/zlib
	chm? ( dev-libs/chmlib )
	crypt? ( app-crypt/qca:2[qt5] )
	djvu? ( app-text/djvu )
	ebook? ( app-text/ebook-tools )
	jpeg? (
		$(add_kdeapps_dep libkexiv2)
		virtual/jpeg:0
	)
	mobi? ( $(add_kdeapps_dep kdegraphics-mobipocket) )
	pdf? ( app-text/poppler[qt5,-exceptions(-)] )
	postscript? ( app-text/libspectre )
	tiff? ( media-libs/tiff:0 )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	kde5_src_prepare

	if ! use test ; then
		sed -i \
			-e "/^add_subdirectory.*conf\/autotests/ s/^/#DONT/" \
			CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package chm CHM)
		$(cmake-utils_use_find_package crypt Qca-qt5)
		$(cmake-utils_use_find_package djvu DjVuLibre)
		$(cmake-utils_use_find_package ebook EPub)
		$(cmake-utils_use_find_package jpeg KF5KExiv2)
		$(cmake-utils_use_find_package mobi QMobipocket)
		$(cmake-utils_use_find_package pdf Poppler)
		$(cmake-utils_use_find_package postscript LibSpectre)
		$(cmake-utils_use_find_package tiff TIFF)
	)

	kde5_src_configure
}
