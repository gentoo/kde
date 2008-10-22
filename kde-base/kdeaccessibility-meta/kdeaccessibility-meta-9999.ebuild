# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit kde4overlay-functions

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-svn"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=kde-base/kdeaccessibility-colorschemes-${PV}:${SLOT}
	>=kde-base/kdeaccessibility-iconthemes-${PV}:${SLOT}
	>=kde-base/kmag-${PV}:${SLOT}
	>=kde-base/kmousetool-${PV}:${SLOT}
	>=kde-base/kmouth-${PV}:${SLOT}
	>=kde-base/kttsd-${PV}:${SLOT}
"

# >=kde-base/kbstateapplet-${PV}:${SLOT}  hm kicker applet
#	>=kde-base/ksayit-${PV}:${SLOT} doesnt compile
