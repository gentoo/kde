# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PVCUT=$(ver_cut 1-3)
KFMIN=5.240.0
QTMIN=6.5.0
inherit ecm gear.kde.org

DESCRIPTION="YouTube video player based on mpv, yt-dlp, and Invidious"
HOMEPAGE="https://apps.kde.org/plasmatube/"

LICENSE="CC0-1.0 CC-BY-SA-4.0 GPL-2+ GPL-3+"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-libs/kirigami-addons:6
	dev-libs/qtkeychain[qt6]
	>=dev-qt/qt5compat-${QTMIN}:6[qml]
	>=dev-qt/qtbase-${QTMIN}:6[concurrent,dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	media-libs/mpvqt
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kitemmodels-${KFMIN}:6
	net-misc/yt-dlp
"
