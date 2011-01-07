# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="git://anongit.kde.org/massif-visualizer"
inherit git kde4-base

DESCRIPTION="LE"
HOMEPAGE="Fu"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphviz"

DEPEND="graphviz? ( media-gfx/kgraphviewer )"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with graphviz KGraphViewer)
	)
	kde4-base_src_configure
}
