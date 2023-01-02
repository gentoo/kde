# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION="API to manage the serial connection between the computer and 3D Printers"
HOMEPAGE="https://atelier.kde.org/"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="|| ( LGPL-2.1+ LGPL-3 ) gui? ( GPL-3+ )"
SLOT="0"
IUSE="doc gui test"

BDEPEND="
	>=dev-qt/linguist-tools-${QTMIN}:5
	doc? ( app-doc/doxygen[dot] )
"
DEPEND="
	>=dev-qt/qtcharts-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtserialport-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
"
RDEPEND="${DEPEND}"

src_prepare() {
	ecm_src_prepare
	sed -e "s/${PN}/${PF}/" -i doc/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS=$(usex doc)
		-DBUILD_GUI=$(usex gui)
		-DBUILD_TESTS=$(usex test)
	)
	ecm_src_configure
}
