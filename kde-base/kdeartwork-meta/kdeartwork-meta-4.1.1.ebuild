# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

#	>=kde-base/kdeartwork-kwin-styles-${PV}:${SLOT}
RDEPEND="
	>=kde-base/kdeartwork-colorschemes-${PV}:${SLOT}
	>=kde-base/kdeartwork-emoticons-${PV}:${SLOT}
	>=kde-base/kdeartwork-iconthemes-${PV}:${SLOT}
	>=kde-base/kdeartwork-kscreensaver-${PV}:${SLOT}
	>=kde-base/kdeartwork-kworldclock-${PV}:${SLOT}
	>=kde-base/kdeartwork-sounds-${PV}:${SLOT}
	>=kde-base/kdeartwork-styles-${PV}:${SLOT}
	>=kde-base/kdeartwork-wallpapers-${PV}:${SLOT}
	>=kde-base/kdeartwork-icewm-themes-${PV}:${SLOT}
"
