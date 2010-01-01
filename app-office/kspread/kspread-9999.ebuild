# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice spreadsheet application."

KEYWORDS=""
IUSE="+solver"

DEPEND="
	dev-cpp/eigen:2
	solver? ( sci-libs/gsl )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	kchart/
	interfaces/
	libs/
	filters/
	plugins/
"
KMEXTRA="filters/${KMMODULE}/"

KMLOADLIBS="koffice-libs"

src_configure() {
	mycmakeargs=(
		-DWITH_Eigen2=ON
		$(cmake-utils_use_with solver GSL)
	)

	kde4-meta_src_configure
}
