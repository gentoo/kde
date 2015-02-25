# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P=${PN/kded/kded-integration}-${PV}
inherit kde5

DESCRIPTION="KDE Telepathy workspace integration"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kidletime)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_kdeapps_dep ktp-common-internals)
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	net-libs/telepathy-qt[qt5]
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep signon-kwallet-extension)
	!net-im/ktp-kded-module
"

[[ ${PV} == *9999* ]] || S=${WORKDIR}/${MY_P}
