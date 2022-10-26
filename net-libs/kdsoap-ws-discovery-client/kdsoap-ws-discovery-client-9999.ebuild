# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
ECM_TEST="forceoptional"
inherit ecm kde.org

DESCRIPTION="WS-Discovery client library based on KDSoap"
HOMEPAGE="https://invent.kde.org/libraries/kdsoap-ws-discovery-client"

LICENSE="CC0-1.0 GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RESTRICT="test"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	>=net-libs/kdsoap-1.9.0
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qtxml:5 )
"
BDEPEND="doc? ( app-doc/doxygen[dot] )"

PATCHES=( "${FILESDIR}"/${PN}-0.2_pre20200317-no-install-docs.patch )

src_prepare() {
	ecm_src_prepare
	use test || ecm_punt_qt_module Xml
}

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package doc Doxygen)
		-DBUILD_QCH=OFF # does not use ecm_add_qch from ECMAddQch
	)
	ecm_src_configure
}

src_install() {
	use doc && local HTML_DOCS=( "${BUILD_DIR}"/docs/html/. )
	ecm_src_install
}
