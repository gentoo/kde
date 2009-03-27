# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdnssd/kdnssd-4.2.1.ebuild,v 1.1 2009/03/04 21:20:59 alexxy Exp $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="A DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug zeroconf"

DEPEND="
	zeroconf? ( >=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,zeroconf] )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF -DWITH_DNSSD=ON"

	kde4-meta_src_configure
}
