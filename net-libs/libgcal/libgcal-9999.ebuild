# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="C/C++ interface to the Google Data API"
HOMEPAGE="http://code.google.com/p/libgcal/"
EGIT_REPO_URI=( "git://gitorious.org/${PN}/${PN}" )

LICENSE="BSD"
KEYWORDS=""
SLOT="0"
IUSE="debug doc test"

# Some tests fail
RESTRICT="test"

RDEPEND="
	dev-libs/libxml2:2
	>=net-misc/curl-7.18.2
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-libs/check )
"

DOCS=( README )

src_configure() {
	local mycmakeargs=(
		-DENABLE_TESTS=OFF
		$(cmake-utils_use debug CURL_DEBUG)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_compile docs
}

src_install() {
	use doc && HTML_DOCS=("${BUILD_DIR}/docs/doxygen/html/")
	cmake-utils_src_install
}

src_test() {
	mycmakeargs+=(-DENABLE_TESTS=ON)
	cmake-utils_src_configure
	cmake-utils_src_make test
}
