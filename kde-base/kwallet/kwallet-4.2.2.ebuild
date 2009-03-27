# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwallet/kwallet-4.2.1.ebuild,v 1.2 2009/03/08 14:07:48 scarabeus Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	>=kde-base/kcmshell-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kwalletd-${PV}:${SLOT}[kdeprefix=]
"
