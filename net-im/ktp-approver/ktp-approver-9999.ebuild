# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE Telepathy notification handler"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="LGPL-2.1"
SLOT="5"
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	net-libs/telepathy-qt[qt5]"

RDEPEND="${DEPEND}
	>=net-im/ktp-contact-list-${PV}
	!net-im/ktp-approver:4
"
