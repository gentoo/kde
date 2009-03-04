# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-4.2.0.ebuild,v 1.1 2009/01/28 02:48:04 jmbsvicetto Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/kdenetwork-filesharing-${PV}:${SLOT}
	>=kde-base/kdnssd-${PV}:${SLOT}
	>=kde-base/kget-${PV}:${SLOT}
	>=kde-base/kopete-${PV}:${SLOT}
	>=kde-base/kppp-${PV}:${SLOT}
	>=kde-base/krdc-${PV}:${SLOT}
	>=kde-base/krfb-${PV}:${SLOT}
"
