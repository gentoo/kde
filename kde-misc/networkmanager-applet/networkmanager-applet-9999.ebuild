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
SLOT="0"
IUSE="debug"

DEPEND="
	>=kde-base/solid-${KDE_MINIMAL}[networkmanager]
	>=net-misc/networkmanager-0.7
"
RDEPEND="${DEPEND}"

src_configure() {

	# Fix dbus policy
	sed -i 's/at_console=".*"/group="plugdev"/' \
			"${S}/NetworkManager-kde4.conf" \
				|| die "Fixing dbus policy failed"

	mycmakeargs="${mycmakeargs}
		-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d"

	kde4-base_src_configure
}
