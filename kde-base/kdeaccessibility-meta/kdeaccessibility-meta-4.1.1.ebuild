# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdeaccessibility - merge this to pull in all kdeaccessiblity-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/kdeaccessibility-colorschemes-${PV}:${SLOT}
	>=kde-base/kdeaccessibility-iconthemes-${PV}:${SLOT}
	>=kde-base/kmag-${PV}:${SLOT}
	>=kde-base/kmousetool-${PV}:${SLOT}
	>=kde-base/kmouth-${PV}:${SLOT}
	>=kde-base/kttsd-${PV}:${SLOT}
"
# The following are disabled in CMakeLists.txt
# >=kde-base/kbstateapplet-${PV}:${SLOT} - kicker applet
# >=kde-base/ksayit-${PV}:${SLOT} - doesn't compile
