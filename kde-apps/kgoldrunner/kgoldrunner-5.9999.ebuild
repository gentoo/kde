# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK=true
KDE_SELINUX_MODULE="games"
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Game of action and puzzle solving by KDE"
HOMEPAGE="
	https://www.kde.org/applications/games/kgoldrunner/
	https://games.kde.org/game.php?game=kgoldrunner
"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	media-libs/libsndfile
	media-libs/openal
"
RDEPEND="${DEPEND}"
