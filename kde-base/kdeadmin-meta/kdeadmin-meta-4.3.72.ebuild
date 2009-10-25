# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-functions

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.4"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="cups kdeprefix lilo"

RDEPEND="
	$(add_kdebase_dep kcron)
	$(add_kdebase_dep knetworkconf)
	$(add_kdebase_dep ksystemlog)
	$(add_kdebase_dep kuser)
	cups? ( $(add_kdebase_dep system-config-printer-kde) )
	lilo? ( $(add_kdebase_dep lilo-config) )
	$(block_other_slots)
"

## The following package was just added and has a questionable interest to Gentoo
#	>=kde-base/kpackage-${PV}:${SLOT}

## the following packages are currently missing in kde 4.1
#>=kde-base/kdeadmin-kfile-plugins-${PV}:${SLOT}
#>=kde-base/secpolicy-${PV}:${SLOT}

## These seem to be broken
#>=kde-base/kdat-${PV}:${SLOT}
#>=kde-base/ksysv-${PV}:${SLOT}
