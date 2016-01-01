# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="KDE Telepathy authentication handler"
HOMEPAGE="https://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwallet)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_kdeapps_dep kaccounts-integration)
	$(add_kdeapps_dep ktp-common-internals)
	app-crypt/qca:2[qt5]
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-libs/accounts-qt
	net-libs/signond
	net-libs/telepathy-qt[qt5]
"
DEPEND="
	$(add_frameworks_dep kdewebkit)
	${COMMON_DEPEND}
"
RDEPEND="${COMMON_DEPEND}
	app-crypt/qca:2[openssl]
	!net-im/ktp-auth-handler
"
