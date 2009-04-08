# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid/solid-4.2.1.ebuild,v 1.2 2009/03/06 00:24:29 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
CPPUNIT_REQUIRED="test"
inherit kde4-meta

SRC_URI="${SRC_URI}
	mirror://gentoo/${PN}-4.2.0-backport-solid-bluetooth.patch.tar.bz2"
DESCRIPTION="Solid: the KDE hardware library"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="bluetooth debug networkmanager"

# solid/CMakeLists.txt has an add_subdirectory statement that depends on
# networkmanager-0.7, referring to a non-existant directory, restricted to =0.6*
# for now.
DEPEND="
	>=sys-apps/hal-0.5.9
	bluetooth? (
		|| (
			net-wireless/bluez
			net-wireless/bluez-libs
		)
	)
	networkmanager? ( >=net-misc/networkmanager-0.7 )
"
RDEPEND="${DEPEND}"

KMEXTRA="
	libs/solid/
"

PATCHES=( "${DISTDIR}/${PN}-4.2.0-backport-solid-bluetooth.patch.tar.bz2" )

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with bluetooth BlueZ)
		$(cmake-utils_use_with networkmanager NetworkManager)"

	kde4-meta_src_configure
}

pkg_postinst() {
	elog "If you want to be notified about new plugged devices by a popup,"
	elog "install kde-base/soliduiserver"

	kde4-meta_pkg_postinst
}
