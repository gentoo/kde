# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

DESCRIPTION="C++ string template engine based on the Django template system"
HOMEPAGE="http://www.gitorious.org/grantlee/pages/Home"
SRC_URI="http://downloads.grantlee.org/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug doc"

COMMON_DEPEND="
	>=x11-libs/qt-core-4.5.0:4
	>=x11-libs/qt-gui-4.5.0:4
	>=x11-libs/qt-script-4.5.0:4
"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen[-nodot] )
"
RDEPEND="${COMMON_DEPEND}"

DOCS=(AUTHORS CHANGELOG GOALS README)

src_configure() {
	mycmakeargs=(
		-DBUILD_TESTS=OFF
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	use doc && cmake-utils_src_compile docs
}

src_install() {
	use doc && HTML_DOCS=("${CMAKE_BUILD_DIR}/apidocs/html/")

	cmake-utils_src_install
}

src_test() {
	mycmakeargs+=(
		-DBUILD_TESTS=ON
	)

	cmake-utils_src_configure
	cmake-utils_src_compile
	cmake-utils_src_test
}
