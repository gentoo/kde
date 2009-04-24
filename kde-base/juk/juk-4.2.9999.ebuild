# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-4.2.2.ebuild,v 1.2 2009/04/17 07:53:25 alexxy Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS=""
IUSE="debug doc musicbrainz"

DEPEND="
	>=media-libs/taglib-1.5
	musicbrainz? ( media-libs/tunepimp )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with musicbrainz TunePimp)"

	kde4-meta_src_configure
}
