# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="KDE accounts providers"
HOMEPAGE="https://community.kde.org/KTp"
LICENSE="LGPL-2.1"

KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kpackage)
	$(add_kdeapps_dep kaccounts-integration)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtxml:5
"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
"
RDEPEND="${COMMON_DEPEND}
	net-im/telepathy-connection-managers[xmpp]
	net-libs/signon-ui
	net-libs/signon-oauth2
"
