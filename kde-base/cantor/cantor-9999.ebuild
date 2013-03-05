# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE4 interface for doing mathematics and scientific computing"
KEYWORDS=""
IUSE="analitza debug postscript qalculate +R"

# TODO Add Sage Mathematics Software backend (http://www.sagemath.org)
RDEPEND="
	analitza? ( $(add_kdebase_dep analitza) )
	qalculate? (
		sci-libs/cln
		sci-libs/libqalculate
	)
	postscript? ( app-text/libspectre )
	R? ( dev-lang/R )
	dev-qt/qtxmlpatterns:4
"
DEPEND="${RDEPEND}
	>=dev-cpp/eigen-2.0.3:2
"

RESTRICT="test"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with analitza)
		$(cmake-utils_use_with postscript LibSpectre)
		$(cmake-utils_use_with qalculate)
		$(cmake-utils_use_with R)
	)
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	if ! use analitza && ! use qalculate && ! use R; then
		echo
		ewarn "You have decided to build ${PN} with no backend."
		ewarn "To have this application functional, please do one of below:"
		ewarn "    # emerge -va1 '='${CATEGORY}/${P} with 'analitza', 'qalculate' or 'R' USE flag enabled"
		ewarn "    # emerge -vaDu sci-mathematics/maxima"
		echo
	fi
}
