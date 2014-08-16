# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
EGIT_BRANCH="frameworks"

inherit kde5

DESCRIPTION="Universal document viewer based on KPDF"
HOMEPAGE="http://okular.kde.org http://www.kde.org/applications/graphics/okular"
KEYWORDS=""
IUSE="chm crypt debug dpi djvu ebook +jpeg +pdf +tiff"
# TODO:
# * Temporarily deactivated +postscript USE as upstream has it deactivated.
#   postscript? ( app-text/libspectre )
# 	$(cmake-utils_use_with postscript LibSpectre)
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
	>=dev-qt/qtgui-5.3.1:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-libs/freetype
	media-libs/phonon[qt5]
	sys-devel/gettext
	sys-libs/zlib
	chm? ( dev-libs/chmlib )
	crypt? ( app-crypt/qca[qt5] )
	djvu? ( app-text/djvu )
	dpi? ( x11-libs/libkscreen )
	ebook? ( app-text/ebook-tools )
	jpeg? ( virtual/jpeg:0 )
	pdf? ( app-text/poppler[qt5,-exceptions(-)] )
	tiff? ( media-libs/tiff )
"
RDEPEND="${DEPEND}
	!kde-base/okular:4
"
RESTRICT=test
# test 2: parttest hangs

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with chm)
		$(cmake-utils_use_with crypt QCA2)
		$(cmake-utils_use_with djvu DjVuLibre)
		$(cmake-utils_use_find_package dpi KF5Screen)
		$(cmake-utils_use_with ebook EPub)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with jpeg Kexiv2)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with tiff)
	)

	kde5_src_configure
}
