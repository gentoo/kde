# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

FRAMEWORKS_MINIMAL="5.17.0"
QT_MINIMAL="5.5.0"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Qt Platform Theme integration plugins for the Plasma workspaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_plasma_dep kwayland)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5=
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libXcursor
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	$(add_plasma_dep oxygen-fonts '' 5.4.3)
	media-fonts/noto
"

# requires running kde environment
RESTRICT="test"
