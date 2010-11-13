# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebase-workspace"
CPPUNIT_REQUIRED="optional"
inherit virtualx kde4-meta

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application."
KEYWORDS=""
IUSE="debug +handbook lm_sensors"

COMMONDEPEND="
	x11-libs/libXrender
	x11-libs/libXres
	lm_sensors? ( sys-apps/lm_sensors )
"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto
"
RDEPEND="${COMMONDEPEND}"

KMEXTRA="
	libs/ksysguard/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with lm_sensors Sensors)
	)

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst
	ewarn "Note that ksysguard has powerful features; one of these is the executing of arbitrary"
	ewarn "programs with elevated privileges (as data sources). So be careful opening worksheets"
	ewarn "from untrusted sources!"
}
