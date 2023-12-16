# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm plasma.kde.org

DESCRIPTION="Components relating to Flatpak pipewire use in Plasma"

LICENSE="LGPL-2.1+"
SLOT="6"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	media-libs/libepoxy
	media-libs/libglvnd
	media-libs/libva:=
	media-video/ffmpeg:=
	>=media-video/pipewire-0.3:=
	x11-libs/libdrm
"
DEPEND="${COMMON_DEPEND}
	test? (
		dev-libs/plasma-wayland-protocols
		dev-libs/wayland
		>=dev-qt/qtwayland-${QTMIN}:6
		>=kde-plasma/kwayland-${KFMIN}:6
	)
"
RDEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:6
	x11-themes/sound-theme-freedesktop
	test? ( >=dev-qt/qtwayland-${QTMIN}:6 )
"
