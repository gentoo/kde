# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.245.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.6.0
inherit ecm plasma.kde.org

DESCRIPTION="Provides KWindowSystem integration plugin for Wayland"
HOMEPAGE="https://invent.kde.org/plasma/kwayland-integration"

LICENSE="LGPL-2.1"
SLOT="6"
KEYWORDS=""
IUSE=""

# dev-qt/qtgui: QtXkbCommonSupport is provided by either IUSE libinput or X
# slot ops:
# dev-qt/qtgui: QtXkbCommonSupportPrivate
# dev-qt/qtwayland: Qt::WaylandClientPrivate (private/qwayland*_p.h) stuff
# kde-frameworks/kwindowsystem: Various private headers
DEPEND="
	>=dev-libs/wayland-1.15
	>=dev-qt/qtgui-${QTMIN}:6=
	|| (
		>=dev-qt/qtgui-${QTMIN}:6[libinput]
		>=dev-qt/qtgui-${QTMIN}:6[X]
	)
	>=dev-qt/qtwidgets-${QTMIN}:6
	>=dev-qt/qtwayland-${QTMIN}:6=
	>=kde-frameworks/kwindowsystem-${KFMIN}:6=
	>=kde-plasma/kwayland-${PVCUT}:6
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-qt/qtwaylandscanner-${QTMIN}:6
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	ecm_src_prepare
	ecm_punt_kf_module IdleTime
	cmake_comment_add_subdirectory autotests # only contains idletime test
	cmake_run_in src cmake_comment_add_subdirectory idletime
}
