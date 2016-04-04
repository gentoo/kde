# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KMNAME="kde-baseapps"
EGIT_BRANCH="frameworks"
inherit kde5

DESCRIPTION="Can be used to show nice dialog boxes from shell scripts"
KEYWORDS=""
IUSE=""

S=${WORKDIR}/${P}/${PN}

DEPEND="
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_qt_dep qtdbus)
"
RDEPEND="${DEPEND}"
