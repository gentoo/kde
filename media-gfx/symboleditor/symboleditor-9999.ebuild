# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
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
	dev-qt/qtbase:6[gui,widgets]
	kde-frameworks/kconfig:6
	kde-frameworks/kconfigwidgets:6
	kde-frameworks/kcoreaddons:6
	kde-frameworks/ki18n:6
	kde-frameworks/kio:6
	kde-frameworks/kwidgetsaddons:6
	kde-frameworks/kxmlgui:6
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
