# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcddb/libkcddb-4.2.1.ebuild,v 1.2 2009/03/08 14:11:47 scarabeus Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for CDDB"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug musicbrainz"

DEPEND="
	musicbrainz? ( media-libs/musicbrainz:1 )
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with musicbrainz MusicBrainz)"

	kde4-meta_src_configure
}
