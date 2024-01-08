# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
ECM_QTHELP="true"
ECM_TEST="true"
KDE_ORG_COMMIT="f62bfee42797bc46795d8e997e5aee271d193227"
KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm kde.org

DESCRIPTION="Various text handling addons"
HOMEPAGE="https://invent.kde.org/libraries/ktextaddons"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
# 	SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2+"
SLOT="6"
IUSE="speech"

RESTRICT="test"

DEPEND="
	>=dev-libs/qtkeychain-0.14.1-r1:=[qt6]
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=dev-qt/qtmultimedia-${QTMIN}:6
	>=kde-frameworks/karchive-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/sonnet-${KFMIN}:6
	>=kde-frameworks/syntax-highlighting-${KFMIN}:6
	speech? ( >=dev-qt/qtspeech-${QTMIN}:6 )
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"

# https://invent.kde.org/libraries/ktextaddons/-/merge_requests/9
PATCHES=(
	"${FILESDIR}/${P}-kf-5.247.patch"
	"${FILESDIR}/${P}-no-xmlgui.patch"
)

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package speech Qt6TextToSpeech)
	)
	ecm_src_configure
}
