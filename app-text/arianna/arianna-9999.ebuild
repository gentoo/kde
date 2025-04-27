# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KDE_ORG_CATEGORY="graphics"
PVCUT=$(ver_cut 1-3)
KFMIN=6.13.0
QTMIN=6.7.2
inherit ecm gear.kde.org xdg

DESCRIPTION="EPub Reader for mobile devices"
HOMEPAGE="https://apps.kde.org/arianna/"

LICENSE="|| ( GPL-2 GPL-3 ) || ( LGPL-2.1 LGPL-3 ) || ( MIT GPL-3 ) BSD CC0-1.0 CC-BY-SA-4.0 GPL-3 GPL-3+ LGPL-2+ LGPL-2.1+ LGPL-3+ MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-libs/kirigami-addons:6
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets,sql,xml]
	>=dev-qt/qthttpserver-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-qt/qtwebchannel-${QTMIN}:6[qml]
	>=dev-qt/qtwebengine-${QTMIN}:6[qml]
	>=dev-qt/qtwebsockets-${QTMIN}:6
	>=kde-frameworks/baloo-${KFMIN}:6
	>=kde-frameworks/karchive-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kquickcharts-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:6
"
RDEPEND="${DEPEND}"
