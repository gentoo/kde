# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/marble/marble-4.2.2.ebuild,v 1.3 2009/04/17 07:56:37 alexxy Exp $

EAPI="2"

KMNAME="kdeedu"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Generic geographical map widget"
KEYWORDS=""
IUSE="debug designer-plugin gps +handbook plasma python"

DEPEND="
	gps? ( sci-geosciences/gpsd )
	python? (
		>=dev-python/PyQt4-4.4.4-r1
		>=kde-base/pykde4-${PV}:${SLOT}[kdeprefix=]
	)
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !sci-geosciences/marble )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with python PyKDE4)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PythonLibrary)
		$(cmake-utils_use_with python SIP)"

	sed -i \
		-e 's:add_subdirectory(cmake):#dontwantit:g' \
		CMakeLists.txt || die "sed to disable file collisions failed"

	find "${S}/marble/src/bindings/python/sip" -name "*.sip" | xargs -- sed -i 's/#include <marble\//#include </'

	if use gps; then
		mycmakeargs="${mycmakeargs} -DHAVE_LIBGPS=1"
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed to disable gpsd failed."
	fi

	kde4-meta_src_configure
}
