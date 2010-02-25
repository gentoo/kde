# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

QT_MINIMAL="4.6.0_beta"

inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"
SRC_URI="http://dev.gentoo.org/~tampakrap/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="consolekit debug +networkmanager wicd"

DEPEND="
	!kde-misc/networkmanager-applet
	>=kde-base/solid-${KDE_MINIMAL}[networkmanager?,wicd?]
	>=net-misc/networkmanager-0.7
	consolekit? ( sys-auth/consolekit )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! use networkmanager && ! use wicd; then
		eerror "You need to pick up one of the backend implementations"
		eerror "   * networkmanager"
		eerror "   * wicd"
		die "No backend selected"
	fi

	kde4-base_pkg_setup
}

src_prepare() {
	kde4-base_src_prepare

	if ! use consolekit; then
		# Fix dbus policy
		sed -i \
			-e 's/at_console=".*"/group="plugdev"/' \
			"${S}/NetworkManager-kde4.conf" \
			|| die "Fixing dbus policy failed"
	fi
}

src_configure() {
	mycmakeargs=(
		-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d
	)

	kde4-base_src_configure
}
