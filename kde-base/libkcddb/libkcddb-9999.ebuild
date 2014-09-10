# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="kf5"
inherit kde5

DESCRIPTION="KDE library for CDDB"
KEYWORDS=""
IUSE="musicbrainz"

# tests require network access and compare static data with online data
# bug 280996
RESTRICT=test

DEPEND="
	musicbrainz? ( media-libs/musicbrainz:5 )
"
RDEPEND="${DEPEND}
	!kde-base/libkcddb:4
"

src_prepare() {
	sed -e '/add_subdirectory( test )/ s/^#*/#/' \
		-i CMakeLists.txt || die

	kde5_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with musicbrainz MusicBrainz5)
	)

	kde5_src_configure
}
