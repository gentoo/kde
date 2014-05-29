# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Bluetooth stack for KDE"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/bluedevil"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	net-libs/libbluedevil:5
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	!app-mobilephone/obexd
	!app-mobilephone/obex-data-server
	!net-wireless/bluedevil:4
	!net-wireless/kbluetooth
"

PATCHES=( "${FILESDIR}/${P}-ecm-cmake.patch" )
