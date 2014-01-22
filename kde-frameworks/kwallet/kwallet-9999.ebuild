# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="${PN}-framework"
inherit kde-frameworks

DESCRIPTION="Library for working with KDE wallets"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="crypt"

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	crypt? (
		kde-base/kdepimlibs
		app-crypt/gpgme:1=
	)
"
DEPEND="${RDEPEND}
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package crypt Gpgme)
		$(cmake-utils_use_find_package crypt QGpgme)
	)

	kde-frameworks_src_configure
}
