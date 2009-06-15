# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/step/step-4.2.2.ebuild,v 1.2 2009/04/17 07:57:20 alexxy Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="The KDE physics simulator"
KEYWORDS=""
IUSE="debug +handbook +gsl +qalculate"

DEPEND="
	sci-libs/cln
	>=sci-mathematics/gmm-3.0
	gsl? ( >=sci-libs/gsl-1.12 )
	qalculate? ( >=sci-libs/libqalculate-0.9.6-r1 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gsl)
		$(cmake-utils_use_with qalculate)"

	kde4-meta_src_configure
}
