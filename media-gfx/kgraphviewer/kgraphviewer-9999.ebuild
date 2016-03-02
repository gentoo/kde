# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
KDE_HANDBOOK="true"
inherit kde5

DESCRIPTION="Graphviz dot graph file viewer"
HOMEPAGE="http://www.kde.org/applications/graphics/kgraphviewer/
http://extragear.kde.org/apps/kgraphviewer/"

LICENSE="GPL-2 FDL-1.2"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep khtml)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	>=media-gfx/graphviz-2.30
"
DEPEND="${RDEPEND}
	dev-libs/boost
	!media-gfx/kgraphviewer:4
"
