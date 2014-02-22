# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Widget library for baloo"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep kfilemetadata)
"
RDEPEND="${DEPEND}"
