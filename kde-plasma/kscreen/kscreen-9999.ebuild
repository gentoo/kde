# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE screen management"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/kscreen"

KEYWORDS=""
IUSE=""

DEPEND="
	$(add_kdeplasma_dep libkscreen)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="
	${DEPEND}
	!kde-misc/kscreen
"
