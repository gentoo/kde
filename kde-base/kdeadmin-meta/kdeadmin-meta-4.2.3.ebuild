# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-4.2.2.ebuild,v 1.2 2009/04/17 06:40:25 alexxy Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="lilo"

# reavertm TODO add >=kde-base/system-config-printer-kde-${PV}:${SLOT} when system-config-printer unmasked in tree
RDEPEND="
	>=kde-base/kcron-${PV}:${SLOT}
	>=kde-base/knetworkconf-${PV}:${SLOT}
	>=kde-base/ksystemlog-${PV}:${SLOT}
	>=kde-base/kuser-${PV}:${SLOT}
	lilo? ( >=kde-base/lilo-config-${PV}:${SLOT} )
"

## The following package was just added and has a questionable interest to Gentoo
#	>=kde-base/kpackage-${PV}:${SLOT}

## the following packages are currently missing in kde 4.1
#>=kde-base/kdeadmin-kfile-plugins-${PV}:${SLOT}
#>=kde-base/secpolicy-${PV}:${SLOT}

## These seem to be broken
#>=kde-base/kdat-${PV}:${SLOT}
#>=kde-base/ksysv-${PV}:${SLOT}
