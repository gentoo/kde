# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK=true
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="KDE screenshot utility"
HOMEPAGE="http://www.kde.org/applications/graphics/ksnapshot/"
KEYWORDS=""
IUSE=""

# TODO:
# X use flag: -X doesn't build
# kipi use flag, when upstream provides it
DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}
	!kde-base/ksnapshot:4
"
