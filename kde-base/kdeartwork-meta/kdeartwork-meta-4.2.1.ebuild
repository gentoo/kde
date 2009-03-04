# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-meta/kdeartwork-meta-4.2.0.ebuild,v 1.1 2009/01/28 02:32:14 jmbsvicetto Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/kdeartwork-colorschemes-${PV}:${SLOT}
	>=kde-base/kdeartwork-desktopthemes-${PV}:${SLOT}
	>=kde-base/kdeartwork-emoticons-${PV}:${SLOT}
	>=kde-base/kdeartwork-iconthemes-${PV}:${SLOT}
	>=kde-base/kdeartwork-kscreensaver-${PV}:${SLOT}
	>=kde-base/kdeartwork-sounds-${PV}:${SLOT}
	>=kde-base/kdeartwork-styles-${PV}:${SLOT}
	>=kde-base/kdeartwork-wallpapers-${PV}:${SLOT}
"
