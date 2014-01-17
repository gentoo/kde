# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE remote desktop connection (RDP and VNC) client"
HOMEPAGE="http://www.kde.org/applications/internet/krdc/"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug jpeg rdesktop vnc zeroconf telepathy"

#nx? ( >=net-misc/nxcl-0.9-r1 ) disabled upstream, last checked 4.3.61

DEPEND="
	jpeg? ( virtual/jpeg:0 )
	vnc? ( >=net-libs/libvncserver-0.9 )
	zeroconf? ( net-dns/avahi )
	telepathy? ( >=net-libs/telepathy-qt-0.9 )
"
RDEPEND="${DEPEND}
	rdesktop? ( >=net-misc/freerdp-1.1.0_beta1[X] )
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with telepathy TelepathyQt4)
		$(cmake-utils_use_with vnc LibVNCServer)
		$(cmake-utils_use_with zeroconf DNSSD)
	)

	kde4-base_src_configure
}
