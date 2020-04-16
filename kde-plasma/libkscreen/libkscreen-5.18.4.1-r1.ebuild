# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_QTHELP="true"
ECM_TEST="forceoptional"
KFMIN=5.66.0
PVCUT=$(ver_cut 1-3)
QTMIN=5.12.3
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

DESCRIPTION="Plasma screen management library"
SRC_URI+=" https://dev.gentoo.org/~asturm/distfiles/${PN}-wrapland-support-5.18.4.tar.xz"

LICENSE="GPL-2" # TODO: CHECK
SLOT="5/7"
KEYWORDS="~amd64"
IUSE="kwinft"

DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtx11extras-${QTMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kwayland-${KFMIN}:5
	x11-libs/libxcb
	kwinft? ( gui-libs/wrapland:5 )
"
RDEPEND="${DEPEND}"

PATCHES=( "${WORKDIR}/${PN}-wrapland-support.patch" )

# requires running session
RESTRICT+=" test"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package kwinft Wrapland)
	)

	ecm_src_configure
}
