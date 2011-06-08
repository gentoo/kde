# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
if [[ ${PV} == *9999 ]]; then
	kde_eclass="kde4-base"
else
	KMNAME="kdegraphics"
	kde_eclass="kde4-meta"
fi
inherit ${kde_eclass}

DESCRIPTION="Paint Program for KDE"
KEYWORDS=""
LICENSE="BSD LGPL-2"
IUSE="debug"

src_install() {
	kde4-meta_src_install

	# why, oh why?!
	rm "${D}/usr/share/apps/cmake/modules/FindKSane.cmake" || die
}
