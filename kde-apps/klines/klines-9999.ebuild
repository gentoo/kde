# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="forceoptional"
KDE_SELINUX_MODULE="games"
inherit kde5

DESCRIPTION="A little KDE game about balls and how to get rid of them"
HOMEPAGE="
	https://www.kde.org/applications/games/klines/
	https://games.kde.org/game.php?game=klines
"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"

RDEPEND="${DEPEND}"

DOCS=( AUTHORS )
