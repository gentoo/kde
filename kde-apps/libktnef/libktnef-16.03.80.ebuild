# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_DOXYGEN="true"
KDE_TEST="true"
KMNAME="ktnef"
inherit kde5

DESCRIPTION="Library for handling TNEF data"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="
	$(add_kdeapps_dep kcalcore)
	$(add_kdeapps_dep kcalutils)
	$(add_kdeapps_dep kcontacts)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
"
RDEPEND="${DEPEND}
	!kde-apps/ktnef:4
	!<kde-apps/ktnef-15.12.2:5
"
