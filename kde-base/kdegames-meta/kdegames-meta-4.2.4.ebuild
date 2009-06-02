# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegames-meta/kdegames-meta-4.2.3.ebuild,v 1.1 2009/05/06 23:09:47 scarabeus Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdegames - merge this to pull in all kdegames-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="opengl"

RDEPEND="
	>=kde-base/bomber-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/bovo-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kapman-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/katomic-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kbattleship-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kblackbox-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kblocks-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kbounce-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kbreakout-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdiamond-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kfourinline-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kgoldrunner-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/killbots-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kiriki-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kjumpingcube-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/klines-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmahjongg-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmines-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/knetwalk-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kolf-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kollision-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/konquest-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kpat-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kreversi-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksame-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kshisen-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksirk-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kspaceduel-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ksquares-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ktuberling-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kubrick-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdegames-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkmahjongg-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/lskat-${PV}:${SLOT}[kdeprefix=]
	opengl? ( >=kde-base/ksudoku-${PV}:${SLOT}[kdeprefix=] )
"
