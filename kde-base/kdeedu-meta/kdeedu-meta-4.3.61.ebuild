# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu-meta/kdeedu-meta-4.2.4.ebuild,v 1.2 2009/06/04 23:34:19 alexxy Exp $

EAPI="2"

DESCRIPTION="KDE educational apps - merge this to pull in all kdeedu-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.4"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/blinken-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kalgebra-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kalzium-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kanagram-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kbruch-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kgeography-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/khangman-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kig-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kiten-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/klettres-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmplot-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kstars-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ktouch-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kturtle-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kwordquiz-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdeedu-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/marble-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/parley-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/step-${PV}:${SLOT}[kdeprefix=]
"
