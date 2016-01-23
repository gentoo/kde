# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde5

DESCRIPTION="Library for managing partitions"
HOMEPAGE="https://www.kde.org/applications/system/kdepartitionmanager"

LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

CDEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	dev-libs/libatasmart
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	sys-apps/util-linux
	>=sys-block/parted-3
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
"
RDEPEND="${CDEPEND}
	<sys-block/partitionmanager-2.0.0
"
