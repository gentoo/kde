# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
KMNAME="kdegraphics-thumbnailers"
inherit kde4-base

DESCRIPTION="KDE 4 thumbnail generators for PDF/PS files"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdcraw)
	$(add_kdebase_dep libkexiv2)
"
RDEPEND="${DEPEND}"

add_blocker kdegraphics-strigi-analyzer '<4.2.91'

src_install() {
	kde4-meta_src_install

	# why, oh why?!
	rm "${D}/usr/share/apps/cmake/modules/FindKSane.cmake" || die
}
