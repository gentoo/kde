# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="The KDE physics simulator"
KEYWORDS=""
IUSE="debug +handbook +gsl +qalculate"

DEPEND="
	>=dev-cpp/eigen-2.0.51
	sci-libs/cln
	>=sci-mathematics/gmm-3.0
	gsl? ( >=sci-libs/gsl-1.9-r1 )
	qalculate? ( >=sci-libs/libqalculate-0.9.5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gsl GSL)
		$(cmake-utils_use_with qalculate Qalculate)"

	kde4-meta_src_configure
}
