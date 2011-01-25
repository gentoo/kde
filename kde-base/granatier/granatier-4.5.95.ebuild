# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="KDE Bomberman game"
KEYWORDS="~amd64 ~x86"
IUSE="debug openal"

DEPEND="
	openal? (
		media-libs/libsndfile
		media-libs/openal
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with openal OpenAL)
		$(cmake-utils_use_with openal SndFile)
	)

	kde4-meta_src_configure
}
