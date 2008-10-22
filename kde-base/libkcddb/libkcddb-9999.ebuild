# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdemultimedia
inherit kde4svn-meta

DESCRIPTION="KDE library for CDDB"
KEYWORDS=""
IUSE="debug htmlhandbook musicbrainz"

# Tests are broken. Last checked at revision 796343.
RESTRICT="test"

DEPEND="${DEPEND}
	musicbrainz? ( media-libs/musicbrainz )"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable musicbrainz MusicBrainz)"
	kde4overlay-meta_src_compile
}
