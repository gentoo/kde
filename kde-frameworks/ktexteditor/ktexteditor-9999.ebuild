# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Full text editor component"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kprintutils)
	$(add_frameworks_dep sonnet)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep knotifications)
	dev-qt/qtwidgets:5
	dev-qt/qtscript:5
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
