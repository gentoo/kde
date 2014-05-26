# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Framework for working with KDE activities"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kdbusaddons)
	dev-qt/qtdbus:5
"
RDEPEND="${DEPEND}
	!kde-base/kactivities:4[-minimal]
"
