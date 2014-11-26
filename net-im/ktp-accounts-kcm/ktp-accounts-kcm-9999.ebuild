# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE Telepathy account management kcm"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="LGPL-2.1"
SLOT="5"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-libs/telepathy-qt[qt5]
	kde-misc/kaccounts-integration
"

RDEPEND="${DEPEND}
	!net-im/ktp-accounts-kcm:4
"
