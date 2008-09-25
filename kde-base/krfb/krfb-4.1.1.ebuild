# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2_pre3"

KMNAME=kdenetwork
inherit kde4-meta

DESCRIPTION="VNC-compatible server to share KDE desktops"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook zeroconf"

DEPEND=">=net-libs/libvncserver-0.9
	net-libs/openslp
	x11-libs/libXdamage
	zeroconf? ( || ( net-dns/avahi[mdnsresponder-compat] net-misc/mDNSResponder ) )"
RDEPEND="${DEPEND}"

src_compile() {
	# krfb requires both slp and vnc to build
	mycmakeargs="${mycmakeargs}
		-DWITH_Xmms=OFF -DWITH_SLP=ON -DWITH_LibVNCServer=ON
		$(cmake-utils_use_with zeroconf DNSSD)"

	kde4-meta_src_compile
}
