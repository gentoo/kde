# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="playground/base/plasma/applets"
KMMODULE="networkmanager"
inherit kde4-base

DESCRIPTION="A NetworkManager applet for kde"
HOMEPAGE="http://kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS=""
IUSE=""
SLOT="live"

DEPEND=">=net-misc/networkmanager-0.7
		kde-base/solid[networkmanager]"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d
		"

	kde4-base_src_configure
}
