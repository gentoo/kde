# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm plasma.kde.org

DESCRIPTION="Qt component to allow applications make use of Wayland wl-layer-shell protocol"

LICENSE="LGPL-3+"
SLOT="6"
KEYWORDS=""
IUSE=""

# dev-qt/qtgui: QtXkbCommonSupport is provided by either IUSE libinput or X
# slot op: various private QtWaylandClient headers
RDEPEND="
	>=dev-libs/wayland-1.15
	>=dev-qt/qtdeclarative-${QTMIN}:6
	|| (
		>=dev-qt/qtbase-${QTMIN}:6[libinput]
		>=dev-qt/qtbase-${QTMIN}:6[X]
	)
	>=dev-qt/qtwayland-${QTMIN}:6=
	x11-libs/libxkbcommon
"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
"
BDEPEND="
	>=dev-qt/qtwayland-${QTMIN}:6
	dev-util/wayland-scanner
	virtual/pkgconfig
"
