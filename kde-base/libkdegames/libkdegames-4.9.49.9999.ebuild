# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdegames"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS=""
IUSE="debug openal"

DEPEND="
	>=dev-games/ggz-client-libs-0.0.14
	openal? (
		media-libs/libsndfile
		media-libs/openal
	)
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use openal USE_OPENAL_SNDFILE)
	)

	kde4-base_src_configure
}
