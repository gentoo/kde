# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="C++ string template engine based on the Django template system"
HOMEPAGE="http://www.gitorious.org/grantlee/pages/Home"
EGIT_REPO_URI=( "git://gitorious.org/grantlee/${PN}" )

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug doc test"

COMMON_DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtscript:4
"
DEPEND="${COMMON_DEPEND}
	doc? ( || ( <app-doc/doxygen-1.7.6.1[-nodot] >=app-doc/doxygen-1.7.6.1[dot] ) )
	test? ( dev-qt/qttest:4 )
"
RDEPEND="${COMMON_DEPEND}"

DOCS=(AUTHORS CHANGELOG GOALS README)

PATCHES=(
	"${FILESDIR}/${PN}-0.3.0-nonfatal-warnings.patch"
)

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
	use doc && HTML_DOCS=("${BUILD_DIR}/apidox/")

	cmake-utils_src_install
}
