# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-meta/kdepim-meta-4.2.4.ebuild,v 1.2 2009/06/04 23:44:57 alexxy Exp $

EAPI="2"
inherit kde4-functions

DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="live"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="kdeprefix"

RDEPEND="
	>=kde-base/akonadi-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/akregator-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kabcclient-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kaddressbook-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kalarm-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdepim-icons-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdepim-kresources-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdepim-strigi-analyzer-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdepim-wizards-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kjots-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kleopatra-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmail-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kmailcvt-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/knode-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/knotes-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/konsolekalendar-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kontact-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kontact-specialdates-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kontactinterfaces-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/korganizer-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kpilot-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/ktimetracker-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkleo-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkpgp-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libksieve-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/mimelib-${PV}:${SLOT}[kdeprefix=]
	$(block_other_slots)
"
