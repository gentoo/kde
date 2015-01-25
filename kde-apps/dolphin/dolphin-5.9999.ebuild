# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
KMNAME="kde-baseapps"
KDE_HANDBOOK="true"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KDE filemanager focusing on usability"
HOMEPAGE="http://dolphin.kde.org http://www.kde.org/applications/system/dolphin"
KEYWORDS=""
IUSE="semantic-desktop"

DEPEND="
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
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
	$(add_kdeapps_dep libkonq)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
	semantic-desktop? (
		$(add_kdeplasma_dep baloo)
		$(add_kdeplasma_dep baloo-widgets)
		$(add_kdeplasma_dep kfilemetadata)
	)
"
RDEPEND="${DEPEND}
	$(add_kdeplasma_dep kio-extras)
	!kde-base/dolphin:4
"

PATCHES=( "${FILESDIR}/${PN}-5.9999-tests-optional.patch" )

S=${S}/${PN}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop KF5Baloo)
		$(cmake-utils_use_with semantic-desktop KF5BalooWidgets)
		$(cmake-utils_use_with semantic-desktop KF5FileMetaData)
	)

	kde5_src_configure
}
