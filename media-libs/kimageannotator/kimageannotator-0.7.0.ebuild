# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VIRTUALX_REQUIRED="test"
inherit cmake virtualx

MY_PN=kImageAnnotator
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Tool for annotating images"
HOMEPAGE="https://github.com/ksnip/kImageAnnotator"
SRC_URI="https://github.com/ksnip/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="test"

RDEPEND="
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtsvg:6
	>=media-libs/kcolorpicker-0.3.0
"
DEPEND="${RDEPEND}
	test? (
			dev-qt/qtbase:6[test]
			dev-cpp/gtest
	)
"
BDEPEND="
	dev-qt/qttools:6[linguist]
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
		-DBUILD_WITH_QT6=ON
	)
	cmake_src_configure
}

src_test() {
	BUILD_DIR="${BUILD_DIR}/tests" virtx cmake_src_test
}
