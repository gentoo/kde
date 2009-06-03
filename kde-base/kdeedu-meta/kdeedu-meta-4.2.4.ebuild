# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu-meta/kdeedu-meta-4.2.3.ebuild,v 1.1 2009/05/06 23:09:02 scarabeus Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="KDE educational apps - merge this to pull in all kdeedu-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/blinken-${PV}:${SLOT}
	>=kde-base/kalgebra-${PV}:${SLOT}
	>=kde-base/kalzium-${PV}:${SLOT}
	>=kde-base/kanagram-${PV}:${SLOT}
	>=kde-base/kbruch-${PV}:${SLOT}
	>=kde-base/kgeography-${PV}:${SLOT}
	>=kde-base/khangman-${PV}:${SLOT}
	>=kde-base/kig-${PV}:${SLOT}
	>=kde-base/kiten-${PV}:${SLOT}
	>=kde-base/klettres-${PV}:${SLOT}
	>=kde-base/kmplot-${PV}:${SLOT}
	>=kde-base/kstars-${PV}:${SLOT}
	>=kde-base/ktouch-${PV}:${SLOT}
	>=kde-base/kturtle-${PV}:${SLOT}
	>=kde-base/kwordquiz-${PV}:${SLOT}
	>=kde-base/libkdeedu-${PV}:${SLOT}
	>=kde-base/marble-${PV}:${SLOT}
	>=kde-base/parley-${PV}:${SLOT}
	>=kde-base/step-${PV}:${SLOT}
"
