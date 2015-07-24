# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
KDE_SELINUX_MODULE="games"
inherit kde5

DESCRIPTION="Classic mine sweeper game"
HOMEPAGE="
	http://www.kde.org/applications/games/kmines/
	http://games.kde.org/game.php?game=kmines
"
KEYWORDS=""
IUSE="phonon"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libkdegames)
	dev-qt/qtdeclarative:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	phonon? ( media-libs/phonon[qt5] )
"

RDEPEND="${DEPEND}"

src_prepare() {
	# fix copy-paste (?) error, there are no tests
	sed -i "/find_package(Qt5/ s/ Test//" CMakeLists.txt || die

	kde5_src_prepare
}

src_configure(){
	local mycmakeargs=(
		$(cmake-utils_use_find_package phonon Phonon4Qt5)
	)

	kde5_src_configure
}
