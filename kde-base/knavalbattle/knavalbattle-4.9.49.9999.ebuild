# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdegames"
fi
KDE_HANDBOOK="optional"
inherit games-ggz ${eclass}

DESCRIPTION="The KDE Battleship clone"
KEYWORDS=""
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"

add_blocker kbattleship

src_prepare() {
	# cmake is doing this really weird
	if [[ ${PV} == *9999 ]]; then
		sed -i \
			-e "s:register_ggz_module:#register_ggz_module:g" \
			src/CMakeLists.txt || die "ggz removal failed"
	else
		sed -i \
			-e "s:register_ggz_module:#register_ggz_module:g" \
			"${PN}"/src/CMakeLists.txt || die "ggz removal failed"
	fi

	${eclass}_src_prepare
}
