# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_TEST="true"
inherit kde5

DESCRIPTION="Library for reading/writing KVTML"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	dev-qt/qtxml:5
"
RDEPEND="${DEPEND}"
