# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

KDE_DOX_DIR="libalkimia"
KDE_DOXYGEN="true"
KMNAME="alkimia"
inherit kde5

DESCRIPTION="Library with common classes and functionality used by KDE finance applications"
HOMEPAGE="http://kde-apps.org/content/show.php/libalkimia?content=137323"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_qt_dep qtdbus)
	dev-libs/gmp:0=[cxx]
"
DEPEND="${RDEPEND}
	!app-office/libalkimia:4
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtxml)
	virtual/pkgconfig
"
