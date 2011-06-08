# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="Svgpart is a kpart for viewing SVGs"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

src_install() {
	kde4-meta_src_install

	# why, oh why?!
	rm "${ED}/usr/share/apps/cmake/modules/FindKSane.cmake" || die
}
