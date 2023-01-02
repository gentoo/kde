# Copyright 1999-2023 Gentoo Authors
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
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

LICENSE="GPL-2"
SLOT="5"

BDEPEND="
	sys-devel/gettext
"
DEPEND="
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/ki18n:5
	kde-frameworks/kio:5
	kde-frameworks/kwidgetsaddons:5
	kde-frameworks/kxmlgui:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=ON
	)

	ecm_src_configure
}
