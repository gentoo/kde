# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_EXAMPLES="true"
ECM_TEST="true"
KFMIN=6.11.0
QTMIN=6.8.1
inherit ecm plasma.kde.org

DESCRIPTION="Style engine providing a unified style description to separate output styles"
HOMEPAGE="https://quantumproductions.info/articles/2025-02/moving-kdes-styling-future
https://files.quantumproductions.info/union/overview.html"

LICENSE="|| ( LGPL-2.1 LGPL-3 ) GPL-3 BSD-2"
SLOT="6"
KEYWORDS=""
IUSE="svg tools"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	svg? (
		>=dev-cpp/rapidyaml-0.7.2:=
		>=dev-qt/qtsvg-${QTMIN}:6
		>=kde-frameworks/karchive-${KFMIN}:6
		>=kde-frameworks/kcolorscheme-${KFMIN}:6
		>=kde-frameworks/kconfig-${KFMIN}:6
		kde-plasma/libplasma:6
	)
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-qt/qttools-${QTMIN}:6[qdoc]"

DOCS=( README.md )

src_configure() {
	local mycmakeargs=(
		-DWITH_PLASMASVG_INPUT=$(usex svg)
		-DBUILD_TOOLS=$(usex tools)
	)
	ecm_src_configure
}

src_install() {
	use examples && local DOCS+=( "${S}"/examples/snippets/{Button,Positioner}.qml )
	use tools && dobin "${BUILD_DIR}"/bin/union-ruleinspector
	ecm_src_install
}
