# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
CPPUNIT_REQUIRED="test"
inherit kde4svn-meta

DESCRIPTION="Solid: the KDE hardware library"
KEYWORDS=""
IUSE="bluetooth networkmanager"

# solid/CMakeLists.txt has an add_subdirectory statement that depends on
# networkmanager-0.7, referring to a non-existant directory, restricted to =0.6*
# for now.
DEPEND=">=sys-apps/hal-0.5.9
	bluetooth? ( net-wireless/bluez-libs )
	networkmanager? ( =net-misc/networkmanager-0.6* )"
RDEPEND="${DEPEND}"

KMEXTRA="libs/solid/"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with bluetooth BlueZ)
		$(cmake-utils_use_with networkmanager NetworkManager)"

	kde4overlay-meta_src_compile
}
