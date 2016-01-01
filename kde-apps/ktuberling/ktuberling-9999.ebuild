# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="true"
KDE_PUNT_BOGUS_DEPS="true"
KDE_SELINUX_MODULE="games"
inherit kde5

DESCRIPTION="Potato game for kids by KDE"
HOMEPAGE="
	https://www.kde.org/applications/games/ktuberling/
	https://games.kde.org/game.php?game=ktuberling
"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
"

RDEPEND="${DEPEND}"
