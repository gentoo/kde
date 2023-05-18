# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.106.0
QTMIN=5.15.9
KDE_ORG_CATEGORY="system"
inherit ecm kde.org

DESCRIPTION="Screenshare Wayland windows to XWayland apps"

if [[ ${KDE_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2+"
SLOT="0"

DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtx11extras-${QTMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5=
	>=kde-frameworks/ki18n-${KFMIN}:5=
	>=kde-frameworks/knotifications-${KFMIN}:5=
	>=kde-frameworks/kwindowsystem-${KFMIN}:5=
	>=kde-plasma/kpipewire-5.27.4:5
	media-libs/freetype
	x11-libs/libxcb:=
"
RDEPEND="${DEPEND}"

BDEPEND="virtual/pkgconfig"
