# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-4.14.3.ebuild,v 1.3 2015/02/14 14:35:02 ago Exp $

EAPI=5

inherit kde4-meta-pkg

DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
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
