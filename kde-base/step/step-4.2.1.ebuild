# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/step/step-4.2.0.ebuild,v 1.2 2009/02/01 08:37:40 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="The KDE physics simulator"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+gsl +qalculate"

DEPEND=">=sci-mathematics/gmm-3.0
	sci-libs/cln
	gsl? ( >=sci-libs/gsl-1.9-r1 )
	qalculate? ( >=sci-libs/libqalculate-0.9.5 )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gsl GSL)
		$(cmake-utils_use_with qalculate Qalculate)"

	kde4-meta_src_configure
}
