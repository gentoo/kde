# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="The KDE physics simulator"
HOMEPAGE="http://edu.kde.org/step"
KEYWORDS=""
IUSE="debug +gsl +qalculate"

DEPEND="
	>=dev-cpp/eigen-2.0.3:2
	gsl? ( >=sci-libs/gsl-1.9-r1 )
	qalculate? ( >=sci-libs/libqalculate-0.9.5 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with gsl)
		$(cmake-utils_use_with qalculate)
	)
	kde4-base_src_configure
}
