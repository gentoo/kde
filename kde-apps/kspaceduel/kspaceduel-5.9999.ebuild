# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_BRANCH="frameworks"
KDE_HANDBOOK="true"
KDE_SELINUX_MODULE="games"
inherit kde5

DESCRIPTION="KDE Space Game"
HOMEPAGE="
	https://www.kde.org/applications/games/kspaceduel/
	https://games.kde.org/game.php?game=kspaceduel
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
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	$(add_qt_dep qtdeclarative 'widgets')
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	media-libs/phonon[qt5]
"

RDEPEND="${DEPEND}"

src_prepare() {
	# fix copy-paste (?) error, there are no tests
	sed -i "/find_package(Qt5/ s/ Test//" CMakeLists.txt || die

	kde5_src_prepare
}
