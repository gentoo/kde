# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Svgpart is a kpart for viewing SVGs"
KEYWORDS=""
IUSE="debug"

src_install() {
	kde4-meta_src_install

	# why, oh why?!
	rm "${D}/usr/share/apps/cmake/modules/FindKSane.cmake" || die
}
