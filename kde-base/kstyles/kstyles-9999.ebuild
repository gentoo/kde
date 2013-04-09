# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE: A set of different KDE styles."
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep liboxygenstyle)
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/oxygen
"
