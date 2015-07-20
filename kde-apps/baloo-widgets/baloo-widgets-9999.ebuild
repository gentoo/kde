# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Widget library for baloo"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_plasma_dep baloo)
	$(add_plasma_dep kfilemetadata)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
	!kde-base/baloo-widgets:5
"
