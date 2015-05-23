# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Plasma filemanager focusing on usability"
HOMEPAGE="http://dolphin.kde.org http://www.kde.org/applications/system/dolphin"
KEYWORDS=""
IUSE="semantic-desktop"

DEPEND="
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
	semantic-desktop? (
		$(add_plasma_dep baloo)
		$(add_plasma_dep baloo-widgets)
		$(add_plasma_dep kfilemetadata)
	)
"
RDEPEND="${DEPEND}
	$(add_plasma_dep kio-extras)
"

RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop KF5Baloo)
		$(cmake-utils_use_with semantic-desktop KF5BalooWidgets)
		$(cmake-utils_use_with semantic-desktop KF5FileMetaData)
	)

	kde5_src_configure
}
