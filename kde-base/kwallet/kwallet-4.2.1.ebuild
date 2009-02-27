# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwallet/kwallet-4.2.0.ebuild,v 1.2 2009/02/01 08:14:20 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="
	>=kde-base/kcmshell-${PV}:${SLOT}
	kde-base/kwalletd:${SLOT}
"
