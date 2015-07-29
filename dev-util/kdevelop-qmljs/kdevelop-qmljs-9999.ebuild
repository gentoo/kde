# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDEBASE="kdevelop"
KMNAME="kdev-qmljs"
KDE_TEST=true
inherit kde5

DESCRIPTION="QML and javascript plugin for KDevelop 5"
LICENSE="GPL-2 LGPL-2"
IUSE=""
KEYWORDS=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep threadweaver)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-util/kdevplatform:5
"
RDEPEND="${DEPEND}
	dev-util/kdevelop:5
"

RESTRICT="test"
