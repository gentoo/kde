# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_BLOCK_SLOT4="false"
inherit kde5

DESCRIPTION="Library to support mobipocket ebooks"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+thumbnail"

DEPEND="
	$(add_qt_dep qtgui)
	thumbnail? ( $(add_frameworks_dep kio) )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_thumbnailers=$(usex thumbnail)
	)

	kde5_src_configure
}
