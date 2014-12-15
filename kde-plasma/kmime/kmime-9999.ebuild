# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE library for MIME handling"
KEYWORDS=""
LICENSE="LGPL-2"
IUSE=""

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"
