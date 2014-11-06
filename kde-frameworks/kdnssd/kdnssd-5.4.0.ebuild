# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kdnssd/kdnssd-5.3.0.ebuild,v 1.1 2014/10/15 13:29:47 kensington Exp $

EAPI=5

inherit kde5

DESCRIPTION="Framework for network service discovery using Zeroconf"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE="nls zeroconf"

RDEPEND="
	dev-qt/qtnetwork:5
	zeroconf? (
		dev-qt/qtdbus:5
		net-dns/avahi[mdnsresponder-compat]
	)
"
DEPEND="${RDEPEND}
	nls? ( dev-qt/linguist-tools:5 )
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_DNSSD=ON
		$(cmake-utils_use_find_package zeroconf Avahi)
	)

	kde5_src_configure
}
