# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdemultimedia
inherit kde4-meta

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS="~amd64"
IUSE="debug htmlhandbook tunepimp"

DEPEND="
	>=media-libs/taglib-1.5
	tunepimp? ( media-libs/tunepimp )"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with tunepimp TunePimp)"
	kde4-meta_src_compile
}
