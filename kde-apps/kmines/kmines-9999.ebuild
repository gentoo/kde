# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_HANDBOOK="forceoptional"
KDE_PUNT_BOGUS_DEPS="true"
KDE_SELINUX_MODULE="games"
inherit kde5

DESCRIPTION="Classic mine sweeper game"
HOMEPAGE="
	https://www.kde.org/applications/games/kmines/
	https://games.kde.org/game.php?game=kmines
"
KEYWORDS=""
IUSE="phonon"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	phonon? ( media-libs/phonon[qt5] )
"

RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs=(
		$(cmake-utils_use_find_package phonon Phonon4Qt5)
	)

	kde5_src_configure
}
