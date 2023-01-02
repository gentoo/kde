# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional" # TODO: not optional until kdelibs4support is gone
KFMIN=5.82.0
QTMIN=5.15.5
inherit ecm kde.org

DESCRIPTION="Video player plugin for Konqueror and basic MPlayer frontend"
HOMEPAGE="https://kmplayer.kde.org https://apps.kde.org/kmplayer/"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${EGIT_BRANCH}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2 FDL-1.2 LGPL-2.1"
SLOT="5"
IUSE="cairo"

BDEPEND="sys-devel/gettext"
DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtx11extras-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	>=kde-frameworks/kbookmarks-${KFMIN}:5
	>=kde-frameworks/kcompletion-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdelibs4support-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kmediaplayer-${KFMIN}:5
	>=kde-frameworks/kparts-${KFMIN}:5
	>=kde-frameworks/ktextwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kxmlgui-${KFMIN}:5
	>=media-libs/phonon-4.11.0
	x11-libs/libX11
	x11-libs/libxcb
	cairo? ( x11-libs/cairo[X,xcb(+)] )
"
RDEPEND="${DEPEND}
	media-video/mplayer
"

src_configure() {
	# 0.12: expat build broken, check in later releases
	local mycmakeargs=(
		-DKMPLAYER_BUILT_WITH_EXPAT=OFF
		-DKMPLAYER_BUILT_WITH_NPP=OFF
		-DKMPLAYER_BUILT_WITH_CAIRO=$(usex cairo)
	)
	ecm_src_configure
}
