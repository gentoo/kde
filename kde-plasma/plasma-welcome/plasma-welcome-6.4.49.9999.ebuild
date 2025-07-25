# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.14.0
QTMIN=6.8.1
inherit ecm dot-a plasma.kde.org xdg

DESCRIPTION="Friendly onboarding wizard for Plasma"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-libs/kirigami-addons-1.2.0
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/knewstuff-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/ksvg-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-plasma/libplasma-${KDE_CATV}:6
"
RDEPEND="${DEPEND}"

src_configure() {
	lto-guarantee-fat
	ecm_src_configure
}

src_install() {
	ecm_src_install
	strip-lto-bytecode
}
