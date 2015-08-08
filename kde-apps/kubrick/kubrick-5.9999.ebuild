# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK=true
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Game based on the \"Rubik's Cube\" puzzle by KDE"
HOMEPAGE="http://www.kde.org/applications/games/kubrick/"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	virtual/glu
"
DEPEND="${RDEPEND}
	virtual/opengl
"
