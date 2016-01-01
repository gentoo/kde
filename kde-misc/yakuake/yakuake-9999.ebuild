# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Quake-style terminal emulator based on konsole"
HOMEPAGE="http://yakuake.kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep konsole)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
"
RDEPEND="${DEPEND}
	!kde-misc/yakuake:4
"
