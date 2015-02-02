# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kde-baseapps"
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="KDialog can be used to show nice dialog boxes from shell scripts"
KEYWORDS=""
IUSE=""

S=${WORKDIR}/${P}/${PN}

RDEPEND="$(add_frameworks_dep kde4libs)
	$(add_frameworks_dep kwidgetsaddons)
	dev-qt/qtdbus:5"
DEPEND="${RDEPEND}"
