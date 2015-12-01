# Copyright 1999-2015 Gentoo Foundation
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
	dev-libs/gmp[cxx]
	dev-qt/qtdbus:5
"
DEPEND="${RDEPEND}
	!app-office/libalkimia:4
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtxml:5
	virtual/pkgconfig
"
