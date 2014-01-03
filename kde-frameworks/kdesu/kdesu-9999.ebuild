# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TEST="false"
inherit kde-frameworks

DESCRIPTION="Framework to handle super user actions"
KEYWORDS=""
IUSE="X"

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kpty)
	$(add_frameworks_dep kservice)
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}
	X? ( dev-qt/qtx11extras:5 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package X X11)
	)

	kde-frameworks_src_configure
}
