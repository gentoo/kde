# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

QT_MINIMAL="4.5.0"
inherit cmake-utils git-2

DESCRIPTION="C++ string template engine based on the Django template system"
HOMEPAGE="http://www.gitorious.org/grantlee/pages/Home"
EGIT_REPO_URI="git://gitorious.org/grantlee/grantlee.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug doc test"

COMMON_DEPEND="
	>=dev-qt/qtcore-${QT_MINIMAL}:4
	>=dev-qt/qtgui-${QT_MINIMAL}:4
	>=dev-qt/qtscript-${QT_MINIMAL}:4
"
DEPEND="${COMMON_DEPEND}
	doc? ( || ( <app-doc/doxygen-1.7.6.1[-nodot] >=app-doc/doxygen-1.7.6.1[dot] ) )
	test? ( >=dev-qt/qttest-${QT_MINIMAL}:4 )
"
RDEPEND="${COMMON_DEPEND}"

DOCS=(AUTHORS CHANGELOG GOALS README)

PATCHES=( "${FILESDIR}/${PN}-0.1.9-qt-test-optional.patch" )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build test TESTS)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	use doc && cmake-utils_src_compile docs
}

src_install() {
	use doc && HTML_DOCS=("${CMAKE_BUILD_DIR}/apidox/")

	cmake-utils_src_install
}
