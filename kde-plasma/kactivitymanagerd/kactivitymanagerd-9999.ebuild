# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=9999
QTMIN=6.9.1
inherit ecm plasma.kde.org xdg

DESCRIPTION="System service to manage user's activities, track the usage patterns etc."

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="6"
KEYWORDS=""
IUSE=""

# kde-frameworks/kwindowsystem[X]: Unconditional use of KX11Extras
RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,sql,sqlite,widgets]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kglobalaccel-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6[X]
	>=kde-frameworks/kxmlgui-${KFMIN}:6
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
