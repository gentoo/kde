# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-meta/kdepim-meta-4.2.2.ebuild,v 1.2 2009/04/17 06:36:12 alexxy Exp $

EAPI="2"

inherit kde4-functions

DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=kde-base/akonadi-${PV}:${SLOT}
	>=kde-base/akregator-${PV}:${SLOT}
	>=kde-base/kabcclient-${PV}:${SLOT}
	>=kde-base/kaddressbook-${PV}:${SLOT}
	>=kde-base/kalarm-${PV}:${SLOT}
	>=kde-base/kdemaildir-${PV}:${SLOT}
	>=kde-base/kdepim-icons-${PV}:${SLOT}
	>=kde-base/kdepim-kresources-${PV}:${SLOT}
	>=kde-base/kdepim-strigi-analyzer-${PV}:${SLOT}
	>=kde-base/kdepim-wizards-${PV}:${SLOT}
	>=kde-base/kjots-${PV}:${SLOT}
	>=kde-base/kleopatra-${PV}:${SLOT}
	>=kde-base/kmail-${PV}:${SLOT}
	>=kde-base/kmailcvt-${PV}:${SLOT}
	>=kde-base/knode-${PV}:${SLOT}
	>=kde-base/knotes-${PV}:${SLOT}
	>=kde-base/kode-${PV}:${SLOT}
	>=kde-base/konsolekalendar-${PV}:${SLOT}
	>=kde-base/kontact-${PV}:${SLOT}
	>=kde-base/kontact-specialdates-${PV}:${SLOT}
	>=kde-base/kontactinterfaces-${PV}:${SLOT}
	>=kde-base/korganizer-${PV}:${SLOT}
	>=kde-base/kpilot-${PV}:${SLOT}
	>=kde-base/ktimetracker-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}
	>=kde-base/libkholidays-${PV}:${SLOT}
	>=kde-base/libkleo-${PV}:${SLOT}
	>=kde-base/libkpgp-${PV}:${SLOT}
	>=kde-base/libksieve-${PV}:${SLOT}
	>=kde-base/mimelib-${PV}:${SLOT}
"
