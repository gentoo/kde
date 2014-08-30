# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Breeze visual style for the Plasma desktop"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/breeze"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep frameworkintegration)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libxcb
"
RDEPEND="
	${DEPEND}
	dev-qt/qtgraphicaleffects:5
"
