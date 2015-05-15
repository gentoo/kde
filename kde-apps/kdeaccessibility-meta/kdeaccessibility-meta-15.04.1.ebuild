# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5-meta-pkg

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND="
	$(add_kdebase_dep jovie)
	$(add_kdebase_dep kaccessible)
	$(add_kdebase_dep kmag)
	$(add_kdebase_dep kmousetool)
	$(add_kdebase_dep kmouth)
"
