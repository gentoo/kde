# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Special Dates plugin for Kontact: displays a summary of important holidays and calendar events"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'akonadi')
	$(add_kdebase_dep korganizer)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kontact)
"

KMEXTRACTONLY="
	korganizer
"
KMEXTRA="
	kontact/plugins/specialdates/
"
