# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for CDDB"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug musicbrainz"

# tests require network access and compare static data with online data
# bug 280996
RESTRICT=test

DEPEND="
	musicbrainz? ( media-libs/musicbrainz:3 )
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with musicbrainz MusicBrainz3)
	)

	kde4-meta_src_configure
}
