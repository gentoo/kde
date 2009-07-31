# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-meta/kde-meta-4.2.4.ebuild,v 1.2 2009/06/04 23:40:43 alexxy Exp $

EAPI="2"

DESCRIPTION="KDE - merge this to pull in all non-developer, split kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS=""
SLOT="4.3"
IUSE="accessibility kdeprefix +mysql nls"

# excluded: kdebindings, kdesdk, kdevelop, since these are developer-only
RDEPEND="
	>=kde-base/kate-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdeadmin-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdeartwork-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdebase-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdeedu-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdegames-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdegraphics-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdemultimedia-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdenetwork-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdeplasma-addons-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdetoys-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdeutils-meta-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdewebdev-meta-${PV}:${SLOT}[kdeprefix=]
	accessibility? ( >=kde-base/kdeaccessibility-meta-${PV}:${SLOT}[kdeprefix=] )
	mysql? ( >=kde-base/kdepim-meta-${PV}:${SLOT}[kdeprefix=] )
	nls? ( >=kde-base/kde-l10n-${PV}:${SLOT}[kdeprefix=] )
"
# make kdepim-meta optional since it requires long hated mysql which people tend
# not to want in their system. But also enable it by default
