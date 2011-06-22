# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_MINIMAL="4.6"

KDE_SCM="git"
EGIT_REPONAME="networkmanagement"

if use nm09; then
	EGIT_BRANCH="nm09"
else
	EGIT_BRANCH="master"
fi

inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"
[[ ${PV} != 9999* ]] && SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
SLOT="4"
IUSE="consolekit nm09 debug"

# From 0.9 networkmanager the solid is not used
DEPEND="
	net-misc/mobile-broadband-provider-info
	nm09?	( >=net-misc/networkmanager-0.8.9997 )
	!nm09?	( $(add_kdebase_dep solid 'networkmanager') )
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
	local mycmakeargs=(
		-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d
	)

	kde4-base_src_configure
}
