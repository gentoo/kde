# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Dedicated search application built on top of Baloo"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/milou"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep krunner)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	kde-base/baloo:5
"
RDEPEND="${DEPEND}"
