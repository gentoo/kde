# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# $Header:

EAPI="1"

inherit kde4overlay-functions

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-svn"
KEYWORDS=""
IUSE="lilo"

RDEPEND="
	>=kde-base/kcron-${PV}:${SLOT}
	>=kde-base/ksystemlog-${PV}:${SLOT}
	>=kde-base/knetworkconf-${PV}:${SLOT}
	>=kde-base/kuser-${PV}:${SLOT}
	lilo? ( >=kde-base/lilo-config-${PV}:${SLOT} )
"
# >=kde-base/kdeadmin-strigi-analyzer-${PV}:${SLOT}
## the following package has missing rdepends (the 'SMART package manager') and
## isn't useful enough on Gentoo to fix it now
#	>=kde-base/kpackage-${PV}:${SLOT}

#>=kde-base/kdat-${PV}:${SLOT} not updated for a long time
#>=kde-base/ksysv-${PV}:${SLOT}  not updated for a long time
# secpolicy got kicked from svn it seems
