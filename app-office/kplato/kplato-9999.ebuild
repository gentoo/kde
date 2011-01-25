# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Please note that koffice is currently bumped "forward" and that this live
# ebuild is more or less unmaintained.
#

EAPI="3"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice project management application"

KEYWORDS=""
IUSE=""

DEPEND="~app-office/koffice-libs-${PV}:${SLOT}[reports]"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	KoConfig.h.cmake
	libs/
	plugins/chartshape/kdchart
"
KMEXTRA="
	filters/${KMMODULE}/
	kdgantt/
"
KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with python PythonLibs)
		-DBUILD_kplato=ON
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
