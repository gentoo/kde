# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE Telepathy contact list"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="GPL-2"
SLOT="5"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	=net-im/ktp-common-internals-9999:5
	net-libs/telepathy-qt[qt5]
"

RDEPEND="${DEPEND}
	!net-im/ktp-contact-list:4
"
