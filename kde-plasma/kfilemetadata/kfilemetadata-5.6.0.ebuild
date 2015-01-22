# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

# version scheme fail by upstream
if [[ ${KDE_BUILD_TYPE} = release ]]; then
	PLASMA_VERSION=5.2.0
	SRC_URI="mirror://kde/stable/plasma/${PLASMA_VERSION}/${PN}-${PV}.tar.xz"
fi
DESCRIPTION="Library for extracting file metadata"
KEYWORDS=" ~amd64"
IUSE="epub exif ffmpeg pdf taglib"

# TODO: mobi? ( $(add_kdeplasma_dep kdegraphics-mobipocket) ) NOTE: not integrated upstream
DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep ki18n)
	dev-qt/qtxml:5
	epub? ( app-text/ebook-tools )
	exif? ( media-gfx/exiv2:= )
	ffmpeg? ( virtual/ffmpeg )
	pdf? ( app-text/poppler[qt5] )
	taglib? ( media-libs/taglib )
"
RDEPEND="${DEPEND}
	!kde-base/kfilemetadata:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package epub EPub)
		$(cmake-utils_use_find_package exif Exiv2)
		$(cmake-utils_use_find_package ffmpeg FFmpeg)
		$(cmake-utils_use_find_package pdf PopplerQt5)
		$(cmake-utils_use_find_package taglib Taglib)
	)

	kde5_src_configure
}
