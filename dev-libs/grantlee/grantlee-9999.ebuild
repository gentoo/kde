# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.65.0
QTMIN=5.12.3
VIRTUALX_REQUIRED="test"
inherit kde.org ecm

DESCRIPTION="C++ string template engine based on the Django template system"
HOMEPAGE="https://github.com/steveire/grantlee"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""
IUSE="doc"

BDEPEND="
	doc? ( app-doc/doxygen[dot] )
	test? ( >=dev-qt/linguist-tools-${QTMIN}:5 )
"
RDEPEND="
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-slot.patch" )

src_compile() {
	ecm_src_compile
	use doc && cmake_src_compile docs
}

src_install() {
	use doc && local HTML_DOCS=("${BUILD_DIR}/apidox/")
	ecm_src_install
}
