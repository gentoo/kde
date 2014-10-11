# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Dedicated search application built on top of Baloo"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/milou"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep krunner)
	$(add_frameworks_dep kservice)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep baloo)
"
