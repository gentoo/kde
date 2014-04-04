# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Next generation of the Nepomuk project"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kfilemetadata)
	dev-libs/qjson
	dev-libs/xapian
	sys-apps/attr
	!<kde-base/nepomuk-4.12.50
"
RDEPEND="${DEPEND}"

RESTRICT="test"
