# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KDE_ORG_CATEGORY="system"
KFMIN=6.22.0
QTMIN=6.10.1
inherit ecm kde.org

DESCRIPTION="System service for applications to obtain information about logged in accounts"
HOMEPAGE="https://invent.kde.org/system/konlineaccounts"

LICENSE="CC0-1.0 GPL-2+ LGPL-2.1+"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/qcoro[network]
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtnetworkauth-${QTMIN}:6
	>=dev-qt/qtwebengine-${QTMIN}:6[qml]
	kde-apps/libkgapi:6=
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:6
"
BDEPEND="
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
"
