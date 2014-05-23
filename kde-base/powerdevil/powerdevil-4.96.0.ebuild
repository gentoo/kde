# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Manages the power consumption settings of a Plasma Shell"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/powerdevil"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep krunner)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}
	!kde-base/powerdevil:4
"
