# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Widget library for baloo"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep baloo)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kfilemetadata)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${COMMON_DEPEND}
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kservice)
"
RDEPEND="${COMMON_DEPEND}
	!kde-base/baloo-widgets
"
