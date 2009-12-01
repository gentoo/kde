# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE remote desktop connection (RDP and VNC) client"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +handbook jpeg rdp vnc zeroconf"

#nx? ( >=net-misc/nxcl-0.9-r1 ) disabled upstream, last checked 4.3.61
#telepathy? ( >=net-libs/telepathy-qt4-0.18 ) not yet in portage/overlay

DEPEND="
	jpeg? ( media-libs/jpeg )
	vnc? ( >=net-libs/libvncserver-0.9 )
	zeroconf? (
		|| (
			net-dns/avahi
			net-misc/mDNSResponder
		)
	)
"
RDEPEND="${DEPEND}
	rdp? ( net-misc/rdesktop )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_TelepathyQt4=OFF
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with vnc LibVNCServer)
		$(cmake-utils_use_with zeroconf DNSSD)
	"
	# $(cmake-utils_use_with telepathy TelepathyQt4)

	kde4-meta_src_configure
}
