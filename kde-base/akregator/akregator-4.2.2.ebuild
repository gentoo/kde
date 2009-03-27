# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-4.2.1.ebuild,v 1.2 2009/03/08 13:07:54 scarabeus Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"

KMLOADLIBS="libkdepim"
