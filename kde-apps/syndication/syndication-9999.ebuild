# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_DOXYGEN="true"
KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for parsing RSS and Atom feeds"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kio)
	dev-qt/qtxml:5
"
DEPEND="${RDEPEND}"
