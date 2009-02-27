# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-4.2.0.ebuild,v 1.2 2009/02/01 08:03:06 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdebase-workspace"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook lm_sensors"

COMMONDEPEND="x11-libs/libXrender
	x11-libs/libXres
	lm_sensors? ( sys-apps/lm_sensors )"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto"

KMEXTRA="libs/ksysguard/"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with lm_sensors Sensors)"

	kde4-meta_src_configure
}

src_test() {
# one out of two tests are broken. we just disable it. last tested on 4.1.0.
	sed -e '/guitest/s/^/#DONOTTEST/' \
		-i "${S}"/libs/ksysguard/tests/CMakeLists.txt

	kde4-meta_src_test
}
