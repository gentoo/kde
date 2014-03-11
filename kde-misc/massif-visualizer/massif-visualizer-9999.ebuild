# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Tool visualising massif data."
HOMEPAGE="http://kde-apps.org/content/show.php/Massif+Visualizer?content=122409"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS=""
IUSE="graphviz"

DEPEND="graphviz? ( media-gfx/kgraphviewer )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with graphviz KGraphViewer)
	)
	kde4-base_src_configure
}
