# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Solid: the KDE hardware library"
KEYWORDS="~amd64"
IUSE="bluetooth networkmanager test"

DEPEND="
	>=sys-apps/hal-0.5.9
	bluetooth? ( net-wireless/bluez-libs )
	networkmanager? ( net-misc/networkmanager )"
RDEPEND="${DEPEND}"

KMEXTRA="libs/solid/"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with bluetooth BlueZ)
		$(cmake-utils_use_with networkmanager NetworkManager)"

	kde4-meta_src_compile
}

pkg_postinst() {
	elog "If you want to be notified about new plugged devices by a popup,"
	elog "install kde-base/soliduiserver"

	kde4-meta_pkg_postinst
}
