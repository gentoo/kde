# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Nepomuk core libraries"
KEYWORDS=""
IUSE="debug exif ffmpeg pdf taglib"

DEPEND="
	>=dev-libs/shared-desktop-ontologies-0.11.0
	>=dev-libs/soprano-2.9.0[dbus,raptor,redland,virtuoso]
	exif? ( media-gfx/exiv2 )
	ffmpeg? ( virtual/ffmpeg )
	pdf? ( app-text/poppler[qt4] )
	taglib? ( media-libs/taglib )
"
RDEPEND="${DEPEND}"

add_blocker nepomuk '<4.8.80'

RESTRICT="test"
# bug 392989

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with exif Exiv2)
		$(cmake-utils_use_with ffmpeg FFmpeg)
		$(cmake-utils_use_with pdf PopplerQt4)
		$(cmake-utils_use_with taglib Taglib)
	)

	kde4-base_src_configure
}
