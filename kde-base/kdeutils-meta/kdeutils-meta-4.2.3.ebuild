# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils-meta/kdeutils-meta-4.2.2.ebuild,v 1.2 2009/04/17 06:45:40 alexxy Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="floppy"

# reavertm TODO add kde-base/printer-applet-${PV}:${SLOT} when deps are unmasked in portage
RDEPEND="
	>=kde-base/ark-${PV}:${SLOT}
	>=kde-base/kcalc-${PV}:${SLOT}
	>=kde-base/kcharselect-${PV}:${SLOT}
	>=kde-base/kdessh-${PV}:${SLOT}
	>=kde-base/kdf-${PV}:${SLOT}
	>=kde-base/kgpg-${PV}:${SLOT}
	>=kde-base/ktimer-${PV}:${SLOT}
	>=kde-base/kwallet-${PV}:${SLOT}
	>=kde-base/superkaramba-${PV}:${SLOT}
	>=kde-base/sweeper-${PV}:${SLOT}
	>=kde-base/okteta-${PV}:${SLOT}
	floppy? ( >=kde-base/kfloppy-${PV}:${SLOT} )
"
