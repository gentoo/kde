# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK=true
inherit kde5

DESCRIPTION="Kompare is a program to view the differences between files"
HOMEPAGE="http://www.kde.org/applications/development/kompare
http://www.caffeinated.me.uk/kompare"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep ktexteditor)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_kdeapps_dep libkomparediff2)
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
"

DEPEND="${RDEPEND}"
