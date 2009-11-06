# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeedu"
inherit kde4-meta

DESCRIPTION="KDE4 interface for doing mathematics and scientific computing"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook ps +R"

# TODO Add Sage Mathematics Software backend (http://www.sagemath.org)
COMMON_DEPEND="
	ps? ( app-text/libspectre )
	R? ( dev-lang/R )
"
DEPEND="${COMMON_DEPEND}
	>=dev-cpp/eigen-2.0.3
"
RDEPEND="${COMMON_DEPEND}"

src_configure() {
	mycmakeargs+="
		$(cmake-utils_use_with ps LibSpectre)
		$(cmake-utils_use_with R)
	"

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! use R; then
		echo
		ewarn "You have decided to build ${PN} with no backend."
		ewarn "To have this application functional, please do one of below:"
		ewarn "    # emerge -va1 '='${CATEGORY}/${P} with 'R' USE flag enabled"
		ewarn "    # emerge -vaDu sci-mathematics/maxima"
		echo
	fi
}
