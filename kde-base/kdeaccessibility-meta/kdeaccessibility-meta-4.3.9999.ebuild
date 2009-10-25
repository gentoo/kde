# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit kde4-functions

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.3"
KEYWORDS=""
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/kdeaccessibility-colorschemes-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdeaccessibility-iconthemes-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmag-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmousetool-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmouth-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kttsd-${PV}:${SLOT}[kdeprefix=]
	$(block_other_slots)
"
# The following are disabled in CMakeLists.txt
# >=kde-base/kbstateapplet-${PV}:${SLOT} - kicker applet
# >=kde-base/ksayit-${PV}:${SLOT} - doesn't compile
