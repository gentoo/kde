# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_TEST="forceoptional"
KMNAME="alkimia"
inherit kde5

DESCRIPTION="Library with common classes and functionality used by KDE finance applications"
HOMEPAGE="http://kde-apps.org/content/show.php/libalkimia?content=137323"

LICENSE="LGPL-2.1"
SLOT="0/6"
KEYWORDS=""
IUSE="doc"

RDEPEND="
	$(add_qt_dep qtdbus)
	dev-libs/gmp:0=[cxx]
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package doc Doxygen)
	)
	kde5_src_configure
}
