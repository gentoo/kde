# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=5.245.0
QTMIN=6.6.0
VIRTUALDBUS_TEST="true"
inherit ecm gear.kde.org

DESCRIPTION="Administer web accounts for the sites and services across the Plasma desktop"
HOMEPAGE="https://community.kde.org/KTp"

LICENSE="LGPL-2.1"
SLOT="6"
KEYWORDS=""
IUSE=""

# bug #549444
RESTRICT="test"

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kdeclarative-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-frameworks/kwallet-${KFMIN}:6
	>=net-libs/accounts-qt-1.16-r1[qt6]
	>=net-libs/signond-8.61-r1[qt6]
"
DEPEND="${COMMON_DEPEND}
	dev-libs/qcoro
	>=kde-frameworks/kcmutils-${KFMIN}:6
	kde-plasma/kde-cli-tools:*
"
# KAccountsMacros.cmake needs intltool
RDEPEND="${COMMON_DEPEND}
	dev-util/intltool
"
BDEPEND="
	>=kde-frameworks/kpackage-${KFMIN}:6
	sys-devel/gettext
"
