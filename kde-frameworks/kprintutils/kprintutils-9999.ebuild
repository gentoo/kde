# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Print dialogs"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep ktextwidgets)
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

DOCS=( README.md )
