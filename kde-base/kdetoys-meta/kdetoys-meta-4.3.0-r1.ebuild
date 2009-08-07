# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-4.3.0.ebuild,v 1.1 2009/08/04 00:25:17 wired Exp $

EAPI="2"
inherit kde4-functions

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.3"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/amor-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kteatime-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ktux-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kweather-${PV}:${SLOT}[kdeprefix=]
	$(block_other_slots)
"
