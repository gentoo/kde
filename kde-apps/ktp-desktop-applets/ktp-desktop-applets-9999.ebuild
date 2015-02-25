# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE Telepathy contact, presence and chat Plasma applets"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep plasma)
"
RDEPEND="${DEPEND}
	$(add_frameworks_dep kdeclarative)
	$(add_kdeapps_dep ktp-common-internals)
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	!net-im/ktp-desktop-applets
"
