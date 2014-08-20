# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Collection of applications used for file and Internet browsing"
HOMEPAGE="https://projects.kde.org/projects/kde/applications/kde-baseapps"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep baloo-widgets)
	$(add_kdebase_dep kfilemetadata)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdesu)
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
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/phonon[qt5]
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	!kde-base/kdialog:4
	!kde-base/dolphin:4
	!kde-base/kfind:4
	!kde-base/libkonq:4
"
