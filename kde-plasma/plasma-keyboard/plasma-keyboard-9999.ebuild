# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.9.0
QTMIN=6.8.1
inherit ecm plasma.kde.org xdg

DESCRIPTION="Virtual keyboard based on Qt Virtual Keyboard"
HOMEPAGE="https://invent.kde.org/plasma/plasma-keyboard"

LICENSE="|| ( GPL-2 GPL-3 ) LGPL-2.1 LGPL-3"
SLOT="6"
KEYWORDS=""

# slot op: Uses Qt6::GuiPrivate for qxkbcommon_p.h
RDEPEND="
	dev-libs/wayland
	>=dev-qt/qtbase-${QTMIN}:6=[gui,X]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtvirtualkeyboard-${QTMIN}:6
	>=dev-qt/qtwayland-${QTMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
"
DEPEND="${RDEPEND}
	>=dev-libs/wayland-protocols-1.19
"
BDEPEND="
	>=dev-qt/qtwayland-${QTMIN}:6
	dev-util/wayland-scanner
"
