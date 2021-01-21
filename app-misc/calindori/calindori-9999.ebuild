# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_ORG_CATEGORY=plasma-mobile
KFMIN=5.74.0
QTMIN=5.15.2
inherit ecm kde.org

DESCRIPTION="Touch friendly calendar application"
HOMEPAGE="https://apps.kde.org/cs/calindori"

LICENSE="CC-BY-SA-4.0 BSD GPL-3+"
SLOT="5"
KEYWORDS=""
IUSE=""

BDEPEND="virtual/pkgconfig"
DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kcalendarcore-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kirigami-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
"
RDEPEND="${DEPEND}"
