# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="Library which offers crash handling functions"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kwindowsystem)
	dev-qt/qtx11extras:5
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
