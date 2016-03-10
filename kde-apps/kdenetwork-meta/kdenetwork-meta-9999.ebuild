# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde5-meta-pkg

DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
KEYWORDS=""
IUSE="ppp +qt4 +telepathy"

RDEPEND="
	$(add_kdeapps_dep kdenetwork-filesharing)
	$(add_kdeapps_dep krdc)
	$(add_kdeapps_dep krfb)
	telepathy? ( $(add_kdeapps_dep plasma-telepathy-meta) )
	!telepathy? ( qt4? ( $(add_kdeapps_dep kopete) ) )
	qt4? (
		$(add_kdeapps_dep kget)
		$(add_kdeapps_dep zeroconf-ioslave)
		ppp? ( $(add_kdeapps_dep kppp) )
	)
"
