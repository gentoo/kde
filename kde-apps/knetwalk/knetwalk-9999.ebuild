# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="KDE version of the popular NetWalk game for system administrators"
HOMEPAGE="
	http://www.kde.org/applications/games/knetwalk/
	http://games.kde.org/game.php?game=knetwalk
"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-9999-tests-optional.patch" )
