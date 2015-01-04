# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE Telepathy contact, presence and chat Plasma applets"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/stable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-2 LGPL-2.1"
SLOT="5"
IUSE=""

DEPEND="
	$(add_frameworks_dep plasma)
"
RDEPEND="${DEPEND}
	$(add_frameworks_dep kdeclarative)
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	>=net-im/ktp-common-internals-${PV}
	!net-im/ktp-desktop-applets:4
"
