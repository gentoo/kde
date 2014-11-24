# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-meta-pkg

DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
KEYWORDS=""
IUSE="ppp"

RDEPEND="
	$(add_kdebase_dep kdenetwork-filesharing)
	$(add_kdebase_dep kget)
	$(add_kdebase_dep kopete)
	$(add_kdebase_dep krdc)
	$(add_kdebase_dep krfb)
	$(add_kdebase_dep zeroconf-ioslave)
	ppp? ( $(add_kdebase_dep kppp) )
"
