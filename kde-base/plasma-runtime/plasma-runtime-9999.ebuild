# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kde-runtime"
KMMODULE="plasma"
DECLARATIVE_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="Script engine and package tool for plasma"
KEYWORDS=""
IUSE="debug"

# file collisions, bug 394997
add_blocker plasma-workspace 4.4.50

DEPEND="
	$(add_kdebase_dep kactivities)
"
RDEPEND="${DEPEND}"
