# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.5.0
QTMIN=6.8.1
inherit ecm plasma.kde.org

DESCRIPTION="Plasma shell for TVs"
HOMEPAGE="https://plasma-bigscreen.org/"

LICENSE="Apache-2.0 GPL-2"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtmultimedia-${QTMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-plasma/kwayland-${KDE_CATV}:6
	>=kde-plasma/libplasma-${KDE_CATV}:6
	>=kde-plasma/plasma-activities-${KDE_CATV}:6
	>=kde-plasma/plasma-activities-stats-${KDE_CATV}:6
	>=kde-plasma/plasma-workspace-${KDE_CATV}:6
"
RDEPEND="${DEPEND}
	>=dev-qt/qtsvg-${QTMIN}:6
	>=dev-qt/qtvirtualkeyboard-${QTMIN}:6
"
