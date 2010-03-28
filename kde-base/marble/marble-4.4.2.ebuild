# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdeedu"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Generic geographical map widget"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug designer-plugin gps +handbook plasma python"

# tests fail / segfault. Last checked for 4.2.88
RESTRICT=test

DEPEND="
	gps? ( sci-geosciences/gpsd )
	python? (
		>=dev-python/PyQt4-4.4.4-r1
		$(add_kdebase_dep pykde4)
	)
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !sci-geosciences/marble )
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with python PyKDE4)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PythonLibrary)
		$(cmake-utils_use_with python SIP)
	)

	find "${S}/marble/src/bindings/python/sip" -name "*.sip" | xargs -- sed -i 's/#include <marble\//#include </'

	if use gps; then
		mycmakeargs+=(-DHAVE_LIBGPS=1)
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed to disable gpsd failed."
	fi

	kde4-meta_src_configure
}
