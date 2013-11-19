# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier2"
inherit kde-frameworks

DESCRIPTION="Library for working with KDE wallets"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
"
DEPEND="${RDEPEND}
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
