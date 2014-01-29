# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="Framework providing integration of QML and KDE work spaces"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"
