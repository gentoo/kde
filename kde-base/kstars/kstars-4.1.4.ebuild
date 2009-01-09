# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-4.1.3.ebuild,v 1.3 2008/11/16 08:04:06 vapier Exp $

EAPI="2"

KMNAME=kdeedu
inherit kde4-meta flag-o-matic toolchain-funcs

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug fits htmlhandbook nova sbig usb"

DEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
		fits? ( sci-libs/cfitsio )
		nova? ( >=sci-libs/libnova-0.12.1 )
		sbig? ( sci-libs/indilib
			usb? ( dev-libs/libusb ) )"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${PN}-4.1.0-destdir.patch")

src_unpack() {
	[[ $(tc-arch) == "ppc64" ]] && append-flags -mminimal-toc #241900

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with fits CFitsio)
		$(cmake-utils_use_with nova Nova)
		$(cmake-utils_use_with sbig SBIG)
		$(cmake-utils_use_with usb USB)"

	sed -i -e "s:add_subdirectory(cmake):#dontwantit:g" CMakeLists.txt \
		|| die  "disabling cmake includes failed"
	sed -i -e "s:add_subdirectory( cmake ):#dontwantit:g" CMakeLists.txt \
		|| die "disabling cmake includes failed"

	kde4-meta_src_configure

	# FIXME Unhandled arguments - added sbig but not sure about use descriptions or flag names...
	# WITH_SBIG - Switch which controls the detection of the proprietary and binary only SBIG CCD universal library. No ebuild for this package
	# are available at the moment.
	# ssh_tunnel ->  INDI Server binds locally. Remote clients may only connect
	# via SSH Tunneling.
}
