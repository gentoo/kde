# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-functions

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.3"
KEYWORDS=""
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/amor-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kteatime-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ktux-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kweather-${PV}:${SLOT}[kdeprefix=]
	$(block_other_slots)
"
