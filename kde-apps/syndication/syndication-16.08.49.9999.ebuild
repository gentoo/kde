# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="true"
QT_MINIMAL="5.6.0"
inherit kde5

DESCRIPTION="Library for parsing RSS and Atom feeds"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtxml)
"
RDEPEND="${DEPEND}"
