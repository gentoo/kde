# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="none"
KMNAME=kdeedu
SLOT="kde-svn" # Goes in the ebuild because of NEED_KDE=none
KDEDIR="/usr/kde/svn"
CPPUNIT_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="KDE: generic geographical map widget"
KEYWORDS=""
IUSE="debug designer-plugin htmlhandbook kde gps"
# Need to set this because of NEED_KDE="none"
SRC_URI=""

# FIXME: undefined reference when building tests. RESTRICTed for now.
RESTRICT="test"

COMMONDEPEND="
	kde-base/kdelibs:${SLOT}
	gps? ( sci-geosciences/gpsd )
	kde? ( >=kde-base/kdelibs-${PV}:${SLOT}
		>=kde-base/kdepimlibs-${PV}:${SLOT} )"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"

src_compile() {
#	epatch "${FILESDIR}/${P}-fix-tests.patch"

	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with designer-plugin DESIGNER_PLUGIN)"

	if use gps; then
		mycmakeargs="${mycmakeargs} -DHAVE_LIBGPS=1"
	else
		sed -i -e 's:FIND_LIBRARY(libgps_LIBRARIES gps):# LIBGPS DISABLED &:' \
			marble/Findlibgps.cmake || die "sed to disable gpsd failed."
	fi

	if ! use kde; then
		mycmakeargs="${mycmakeargs} -DQTONLY:BOOL=ON"
	fi

	kde4overlay-meta_src_compile
}

src_install() {
	kde4overlay-meta_src_install
	# This file is installed by kde-base/libkdeedu
	rm "${D}"/usr/kde/svn/share/apps/cmake/modules/FindKDEEdu.cmake
}

src_test() {
	mycmakeargs="${mycmakeargs} -DENABLE_TESTS=TRUE"

	kde4overlay-meta_src_test
}
