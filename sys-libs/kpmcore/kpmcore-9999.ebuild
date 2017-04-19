# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

DESCRIPTION="Library for managing partitions"
HOMEPAGE="https://www.kde.org/applications/system/kdepartitionmanager"
LICENSE="GPL-3"
SLOT="5/4"
IUSE=""

CDEPEND="
	$(add_frameworks_dep kauth)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	dev-libs/libatasmart
	sys-apps/util-linux
	>=sys-block/parted-3
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
"
RDEPEND="${CDEPEND}
	!<sys-block/partitionmanager-2.0.0
"
