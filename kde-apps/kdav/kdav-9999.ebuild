# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_TEST="true"
inherit kde5

DESCRIPTION="DAV protocol implemention with KJobs"
LICENSE="GPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kio)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtxml)
	$(add_qt_dep qtxmlpatterns)
"
RDEPEND="${DEPEND}"
