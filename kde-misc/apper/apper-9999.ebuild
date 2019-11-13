# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KFMIN=5.60.0
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="KDE Plasma PackageKit frontend"
HOMEPAGE="https://kde.org/applications/system/org.kde.apper
https://userbase.kde.org/Apper"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

DEPEND="
	>=app-admin/packagekit-qt-1.0.0
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtsql-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtxmlpatterns-${QTMIN}:5
	>=kde-frameworks/kcmutils-${KFMIN}:5
	>=kde-frameworks/kcompletion-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kdbusaddons-${KFMIN}:5
	>=kde-frameworks/kded-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kiconthemes-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kitemviews-${KFMIN}:5
	>=kde-frameworks/kjobwidgets-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/solid-${KFMIN}:5
	kde-plasma/libkworkspace:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DDEBCONF_SUPPORT=OFF
		-DAUTOREMOVE=OFF
		-DAPPSTREAM=OFF
		-DLIMBA=OFF
		-DMAINTAINER=OFF
	)

	ecm_src_configure
}
