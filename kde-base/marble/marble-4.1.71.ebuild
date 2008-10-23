# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"
NEED_KDE="none"
KMNAME=kdeedu

if use kdeprefix; then
	KDEDIR="/usr/kde/4.2"
else
	KDEDIR="/usr"
fi
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Generic geographical map widget"
KEYWORDS="~amd64 ~x86"
IUSE="debug designer-plugin htmlhandbook kde gps"
# Goes in the ebuild because of NEED_KDE=none
SLOT="4.2"

# FIXME: undefined reference when building tests. RESTRICTed for now.
# Last checked in 4.0.3.
RESTRICT="test"

COMMONDEPEND="gps? ( sci-geosciences/gpsd )
	kde? ( >=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=]
		>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=] )
	!kdeprefix? ( !sci-geosciences/marble )"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)"

	sed -i -e 's:add_subdirectory(cmake):#dontwantit:g' CMakeLists.txt \
		|| die "sed to disable file collisions failed"

	if use gps; then
		mycmakeargs="${mycmakeargs} -DHAVE_LIBGPS=1"
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed to disable gpsd failed."
	fi

	if ! use kde; then
		mycmakeargs="${mycmakeargs} -DQTONLY:BOOL=ON"
	fi

	kde4-meta_src_configure
}

src_test() {
	mycmakeargs="${mycmakeargs} -DENABLE_TESTS=TRUE"
	kde4-meta_src_test
}
