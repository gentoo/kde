# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FRAMEWORKS_TYPE="tier2"
VIRTUALX_REQUIRED="test"
inherit kde-frameworks

DESCRIPTION="Library for completion tasks"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}"
