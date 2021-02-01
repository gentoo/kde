# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_TEST="true"
KFMIN=5.74.0
QTMIN=5.15.2
VIRTUALX_REQUIRED="test"
inherit ecm kde.org

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV%.0}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

DESCRIPTION="Cross-platform web browser using QtWebEngine"
HOMEPAGE="https://www.falkon.org/"

LICENSE="GPL-3"
SLOT="0"
IUSE="dbus kde libressl +X"

COMMON_DEPEND="
	>=dev-qt/qtdeclarative-${QTMIN}:5[widgets]
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5[ssl]
	>=dev-qt/qtprintsupport-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5[sqlite]
	>=dev-qt/qtwebchannel-${QTMIN}:5
	>=dev-qt/qtwebengine-${QTMIN}:5=[widgets]
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/karchive-${KFMIN}:5
	virtual/libintl
	dbus? ( >=dev-qt/qtdbus-${QTMIN}:5 )
	kde? (
		>=kde-frameworks/kcoreaddons-${KFMIN}:5
		>=kde-frameworks/kcrash-${KFMIN}:5
		>=kde-frameworks/kio-${KFMIN}:5
		>=kde-frameworks/kwallet-${KFMIN}:5
		>=kde-frameworks/purpose-${KFMIN}:5
	)
	libressl? ( dev-libs/libressl:= )
	!libressl? ( dev-libs/openssl:0= )
	X? (
		>=dev-qt/qtx11extras-${QTMIN}:5
		x11-libs/libxcb:=
		x11-libs/xcb-util
	)
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/linguist-tools-${QTMIN}:5
	>=dev-qt/qtconcurrent-${QTMIN}:5
"
if [[ ${KDE_BUILD_TYPE} != live ]]; then
	DEPEND+=" >=kde-frameworks/ki18n-${KFMIN}:5"
fi
RDEPEND="${COMMON_DEPEND}
	>=dev-qt/qtsvg-${QTMIN}:5
"

src_configure() {
	local mycmakeargs=(
		-DDISABLE_DBUS=$(usex !dbus)
		$(cmake_use_find_package kde KF5Wallet)
		$(cmake_use_find_package kde KF5KIO)
		-DNO_X11=$(usex !X)
	)
	ecm_src_configure
}
