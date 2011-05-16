# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Activity manager"
KEYWORDS=""
IUSE="debug semantic-desktop"

DEPEND="$(add_kdebase_dep kdelibs 'semantic-desktop=')"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		# $(cmake-utils_use_with zeitgeist QtZeitgeist)
		-DWITH_QtZeitgeist=NO
	)
	kde4-meta_src_configure
}
