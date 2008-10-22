# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace
CPPUNIT_REQUIRED="optional"
inherit kde4svn-meta

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application."
KEYWORDS=""
IUSE="debug htmlhandbook lm_sensors"

COMMONDEPEND=">=kde-base/kdebase-data-${PV}:${SLOT}
	>=kde-base/libplasma-${PV}:${SLOT}
	x11-libs/libXrender
	x11-libs/libXres
	lm_sensors? ( sys-apps/lm_sensors )"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto"
RDEPEND="${COMMONDEPEND}
	>=kde-base/plasma-workspace-${PV}:${SLOT}"

KMEXTRA="libs/ksysguard/"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with lm_sensors Sensors)"

	kde4overlay-meta_src_compile
}

src_test() {
	sed -e '/guitest/s/^/#DONOTTEST/' \
		-i "${S}"/libs/ksysguard/tests/CMakeLists.txt

	kde4overlay-meta_src_test
}
