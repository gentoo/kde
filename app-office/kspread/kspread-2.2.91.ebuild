# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kspread/kspread-2.2.2.ebuild,v 1.4 2010/11/04 13:44:13 hwoarang Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice spreadsheet application."

KEYWORDS="~amd64 ~x86"
IUSE="+solver"

DEPEND="
	dev-cpp/eigen:2
	solver? ( sci-libs/gsl )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	KoConfig.h.cmake
	kchart/
	interfaces/
	libs/
	filters/
	plugins/
"
KMEXTRA="filters/${KMMODULE}/
	filters/libmso"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		-DWITH_Eigen2=ON
		$(cmake-utils_use_with solver GSL)
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
