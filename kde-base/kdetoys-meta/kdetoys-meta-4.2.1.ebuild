# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-4.2.0.ebuild,v 1.1 2009/01/28 02:54:56 jmbsvicetto Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/amor-${PV}:${SLOT}
	>=kde-base/kteatime-${PV}:${SLOT}
	>=kde-base/ktux-${PV}:${SLOT}
	>=kde-base/kweather-${PV}:${SLOT}
"
