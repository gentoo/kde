# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit kde4overlay-functions

DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-svn"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=kde-base/kdeartwork-colorschemes-${PV}:${SLOT}
	>=kde-base/kdeartwork-emoticons-${PV}:${SLOT}
	>=kde-base/kdeartwork-iconthemes-${PV}:${SLOT}
	>=kde-base/kdeartwork-kscreensaver-${PV}:${SLOT}
	>=kde-base/kdeartwork-kworldclock-${PV}:${SLOT}
	>=kde-base/kdeartwork-styles-${PV}:${SLOT}
	>=kde-base/kdeartwork-wallpapers-${PV}:${SLOT}
	"
# >=kde-base/kdeartwork-kwin-styles-${PN}:${SLOT} add this when package fixed
# i removed sounds and icewm-themes, arent touched for a long time in svn
