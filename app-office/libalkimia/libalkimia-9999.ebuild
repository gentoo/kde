# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KMNAME="alkimia"
inherit kde5

DESCRIPTION="Library with common classes and functionality used by KDE finance applications"
HOMEPAGE="http://kde-apps.org/content/show.php/libalkimia?content=137323"

LICENSE="LGPL-2.1"
SLOT="0/6"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_qt_dep qtdbus)
	dev-libs/gmp:0=[cxx]
"
DEPEND="${RDEPEND}
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtxml)
	virtual/pkgconfig
"
