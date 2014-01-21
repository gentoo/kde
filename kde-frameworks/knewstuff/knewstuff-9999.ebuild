# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Framework for downloading and sharing additional application data"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep attica qt5)
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
