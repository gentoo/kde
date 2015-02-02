# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="KDE image scanning application"
HOMEPAGE="http://www.kde.org/applications/graphics/skanlite/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep libksane)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/libpng:0=
"
DEPEND="${RDEPEND}"
