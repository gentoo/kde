# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils

KMNAME=kdenetwork
inherit kde4svn-meta

DESCRIPTION="A DNSSD (DNS Service Discovery - part of Rendezvous) ioslave and kded module"
KEYWORDS=""
IUSE="debug"

DEPEND="|| ( net-dns/avahi net-misc/mDNSResponder )
	kde-base/kdepimlibs:${SLOT}"
RDEPEND="net-dns/avahi"

pkg_setup() {
	if has_version net-dns/avahi && ! built_with_use net-dns/avahi mdnsresponder-compat; then
		eerror "You should rebuild avahi with mdnsresponder-compat USE flag!"
		die "rebuild net-dns/avahi with mdnsresponder-compat"
	fi
}
src_compile() {
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF -DWITH_DNSSD=ON"

	kde4overlay-meta_src_compile
}
