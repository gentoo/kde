# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VIRTUALX_REQUIRED="test"
inherit cmake-utils virtualx git-r3

DESCRIPTION="C++ string template engine based on the Django template system"
HOMEPAGE="https://github.com/steveire/grantlee"
EGIT_REPO_URI=( "https://github.com/steveire/${PN}" )

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE="debug doc test"

BDEPEND="
	doc? ( app-doc/doxygen[dot] )
"
RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )
"

# bug 682258
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${PN}-0.3.0-nonfatal-warnings.patch"
	"${FILESDIR}/${P}-slot.patch"
)

src_prepare() {
	cmake-utils_src_prepare
	sed -e '/testfilters/d' \
		-i templates/tests/CMakeLists.txt || die # bug 661900
}

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
	virtx cmake-utils_src_test
}

src_install() {
	use doc && local HTML_DOCS=("${BUILD_DIR}/apidox/")

	cmake-utils_src_install
}
