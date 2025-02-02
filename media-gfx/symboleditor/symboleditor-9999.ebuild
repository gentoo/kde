# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
KFMIN=6.5.0
QTMIN=6.7.2
inherit ecm kde.org

DESCRIPTION="Application to create libraries of QPainterPath objects with rendering hints"
HOMEPAGE="https://apps.kde.org/symboleditor/
https://userbase.kde.org/SymbolEditor"

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	MY_P=SymbolEditor-${PV}
	SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${MY_P}.tar.bz2"
	S="${WORKDIR}"/${MY_P}
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"
BDEPEND="sys-devel/gettext"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=ON
	)

	ecm_src_configure
}
