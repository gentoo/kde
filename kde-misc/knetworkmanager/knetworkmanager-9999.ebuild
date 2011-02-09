# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_MINIMAL="4.5"

KDE_SCM="git"
ESCM_REPONAME="networkmanagement"
[[ ${PV} = 9999* ]] && SRC_URI="mirror://gentoo/${P}.tar.bz2"

inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="consolekit debug +networkmanager wicd"

DEPEND="
	$(add_kdebase_dep solid 'networkmanager?,wicd?')
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.7
	consolekit? ( sys-auth/consolekit )
	!wicd? ( $(add_kdebase_dep solid 'networkmanager') )
"
RDEPEND="${DEPEND}"

RESTRICT="test"

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
