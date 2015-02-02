# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit cmake-utils virtualx git-r3

DESCRIPTION="C++ string template engine based on the Django template system"
HOMEPAGE="http://www.gitorious.org/grantlee/pages/Home"
EGIT_REPO_URI=( "git://gitorious.org/grantlee/${PN}" )

LICENSE="LGPL-2.1"
SLOT="5"
KEYWORDS=""
IUSE="debug doc test"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtscript:5
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[dot] )
	test? ( dev-qt/qttest:5 )
"

DOCS=( AUTHORS CHANGELOG README )

PATCHES=(
	"${FILESDIR}/${PN}-0.3.0-nonfatal-warnings.patch"
	"${FILESDIR}/${PN}-slot.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	use doc && cmake-utils_src_compile docs
}

src_test() {
	VIRTUALX_COMMAND="cmake-utils_src_test" virtualmake
}

src_install() {
	use doc && HTML_DOCS=("${BUILD_DIR}/apidox/")

	cmake-utils_src_install
}
