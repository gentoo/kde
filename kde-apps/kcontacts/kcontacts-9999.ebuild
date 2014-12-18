# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Contacts library for KDE PIM apps"
KEYWORDS=""
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"
