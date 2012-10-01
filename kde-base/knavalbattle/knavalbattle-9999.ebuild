# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit games-ggz kde4-base

DESCRIPTION="The KDE Battleship clone"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"

add_blocker kbattleship

src_prepare() {
	# cmake is doing this really weird
	sed -i \
		-e "s:register_ggz_module:#register_ggz_module:g" \
		src/CMakeLists.txt || die "ggz removal failed"

	kde4-base_src_prepare
}
