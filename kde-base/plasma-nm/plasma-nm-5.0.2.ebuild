# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE Plasma applet for NetworkManager"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=" ~amd64"
IUSE="modemmanager openconnect"

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep solid)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	>=net-libs/libnm-qt-5.0
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.9.10.0[teamd]
	modemmanager? ( >=net-libs/libmm-qt-5.0 )
	openconnect? (
		net-misc/networkmanager-openconnect
		net-misc/openconnect
	)
"
RDEPEND="${DEPEND}
	!kde-misc/networkmanagement
	!kde-misc/plasma-nm:4
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package modemmanager ModemManager)
		$(cmake-utils_use_find_package modemmanager KF5ModemManagerQt)
		$(cmake-utils_use_find_package openconnect OpenConnect)
	)

	kde5_src_configure
}
