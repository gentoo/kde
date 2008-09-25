# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

DESCRIPTION="KDE - merge this to pull in all non-developer, split kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="accessibility"

# excluded: kdebindings, kdesdk, kdevelop, since these are developer-only
RDEPEND="
	>=kde-base/kate-${PV}:${SLOT}
	>=kde-base/kdeadmin-meta-${PV}:${SLOT}
	>=kde-base/kdeartwork-meta-${PV}:${SLOT}
	>=kde-base/kdebase-meta-${PV}:${SLOT}
	>=kde-base/kdeedu-meta-${PV}:${SLOT}
	>=kde-base/kdegames-meta-${PV}:${SLOT}
	>=kde-base/kdegraphics-meta-${PV}:${SLOT}
	>=kde-base/kdemultimedia-meta-${PV}:${SLOT}
	>=kde-base/kdenetwork-meta-${PV}:${SLOT}
	>=kde-base/kdepim-meta-${PV}:${SLOT}
	>=kde-base/kdetoys-meta-${PV}:${SLOT}
	>=kde-base/kdeutils-meta-${PV}:${SLOT}
	accessibility? ( >=kde-base/kdeaccessibility-meta-${PV}:${SLOT} )
"
