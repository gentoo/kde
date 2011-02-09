# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid/solid-4.6.0.ebuild,v 1.2 2011/02/02 11:25:09 scarabeus Exp $

EAPI=3

KDE_SCM="git"
KMNAME="kde-workspace"
CPPUNIT_REQUIRED="test"
inherit kde4-meta

DESCRIPTION="Solid: the KDE hardware library"
KEYWORDS=""
IUSE="debug bluetooth networkmanager wicd"

DEPEND="
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	wicd? ( net-misc/wicd )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep solid-runtime)
"

PDEPEND="bluetooth? ( net-wireless/bluedevil )"

KMEXTRA="
	libs/solid/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with networkmanager NetworkManager)
		$(cmake-utils_use_build wicd)
	)

	kde4-meta_src_configure
}
