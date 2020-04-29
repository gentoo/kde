# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PVCUT=$(ver_cut 1-2)
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Plasma Specific Protocols for Wayland"
HOMEPAGE="https://cgit.kde.org/plasma-wayland-protocols.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-libs/wayland-1.15.0
	>=dev-qt/qtconcurrent-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5[egl]
	>=dev-qt/qtwayland-${QTMIN}:5
"
DEPEND="${RDEPEND}
	>=dev-libs/wayland-protocols-1.15
"
