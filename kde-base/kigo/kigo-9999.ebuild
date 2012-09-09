# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
inherit games-ggz kde4-base

DESCRIPTION="KDE Go game"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	games-board/gnugo
"

src_install() {
	kde4-meta_src_install
	# and also we have to prepare the ggz dir
	insinto "${GGZ_MODDIR}"
	newins src/module.dsc ${P}.dsc
}

pkg_postinst() {
	kde4-base_pkg_postinst
	games-ggz_pkg_postinst
}

pkg_postrm() {
	kde4-base_pkg_postrm
	games-ggz_pkg_postrm
}
