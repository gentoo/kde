# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/marble/marble-4.0.5.ebuild,v 1.1 2008/06/05 22:42:02 keytoaster Exp $

EAPI="1"
NEED_KDE="none"
KMNAME=kdeedu

if use multislot; then
	SLOT="4.1" # Goes in the ebuild because of NEED_KDE=none
	KDEDIR="/usr/kde/4.1"
else
	SLOT="4"
	KDEDIR="/usr"
fi
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="Generic geographical map widget"
KEYWORDS="~amd64 ~x86"
IUSE="debug designer-plugin htmlhandbook kde gps"

# FIXME: undefined reference when building tests. RESTRICTed for now.
# Last checked in 4.0.3.
RESTRICT="test"

COMMONDEPEND="
	gps? ( sci-geosciences/gpsd )
	kde? ( >=kde-base/kdelibs-${PV}:${SLOT}
		>=kde-base/kdepimlibs-${PV}:${SLOT} )"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"

PATCHES=("${FILESDIR}/${KMNAME}-${PV}-cmake_modules.patch")

src_compile() {
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

	kde4-meta_src_compile
}

src_install() {
	kde4-meta_src_install
	# These files are installed by kde-base/libkdeedu (4.1.0)
	rm "${D}"/usr/kde/4.1/share/apps/cmake/modules/FindMarbleWidget.cmake
	rm "${D}"/usr/kde/4.1/share/apps/cmake/modules/FindKDEEdu.cmake
}

src_test() {
	mycmakeargs="${mycmakeargs} -DENABLE_TESTS=TRUE"
	kde4-meta_src_test
}
