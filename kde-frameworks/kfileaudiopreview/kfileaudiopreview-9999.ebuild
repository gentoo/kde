# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="false"
inherit kde5

DESCRIPTION="Plugin for KIO providing a component for previewing audio files"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kservice)
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/phonon[qt5]
"
DEPEND="${RDEPEND}"
