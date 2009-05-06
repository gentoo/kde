# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-meta/kdemultimedia-meta-4.2.2.ebuild,v 1.2 2009/04/17 06:29:04 alexxy Exp $

EAPI="2"
inherit kde4-functions

DESCRIPTION="kdemultimedia - merge this to pull in all kdemultimedia-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/dragonplayer-${PV}:${SLOT}
	>=kde-base/juk-${PV}:${SLOT}
	>=kde-base/kdemultimedia-kioslaves-${PV}:${SLOT}
	>=kde-base/kmix-${PV}:${SLOT}
	>=kde-base/kscd-${PV}:${SLOT}
	>=kde-base/libkcddb-${PV}:${SLOT}
	>=kde-base/libkcompactdisc-${PV}:${SLOT}
"
