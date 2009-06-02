# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-meta/kde-meta-4.2.3.ebuild,v 1.1 2009/05/06 23:13:01 scarabeus Exp $

EAPI="2"

DESCRIPTION="KDE - merge this to pull in all non-developer, split kde-base/* packages"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
SLOT="4.2"
IUSE="accessibility +mysql nls"

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
	>=kde-base/kdeplasma-addons-${PV}:${SLOT}
	>=kde-base/kdetoys-meta-${PV}:${SLOT}
	>=kde-base/kdeutils-meta-${PV}:${SLOT}
	accessibility? ( >=kde-base/kdeaccessibility-meta-${PV}:${SLOT} )
	mysql? (
		>=kde-base/kdepim-meta-${PV}:${SLOT}
		>=kde-base/kdewebdev-meta-${PV}:${SLOT}
	)
	nls? ( >=kde-base/kde-l10n-${PV}:${SLOT} )
"
# make kdepim-meta optional since it requires long hated mysql which people tend
# not to want in their system. But also enable it by default
