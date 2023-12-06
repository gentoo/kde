# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PVCUT=$(ver_cut 1-2)
QTMIN=6.6.0
inherit cmake frameworks.kde.org xdg-utils

DESCRIPTION="Oxygen SVG icon theme"

LICENSE="LGPL-3"
KEYWORDS=""
IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="test? ( >=dev-qt/qtbase-${QTMIN}:6[test] )"
RDEPEND="!kde-frameworks/${PN}:5"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6
	>=kde-frameworks/extra-cmake-modules-${PVCUT}:0
	test? ( app-misc/fdupes )
"

src_prepare() {
	cmake_src_prepare
	use test || cmake_comment_add_subdirectory autotests
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
