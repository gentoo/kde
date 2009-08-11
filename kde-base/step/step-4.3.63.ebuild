# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="The KDE physics simulator"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook +gsl +qalculate"

DEPEND="
	>=dev-cpp/eigen-2.0.3
	sci-libs/cln
	>=sci-mathematics/gmm-3.0
	gsl? ( >=sci-libs/gsl-1.9-r1 )
	qalculate? ( >=sci-libs/libqalculate-0.9.5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gsl)
		$(cmake-utils_use_with qalculate)"

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install
	rm "${D}/usr/share/icons/oxygen/22x22/actions/pointer.png" || die "file not there anymore"
}
